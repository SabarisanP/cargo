<table class="table table-design tab-wid-95">
    <tbody>        
        {foreach key=key from=$station item=sta}
            <tr  class="del-station-sch-{$sta->code} {if count($sta->overrideList) > 0} trhover {/if}" onclick="viewStationExceptionOverride(event, '{$sta->code}')">
                <th width="8%" class="fn-wg-n">
                    <span id="sta_act"><div class="pull-left">
                            {if $sta->stationSequence!=1}
                                <a href="javascript:;" title="Move station up" class="sequence-up" data-code="{$sta->code}" data-sequence="{$sta->stationSequence}" onclick="stationSequenceupdate(this)">
                                    <i class="glyphicon glyphicon-arrow-up"></i>
                                </a>

                            {else}
                                <a class="sequence-up" data-code="{$sta->code}" data-sequence="{$sta->stationSequence}"></a>

                            {/if}
                            {if count($station)-1 != $key}
                                <a href="javascript:;" title="Move station down" class="sequence-down" data-code="{$sta->code}" data-sequence="{$sta->stationSequence}" onclick="stationSequenceupdate(this)">
                                    <i class="glyphicon glyphicon-arrow-down"></i>
                                </a>
                            {else}
                                <a class="sequence-down" data-code="{$sta->code}" data-sequence="{$sta->stationSequence}"></a>
                            {/if}
                        </div></span>
        <div class="pull-left">
            &nbsp;({$sta->stationSequence})
        </div>
    </th>

    <th width="20%" class="bold">{if count($sta->overrideList) > 0}<span class="caret-ovr"></span>&nbsp;{/if}{$sta->station->name|truncate:30:"...":true}</th>
    <th width="7%"></th>
    <th width="15%">{$sta->hoursminitues}&nbsp;
        {assign var=sta_extra_time value=0}  
        {if $sta->minitues > 1439 && $sta->minitues < 2880}
            Next day
            {assign var=sta_extra_time value=1440}  
        {else if $sta->minitues > 2879}   
            Third day
            {assign var=sta_extra_time value=2880}  
        {/if}   
    </th>
    <th width="20%"> 
        {if $sta->activeFrom!='' &&  $sta->activeTo!=''}
            {$sta->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$sta->activeTo}
        {/if}   
    </th>
    <th width="18%"> 
        {if $sta->dayOfWeek!=''}
            <div class="btn-group btn-group-days-display">
                {assign var=sday value=$sta->dayOfWeek}        
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:0:1==1}active{/if}">S</label>
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:1:1==1}active{/if}">M</label>
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:2:1==1}active{/if}">T</label>
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:3:1==1}active{/if}">W</label>
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:4:1==1}active{/if}">T</label>
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:5:1==1}active{/if}">F</label>
                <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:6 ==1}active{/if}">S</label>
            </div> 
        {/if}   
    </th>

        <th width="15%">
            <span id="sta_act">
                <input type="hidden" value="{$sta->station->code}" data-code="{$sta->code}" id="station-sched-code-{$sta->code}" name="station-sched-code" class="st-sd-c">
                <input type="hidden" value="{$sta->minitues}" id="station-sched-time-{$sta->code}" name="station-sched-time" class="st-sd-t">
                <input type="hidden" value="{$sta->minitues}" id="station-sched-time-point-{$sta->station->code}" name="station-sched-time" class="st-sd-t">
                <input type="hidden" value="{if $sta->station->activeFrom!='' && $sta->station->activeTo!='' }{$sta->station->activeFrom} | {$sta->station->activeTo}{/if}" id="station-sched-daterange-{$sta->code}" name="station-sched-daterange" class="st-sd-t">
                <input type="hidden" name="station-sequence-{$sta->code}" id="station-sequence-{$sta->code}" class="sequence" value="{$key+1}" />
                <input type="hidden" name="station-days-schedules-{$sta->code}" id="station-days-schedules-{$sta->code}" value="{$sta->dayOfWeek}" />
                <input type="hidden" name="station-days-mobno-{$sta->code}" id="station-days-mobno-{$sta->code}" value="{($sta->mobileNumber != 'NA') ? $sta->mobileNumber : ''}" />
                <input type="hidden" name="station-days-range-schedules-{$sta->code}" id="station-days-range-schedules-{$sta->code}" value="{if $sta->activeFrom!='' && $sta->activeTo!='' }{$sta->activeFrom} | {$sta->activeTo}{/if}" />
                <a class="edit pTip_top" title="Edit station" href="javascript:;" onclick="stationSchedulesDialog('{$sta->code}')">
                    <i class="fa fa-pencil fa-lg"></i>
                </a>&nbsp;
                <a class="add pTip_top"  title="Add station points" href="javascript:;" onclick="stationPointSchedulesDialog('{$sta->station->code}', '{$sta->code}', '')">
                    <i class="fa fa-plus fa-lg"></i>
                </a>&nbsp;
                <a class="delete pTip_top" title="Delete station" href="javascript:;" onclick="deleteStationschedules('{$sta->code}')">
                    <i class="fa fa-trash-o fa-lg"></i>
                </a>&nbsp;
                <a class="delete pTip_top" title="Add exception / override" href="javascript:;" data-station='{$sta->station->code}' data-date='' data-stationtime="{$sta->minitues}" data-station-code='{$sta->code}' data-ovr-extra-time="{$sta_extra_time}" onclick="stationExceptionDialog(this)">
                    <i class="fa fa-exclamation-circle fa-lg"></i>
                </a>&nbsp;</span>
        </th>
    </tr>
