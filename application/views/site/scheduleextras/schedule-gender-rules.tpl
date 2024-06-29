<div>
    <span class="pull-right">
        {if $action_rights['XTRA-FEMALE-BOOK-POLICY']==1} 
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="showGenderRuleDialog();">Add New Policy</a>
        {/if}
    </span>
    <span class="pull-left">
        <span class="bold">Female Booking Policy</span> <br>
        <i class="fa fa-info-circle"> </i> &nbsp; Set how many "female only seats" allowed in a trip, system wont allow to book single female once any of the following policy matched.
    </span>
</div>

<br><br><br>

{if $rules|count > 0}
    <div class="row">
        <div class="col-md-12">
            <table class="table" width="100%">
                <tr>
                    <th class="bold">Schedule</th>
                    <th class="bold">Group</th>
                    <th class="bold">Days</th>
                    <th class="bold">Max Female only Seats</th>
                    <th class="bold">Apply till before departure</th>
                    <th></th>
                </tr>
                {foreach key=key from=$rules item=row}
                    <tr>
                        <td>
                            {if $row->scheduleList|count >0}
                                {foreach from=$row->scheduleList item=sch key=i}
                                    {if $i == 0}
                                        {$sch->name}
                                    {else}
                                        {break}
                                    {/if}
                                {/foreach}
                                {if $row->scheduleList|@count >1}
                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                    {foreach from=$row->scheduleList item=sch key=i}
                                        {$sch->name} <br/>
                                    {/foreach}
                                    "><span class="label label-success"> {$row->scheduleList|count} </span></a>
                                {/if}
                            {else}
                                All Schedules
                            {/if}
                        </td>
                        <td>
                            {if $row->groupList|count >0}
                                {foreach from=$row->groupList item=group key=i}
                                    {if $i == 0}
                                        {$group->name}
                                    {else}
                                        {break}
                                    {/if}
                                {/foreach}
                                {if $row->groupList|@count >1}
                                <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                    {foreach from=$row->groupList item=group key=i}
                                        {$group->name} <br/>
                                    {/foreach}
                                    "><span class="label label-success"> {$row->groupList|count} </span></a>
                                {/if}
                            {else}
                                All Group
                            {/if}
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
                        <td>{$row->femaleSeatCount} Seats</td>
                        <td>
                            {if $row->releaseMinutes == 0}
                                Apply Always
                            {else}
                                Till {($row->releaseMinutes/60)} hours before depart
                            {/if}
                        </td>
                        <td align="center">
                            {if $action_rights['XTRA-FEMALE-BOOK-POLICY']==1} 
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showGenderRuleDialog('{$row->code}')">
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteGenderRule('{$row->code}')">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>
                            {/if}    
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
    </div>
{else}
    <div class="well well-large "> No Discounts added!</div>
{/if}

<!-- Gender Rule Popup -->

<div id="gender-rule-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal">

        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Schedules</label>
                <select id="genrule-schedules" class="form-control" multiple="multiple">
                    <option value="ALL">All Schedules</option>
                    {foreach item=row from=$schedules}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Group</label>
                <select id="genrule-groups" class="form-control col-md-6" multiple="multiple">
                    <option value="ALL">All Groups</option>
                    {foreach name=o item=row from=$groups}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
                
        <div class="clear_fix_both"></div><br/>
                
        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="genrule-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="genrule-weekday" value="1">S</label>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="form-group">
                <label class="req" for="genrule-releaseminutes" class="req">Apply till before departure</label>
                <select id="genrule-releaseminutes" class="form-control">
                    <option value="0">Apply Always</option>               
                    <option value="60">till 1 hour before departure</option>
                    <option value="120">till 2 hour before departure</option>
                    <option value="180">till 3 hour before departure</option>
                    <option value="240">till 4 hour before departure</option>
                    <option value="360">till 6 hour before departure</option>
                    <option value="480">till 8 hour before departure</option>
                    <option value="720">till 12 hour before departure</option>
                </select>
            </div>
        </div>
        
        <div class="col-lg-7">
            <div class="form-group">
                <label class="req" for="genrule-seats" class="req">Max female only seats allowed</label>               
                <select id="genrule-seats" class="form-control">
                    <option value="1">1 Seat</option> 
                    <option value="2">2 Seats</option>               
                    <option value="3">3 Seats</option>
                    <option value="4">4 Seats</option>
                </select>
                <span class="help-block"><i class="fa fa-info-circle"></i> Each layer / deck considered separately</span>
            </div>
             
        </div>

        <div class="clear_fix_both"></div><br/>
    </form>

    <div class="clear_fix_both"></div><br>

    <div class="clear_fix_both">
        <div class="alert fl suc_cre" style="display: none;" id="genrule-form-action-state"></div>
        <div class="align-right cre_sve" id="genrule-form-buttons">
            <input type="hidden" id="genrule-code-hid" value="" />
            <button class="btn btn-success" type="button" onclick="saveGenderRule();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelGenderRule();">Cancel</button>
        </div>
    </div>
