<div>
    <span class="pull-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showVirtualBlockerDialog('');">New Criteria</a>
    </span>
    <span class="pull-left">
        <span class="bold">Virtual Seat Blocker Rules</span> <br>
    </span>
</div>
<br><br><br>

{if $exceptions|@count > 0}
    <div class="row">
        <div class="col-md-12" >
            <table class="table" width="100%">
                <tr>
                    <th width="1%"></th>
                    <th width="15%" align="center">Date Range</th>
                    <th width="25%" align="center">Schedules</th> 
                    <th width="15%" align="center">Groups</th> 
                    <th width="15%" align="center">Days</th>
                    <th width="10%" align="center"></th>
                    <th width="15%" align="center">Refresh Interval</th>
                    <th width="5%" align="center"></th>
                </tr>
                {foreach from=$exceptions item=rule}
                    <tr class="{if count($rule->exceptionList) > 0} trhover {/if}" id="{$rule->code}" onclick="viewStationExceptionOverride('{$rule->code}')">    
                        <td>{if count($rule->exceptionList) > 0} <span class="caret-ovr" style="margin:0px 10px;"></span>{/if}</td>
                        
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
                            {if $rule->groupList|count<=0}
                                All Groups
                            {else}
                                {foreach from=$rule->groupList item=groups}
                                    {$groups->name}<br>
                                {/foreach}
                            {/if}
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
                            <a href="javascript:;" class="criteria_popover" data-toggle="popover" data-content="
                                {foreach from=$rule->occuapancyblockPercentage item=row}
                                    {assign var=sep value="_"|explode:$row}
                                    When booked {$sep[0]}% seats, block {$sep[1]}% seats </br>
                                {/foreach}
                               ">Criteria</a>
                        </td>
                        
                        <td>
                            &nbsp;&nbsp;&nbsp;{$rule->refreshMinutes} min
                        </td>

                        <td nowrap="nowrap">
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick='showVirtualBlockerDialog({$rule|json_encode})'>
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick='deleteVirtualBlocker({$rule|json_encode})'>
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Add exception / override" href="javascript:;" onclick='basicExceptionDialog({$rule|json_encode})'>
                                <i class="fa fa-exclamation-circle fa-lg"></i>
                            </a>&nbsp;
                        </td>                             
                    </tr>
                    {if count($rule->exceptionList) > 0}
                        {foreach from=$rule->exceptionList item=row}
                            <tr class="{$rule->code} exp-list">
                                <td colspan="2" class="text-center text-danger">Exception List</td>
                                <td nowrap="nowrap">
                                    {$row->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$row->activeTo|date_format:$ns_date_format}
                                </td>
                                <td>
                                    {if $row->dayOfWeek!=''}
                                        {assign var=bday value=$row->dayOfWeek} 
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
                                <td colspan="4" nowrap="nowrap">
                                    <a class="edit pTip_top" title="Edit" href="javascript:;" onclick='basicExceptionDialog({$rule|json_encode},"{$row->code}")'>
                                        <i class="fa fa-pencil fa-lg"></i>
                                    </a>&nbsp;
                                    <a class="delete pTip_top" title="Delete" href="javascript:;" onclick='deleteVirtualBlockerException({$row|json_encode},{$rule|json_encode})'>
                                        <i class="fa fa-trash-o fa-lg"></i>
                                    </a>&nbsp;
                                </td>
                            </tr>
                        {/foreach}
                    {/if}
                {/foreach}
            </table>
        </div>
    </div>
{else}
    <div class="well well-large "> No Blockers available!</div>
{/if}

