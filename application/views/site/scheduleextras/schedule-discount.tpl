<div>
    <span class="pull-right">
        {if $action_rights['SCH-DISCOUNT']==1}
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="showDiscountDialog();">Add Discount</a>
        {/if}
    </span>
    <span class="pull-left">
        <span class="bold">Schedule Discount</span>
    </span>
</div>

<br><br><br>

{if $discount|count > 0}
    <div class="row">
        <div class="col-md-12">
            <table class="table" width="100%">
                <tr>
                    <td width="1%"></td>
                    <td width="6%" class="bold">Name</td>
                    <td width="16%" class="bold">Date Range</td>
                    <td width="15%" class="bold">Schedule</td>
                    <td width="11%" class="bold">Group</td>
                    <td width="10%" class="bold" >Device Medium</td>
                    <td width="9%" class="bold">Discount</td>
                    <td width="7%" class="bold" >Female Discount</td>
                    <td width="15%" class="bold" >Days</td>
                    <td width="10%"></td>
                </tr>
                {foreach key=key from=$discount item=row}
                    <tr class="disount-r-{$row->code} tr-hover" onclick="viewStationExceptionOverride('{$row->code}')">
                        <td>
                            {if count($row->overrideList) > 0} 
                                <span class="caret-ovr" style="margin:0px 10px;"></span>
                            {/if}
                        </td>
                        <td>{$row->name}</td>
                        <td>
                            {$row->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$row->activeTo|date_format:$ns_date_format}
                            <br>
                            <span class="text-muted">
                                {if $row->dateType == 'TXN'}
                                    Transaction Date
                                {elseif $row->dateType == 'TRP'}
                                    Travel Date
                                {/if}
                            </span>
                        </td>
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
                        <td align="left">
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
                            {if $row->deviceMedium->code=="ALL" || $row->deviceMedium->code==""}
                                All Medium
                            {else if $row->deviceMedium->code=="WEB"}
                                Website
                            {else if $row->deviceMedium->code=="MOB"}
                                Mobile Website
                            {else if $row->deviceMedium->code=="APP"}
                                Mobile APP
                            {/if}<br>
                            <span class="text-muted">
                                {if $row->authenticationType->code=="ALL" || $row->authenticationType->code==""}
                                    All Users
                                {else if $row->authenticationType->code=="ARU"}
                                    Registred Users Only
                                {/if}
                            </span>
                        </td>
                        <td>
                            {if $row->percentageFlag == 1}
                                {$row->discountValue}&nbsp;%
                            {else}
                                <i class="fa fa-rupee"></i>&nbsp;{$row->discountValue}
                            {/if}
                        </td>
                        <td>
                            {if $row->femaleDiscountFlag == 1}
                                Yes
                            {else}
                                No
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
                        <td align="center">
                            {if $action_rights['SCH-DISCOUNT']==1}
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showDiscountDialog('{$row->code}')">
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteScheduleDiscount('{$row->code}')">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Add exception" href="javascript:;" onclick="ExceptionDialog('', '{$row->code}')">
                                <i class="fa fa-exclamation-circle fa-lg"></i>
                            </a>
                            {/if}    
                        </td>
                    </tr>
                    {foreach name=expIndex from=$row->overrideList item=exp}
                        <tr class="{$row->code} exp-list" style="display: none;">
                            <td colspan="2" class="text-danger">
                                {if $smarty.foreach.expIndex.first} Exception List {/if} 
                            </td>
                            <td>{$exp->name}</td>
                            <td>
                                {$exp->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$exp->activeTo|date_format:$ns_date_format}
                            </td>
                            <td>
                                {if $exp->scheduleList|count >0}
                                    {foreach from=$exp->scheduleList item=sch key=i}
                                        {if $i == 0}
                                            {$sch->name}
                                        {else}
                                            {break}
                                        {/if}
                                    {/foreach}
                                    {if $exp->scheduleList|@count >1}
                                    <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                        {foreach from=$exp->scheduleList item=sch key=i}
                                            {$sch->name} <br/>
                                        {/foreach}
                                        "><span class="label label-success"> {$exp->scheduleList|count} </span></a>
                                    {/if}
                                {else}
                                    All Schedules
                                {/if}
                            </td>
                            <td colspan="2">
                                {if $exp->dayOfWeek!=''}
                                    {assign var=bday value=$exp->dayOfWeek} 
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
                                {if $action_rights['SCH-DISCOUNT']==1}
                                <a class="edit pTip_top" title="Edit" href="javascript:;" onclick='ExceptionDialog("{$exp->code}", "{$row->code}")'>
                                    <i class="fa fa-pencil fa-lg"></i>
                                </a>&nbsp;
                                <a class="delete pTip_top" title="Delete" href="javascript:;" onclick='deleteDiscountException("{$exp->code}", "{$row->code}")'>
                                    <i class="fa fa-trash-o fa-lg"></i>
                                </a>&nbsp;
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/foreach}
            </table>
        </div>
    </div>
{else}
    <div class="well well-large "> No Discounts added!</div>
{/if}

