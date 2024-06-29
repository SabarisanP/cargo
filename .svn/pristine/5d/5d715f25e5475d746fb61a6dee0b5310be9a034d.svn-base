<div>
    <span class="pull-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showRescheduleTerms('');">New Term</a>
    </span>
    <span class="pull-left">
        <span class="bold">Schedule Ticket Transfer Terms</span>
    </span>
</div>

<br><br><br>

{if $terms|@count > 0}
<div class="row">
    <div class="col-md-12" >
        <table class="table" width="100%">
            <tr>
                <th width="1%"></th>
                <th width="15%" align="center">Date Range</th>
                <th width="15%" align="center">Schedules</th>
                <th width="15%" align="center">Routes</th>
                <th width="13%" align="center">Groups</th> 
                <th width="15%" align="center">Days</th>
                <th width="15%" align="center">Transfer Amount</th>
                <th width="10%" align="center">Transfer Allow Till</th>
                <th width="10%" align="right"></th>
            </tr>
            {foreach from=$terms item=row}
                <tr class="{if count($row->overrideList) > 0} trhover {/if}" id="{$row->code}" onclick="viewStationExceptionOverride('{$row->code}')">  
                    <td>{if count($row->overrideList) > 0} <span class="caret-ovr" style="margin:0px 10px;"></span>{/if}</td>
                    <td nowrap="nowrap">
                        {$row->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$row->activeTo|date_format:$ns_date_format}
                    </td>
                    <td>
                        {foreach from=$row->scheduleList item=schedule}
                            {$schedule->name} <br>
                        {foreachelse}
                            All Schedules
                        {/foreach}
                    </td>
                    <td>
                        {foreach from=$row->routeList item=route}
                            {$route->fromStation->name} - {$route->toStation->name}<br>
                        {foreachelse}
                            All Routes
                        {/foreach}
                    </td>
                    <td>
                        {foreach from=$row->groupList item=groups}
                            {$Allgroups[$groups->code]}<br>
                        {foreachelse}
                            All Groups
                        {/foreach}   
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
                    <td>{$row->chargeAmount} {$row->chargeType->name}</td>
                    <td>
                        {if $row->minutesType->code == "MIN"}
                            {$row->minutes/60} Hours
                        {else}
                            {$row->minutes/60} {$row->minutesType->name}
                        {/if}
                    </td>
                     <td nowrap="nowrap">
                        <a href="javascript:;" onclick='editRescheduleTerms({$row|json_encode});'>
                            {if $row->activeFlag==1}
                                <i class="fa fa-times fa-lg" data-status="0" title="Click to disable"></i>
                            {else}
                                <i class="fa fa-check fa-lg" data-status="9" title="Click to enable"></i>
                            {/if} 
                        </a>&nbsp;
                        {if $row->activeFlag==1}
                        <a class="edit pTip_top" title="Edit" href="javascript:;" onclick='showRescheduleTerms({$row|json_encode});'>
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        {/if}
                        <a class="delete pTip_top" title="Delete" href="javascript:;" onclick='deleteRescheduleTerms({$row|json_encode})'>
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Add exception / override" href="javascript:;" onclick='rescheduleTermsException({$row|json_encode})'>
                            <i class="fa fa-exclamation-circle fa-lg"></i>
                        </a>&nbsp;
                    </td>    
                </tr>
                {foreach from=$row->overrideList item=ovr}
                    <tr class="{$row->code} exp-list">
                        <td colspan="2" class="text-center text-danger">Exception List</td>
                        <td nowrap="nowrap">
                            {$ovr->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$ovr->activeTo|date_format:$ns_date_format}
                        </td>
                        <td>
                            {foreach from=$ovr->scheduleList item=schedule}
                                {$schedule->name} <br>
                            {foreachelse}
                                All Schedules
                            {/foreach}
                        </td>
                        <td>
                            {if $ovr->dayOfWeek!=''}
                                {assign var=bday value=$ovr->dayOfWeek} 
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
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick='rescheduleTermsException({$row|json_encode},"{$ovr->code}")'>
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick='deleteTermsException({$ovr|json_encode},"{$row->code}")'>
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>&nbsp;
                        </td>
                    </tr>
                {/foreach}
             {/foreach}
        </table>
    </div>