<div id="virtual-seat-blocker-dialog"  class="dialog-content-page hide">

    <div style="padding:15px;">
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="vseat_schedules" class="req">Schedules</label>
                    <div id="div_vseat_schedules">
                        <select id='vseat_schedules' name="vseat_schedules" class="form-control" multiple="multiple">                               
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
                    <label  for="user_group" class="req">User Group</label>
                    <div class="input-group col-md-12">
                        <select id="user_group" name="group_code"  class="form-control" multiple="multiple">
                            {foreach name=o item=row from=$groupusers.groups}                                                                    
                                <option  value="{$row->code}">{$row->name}</option>                                                                    
                            {/foreach}
                        </select> 
                        <span class="help-block"> <i class="fa fa-info-circle"> </i> &nbsp; Leave blank for all groups.</span>
                    </div>
                </div>
            </div>
                                        
            <div class="col-lg-4">
                <div class="form-group">
                    <label  for="refresh_minutes" class="req">Refresh Interval</label>
                    <div class="input-group col-md-12">
                        <select id="refresh_minutes" name="refresh_minutes"  class="form-control" >
                            {for $val=5 to 30 step 5}                                                              
                                <option value="{$val}">{$val} Minutes</option>                                                                    
                            {/for}
                        </select> 
                    </div>
                </div>
            </div>
                    
        </div>
        <div class="row">
            <div class="col-lg-4"> 
                <div class="form-group">
                    <label for="vseat_daterange" class="req">Active From & To</label>
                    <div class="input-group">
                        <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                        <input type="text" name="vseat_daterange" id="vseat_daterange" class="form-control" readonly="true" value="">
                    </div>  
                </div>
            </div>  
            
            <div class="col-lg-4">     
                <div class="form-group">
                    <label for="vseat_weekdays" class="req">Day of Week</label>
                    <div class="btn-group btn-group-days" id="vseat_weekdays" data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1" >M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="vseat_day_of_week" value="1">S</label>
                    </div>
                </div>
            </div>  
                
        </div>
        <hr>
        <h5>Criteria</h5>
        <div class="row m-t-5" id="mainRow">
            <div class="col-md-2 text-right m-t-5">When booked</div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">%</span>
                    <select name="book_seat"  class="form-control">
                        <option value='0' selected="">0</option>
                        {for $val=5 to 75 step 5}                                                              
                            <option value="{$val}">{$val}</option>                                                                    
                        {/for}
                    </select>
                </div>
            </div>
            <div class="col-md-2 m-t-5" style="margin-right:-45px">seats, Block</div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">%</span>
                    <select name="block_seat"  class="form-control">
                        <option value='0' selected="">0</option>
                        {for $val=5 to 75 step 5}                                                              
                            <option value="{$val}">{$val}</option>                                                                    
                        {/for}
                    </select>
                </div>
            </div>
            <div class="col-md-2 m-t-5">seats</div> 
        </div>
        <div class="row m-t-5">
            <div class="col-md-2 text-right m-t-5">When booked</div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">%</span>
                    <select name="book_seat"  class="form-control">
                        <option value='0' selected="">0</option>
                        {for $val=5 to 75 step 5}                                                              
                            <option value="{$val}">{$val}</option>                                                                    
                        {/for}
                    </select>
                </div>
            </div>
            <div class="col-md-2 m-t-5" style="margin-right:-45px">seats, Block</div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">%</span>
                    <select name="block_seat"  class="form-control">
                        <option value='0' selected="">0</option>
                        {for $val=5 to 75 step 5}                                                              
                            <option value="{$val}">{$val}</option>                                                                    
                        {/for}
                    </select>
                </div>
            </div>
            <div class="col-md-2 m-t-5">seats</div> 
        </div>
        <div class="row m-t-5">
            <div class="col-md-2 text-right m-t-5">When booked</div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">%</span>
                    <select name="book_seat"  class="form-control">
                        <option value='0' selected="">0</option>
                        {for $val=5 to 75 step 5}                                                              
                            <option value="{$val}">{$val}</option>                                                                    
                        {/for}
                    </select>
                </div>
            </div>
            <div class="col-md-2 m-t-5" style="margin-right:-45px">seats, Block</div>
            <div class="col-md-3">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">%</span>
                    <select name="block_seat"  class="form-control">
                        <option value='0' selected="">0</option>
                        {for $val=5 to 75 step 5}                                                              
                            <option value="{$val}">{$val}</option>                                                                    
                        {/for}
                    </select>
                </div>
            </div>
            <div class="col-md-2 m-t-5">seats</div>  
        </div>
                    
        <div id="addRow"></div>   
        <div class="m-t-5">
            <button class="btn btn-xs btn-success" type="button" id="addRowBtn" onclick="addRow();">Add Row</button>
        </div>
        
        <div class="row mrg_t_40">
            <div class="clear_fix_both">                       
                <div class="alert" style="display: none;" id="vseat-form-action-state"></div>
                <div class="align-right" id="vseat-form-buttons">                    
                    <input name="vseat_code" id="vseat_code" type="hidden" value="" />
                    <button class="btn btn-success" type="button" onclick="saveVirtualBlocker();">Save</button>
                    <button class="btn btn-default" type="button" onclick="closeVirtualBlocker();">Cancel</button>
                </div>
            </div> 
        </div>

    </div>            