</tr>

{if count($sta->overrideList) > 0}
    {foreach key=key from=$sta->overrideList item=staexp}
        <tr id="stationExcTab-{$sta->code}" style="display: none;" class="border_bottom">
            <td ></td>
            <td colspan="6" style="text-align:left;" class="text-danger">Exception List</td>
        </tr>
        {if $staexp->minitues=='-1'}
            <tr class="station-sch-exp-{$sta->code} sta-exp-ovr-lst-hide" id="st-eo-del-{$staexp->code}">
                <td></td>
                <td></td>
                <td></td>
                <td>-</td>
                <td>{$staexp->activeFrom}&nbsp;<i class="fa fa-long-arrow-right"></i>&nbsp;{$staexp->activeTo} </td>
                <td>
                    {if $staexp->dayOfWeek!=''}
                        <div class="btn-group btn-group-days-display">
                            {assign var=sxday value=$staexp->dayOfWeek}        
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                        </div> 
                    {/if}   
                </td>
                <td>
                    <span id="sta_act_ovr">
                        <a class="edit pTip_top" title="Edit station exception" href="javascript:;" data-station='{$sta->station->code}' data-daysofweek='{$staexp->dayOfWeek}' data-date='{$staexp->activeFrom} | {$staexp->activeTo}' data-station-code='{$sta->code}' data-ecode='{$staexp->code}' onclick="stationExceptionDialog(this)">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Delete station exception" href="javascript:;" data-station='{$sta->station->code}' data-station-code='{$sta->code}' data-ecode='{$staexp->code}' onclick="deleteStationExceptionschedules(this)">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;</span>
                </td>
            </tr>
        {/if}   

    {/foreach}

    {foreach key=key from=$sta->overrideList item=staexp}

        <tr id="stationOvrTab-{$sta->code}" style="display: none;" class="border_bottom">
            <td></td>
            <td colspan="6" style="text-align:left;" class="text-danger">Override List</td>
        </tr>

        {if $staexp->minitues!="-1"}
            <tr class="station-sch-ove-{$sta->code} sta-exp-ovr-lst-hide" id="st-eo-del-{$staexp->code}">
                <td></td>
                <td></td>
                <td></td>
                <td>{$staexp->hoursminitues}&nbsp;
                    {assign var=ovr_extra_time value=0}  
                    {if $staexp->minitues > 1439 && $staexp->minitues < 2880}
                        Next day
                        {assign var=ovr_extra_time value=1440}  
                    {else if $staexp->minitues > 2879}   
                        Third day
                        {assign var=ovr_extra_time value=2880}  
                    {/if}
                </td>

                <td>{$staexp->activeFrom}&nbsp;<i class="fa fa-long-arrow-right"></i>&nbsp;{$staexp->activeTo} </td>

                <td>{if $staexp->dayOfWeek!=''}
                        <div class="btn-group btn-group-days-display">
                            {assign var=sxday value=$staexp->dayOfWeek}        
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                        </div> 
                    {/if}   
                </td>

            <td>
                <span id="sta_act_ovr">
                    <a class="edit pTip_top" title="Edit station exception" href="javascript:;" data-station='{$sta->station->code}' data-daysofweek='{$staexp->dayOfWeek}' data-date='{$staexp->activeFrom} | {$staexp->activeTo}' data-stationtime="{$sta->minitues}"  data-time='{$staexp->minitues - $ovr_extra_time}' data-ovr-extra-time="{$ovr_extra_time}" data-station-code='{$sta->code}' data-ecode='{$staexp->code}' data-tab='#st-ovr' onclick="stationExceptionDialog(this)">
                        <i class="fa fa-pencil fa-lg"></i>
                    </a>&nbsp;
                    <a class="delete pTip_top" title="Delete station exception" href="javascript:;" data-station='{$sta->station->code}' data-station-code='{$sta->code}' data-ecode='{$staexp->code}' onclick="deleteStationExceptionschedules(this)">
                        <i class="fa fa-trash-o fa-lg"></i>
                    </a>&nbsp;</span>
            </td>

        </tr>
        {/if}   

            {/foreach}

                {/if}

                    {assign var="sta_pnt" value=""}
                    {foreach key=key1 from=$stationpoint[$sta->station->code] item=stp}
                        {$sta_pnt="`$sta_pnt`,`$stp->code`"}
                        <tr class="del-st-p-{$stp->code} {if count($stp->overrideList) > 0} trhover {/if}" onclick="viewStationPointExceptionOverride(event, '{$stp->code}')">
                            <td></td>
                            <td>{if count($stp->overrideList) > 0}<span class="caret-ovr"></span>&nbsp;{/if} 
                                <span title="{$stp->stationPoint->address} &#013;{$stp->stationPoint->number}">{$stp->stationPoint->name|truncate:30:"...":true}</span>
                            </td>
                            <td>
                                <div class="btn-group" style="opacity:0.7">
                                    {if $stp->boardingFlag==1}
                                    <button type="button" class="btn btn-default btn-xs " title="boarding available">
                                        <i class="fa fa-level-up"></i>
                                    </button>
                                    {else}
                                        <button type="button" class="btn btn-default btn-xs " style="border:0px;">
                                        &nbsp;&nbsp;&nbsp;
                                        </button>
                                    {/if}
                                    
                                    {if $stp->droppingFlag==1}
                                    <button type="button" class="btn btn-default btn-xs " title="dropping available">
                                        <i class="fa fa-level-down"></i>
                                    </button>
                                    {else} 
                                     &nbsp;&nbsp;&nbsp;    
                                    {/if}
                              </div>
                            </td>
                            <td>{$stp->hoursminitues}</td>
                            <td>{$stp->vanRoute->name}</td>
                            <td>{if $stp->fare}<span title="Fare"><i class="fa fa-inr"></i>&nbsp;{$stp->fare}</span>{/if}</td>
                            <td>
                                <span id="sta_act">
                                    <input type="hidden" name="station-point-schedul-code" data-code="{$stp->code}" id="station-point-code-{$stp->code}" value="{$stp->stationPoint->code}" />
                                    <input type="hidden" id="station-point-time-{$stp->code}" value="{$stp->minitues}" />
                                    <input type="hidden" id="station-point-bflag-{$stp->code}" value="{$stp->boardingFlag}" />
                                    <input type="hidden" id="station-point-dflag-{$stp->code}" value="{$stp->droppingFlag}" />
                                    <input type="hidden" id="station-point-days-week-{$stp->code}" value="{$stp->dayOfWeek}" />
                                    <input type="hidden" id="station-point-days-range-{$stp->code}" value="{if $stp->activeFrom!='' && $stp->activeTo!='' }{$stp->activeFrom} | {$stp->activeTo}{/if}" />
                                    <input type="hidden" id="van-route-code-{$stp->code}" value="{$stp->vanRoute->code}"/>
                                    <input type="hidden" id="station-point-fare-{$stp->code}" value="{$stp->fare}"/>
                                    <a href="javascript:;" class="pTip_top" title="Edit station point" class="edit" onclick="stationPointSchedulesDialog('{$sta->station->code}', '{$stp->code}', '{$stp->code}')">
                                        <i class="fa fa-pencil fa-lg"></i>
                                    </a>&nbsp;
                                    <a href="javascript:;" class="pTip_top" title="Delete station point" class="delete" onclick="stationpointSchedulesDelete('{$sta->station->code}', '{$stp->code}')">
                                        <i class="fa fa-trash-o fa-lg"></i>
                                    </a>&nbsp;
                                    <a href="javascript:;" class="pTip_top" title="Add exception / override" data-station='{$sta->station->code}' data-stationtime="{$sta->minitues}" data-time='{$stp->minitues}' data-dayweek="{$stp->lookup->dayOfWeek}" data-station-point-sch-code='{$stp->code}' data-station-point-code='{$stp->stationPoint->code}' data-tab='#stp-ovr' data-additionalspfare='{$stp->fare}' data-dialoghead="{$stp->stationPoint->name} {$stp->hoursminitues}" onclick="stationPointExceptionDialog(this)">
                                        <i class="fa fa-exclamation-circle fa-lg"></i>
                                    </a>&nbsp;
                                </span>
                            </td>
                        </tr>
                        {if count($stp->overrideList) > 0}
                            <tr class="station-point-sch-ove-{$stp->code} station-point-sch-ove-hide border_bottom" style="display: none;" >
                                <td></td>
                                <td colspan="6" style="text-align:left;" class="text-danger">Exception List</td>
                            </tr>


                            {foreach key=key from=$stp->overrideList item=stapexp}
                                {if $stapexp->minitues=="-1"}
                                    <tr class="station-point-sch-ove-{$stp->code} station-point-sch-ove-hide" id="st-pt-exp-del-{$stapexp->code}">
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td>-</td>
                                        <td>{$stapexp->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$stapexp->activeTo} </td>

                                        <td width="20%">{if $stapexp->dayOfWeek!=''} 
                                            <div class="btn-group btn-group-days-display">
                                                {assign var=sxpday value=$stapexp->dayOfWeek}        
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:0:1==1}active{/if}">S</label>
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:1:1==1}active{/if}">M</label>
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:2:1==1}active{/if}">T</label>
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:3:1==1}active{/if}">W</label>
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:4:1==1}active{/if}">T</label>
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:5:1==1}active{/if}">F</label>
                                                <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:6 ==1}active{/if}">S</label>
                                            </div> 
                                        {/if}   </td>
                                    <td>
                                        <span id="sta_act_ovr">
                                            <a class="pTip_top" title="Add station point exception" href="javascript:;" data-tab="#stp-exp" data-station='{$sta->station->code}' data-dayweek="{$stapexp->dayOfWeek}" data-date='{$stapexp->activeFrom} | {$stapexp->activeTo}' data-station-point-sch-code='{$stp->code}' data-station-point-code='{$stp->stationPoint->code}' data-ecode='{$stapexp->code}' data-additionalspfare='{$stp->fare}' onclick="stationPointExceptionDialog(this)">
                                                <i class="fa fa-pencil fa-lg"></i>
                                            </a>&nbsp;
                                            <a class="delete pTip_top" title="Delete station exception" href="javascript:;" data-station='{$sta->station->code}' data-dayweek="{$stapexp->dayOfWeek}" data-date='{$stapexp->activeFrom} | {$stapexp->activeTo}' data-station-point-sch-code='{$stp->code}' data-station-point-code='{$stp->stationPoint->code}' data-ecode='{$stapexp->code}'  onclick="deleteStationPointExceptionschedules(this)">
                                                <i class="fa fa-trash-o fa-lg"></i>
                                            </a>&nbsp;</span>
                                    </td>

                                </tr>

                                {/if}
                                    {/foreach}
                                        <tr class="station-point-sch-ove-{$stp->code} station-point-sch-ove-hide border_bottom" style="display: none;" >
                                            <td> </td>
                                            <td colspan="6" style="text-align:left;" class="text-danger">Override List</td>
                                        </tr>

                                        {foreach key=key from=$stp->overrideList item=stapexp}

                                            {if $stapexp->minitues!="-1"}
                                                <tr class="station-point-sch-ove-{$stp->code} station-point-sch-ove-hide" id="st-pt-exp-del-{$stapexp->code}">
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td>{$stapexp->hoursminitues}</td>
                                                    <td>{$stapexp->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$stapexp->activeTo} </td>

                                                    <td>{if $stapexp->dayOfWeek!=''} 
                                                        <div class="btn-group btn-group-days-display">
                                                            {assign var=sxpday value=$stapexp->dayOfWeek}        
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:0:1==1}active{/if}">S</label>
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:1:1==1}active{/if}">M</label>
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:2:1==1}active{/if}">T</label>
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:3:1==1}active{/if}">W</label>
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:4:1==1}active{/if}">T</label>
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:5:1==1}active{/if}">F</label>
                                                            <label class="btn btn-success-list btn-xs chk-btn {if $sxpday|substr:6 ==1}active{/if}">S</label>
                                                        </div> 
                                                    {/if}   </td>
                                                <td>
                                                    <span id="sta_act_ovr">
                                                        <a class="pTip_top" title="Add station point exception" href="javascript:;" data-tab="#stp-ovr" data-station='{$sta->station->code}' data-dayweek="{$stapexp->dayOfWeek}" data-date='{$stapexp->activeFrom} | {$stapexp->activeTo}' data-station-point-sch-code='{$stp->code}' data-station-point-code='{$stp->stationPoint->code}' data-ecode='{$stapexp->code}' data-stationtime="{$sta->minitues}" data-stationptime='{$stp->minitues}' data-time='{$stapexp->minitues}' data-additionalspfare='{$stp->fare}' onclick="stationPointExceptionDialog(this)">
                                                            <i class="fa fa-pencil fa-lg"></i>
                                                        </a>&nbsp;
                                                        <a class="delete pTip_top" title="Delete station exception" href="javascript:;" data-station='{$sta->station->code}' data-dayweek="{$stapexp->dayOfWeek}" data-date='{$stapexp->activeFrom} | {$stapexp->activeTo}' data-station-point-sch-code='{$stp->code}' data-station-point-code='{$stp->stationPoint->code}' data-ecode='{$stapexp->code}'  onclick="deleteStationPointExceptionschedules(this)">
                                                            <i class="fa fa-trash-o fa-lg"></i>
                                                        </a>&nbsp;</span>
                                                </td>

                                            </tr>
                                            {/if}

                                                {/foreach}
                                                    {/if}
                                                        {/foreach}                                                                     
                                                        </td>
                                                        <input type='hidden' name='all-stp-code-{$sta->code}'  data-code="{$sta->code}" id='all-stp-code-{$sta->code}' value="{$sta_pnt}" />
                                                    </tr>
                                                    {/foreach}
                                                    </tbody>
                                                </table>    
                                                <br/>
                                                <div>
                                                    <a id="sts" href="javascript:;" class="pTip_top" title="Click here to add stations and station points" alt="Click here to add stations and station points" onclick="stationSchedulesDialog()">
                                                        <i class="fa fa-plus fa-lg"></i> Add Stations
                                                    </a>
                                                </div>

                                                <div id="schedules-station-dialog" class="dialog-content-page" style="display: none">
                                                    <form role="form" id="ssd" class="form-horizontal">
                                                        <div class="form-group" id="d_st_name">
                                                            <div class="col-md-7">
                                                                <label class="req" for="wizard_fname">Select a station</label>
                                                                <div class="p_l_n col-md-12">
                                                                    <select id="station-list-sch" class="form-control">
                                                                        <option value=""></option>
                                                                        {foreach name=o item=st from=$stations}
                                                                            <option value="{$st->code}">{$st->name}</option>
                                                                        {/foreach}   

                                                                    </select>
                                                                </div>
                                                            </div>  
                                                            <div class="col-md-5 p_l_n">
                                                                <div class="">
                                                                    <label for="station-sch-mobno">Mobile No</label>
                                                                    <div>
                                                                        <input id="station-sch-mobno" class="form-control" type="text" value="" maxlength="10"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label  class="req" for="station-sch-hours">Station time</label>
                                                            <div class="p_l_n col-md-12"> 
                                                                <div>
                                                                    <input id="station-sch-hours" type="text" name="station-sch-hours" value="" />
                                                                    <label id="station-sch-time-label" class="time-slot col-md-2 col-xs-push-4"></label>
                                                                </div>

                                                            </div>

                                                            <div class="p_l_n col-md-3 sta-sch-dy"> 
                                                                <label>Days</label>      
                                                                <select id="station-schedules-day-type" class="form-control">
                                                                    <option value="1">Same Day</option>
                                                                    <option value="2">Next Day</option>
                                                                    <option value="3">Third Day</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group"><a href="javascript:;" class="pTip_top" title="View advanced options" onclick="viewStationadvance()"><i class="fa fa-plus"></i>&nbsp;Advanced options</a></div>
                                                        <div class="hgt-150"> 
                                                            <div class="form-group advance-station-schedules">
                                                                    <label  for="station-schedules-date">Date</label>
                                                                <div class="p_l_n col-md-6"> 
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                        <input type="text" name="station-schedules-date" id="station-schedules-date" class="form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                                                                    </div>
                                                                </div>
                                                                </div>
                                                            <div class="form-group advance-station-schedules">
                                                                <div class="col-md-5 p_l_n">
                                                                    <label  class="req" for="wizard_fname" class="req">Day of week</label>
                                                                    <div class="btn-group btn-group-days" id="station-week-days" data-toggle="buttons">
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="station-week" value="1">S</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="station-week" value="1">M</label>
                                                                        <label class="btn btn-success btn-xs chk-btn ">
                                                                            <input type="checkbox" name="station-week" value="1">T</label>
                                                                        <label class="btn btn-success btn-xs chk-btn ">
                                                                            <input type="checkbox" name="station-week" value="1">W</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="station-week" value="1">T</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="station-week" value="1">F</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="station-week" value="1">S</label>
                                                                    </div> 
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <div class="clear_fix_both"></div>

                                                        <div class="pull-left" id="station-sch-loading"></div>
                                                        <input type="hidden" name="stationactiveFlag" id="stationactiveFlag" value="1" />
                                                        <input type="hidden" name="stationSequence" id="stationSequence" value="1" />
                                                        <input type="hidden" name="station-time-range" id="station-time-range" value="0" />
                                                        <input type="hidden" name="station_code" id="station_code" value="" />
                                                        <div class="pull-right" id="station-sch-button">
                                                            <input type="hidden" name="id_mnu_code" id="station_sch_code" value="" />
                                                            <button class="btn btn-success" type="button" onclick="saveStationSchedules()">Save</button>
                                                            <button class="btn btn-default" type="button" onclick="cancelStationSchedulesDialog();">Cancel</button>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div id="schedules-station-point-dialog" class="dialog-content-page" style="display: none">
                                                    <form role="form" id="sspd" class="form-horizontal">
                                                        <div class="form-group">
                                                            <label class="req" for="wizard_fname">Select a station point</label>
                                                            <div class=" col-md-12 p_l_n">
                                                                <select id="station-point-sch" class="form-control">

                                                                </select>
                                                                <div class="help-block" id="station-point-addr"></div>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <label  class="req" for="station-sch-hours">Station point time</label>
                                                            <div class="p_l_n col-md-12"> 
                                                                <div>
                                                                    <input id="point-station-sch-hours" type="text" name="point-station-sch-hours" value="" />
                                                                    <label id="station-point-sch-time-label" class="time-slot col-md-2 col-xs-push-4"></label>
                                                                </div>

                                                            </div>

                                                        </div>

                                                        
                                                        <div class="form-group {if $action_rights['BP-DP-CHARGE']==0}hidden{/if}">
                                                            <label for="wizard_fname">Additional Fare</label>
                                                            <div class="col-md-1 p_l_n">
                                                                <input type="number" name="station-point-schedules-fare" id="station-point-schedules-fare" class="form-control no-spin" value="">
                                                            </div>
                                                        </div>                                                        
                                                        
                                                        

                                                        <div class="form-group"><a href="javascript:;" class="pTip_top" title="View advanced options" onclick="viewStationPointAdvance()"><i class="fa fa-plus"></i>&nbsp;Advanced options</a></div>

                                                        <div class="hgt-120"> 
                                                            <div class="row">
                                                                <div class="form-group advance-station-point-schedules col-md-6">
                                                                    <label for="wizard_fname">Boarding / Dropping Flag</label>
                                                                    <div class="p_l_n">
                                                                        <select id="station-point-bdflag" class="form-control">
                                                                            <option value="1">Boarding & Dropping</option>
                                                                            <option value="2">Boarding Only</option>
                                                                            <option value="3">Dropping Only</option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="advance-station-point-schedules col-md-6 p_r_n">
                                                                    <label  for="van-route-dropdown">Van Route</label>
                                                                    <select id="van-route-dropdown" class="form-control">
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="form-group advance-station-point-schedules col-md-6">
                                                                    <label  for="station-schedules-date">Date</label>
                                                                    <div class="p_l_n"> 
                                                                        <div class="input-group">
                                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                            <input type="text" name="station-point-schedules-date" id="station-point-schedules-date" class="form-control" readonly="true" value="">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group advance-station-point-schedules col-md-5">
                                                                    <div class="p_l_15">
                                                                        <label  class="req" for="wizard_fname" class="req">Day of week</label>
                                                                        <div class="btn-group btn-group-days" id="station-point-week-days" data-toggle="buttons">
                                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                                <input type="checkbox" name="station-point-week" value="1">S</label>
                                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                                <input type="checkbox" name="station-point-week" value="1">M</label>
                                                                            <label class="btn btn-success btn-xs chk-btn ">
                                                                                <input type="checkbox" name="station-point-week" value="1">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn ">
                                                                                <input type="checkbox" name="station-point-week" value="1">W</label>
                                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                                <input type="checkbox" name="station-point-week" value="1">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                                <input type="checkbox" name="station-point-week" value="1">F</label>
                                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                                <input type="checkbox" name="station-point-week" value="1">S</label>
                                                                        </div> 
                                                                    </div>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="clear_fix_both"></div>

                                                        <div class="pull-left" id="station-point-sch-loading"></div>
                                                        <input type="hidden" name="stationactiveFlag" id="stationpointactiveFlag" value="1" />
                                                        <input type="hidden" name="station_prt_code" id="station_prt_code" value="" />
                                                        <input type="hidden" name="station_point_code" id="stationa_point_code" value="" />
                                                        <input type="hidden" name="station-point-time-range" id="station-point-time-range" value="0" />
                                                        <div class="pull-right" id="station-point-sch-button">
                                                            <input type="hidden" name="id_mnu_code" id="station_point_sch_code" value="" />
                                                            <button class="btn btn-success" type="button" onclick="saveStationPointSchedulesDialog()">Save</button>
                                                            <button class="btn btn-default" type="button" onclick="cancelStationPointSchedulesDialog();">Cancel</button>
                                                        </div>
                                                    </form>
                                                </div>   

                                                <div id="schedules-exception-station-dialog" class="dialog-content-page" style="display: none">
                                                    <div class="col-xs-12 bold pb10 pt10" id="schedules-exception-head"></div>
                                                    <div class="col-xs-12">
                                                        <ul class="nav nav-tabs" id="tabs_a_exp">
                                                            <li class="active"><a data-toggle="tab" href="#st-expt">Exception</a></li>
                                                            <li><a data-toggle="tab" href="#st-ovr">Override</a></li>
                                                        </ul>
                                                        <div class="tab-content" id="tabs_content_exp">
                                                            <div id="st-expt" class="tab-pane fade in active">
                                                                <form role="form" id="ssed" class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label class='req col-md-3' for="station-exception-schedules-date">Date</label>
                                                                        <div class="col-md-9"> 
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                                <input type="text" name="sta-exp-scd-date" id="sta-exp-scd-date" class="form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-3" for="sta-exp-scd-description">Description</label>
                                                                        <div class="col-md-9">
                                                                            <textarea id="sta-exp-scd-description" class="rs_no form-control"></textarea>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label  class="req col-md-3" >Day of week</label>
                                                                        <div class="col-md-5">
                                                                            <div class="btn-group btn-group-days" id="sta-except-week-days" data-toggle="buttons">
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">S</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">M</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">W</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">F</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-except-week" value="1">S</label>
                                                                            </div> 
                                                                        </div>

                                                                    </div>            
                                                                    <div class="clear_fix_both"></div>

                                                                    <div class="pull-left" id="sta-exp-sch-loading"></div>
                                                                    <div class="pull-right" id="sta-exp-sch-button">
                                                                        <input type="hidden" name="sta-exp-code" id="sta-exp-code" value="" />
                                                                        <input type="hidden" name="sta-prt-code" id="sta-prt-code" value="" />
                                                                        <input type="hidden" name="sta-exp-sch-code" id="sta-exp-sch-code" value="" />
                                                                        <button class="btn btn-success" type="button" onclick="saveStationExceptionDialog()">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelStationExceptionDialog()">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div id="st-ovr"  class="tab-pane fade">
                                                                <form role="form" id="ssorv" class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label class='req col-md-3' for="station-exception-schedules-date">Date</label>
                                                                        <div class="col-md-9"> 
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                                <input type="text" name="sta-ovr-scd-date" id="sta-ovr-scd-date" class="form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-3" for="sta-ovr-scd-description">Description</label>
                                                                        <div class="col-md-9">
                                                                            <textarea id="sta-ovr-scd-description" class="rs_no form-control"></textarea>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label  class="req col-md-3" >Day of week</label>
                                                                        <div class="col-md-5">
                                                                            <div class="btn-group btn-group-days" id="sta-ovr-week-days" data-toggle="buttons">
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">S</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">M</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">W</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">F</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-ovr-week" value="1">S</label>
                                                                            </div> 
                                                                        </div>

                                                                    </div>  
                                                                    <div class="form-group">
                                                                        <label  class="req col-md-3" for="station-sch-hours">Station time</label>

                                                                        <div class="col-md-9"> 
                                                                            <div>
                                                                                <input id="sta-ovr-hours" type="text" name="sta-ovr-hours" value="" />
                                                                            </div>

                                                                        </div>
                                                                        <label id="station-ovr-sch-time-label" class="col-md-2 col-xs-push-6"></label>
                                                                    </div>
                                                                    <div class="clear_fix_both"></div>

                                                                    <div class="pull-left" id="sta-ovr-sch-loading"></div>
                                                                    <div class="pull-right" id="sta-ovr-sch-button">

                                                                        <input type="hidden" name="sta-ovr-code" id="sta-ovr-code" value="" />
                                                                        <input type="hidden" name="station-ovr-time-range" id="station-ovr-time-range" value="0" />
                                                                        <input type="hidden" name="station-ovr-extra-time" id="station-ovr-extra-time" value="0" />
                                                                        <button class="btn btn-success" type="button" onclick="saveStationOverrideDialog()">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelStationExceptionDialog()">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>   
                                                    </div>
                                                </div>

                                                <div id="schedules-exception-station-point-dialog" class="dialog-content-page" style="display: none">
                                                    <div class="col-xs-12 bold pb10 pt10" id="schedules-sp-exception-head"></div>
                                                    <div class="col-xs-12">
                                                        <ul class="nav nav-tabs" id="tabs_stp_exp">
                                                            <li class="active"><a data-toggle="tab" href="#stp-expt">Exception</a></li>
                                                            <li><a data-toggle="tab" href="#stp-ovr">Override</a></li>
                                                        </ul>
                                                        <div class="tab-content" id="tabs_content_exp">
                                                            <div id="stp-expt" class="tab-pane fade in active">
                                                                <form role="form" id="ssed" class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label class='req col-md-3' for="station-exception-schedules-date">Date</label>
                                                                        <div class="col-md-9"> 
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                                <input type="text" name="sta-pit-exp-scd-date" id="sta-pit-exp-scd-date" class="form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label  class="req col-md-3" >Day of week</label>
                                                                        <div class="col-md-5">
                                                                            <div class="btn-group btn-group-days" id="sta-pit-except-week-days" data-toggle="buttons">
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">S</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">M</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">W</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">F</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-except-week" class="sta-exp-ovr-wek" value="1">S</label>
                                                                            </div> 
                                                                        </div>

                                                                    </div>

                                                                    <div class="clear_fix_both"></div>

                                                                    <div class="pull-left" id="sta-pit-exp-sch-loading"></div>
                                                                    <div class="pull-right" id="sta-pit-exp-sch-button">
                                                                        <input type="hidden" name="sta-exp-pin-code" id="sta-exp-pin-code" value="" />
                                                                        <input type="hidden" name="sta-pit-prt-exp-code" id="sta-pit-prt-exp-code" value="" />
                                                                        <input type="hidden" name="sta-pit-exp-sch-code" id="sta-pit-exp-sch-code" value="" />
                                                                        <input type="hidden" name="sta-pit-exp-fare" id="sta-pit-exp-fare" value="" />
                                                                        <input type="hidden" name="sta-pit-exp-code" id="sta-pit-exp-code" value="" />
                                                                        <button class="btn btn-success" type="button" onclick="saveStationPointSchedules()">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelStationPointExceptionDialog()">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div id="stp-ovr" class="tab-pane fade">
                                                                <form role="form" id="ssor" class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label class='req col-md-3' for="stp-ovr-sch-date">Date</label>
                                                                        <div class="col-md-9"> 
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                                <input type="text" name="sta-pit-ovr-scd-date" id="sta-pit-ovr-scd-date" class="form-control" readonly="true" value="">
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label  class="req col-md-3" >Day of week</label>
                                                                        <div class="col-md-5">
                                                                            <div class="btn-group btn-group-days" id="sta-pit-ovr-week-days" data-toggle="buttons">
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">S</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">M</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn ">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">W</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">T</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">F</label>
                                                                                <label class="btn btn-success btn-xs chk-btn">
                                                                                    <input type="checkbox" name="sta-pit-ovr-week" class="sta-exp-ovr-wek" value="1">S</label>
                                                                            </div> 
                                                                        </div>

                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label  class="req" for="sta-pit-ovr-sch-hours">Station point time</label>
                                                                        <div class="p_l_n col-md-10"> 
                                                                            <div>
                                                                                <input id="sta-pit-ovr-sch-hours" type="text" name="sta-pit-ovr-sch-hours" value="" />
                                                                                <label id="sta-pit-ovr-sch-hours-label" class="time-slot col-md-2 col-xs-push-4"></label>
                                                                            </div>

                                                                        </div>

                                                                    </div>

                                                                    <div class="clear_fix_both"></div>

                                                                    <div class="pull-left" id="sta-pit-exp-sch-loading"></div>
                                                                    <div class="pull-right" id="sta-pit-exp-sch-button">
                                                                        <input type="hidden" name="sta-pit-ovr-time-range" id="sta-pit-ovr-time-range" value="0" />
                                                                        <button class="btn btn-success" type="button" onclick="saveStationPointOverrideSchedules()">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelStationPointExceptionDialog()">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>      
                                                </div>


                                                <script>
                                                    var station_json = {$station|json_encode}
                                                    $('input[name="station-schedules-date"]').daterangepicker({
                                                        buttonClasses: ['btn', 'btn-sm'],
                                                        format: 'YYYY-MM-DD',
                                                        separator: ' | ',
                                                        showDropdowns: true
                                                    });
                                                    $('input[name="station-point-schedules-date"]').daterangepicker({
                                                        buttonClasses: ['btn', 'btn-sm'],
                                                        format: 'YYYY-MM-DD',
                                                        separator: ' | ',
                                                        showDropdowns: true
                                                    });

                                                    $('input[name="sta-exp-scd-date"]').daterangepicker({
                                                        buttonClasses: ['btn', 'btn-sm'],
                                                        format: 'YYYY-MM-DD',
                                                        separator: ' | ',
                                                        showDropdowns: true
                                                    });
                                                    $('input[name="sta-pit-exp-scd-date"]').daterangepicker({
                                                        buttonClasses: ['btn', 'btn-sm'],
                                                        format: 'YYYY-MM-DD',
                                                        separator: ' | ',
                                                        showDropdowns: true
                                                    });
                                                    $('input[name="sta-pit-ovr-scd-date"]').daterangepicker({
                                                        buttonClasses: ['btn', 'btn-sm'],
                                                        format: 'YYYY-MM-DD',
                                                        separator: ' | ',
                                                        showDropdowns: true
                                                    });
                                                    $('input[name="sta-ovr-scd-date"]').daterangepicker({
                                                        buttonClasses: ['btn', 'btn-sm'],
                                                        format: 'YYYY-MM-DD',
                                                        separator: ' | ',
                                                        showDropdowns: true
                                                    });
                                                    $('.sta-exp-ovr-lst-hide,.station-point-sch-ove-hide').hide();
                                                    //
                                                    //$('.pTip_top').powerTip({ placement: 'n' });
                                                </script>