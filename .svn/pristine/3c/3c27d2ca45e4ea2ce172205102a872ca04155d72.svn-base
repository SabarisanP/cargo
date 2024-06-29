<span class="align-right">
    <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showSheduleTimeOverrideDialog()">New Time Override</a>
</span>
<br><br><br>

{if $schedulefare|@count > 0}
    <div class="col-md-12" >
        <table class="table" width="100%">
            <tr>
                <th width="20%" align="center">Date Range</th>
                <th width="15%" align="center">Station</th>
                <th width="8%" align="center">Time Changes</th>                
                <th width="10%"align="center" >Days</th>
                <th width="7%"align="center"></th>
            </tr>
            {foreach key=key from=$schedulefare item=schfare name=tao}
                <tr>    
                    <td  width="20%">
                        {$schfare->activeFrom} <span class="glyphicon glyphicon-resize-horizontal"></span> {$schfare->activeTo}
                    </td >
                    <td width="15%" >
                        {$schfare->station->name}
                    </td>
                   

                    <td  width="20%">
                        {if $schfare->overrideType == 'CRVU'} + {else} - {/if}
                        {$schfare->hours}
                        <br>
                        <span class="text-muted">
                            {if $schfare->reactionFlag} All follwoing stations {else} Only this station {/if}
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
                        <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showSheduleTimeOverrideDialog({$smarty.foreach.tao.index})">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteScheduleTimeOverride('{$schfare->code}')">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;
                        <a href="javascript:;" data-toggle="tooltip" data-original-title="{$schfare->updatedUser->name} <br/> {$schfare->updatedAt|date_format:$ns_datetime_format}">
                            <i class="fa fa fa-question-circle fa-lg"></i>
                        </a>
                    </td>                             
                </tr>
            {/foreach}
        </table>
    {else}
        <div class="well well-large "> No details dound!</div>
    {/if}
</div>

    <!-- Schedule Time Popup -->

    <div id="schtime-dialog"  class="dialog-content-page hide">

        <div style="padding:15px;">
            <div class="row" id="type1">

                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="seat-sch-date" class="req ">Station</label>
                        <select id='tao-station' class="inp_error form-control">
                            {foreach item=station from=$stations}           
                                <option value='{$station->station->code}'>{$station->station->name} - {$station->hoursminitues}</option>
                            {/foreach} 
                        </select>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="form-group text-left">
                        <label for="seat-sch-date" class="">&nbsp;</label>
                        <select id='tao-reaction' class="inp_error form-control">                                                                                                       
                            <option value='1'>Apply all following stations</option>
                            <option value='0'>Apply only this station</option>
                        </select>   
                    </div>
                </div>
                        
                <div class="col-lg-4">
                    <div class="form-group">
                        <label class="req" for="seat-sch-date" class="req">Time Override Type</label>
                        <select id='tao-time-type' class="inp_error form-control">
                            <option value="" selected="selected">Select Time Override Type</option>                                                                            
                            <option value='CRVU'>Increase Time</option>
                            <option value='DRVU'>Decrease Time</option>
                        </select>
                    </div>
                </div>
            </div>        
            
            <div class="row">      
                <div class="col-lg-12">
                    <div class="form-group">
                        <label class="req" for="seat-sch-date" class="req">Time </label>
                        <input type="text" name="tao-time" id="tao-time" class="inp_error form-control"  value="0">
                        <input type="hidden" id="tao-time-mins" />
                        <div class="text-center" id="tao-time-label"></div>
                    </div>
                </div>
            </div>              

            <div class="row">        
                <div class="col-lg-4"> 
                    <div class="form-group">
                        <label for="txt_oz_name" class="req">Active From & To</label>
                        <div class="input-group">
                            <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                            <input type="text" name="tao-daterange" id="tao-daterange" class="form-control inp_error" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                        </div>  
                    </div>
                </div>  

                <div class="col-lg-6">     
                    <div class="form-group">
                        <label for="txt_m_name" class="req">Day of Week</label>
                        <div class="btn-group btn-group-days" id="tao-weekdays" data-toggle="buttons">
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="tao-weeks" value="1">S</label>
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" value="1" name="tao-weeks">M</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="tao-weeks" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="tao-weeks" value="1">W</label>
                            <label class="btn btn-success btn-xs chk-btn active">
                                <input type="checkbox" checked="checked" name="tao-weeks" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="tao-weeks" value="1">F</label>
                            <label class="btn btn-success btn-xs chk-btn  active">
                                <input type="checkbox" checked="checked" name="tao-weeks" value="1">S</label>
                        </div>
                    </div>
                </div>
            </div>

               

            <div class="row">
                <div class="clear_fix_both">                       
                    <div class="alert fl suc_cre" style="display: none;" id="fao-schtime-form-action-state"></div>
                    <div class="align-right cre_sve" id="fao-schtime-form-buttons">
                        <button class="btn btn-success" type="button" onclick="saveScheduleTimeOverride();">Save</button>
                        <button class="btn btn-default" type="button" onclick="cancelSheduleTimeOverrideDialog();">Cancel</button>
                    </div>
                </div> 
            </div>

        </div>            
    </div>


    <input name="tao-code" id="tao-code" type="hidden" value="" />
    <script>
        var timeOverrideList = {$schedulefare|json_encode}
        $('input[id="tao-daterange"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | ',
            showDropdowns: true,
            showWeekNumbers: true,
        });
        $('[data-toggle="tooltip"]').tooltip({
            html: true,
        });        
    </script>