</div>
                    
<div id="basic-schedule-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="basic-sch" class="form-horizontal">
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label for="excp-schedules" class="req control-label col-md-3">Schedules</label>
            <div class="col-md-5">
                <select id='excp-schedules' name="excp-schedules" class="form-control" multiple="multiple">           

                </select> 
            </div>
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label  class="req control-label col-md-3" for="exp-weekdays-exp" class="req">Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="exp-weekdays-exp" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked"  name="exp-weeks-exp" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">S</label>
                </div> 
            </div>
        </div>   
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="col-md-3 control-label req" for="basic_except" class="req">Date</label>
            <div class="col-md-9"> 
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="basic_except" id="basic_except" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>

        <div class="clear_fix_both"></div><br />
        <div class="pull-left" id="basic-except-sch-loading"></div>
        <input type="hidden" id="vseat-code" value="" />
        <div class="pull-right" id="basic-except-sch-button">
            <button class="btn btn-success" type="button" id="basic-except-save" onclick="saveBasicException()">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelBasicExceptionDialog();">Cancel</button>
        </div>
    </form>
</div>
                    
<script>
$(document).ready(function(){
    $('.exp-list').hide();
});

$('input[id="vseat_daterange"]').daterangepicker({
    buttonClasses: ['btn', 'btn-sm'],
    format: 'YYYY-MM-DD',
    separator: ' | ',
    showDropdowns: true,
    showWeekNumbers: true
});

$('input[name="basic_except"]').daterangepicker({
    buttonClasses: ['btn', 'btn-sm'],
    format: 'YYYY-MM-DD',
    separator: ' | ',
    showDropdowns: true
});

$('#vseat_schedules').multiselect({
    maxHeight: 200,
    numberDisplayed: 1,
    buttonWidth: '200px',
    dropLeft: true
});

$('#user_group').multiselect({
    maxHeight: 200,
    numberDisplayed: 1,
    buttonWidth: '200px',
    dropLeft: true
});

$(function() {
    $(".criteria_popover").popover({
        placement : 'top', 
        html: 'true',
        container: 'body',
        trigger : 'hover'
    });
});