</div>
{else}
    <div class="well well-large "> No Terms added!</div>
{/if}

<div id="ticket-reschedule-terms-dialog" class="dialog-content-page hide">
    <div style="padding:15px;">
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="terms_schedules" class="req">Schedules</label>
                    <select id='terms_schedules' class="form-control" multiple="multiple">
                        <option value="">All Schedules</option>
                        {foreach item=row from=$schedules}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach}   
                    </select>  
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group text-left">
                    <label for="terms_routes" class="req">Routes</label>
                    <select id="terms_routes" class="form-control" multiple="multiple">
                        <option value="">All Routes</option>
                        {foreach item=row from=$routes}
                            <option value="{$row->fromStation->code}-{$row->toStation->code}">{$row->name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="terms_user_group" class="req">User Group</label>
                    <div class="input-group col-md-12">
                        <select id="terms_user_group" class="form-control" multiple="multiple">
                            <option value="">All User Group</option>
                            {foreach item=row from=$groupusers.groups}
                                <option  value="{$row->code}">{$row->name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="terms_daterange" class="req">Active From & To</label>
                    <div class="input-group">
                        <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                        <input type="text" id="terms_daterange" class="form-control" readonly="true" value="">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="terms_weekdays" class="req">Day of Week</label>
                    <div class="btn-group btn-group-days" id="terms_weekdays" data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1" >M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="terms_day_of_week" value="1">S</label>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="terms_reschedule_charge" class="req p_l_15">Transfer Charges</label>
                <div class="form-group col-md-6 p_r_n">
                    <div class="input-group col-md-12">
                        <span class="input-group-addon "><i class="fa fa-inr"></i></span>
                        <input type="text" id="terms_reshedule_charge" class="form-control" value="">
                    </div>
                </div>
                <div class="form-group col-md-6 p_l_n p_r_n">
                    <select id="terms_reshedule_type" class="form-control">
                        <option value="FLT">Flat</option>
                        <option value="PER">Percentage</option>
                    </select>
                </div>
            </div>
            <div class="col-lg-4 p_l_n">
                <label for="terms_minutes" class="req p_l_15">Transfer Allow Till</label>
                <div class="form-group col-md-7 p_r_n">
                    <select id="terms_minutes" class="form-control">
                        <option value="">Select</option>
                        {for $i=1; $i<=24; $i++}
                            <option value="{$i*60}">{$i}</option>
                        {/for}
                    </select> 
                </div>
                <div class="form-group col-md-5 p_l_n p_r_n">
                    <select id="terms_minutes_type" class="form-control">
                        <option value="MIN" selected>Hours</option>
                        <option value="AM">AM</option>
                        <option value="PM">PM</option>
                    </select> 
                </div>
            </div>
        </div>
                    
        <div class="clear_fix_both">                       
            <div class="alert" style="display: none;" id="ticket-terms-action-state"></div>
            <div class="align-right" id="ticket-terms-form-buttons">                    
                <input name="" id="hid-ticket-terms-code" type="hidden" value="" />
                <button class="btn btn-success" type="button" onclick="saveRescheduleTerms();">Save</button>
                <button class="btn btn-default" type="button" onclick="closeRescheduleTerms();">Cancel</button>
            </div>
        </div> 
    </div>
</div>            

<div id="reschedule-terms-override-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="basic-sch" class="form-horizontal">
        <div class="clear_fix_both"></div><br/>
        <div class="form-group">
            <label for="terms-excp-schedules" class="req control-label col-md-3">Schedules</label>
            <div class="col-md-5">
                <select id='terms-excp-schedules' class="form-control" multiple="multiple">           

                </select> 
            </div>
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label  class="req control-label col-md-3" for="terms-exp-weekdays" class="req">Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="terms-exp-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="terms_weekday_exp" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked"  name="terms_weekday_exp" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="terms_weekday_exp" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="terms_weekday_exp" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="terms_weekday_exp" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="terms_weekday_exp" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="terms_weekday_exp" value="1">S</label>
                </div> 
            </div>
        </div>   
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="col-md-3 control-label req" for="terms_excp_date" class="req">Date</label>
            <div class="col-md-9"> 
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="terms_excp_date" id="terms_excp_date" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>

        <div class="clear_fix_both"></div><br />
        <div class="pull-left" id="terms_excp_action_state"></div>
        <input type="hidden" id="terms-exp-code" value="" />
        <div class="pull-right" id="terms-exp-button">
            <button class="btn btn-success" type="button" id="terms-exp-save" onclick='saveTermsException();'>Save</button>
            <button class="btn btn-default" type="button" onclick="cancelTermsException();">Cancel</button>
        </div>
    </form>
</div>

<script>
{literal}
    $(document).ready(function(){
        $('.exp-list').hide();
    });
    
    $('#terms_schedules').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default terms_schedules',
        dropLeft: true
    });
    $('#terms_routes').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default terms_routes',
        dropLeft: true
    });
    $('#terms_user_group').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default terms_user_group',
        dropLeft: true
    });
    $('#terms_daterange').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true
    });
    $('#terms_excp_date').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true
    });
    
    function showRescheduleTerms(code){
        $('#ticket-reschedule-terms-dialog').css('background', '#fff');
        $('#ticket-reschedule-terms-dialog').removeClass('hide');
        $('#ticket-reschedule-terms-dialog').show();
        $('#ticket-reschedule-terms-dialog').dialog({
            autoOpen: true,
            height: 425,
            width: 725,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();  
        
        $('#ticket-terms-action-state').hide();
        $('.inp_error').removeClass('inp_error');
        if(code!='') {
            $('#hid-ticket-terms-code').val(code.code);
            $('#terms_daterange').val(code.activeFrom + ' | ' + code.activeTo);
            $('#terms_weekdays').find('.active').removeClass('active').removeAttr("checked");
            var str = code.dayOfWeek;
            var res = str.split("");
            $("input[name='terms_day_of_week']").each(function (i) {
                $(this).removeAttr("checked");            
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                }
            });
            if(code.scheduleList.length == 0) {
                $('#terms_schedules').multiselect('select', ['']);
            } else {
                $.each(code.scheduleList, function(i, sch) {
                    $('option[value="'+sch.code+'"]', $('#terms_schedules')).prop('selected', true);
                });
            }
            if(code.groupList.length == 0) {
                $('#terms_user_group').multiselect('select', ['']);
            } else {
                $.each(code.groupList, function(i, grp) {
                    $('option[value="'+grp.code+'"]', $('#terms_user_group')).prop('selected', true);
                });
            }
            $('#terms_routes').val(code.routeList.map(function(val){
                return val.fromStation.code + '-' + val.toStation.code;
            })).multiselect('refresh');
            $('#terms_minutes').val(code.minutes);
            $('#terms_reshedule_charge').val(code.chargeAmount);
            $('#terms_reshedule_type').val(code.chargeType.code);
            $('#terms_minutes_type').val(code.minutesType.code);
            $('#terms_schedules').multiselect('refresh');
            $('#terms_user_group').multiselect('refresh');
        } else {         
            $('#hid-ticket-terms-code').val('');
            $('#terms_daterange').val('');
            $('#terms_weekdays').find("input[name='terms_day_of_week']").each(function (i) {
                $(this).attr("checked", "checked");        
                $(this).parent().addClass('active');
            });
            $('#terms_user_group').multiselect('deselectAll', false).multiselect('refresh');
            $('#terms_schedules').multiselect('deselectAll', false).multiselect('refresh');
            $('#terms_routes').multiselect('deselectAll', false).multiselect('refresh');
            $('#terms_minutes').val('');
            $('#terms_reshedule_charge').val('');
            $('#terms_reshedule_type').val('FLT');
            $('#terms_minutes_type').val('MIN');
        }
    }
    
    function saveRescheduleTerms(){
        var data = {};
    
        var dateRange = $('#terms_daterange').val();
        var date = dateRange.split('|');
        data.activeFrom = $.trim(date[0]);
        data.activeTo = $.trim(date[1]);
        data.activeFlag = 1;
        data.code = $.trim($('#hid-ticket-terms-code').val());
        if($('#terms_schedules').val()){
            data.scheduleList = $.map($('#terms_schedules').val(), function(val) {
                return {code:val};
            });
        }
        data.routeList = $.map($('#terms_routes').val() || [], function(val) {
            val = val.split('-');
            return { 
                fromStation: { code: val[0] },
                toStation: { code: val[1] }
            };
        });
        if($('#terms_user_group').val()){
            data.groupList = $.map($('#terms_user_group').val(), function(val) {
                return {code:val};
            });
        }
        data.minutes = parseInt($('#terms_minutes').val());
        data.chargeAmount = $.trim($('#terms_reshedule_charge').val());
        data.minutesType = { code: $('#terms_minutes_type').val()};
        data.chargeType = { code: $('#terms_reshedule_type').val()};
        data.dayOfWeek = $("input[name='terms_day_of_week']").map(function () {
            return + $(this).is(':checked');
        }).get().join('');   

        $('.inp_error').removeClass('inp_error');
        var err = 0;

        if (dateRange == '') {
            $('#terms_daterange').addClass('inp_error');
            err++;
        }
        if ($('#terms_minutes').val() == '') {
            $('#terms_minutes').addClass('inp_error');
            err++;
        }
        if (data.chargeAmount == '') {
            $('#terms_reshedule_charge').addClass('inp_error');
            err++;
        }
        if ($('#terms_minutes_type').val() == '') {
            $('#terms_minutes_type').addClass('inp_error');
            err++;
        }
        if ($('#terms_schedules').val() == null) {
            $('.terms_schedules').addClass('inp_error');
            err++;
        }
        if ($('#terms_routes').val() == null) {
            $('.terms_routes').addClass('inp_error');
            err++;
        }
        if ($('#terms_user_group').val() == null) {
            $('.terms_user_group').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#ticket-terms-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#ticket-terms-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#ticket-terms-action-state').show();
            return false;
        } else {
            $('#ticket-terms-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#ticket-terms-action-state').hide();
        }

        $('#ticket-terms-form-buttons').hide();
        $('#ticket-terms-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#ticket-terms-action-state').html(loading_popup);
        $('#ticket-terms-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "scheduleextras/ticket-reshedule-terms-update",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#ticket-terms-form-buttons').hide();
                    $('#ticket-terms-action-state').removeClass('alert-danger');
                    $('#ticket-terms-action-state').addClass('alert-success');
                    $('#ticket-terms-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        closeRescheduleTerms();
                        getTicketRescheduleTerms();
                    }, 3000);
                } else {
                    $('#ticket-terms-action-state').show();
                    $('#ticket-terms-action-state').addClass('alert-danger');
                    $('#ticket-terms-action-state').html(response.errorDesc);
                    $('#ticket-terms-form-buttons').show();
                }
            }
        });
    }

    function closeRescheduleTerms() {
        $('#ticket-reschedule-terms-dialog').dialog('destroy');
        $('#ticket-reschedule-terms-dialog').hide();
    }
    
    function deleteRescheduleTerms(code) {
        if (confirm('Do you want to delete this Ticket Reschedule Term?')) {
            code.activeFlag = 2;
            var data = {};
            data = code;
            var loading_overlay = iosOverlay({
                text: "Deleting...",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "scheduleextras/ticket-reshedule-terms-update",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function () {
                            getTicketRescheduleTerms();
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
    
    function editRescheduleTerms(code){
        var data = {};
        data = code;
        var msg ='';
        if(data.activeFlag == 1){
            data.activeFlag = 0;
            msg = 'Do you want to disable this term?';
        } else {
            data.activeFlag = 1;
            msg = 'Do you want to enable this terms?';
        }
        if (confirm(msg)) {
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'JSON',
                url: base_url + "scheduleextras/ticket-reshedule-terms-update",
                data: data,
                success: function(response) {
                    if (response.status == 1) {      
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        getTicketRescheduleTerms();
                    }, 2000);
                }
            });
        }
    }
    
    function rescheduleTermsException(data,code){
        $('#reschedule-terms-override-dialog').css('background', '#fff');
        $('#reschedule-terms-override-dialog').removeClass('hide');
        $('#reschedule-terms-override-dialog').show();
        $('#reschedule-terms-override-dialog').dialog({
            autoOpen: true,
            height: 380,
            width: 600,
            modal: true,
            resizable: false
        });
        $('#terms_excp_action_state').html('');
        $('#terms-excp-schedules').html('');
        $.each(data.scheduleList, function(i, schs) {
            $('#terms-excp-schedules').append($('<option>', { 
                selected : '',
                value: schs.code,
                text : schs.name
            }));
        });    
        $('#terms-excp-schedules').multiselect('refresh');
        if(_isdefined(code)){
            $.each(data.overrideList, function(i, schs) {
                if(schs.code == code){ 
                    $('#terms_excp_date').val(schs.activeFrom + ' | ' + schs.activeTo);
                    $('#terms_weekdays').find('.active').removeClass('active').removeAttr("checked");
                    var str = schs.dayOfWeek;
                    var res = str.split("");
                    $("input[name='terms_weekday_exp']").each(function (i) {
                        $(this).removeAttr("checked").parent().removeClass('active');            
                        if (res[i] == 1) {
                            $(this).prop('checked', true);
                            $(this).parent().addClass('active');
                        }
                    });
                    schs.lookupCode = code;
                    $('#terms-excp-schedules').multiselect('refresh');
                    $('#terms-exp-save').attr('onclick','saveTermsException('+JSON.stringify(schs)+')');
                    return false;
                }
            });
        } else {
            $('#terms_excp_date').val('');
            $('#terms-excp-schedules').val('').multiselect('refresh');
            $('#terms-exp-weekdays').find("input[name='terms_weekday_exp']").each(function (i) {
                $(this).attr("checked", "checked");        
                $(this).parent().addClass('active');
            });
            data.lookupCode = data.code;
            data.code = '';
            $('#terms-exp-save').attr('onclick','saveTermsException('+JSON.stringify(data)+')');
        }
        $(".ui-dialog-titlebar").hide();
    }
    
    function cancelTermsException(){
        $('#reschedule-terms-override-dialog').dialog('destroy');
        $('#reschedule-terms-override-dialog').hide();
    }
    
    function saveTermsException(code){
        var data = code;
        var ldateSch = $('#terms_excp_date').val();
        var ldate = ldateSch.split('|');
        data.activeTo = $.trim(ldate[1]);
        data.activeFrom = $.trim(ldate[0]);
        if($('#terms-excp-schedules').val()){
            data.scheduleList = $.map($('#terms-excp-schedules').val(), function(val) {
                return {code:val};
            });
        } else {
            data.scheduleList = '';
        }
        data.dayOfWeek = $("input[name='terms_weekday_exp']").map(function () {
            return + $(this).is(':checked');
        }).get().join('');  
        data.chargeAmount = -1;

        var err = 0;
        $('#terms_excp_action_state').html('');
        $('.inp_error').removeClass('inp_error');
        if (ldateSch == '') {
            $('#terms_excp_date').addClass('inp_error');
            err++;
        }
        if (err > 0) {
            $('#terms_excp_action_state').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red.</div>');
            return false;
        }
        $('#terms_excp_action_state').html(loading_small);

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "scheduleextras/ticket-reshedule-terms-update",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#terms_excp_action_state').html('<div class="alert alert-success">Exception added successfully.</div>');
                    window.setTimeout(function () {
                        cancelTermsException();
                        getTicketRescheduleTerms();
                    }, 2000);
                } else {
                    $('#terms_excp_action_state').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                }
            }
        });
    }
    
    function deleteTermsException(code,termCode){
        if (confirm('Do you want to delete this Exception?')) {
            code.activeFlag = 2;
            code.lookupCode = termCode;
            var data = {};
            data = code;
            
            var loading_overlay = iosOverlay({
                text: "Deleting...",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "scheduleextras/ticket-reshedule-terms-update",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function () {
                            getTicketRescheduleTerms();
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
    function viewStationExceptionOverride(code){
        $('.'+code).toggle('slow');
    }
{/literal}
</script>