<!-- Discount Popup -->

<div id="discount-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal">

        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Name</label>
                <input placeholder="Name" id="dis-name"class="form-control">
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Schedules</label>
                <select id="dis-schedules" class="form-control" multiple="multiple">
                    <option value="ALL">All Schedules</option>
                    {foreach item=row from=$schedules}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>

        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" id="dis-range" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                </div>
            </div>
        </div>

        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="dis-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-weekday" value="1">S</label>
                </div>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>

        <div class="col-lg-4 p_l_n">
            <label class="req">Discount Value</label>
            <input placeholder="Discount Value" id="dis-value" class="form-control">
        </div>
        <div class="col-lg-2 p_l_n">
            <label for="txt_l_name">&nbsp;</label>
            <input style="position:relative;top:5px" type="checkbox" id="dis-percent"><span style="position:relative;top:5px">&nbsp;<b>%</b></span>
        </div>

        <div class="col-lg-6 p_l_n">
            <div>
                <label class="req">Group</label>
                <select id="dis-groups" class="form-control col-md-6" multiple="multiple">
                    <option value="ALL">All Groups</option>
                    {foreach name=o item=row from=$groups}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>

        <div class="col-lg-6 p_l_n">
            <label class="req">Device Medium</label>
            <select id="dis-device" class="form-control col-md-6">
                <option value="ALL">All</option>
                <option value="WEB">Website</option>
                <option value="MOB">Mobile Website</option>
                <option value="APP">Mobile APP</option>
            </select>
        </div>

        <div class="col-lg-6 p_l_n">
            <label class="req">Date Type</label>
            <input type="radio" name="dis-dateopt" value="TXN" class="grp_radio" checked> Transaction Date &nbsp;
            <input type="radio" name="dis-dateopt" value="TRP" class="grp_radio"> Travel Date
        </div>

        <div class="clear_fix_both"></div><br/>

        <div class="col-lg-6 p_l_n">
            <label class="req">User Type</label>
            <select id="dis-user-type" class="form-control col-md-6">
                <option value="ALL">All User</option>
                <!--<option value="GUEST">Guest Only</option>-->
                <option value="ARU">Registered Only</option>
            </select>
        </div>
        
        <div class="col-lg-6 p_l_n">
            <label>&nbsp;</label>
            <input type="checkbox" id="dis-femaleflag">
            <label style="display: inline-block; font-weight: normal;" for="dis-femaleflag">&nbsp;Female Discount</label>
        </div>
    </form>

    <div class="clear_fix_both"></div><br>

    <div class="clear_fix_both">
        <div class="alert fl suc_cre" style="display: none;" id="dis-form-action-state"></div>
        <div class="align-right cre_sve" id="dis-form-buttons">
            <input type="hidden" id="dis-code-hid" value="" />
            <button class="btn btn-success" type="button" onclick="saveDiscount();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelDiscountDialog();">Cancel</button>
        </div>
    </div>
</div>


<!-- Exception Popup -->