function showVirtualBlockerDialog(code){
    $('#virtual-seat-blocker-dialog').css('background', '#fff');
    $('#virtual-seat-blocker-dialog').removeClass('hide');
    $('#virtual-seat-blocker-dialog').show();
    $('#virtual-seat-blocker-dialog').dialog({
        autoOpen: true,
        height: 600,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    if(code!='') {
        $('#vseat_code').val(code.code);
        $('#refresh_minutes').val(code.refreshMinutes);
        $('#vseat_daterange').val(code.activeFrom + ' | ' + code.activeTo);
        $('#vseat_weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = code.dayOfWeek;
        var res = str.split("");
        $("input[name='vseat_day_of_week']").each(function (i) {
            $(this).removeAttr("checked");            
            if (res[i] == 1) {
                $(this).prop('checked', true);
                $(this).parent().addClass('active');
            }
        });
        $.each(code.scheduleList, function(i, sch) {
            $('option[value="'+sch.code+'"]', $('#vseat_schedules')).prop('selected', true);
        }); 
        $.each(code.groupList, function(i, grp) {
            $('option[value="'+grp.code+'"]', $('#user_group')).prop('selected', true);
        }); 
        var obp = code.occuapancyblockPercentage;
        for(var i = 3; i < obp.length ; i++) {
            $('#addRow').append($( "#mainRow" ).clone()).addClass('temp');
        }
        $("select[name='book_seat']").each(function(j,val){
            $(this).val(obp[j].split('_')[0]);
        });
        $("select[name='block_seat']").each(function(k,val){
            $(this).val(obp[k].split('_')[1]);
        });
        $('#vseat_schedules').multiselect('refresh');
        $('#user_group').multiselect('refresh');
    } else {
        $('select').val('0');
        $('#refresh_minutes').val('5');
        $('#vseat_schedules').val('');
        $('#vseat_daterange').val('');
        $('#vseat_weekdays').find("input[name='vseat_day_of_week']").each(function (i) {
            $(this).attr("checked", "checked");        
            $(this).parent().addClass('active');
        });
        $('#vseat_code').val('');
    }
}

function closeVirtualBlocker() {
    $('#virtual-seat-blocker-dialog').dialog('destroy');
    $('#virtual-seat-blocker-dialog').hide();
    $(".temp").children().remove();
}

function saveVirtualBlocker(){
    var data = {};
    
    var dateRange = $('#vseat_daterange').val();
    var date = dateRange.split('|');
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.schedules = $.trim($('#vseat_schedules').val());
    data.groupList = $.trim($('#user_group').val());
    data.refreshMinutes = $('#refresh_minutes').val();
    data.code = $('#vseat_code').val();
    data.bookSeat = $("select[name='book_seat']").map(function () {
        return + $(this).val();
    }).get(); 
    data.blockSeat = $("select[name='block_seat']").map(function () {
        return + $(this).val();
    }).get(); 
    data.dayOfWeek = $("input[name='vseat_day_of_week']").map(function () {
        return + $(this).is(':checked');
    }).get();   
    
    $('.multiselect, #vseat_daterange').removeClass('inp_error');
    
    var err = 0;
    
    if (dateRange == '') {
        $('#vseat_daterange').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#vseat-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#vseat-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#vseat-form-action-state').show();
        return false;
    } else {
        $('#vseat-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vseat-form-action-state').hide();
    }

    $('#vseat-form-buttons').hide();
    $('#vseat-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#vseat-form-action-state').html(loading_popup);
    $('#vseat-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "scheduleextras/save-virtual-seats-block",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#vseat-form-buttons').hide();
                $('#vseat-form-action-state').removeClass('alert-danger');
                $('#vseat-form-action-state').addClass('alert-success');
                $('#vseat-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    closeVirtualBlocker();
                    getAllVirtualSeatBlocker();
                }, 3000);
            } else {
                $('#vseat-form-action-state').show();
                $('#vseat-form-action-state').addClass('alert-danger');
                $('#vseat-form-action-state').html(response.errorDesc);
                $('#vseat-form-buttons').show();
            }
        }
    });
}

