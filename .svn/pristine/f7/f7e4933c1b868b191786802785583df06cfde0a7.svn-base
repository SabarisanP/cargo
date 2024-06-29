<div>
    <span class="pull-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showAllSpExceptionDialog('')">New Exception</a>
    </span>
    <span class="pull-left">
        <span class="bold">All Station Point Exception</span> <br>
        <i class="fa fa-info-circle"> </i> &nbsp; Exceptions created / shown here are applied to all the schedules.
    </span>
    
</div>

<br><br><br>

    {if $exceptions|@count > 0}
    <div class="row">
        <div class="col-md-12" >
            <table class="table" width="100%">
                <tr>
                    <th width="10%" align="center">Date Range</th>
                    <th width="15%" align="center">Schedules</th>
                    <th width="13%" align="center">Station</th>
                    <th width="15%" align="center">Station Points</th>   
                    <th width="15%"align="center" >Days</th>          
                    <th width="12%"align="center" >Boarding / Dropping</th>         
                    <th width="10%"align="center" >Release Before</th>         
                    <th width="5%"align="center"></th>
                </tr>
                {foreach from=$exceptions item=rule}
                    <tr>    
                        <td nowrap="nowrap">
                            {$rule->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$rule->activeTo|date_format:$ns_date_format}
                        </td >
                        
                        <td>
                            {if $rule->scheduleList|count<=0}
                                All Schedules
                            {else}
                                {foreach from=$rule->scheduleList item=schedule}
                                    {$schedule->name} {if $schedule->serviceNumber!=''}(<span class="warning-text">{$schedule->serviceNumber}</span>){/if} <br>
                                {/foreach}
                            {/if}
                        </td>
                        
                        <td>
                            {$rule->station->name}
                        </td>

                        <td>
                            {foreach from=$rule->stationPointList item=point}
                                {$point->name} <br>
                            {/foreach}
                        </td>
                        
                        <td>
                            {if $rule->dayOfWeek!=''}
                                {assign var=bday value=$rule->dayOfWeek} 
                                <div class="btn-group btn-group-days-display">                                    
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                                </div> 
                            {/if}
                        </td> 
                        
                        <td>
                            {if $rule->boardingFlag == 1 && $rule->droppingFlag == 1}
                                Boarding & Dropping
                            {elseif $rule->boardingFlag == 1}
                                Boarding
                            {elseif $rule->droppingFlag == 1}
                                Dropping
                            {/if}
                        </td>
                        
                        <td>
                            {if $rule->releaseMinutes == 0}
                                Never released
                            {else}
                                Released {($rule->releaseMinutes/60)} hours before
                            {/if}
                        </td>
                        
                        <td nowrap="nowrap">
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showAllSpExceptionDialog('{$rule->code}')">
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteAllSpException('{$rule->code}')">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>&nbsp;
                        </td>                             
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
    {else}
        <div class="well well-large "> No exceptions added!</div>
    {/if}

<!-- Schedule Time Popup -->

<div id="all-sp-exception-dialog"  class="dialog-content-page hide">

    <div style="padding:15px;">
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="aspe_schedules" class="">Schedules</label>
                    <div id="div_aspe_schedules">
                        <select id='aspe_schedules' name="aspe_schedules" class="form-control" multiple="multiple">                               
                            {foreach name=o item=row from=$schedules}
                                <option value="{$row->code}">{$row->name}{if $row->serviceNumber!=''} - <span class="warning-text">{$row->serviceNumber}</span>{/if}</option>
                            {/foreach}   
                        </select>
                    </div>  
                    <span class="help-block"> <i class="fa fa-info-circle"> </i> &nbsp; Leave blank for all schedules.</span>    
                    <div id="schaction" class="hide"></div>
                </div>
            </div> 
                        
            <div class="col-lg-4">
                <div class="form-group">
                    <label class="req" for="seat-sch-date" class="req">Station</label>
                    <select id='aspe_station' class="form-control" onchange="getStationPoints(this.value)">
                        <option value=''>Select a station</option>
                        {foreach item=station from=$stations}           
                            <option value='{$station->code}'>{$station->name}</option>
                        {/foreach} 
                    </select>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="aspe_statiopoint" class="req">Station Point</label>
                    <div id="div_aspe_statiopoint">
                        <select id='aspe_statiopoint' name="aspe_statiopoint" class="form-control" multiple="multiple">                                                                                                       
                        </select>
                    </div>                    
                    <div id="spaction" class="hide"></div>
                </div>
            </div>
            
                   
        </div>

        <div class="row">        
            <div class="col-lg-4"> 
                <div class="form-group">
                    <label for="txt_oz_name" class="req">Active From & To</label>
                    <div class="input-group">
                        <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                        <input type="text" name="aspe_daterange" id="aspe_daterange" class="form-control" readonly="true" value="">
                    </div>  
                </div>
            </div>  

            <div class="col-lg-4">     
                <div class="form-group">
                    <label for="txt_m_name" class="req">Day of Week</label>
                    <div class="btn-group btn-group-days" id="aspe_weekdays" data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1" >M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="aspe_day_of_week" value="1">S</label>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="form-group">
                    <label class="req" for="aspe_releaseminutes" class="req">Release Before</label>
                    <select id='aspe_releaseminutes' name="aspe_releaseminutes" class="form-control">
                        <option value="0">Never Release</option>               
                        <option value="60">01 hour</option>
                        <option value="120">02 hours</option>
                        <option value="180">03 hours</option>
                        <option value="240">04 hours</option>
                        <option value="360">06 hours</option>
                        <option value="480">08 hours</option>
                        <option value="720">12 hours</option>
                        <option value="1440">01 Day</option>
                        <option value="2880">02 Days</option>
                        <option value="4320">03 Days</option>
                        <option value="5760">04 Days</option>
                        <option value="7200">05 Days</option>
                    </select>
                </div>
            </div>
            
            <div class="col-lg-6 form-inline">
                <div class="form-group">
                    <label style="display: inline-block;">&nbsp;</label>
                    <input type="checkbox" id="aspe_boardingflag" checked>
                    <label style="display: inline-block;" for="aspe_boardingflag">&nbsp;Boading</label>
                </div>
                <div class="form-group">
                    <label style="display: inline-block;">&nbsp;</label>
                    <input type="checkbox" id="aspe_droppingflag">
                    <label style="display: inline-block;" for="aspe_droppingflag">&nbsp;Dropping</label>
                </div>
            </div>
                    
        </div>
                        
        <div class="row">
            <div class="col-lg-12">  
                <span class="help-block"> <i class="fa fa-info-circle"> </i> &nbsp; Above selected station point(s) will not appeared in all the schedules with the date range choosed.</span>
            </div>
        </div>            

        <div class="row">
            <div class="clear_fix_both">                       
                <div class="alert" style="display: none;" id="aspe-form-action-state"></div>
                <div class="align-right" id="aspe-form-buttons">                    
                    <input name="aspe_code" id="aspe_code" type="hidden" value="" />
                    <button class="btn btn-success" type="button" onclick="saveAllStationPointException();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeAllSpExceptionDialog();">Cancel</button>
                </div>
            </div> 
        </div>

    </div>            
</div>


<script>
    var exceptions = {$exceptions|json_encode};
    $('input[id="aspe_daterange"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
</script>