<div id="exception-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="basic-sch" class="form-horizontal">
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="req col-md-3">Name</label>
            <div class="col-md-9">
                <input type="text" value="" id="dis-exp-name"  class="form-control">
            </div>
        </div>
        <div class="clear_fix_both"></div><br>
        
        <div class="form-group">
            <label class=" col-md-3 req">Schedules</label>
            <div class="col-md-9">
                <select id="dis-exp-schedules" class="form-control" multiple="multiple">
                </select>
            </div>
        </div>
        <div class="clear_fix_both"></div><br>

        <div class="form-group">
            <label class="req col-md-3" for="dis-exp-weekdays" class="req">Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="dis-exp-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="dis-exp-weekday" value="1">S</label>
                </div>
            </div>
        </div>
        <div class="clear_fix_both"></div><br>

        <div class="form-group">
            <label class="col-md-3 req" class="req">Date</label>
            <div class="col-md-9">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="exp_disc_date" id="dis-exp-range" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>


        <div class="clear_fix_both"></div><br />
        <input type="hidden" id="dis-exp-code">
        <input type="hidden" id="dis-exp-dis-code">
        <div class="alert fl suc_cre" style="display: none;" id="dis-exp-action-state"></div>
        <div class="pull-right" id="dis-dis-exp-form-buttons">
            <button class="btn btn-success" type="button" onclick="saveDiscountException()">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelExceptionDialog();">Cancel</button>
        </div>
    </form>
</div>