function deleteVirtualBlocker(code) {
    if (confirm('Do you want to delete this Virtual Seat Blocker?')) {
        code.activeFlag = 2;
        var data = {}
        data.code = code;
        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "scheduleextras/delete-virtual-seats-block",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getAllVirtualSeatBlocker();
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }
}
function basicExceptionDialog(code,expceptionCode) {
    $('#basic-schedule-dialog').css('background', '#fff');
    $('#basic-schedule-dialog').removeClass('hide');
    $('#basic-schedule-dialog').show();
    $('#basic-schedule-dialog').dialog({
        autoOpen: true,
        height: 380,
        width: 600,
        modal: true,
        resizable: false
    });
    $('#basic-except-sch-loading').html('');
    if (_isdefined(code)) {
        if(_isdefined(expceptionCode)){
            $.each(code.exceptionList, function(i, exp) {
                if(exp.code == expceptionCode){
                    exp.lookupCode = code.code;
                    exp.occuapancyblockPercentage = code.occuapancyblockPercentage;
                    $('#vseat-code').val(JSON.stringify(exp));
                    $("input[name='exp-weeks-exp']").each(function (j) {
                        $(this).removeAttr("checked"); 
                        $(this).parent().removeClass('active');
                        if (exp.dayOfWeek[j] == 1) {
                            $(this).prop('checked', true);
                            $(this).parent().addClass('active');
                        }
                    });
                    $("#basic_except").val(exp.activeFrom + ' | ' + exp.activeTo);
                }
            });
        } else {
            code.lookupCode = code.code;
            code.code = null;
            $('#vseat-code').val(JSON.stringify(code));
            $("input[name='exp-weeks-exp']").each(function (i) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            });
            $("#basic_except").val('');
        }
        $('#excp-schedules').html('');
        $.each(code.scheduleList, function(i, schs) {
            $('#excp-schedules').append($('<option>', { 
                selected : '',
                value: schs.code,
                text : schs.name+' - '+schs.serviceNumber
            }));
        });
        $("#excp-schedules").multiselect('destroy');
        $('#excp-schedules').multiselect('refresh');
    }
    $(".ui-dialog-titlebar").hide();
}

function saveBasicException() {
    var data = JSON.parse($('#vseat-code').val());
    var ldateSch = $('#basic_except').val();
    var ldate = ldateSch.split('|');
    data.activeTo = $.trim(ldate[1]);
    data.activeFrom = $.trim(ldate[0]);
    data.scheduleList = $("#excp-schedules").val();
    data.dayOfWeek = $("#exp-weekdays-exp label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
    
    var err = 0;
    $('#basic-except-sch-loading').html('');
    $('.inp_error').removeClass('inp_error');
    if (ldateSch == '') {
        $('#basic_except').addClass('inp_error');
        err++;
    }
    if (err > 0) {
        $('#basic-except-sch-loading').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
        return false;
    }
    $('#basic-except-sch-loading').html(loading_small);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "scheduleextras/virtual-seats-block-exception",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#basic-except-sch-loading').html('<div class="alert alert-success">Exception added successfully.</div>');
                window.setTimeout(function () {
                    cancelBasicExceptionDialog();
                    getAllVirtualSeatBlocker();
                }, 2000);
            } else {
                $('#basic-except-sch-loading').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
            }
        }
    })
}

function deleteVirtualBlockerException(code,virtualBlocker){
    if (confirm('Do you want to delete this Exception?')) {
        code.activeFlag = 2;
        code.lookupCode = virtualBlocker.code;
        code.occuapancyblockPercentage = virtualBlocker.occuapancyblockPercentage;
        var data = {}
        data.code = code;
        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "scheduleextras/delete-virtual-seats-block",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getAllVirtualSeatBlocker();
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    }   
}
function cancelBasicExceptionDialog() {
    $('#basic-schedule-dialog').dialog('destroy');
    $('#basic-schedule-dialog').hide();
}
function viewStationExceptionOverride(code){
    $('.'+code).toggle('slow');
}
function addRow(){
    $('#addRow').append($( "#mainRow" ).clone()).addClass('temp');
}
</script>

<style>
    .col-md-2{
        padding:0px;
    }
    .col-md-3{
        padding:0px 5px;
        width:100px;
    }
</style>