</div>

<script>
    var schGenRules = {$rules|json_encode};
    
    $('.has-popover').popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });
    
    $('#genrule-schedules').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default genrule-schedules',
        dropLeft: true
    });

    $('#genrule-groups').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default genrule-groups',
        dropLeft: true
    });
    
    function showGenderRuleDialog(code) {
        $('#genrule-form-buttons').show();
        $('#genrule-form-action-state').html('').hide();
        $('.inp_error').removeClass('inp_error');

        $('#gender-rule-dialog').css('background', '#fff');
        $('#gender-rule-dialog').removeClass('hide');
        $('#gender-rule-dialog').show();
        $('#gender-rule-dialog').dialog({
            autoOpen: true,
            height: 450,
            width: 570,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (!code) {
            $('#genrule-code-hid').val('');
            $('#genrule-releaseminutes').val('0');
            $('#genrule-schedules').multiselect('deselectAll', false).multiselect('refresh');
            $('#genrule-groups').multiselect('deselectAll', false).multiselect('refresh');
            $('#genrule-weekdays').find('input[name="genrule-weekday"]').each(function (i) {
                $(this).attr('checked', true);
                $(this).parent().addClass('active');
            });
        } else {
            var data = _.find(schGenRules, function (o) { return o.code === code; });

            $('#genrule-code-hid').val(data.code);
            $('#genrule-releaseminutes').val(data.releaseMinutes);
            $('#genrule-seats').val(data.femaleSeatCount);
            var str = data.dayOfWeek;
            var res = str.split('');
            $('input[name="genrule-weekday"]').each(function (i) {
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                } else {
                    $(this).attr('checked', false);
                    $(this).parent().removeClass('active');
                }
            });
            
            $('#genrule-schedules').val(data.scheduleList.map(function(val){
                return val.code;
            })).multiselect('refresh');
            $('#genrule-groups').val(data.groupList.map(function(val){
                return val.code;
            })).multiselect('refresh');
            
            if(data.scheduleList.length === 0) {
                $('#genrule-schedules').val(['ALL']).multiselect('refresh');
            }
            if(data.groupList.length === 0) {
                $('#genrule-groups').val(['ALL']).multiselect('refresh');
            }
        }
    }
    
    function cancelGenderRule() {
        $('#gender-rule-dialog').dialog('destroy');
        $('#gender-rule-dialog').hide();
    }
    
    function saveGenderRule() {
        $('.inp_error').removeClass('inp_error');

        var data = {};
        var err = 0;

        data.activeFlag = 1;
        data.code = $('#genrule-code-hid').val();
        data.releaseMinutes = $('#genrule-releaseminutes').val();
        data.femaleSeatCount = $('#genrule-seats').val();

        data.dayOfWeek = $('input[name="genrule-weekday"]').map(function () {
            return +$(this).is(':checked');
        }).get().join('');

        if ($('#genrule-schedules').val() == null) {
            $('.genrule-schedules').addClass('inp_error');
            err++;
        } else if($.inArray('ALL', $('#genrule-schedules').val()) != -1) {
            data.scheduleList = [{ code: '' }];
        } else {
            data.scheduleList = $.map($('#genrule-schedules').val() || [], function(val) {
                return { code: val };
            });
        }

        if ($('#genrule-groups').val() == null) {
            $('.genrule-groups').addClass('inp_error');
            err++;
        } else if($.inArray('ALL', $('#genrule-groups').val()) != -1) {
            data.groupList = [{ code: '' }];
        } else {
            data.groupList = $.map($('#genrule-groups').val() || [], function(val) {
                return { code: val };
            });
        }

        if (err > 0) {
            $('#genrule-form-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#genrule-form-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#genrule-form-action-state').show();
            return false;
        } else {
            $('#genrule-form-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#genrule-form-action-state').hide();
        }

        $('#genrule-form-buttons').hide();
        $('#genrule-form-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#genrule-form-action-state').html(loading_popup);
        $('#genrule-form-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-schedule-gender-rules',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#genrule-form-buttons').hide();
                    $('#genrule-form-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#genrule-form-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelGenderRule();
                        getScheduleExtrasGenderRules();
                    }, 3000);
                } else {
                    $('#genrule-form-action-state').show();
                    $('#genrule-form-action-state').addClass('alert-danger');
                    $('#genrule-form-action-state').html(response.errorDesc);
                    $('#genrule-form-buttons').show();
                }
            }
        });
    }
    
    function deleteGenderRule(code) {
        if (!confirm('Do you want to delete this Schedule Gender Rule?')) {
            return;
        }

        var data = _.find(schGenRules, function (o) {
            return o.code === code;
        });
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-schedule-gender-rules',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        getScheduleExtrasGenderRules();
                        return;
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            }
        });
    }
</script>