<script>
    var schDis = {$discount|json_encode};

    $('#dis-range, #dis-exp-range').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true
    });

    $('#dis-schedules').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default dis-schedules',
        dropLeft: true
    });

    $('#dis-groups').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default dis-groups',
        dropLeft: true
    });

    $('#dis-exp-schedules').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default dis-exp-schedules',
        dropLeft: true
    });
    
    $('.has-popover').popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });

    function showDiscountDialog(code) {
        $('#dis-form-buttons').show();
        $('#dis-form-action-state').html('').hide();
        $('.inp_error').removeClass('inp_error');

        $('#discount-dialog').css('background', '#fff');
        $('#discount-dialog').removeClass('hide');
        $('#discount-dialog').show();
        $('#discount-dialog').dialog({
            autoOpen: true,
            height: 550,
            width: 570,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (!code) {
            $('#dis-code-hid').val('');
            $('#dis-name').val('');
            $('#dis-range').val('');
            $('#dis-range').data('daterangepicker').setStartDate({});
            $('#dis-range').data('daterangepicker').setEndDate({});
            $('#dis-value').val('');
            $('#dis-device').val('ALL');
            $('#dis-user-type').val('ALL');
            $('input[name="dis-dateopt"][value="TXN"]').attr('checked', true);
            $('#dis-percent').prop('checked', false);
            $('#dis-femaleflag').prop('checked', false);
            $('#dis-schedules').multiselect('deselectAll', false).multiselect('refresh');
            $('#dis-groups').multiselect('deselectAll', false).multiselect('refresh');
            $('#dis-weekdays').find('input[name="dis-weekday"]').each(function (i) {
                $(this).attr('checked', true);
                $(this).parent().addClass('active');
            });
        } else {
            var data = _.find(schDis, function (o) { return o.code === code; });

            $('#dis-code-hid').val(data.code);
            $('#dis-name').val(data.name);
            $('#dis-range').val(data.activeFrom + ' | ' + data.activeTo);
            $('#dis-range').data('daterangepicker').setStartDate(data.activeFrom);
            $('#dis-range').data('daterangepicker').setEndDate(data.activeTo);
            $('#dis-value').val(data.discountValue);
            $('#dis-device').val(data.deviceMedium.code);
            $('#dis-user-type').val(data.authenticationType.code);
            $('input[name="dis-dateopt"][value="' + data.dateType + '"]').attr('checked', true);
            $('#dis-percent').prop('checked', data.percentageFlag == 1 ? true : false);
            $('#dis-femaleflag').prop('checked', data.femaleDiscountFlag == 1);
            var str = data.dayOfWeek;
            var res = str.split('');
            $('input[name="dis-weekday"]').each(function (i) {
                $(this).attr('checked', false);
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                }
            });
            
            $('#dis-schedules').val(data.scheduleList.map(function(val){
                return val.code;
            })).multiselect('refresh');
            $('#dis-groups').val(data.groupList.map(function(val){
                return val.code;
            })).multiselect('refresh');
            
            if(data.scheduleList.length == 0) {
                $('#dis-schedules').val(['ALL']).multiselect('refresh');
            }
            if(data.groupList.length == 0) {
                $('#dis-groups').val(['ALL']).multiselect('refresh');
            }
        }
    }

    function cancelDiscountDialog() {
        $('#discount-dialog').dialog('destroy');
        $('#discount-dialog').hide();
    }

    function saveDiscount() {
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.authenticationType = {};
        data.deviceMedium = {};

        var date = $('#dis-range').val().split('|');
        var err = 0;

        data.activeFlag = 1;
        data.code = $('#dis-code-hid').val();
        data.name = $('#dis-name').val();
        data.activeFrom = $.trim(date[0]);
        data.activeTo = $.trim(date[1]);
        data.discountValue = $.trim($('#dis-value').val());
        data.dateType = $('input[name="dis-dateopt"]:checked').val();
        data.deviceMedium.code = $('#dis-device').val();
        data.authenticationType.code = $('#dis-user-type').val();
        data.percentageFlag = $('#dis-percent:checked').val() ? 1 : 0;
        data.scheduleCode = $('#sch_code').val();
        data.femaleDiscountFlag = $('#dis-femaleflag').is(':checked') ? 1 : 0;

        data.dayOfWeek = $('input[name="dis-weekday"]').map(function () {
            return +$(this).is(':checked');
        }).get().join('');

        if ($('#dis-schedules').val() == null) {
            $('.dis-schedules').addClass('inp_error');
            err++;
        } else if($.inArray('ALL', $('#dis-schedules').val()) != -1) {
            data.scheduleList = [{ code: '' }];
        } else {
            data.scheduleList = $.map($('#dis-schedules').val() || [], function(val) {
                return { code: val };
            });
        }

        if ($('#dis-groups').val() == null) {
            $('.dis-groups').addClass('inp_error');
            err++;
        } else if($.inArray('ALL', $('#dis-groups').val()) != -1) {
            data.groupList = [{ code: '' }];
        } else {
            data.groupList = $.map($('#dis-groups').val() || [], function(val) {
                return { code: val };
            });
        }

        if (data.name == '') {
            $('#dis-name').addClass('inp_error');
            err++;
        }
        if ($('#dis-range').val() == '') {
            $('#dis-range').addClass('inp_error');
            err++;
        }
        if (data.discountValue == '') {
            $('#dis-value').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#dis-form-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#dis-form-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#dis-form-action-state').show();
            return false;
        } else {
            $('#dis-form-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#dis-form-action-state').hide();
        }

        $('#dis-form-buttons').hide();
        $('#dis-form-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#dis-form-action-state').html(loading_popup);
        $('#dis-form-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-schedule-discount',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#dis-form-buttons').hide();
                    $('#dis-form-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#dis-form-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelDiscountDialog();
                        getScheduleExtrasDiscount();
                    }, 3000);
                } else {
                    $('#dis-form-action-state').show();
                    $('#dis-form-action-state').addClass('alert-danger');
                    $('#dis-form-action-state').html(response.errorDesc);
                    $('#dis-form-buttons').show();
                }
            }
        });
    }

    function deleteScheduleDiscount(code) {
        if (!confirm('Do you want to delete this Schedule discount?')) {
            return;
        }

        var data = _.find(schDis, function (o) {
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
            url: base_url + 'scheduleextras/update-schedule-discount',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        getScheduleExtrasDiscount();
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

    function ExceptionDialog(code, schcode) {
        $('#dis-dis-exp-form-buttons').show();
        $('#dis-exp-action-state').html('').hide();
        $('.inp_error').removeClass('inp_error');

        $('#exception-dialog').css('background', '#fff');
        $('#exception-dialog').removeClass('hide');
        $('#exception-dialog').show();
        $('#exception-dialog').dialog({
            autoOpen: true,
            height: 450,
            width: 500,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();
        $('#dis-exp-dis-code').val(schcode);        
        var dis = _.find(schDis, function (o) {
            return o.code === schcode;
        });
        var option = '<option value="ALL">All Schedules</option>';
        $.each(dis.scheduleList, function(i, val) {
            option += '<option value="' + val.code + '">' + val.name + '</option>';
        });
        $('#dis-exp-schedules').html(option).multiselect('rebuild');
        
        if(dis.scheduleList.length == 0) {
            $('#dis-exp-schedules').val(['ALL']).multiselect('refresh');
        }

        if (!code) {
            $('#dis-exp-code').val('');
            $('#dis-exp-name').val('');
            $('#dis-exp-range').val('');
            $('#dis-exp-range').data('daterangepicker').setStartDate({});
            $('#dis-exp-range').data('daterangepicker').setEndDate({});
            $('#dis-exp-weekdays').find("input[name='dis-exp-weekday']").each(function (i) {
                $(this).attr('checked', true);
                $(this).parent().addClass('active');
            }); 
        } else {
            var data = _.find(dis.overrideList, function (o) {
                return o.code === code;
            });
            $('#dis-exp-code').val(code);
            $('#dis-exp-name').val(data.name);
            $('#dis-exp-range').val(data.activeFrom + ' | ' + data.activeTo);
            $('#dis-exp-range').data('daterangepicker').setStartDate(data.activeFrom);
            $('#dis-exp-range').data('daterangepicker').setEndDate(data.activeTo);
            var str = data.dayOfWeek;
            var res = str.split('');
            $('input[name="dis-exp-weekday"]').each(function (i) {                
                if (res[i] == 1) {
                    $(this).prop('checked', true);
                    $(this).parent().addClass('active');
                } else {
                    $(this).attr('checked', false);
                    $(this).parent().removeClass('active');
                }
            });
            $('#dis-exp-schedules').val(data.scheduleList.map(function(val){
                return val.code;
            })).multiselect('refresh');
            
            if(data.scheduleList.length == 0) {
                $('#dis-exp-schedules').val(['ALL']).multiselect('refresh');
            }
        }
    }

    function cancelExceptionDialog() {
        $('#exception-dialog').dialog('destroy');
        $('#exception-dialog').hide();
    }

    function saveDiscountException() {
        $('.inp_error').removeClass('inp_error');
        var data = _.find(schDis, function (o) { return o.code === $('#dis-exp-dis-code').val(); }) || {};

        var dateExp = $('#dis-exp-range').val();
        var date = dateExp.split('|');
        var err = 0;

        data.code = $('#dis-exp-code').val();
        data.name = $.trim($('#dis-exp-name').val());
        data.activeFrom = $.trim(date[0]);
        data.activeTo = $.trim(date[1]);
        data.lookupCode = $('#dis-exp-dis-code').val();
        
        data.dayOfWeek = $("input[name='dis-exp-weekday']").map(function () {
            return +$(this).is(':checked');
        }).get().join('');
        
        if ($('#dis-exp-schedules').val() == null) {
            $('.dis-exp-schedules').addClass('inp_error');
            err++;
        } else if($.inArray('ALL', $('#dis-exp-schedules').val()) != -1) {
            data.scheduleList = [{ code: '' }];
        } else {
            data.scheduleList = $.map($('#dis-exp-schedules').val() || [], function(val) {
                return { code: val };
            });
        }

        if (data.name == '') {
            $('#dis-exp-name').addClass('inp_error');
            err++;
        }

        if ($('#dis-exp-range').val() == '') {
            $('#exp_disc_date').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#dis-exp-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#dis-exp-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#dis-exp-action-state').show();
            return false;
        } else {
            $('#dis-exp-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#dis-exp-action-state').hide();
        }

        $('#dis-exp-form-buttons').hide();
        $('#dis-exp-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#dis-exp-action-state').html(loading_popup);
        $('#dis-exp-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-schedule-discount-exception',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#dis-exp-form-buttons').hide();
                    $('#dis-exp-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#dis-exp-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelExceptionDialog();
                        getScheduleExtrasDiscount();
                    }, 3000);
                } else {
                    $('#dis-exp-action-state').show();
                    $('#dis-exp-action-state').addClass('alert-danger');
                    $('#dis-exp-action-state').html(response.errorDesc);
                    $('#dis-exp-form-buttons').show();
                }
            }
        });
    }
    
    function viewStationExceptionOverride(code){
        $('.' + code).toggle('slow');
    }
    
    function deleteDiscountException(code, schcode) {
        if (!confirm('Do you want to delete this Schedule discount?')) {
            return;
        }

        var dis = _.find(schDis, function (o) {
            return o.code === schcode;
        });
        var data = _.find(dis.overrideList, function (o) {
            return o.code === code;
        });
        data.activeFlag = 2;
        data.lookupCode = schcode;

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'scheduleextras/update-schedule-discount-exception',
            data: data,
            success: function (response) {
                if (response.status === 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        getScheduleExtrasDiscount();
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
