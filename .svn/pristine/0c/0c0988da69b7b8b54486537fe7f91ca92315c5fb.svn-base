<span class="align-right">
    <a href="javascript:;" class="btn btn-success  btn-sm" onclick="enRouteBookingDialog()">New EnRoute Booking</a>
</span>
<br><br><br>

{if $result|@count > 0}
    <div class="col-md-12" >
        <table class="table" width="100%">
            <tr>
                <th align="center">Stages</th>
                <th align="center">Day Of Week</th>
                <th align="center">Open x Hours before Schedule Time</th>
                <th align="center">Booking open pattern</th>
                <th align="right"></th>
                <th width="8%" align="right"></th>
            </tr>
            {foreach key=key from=$result item=row}
                <tr>
                    <td>
                        {foreach from=$row->stageList item=stage key=i}
                            {if $i == 0}
                                {$stage->fromStation->name} - {$stage->toStation->name}
                            {else}
                                {break}
                            {/if}
                        {/foreach}
                        &nbsp;
                        {if $row->stageList|@count >1}
                            <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                            {foreach from=$row->stageList item=stage key=i}
                                {$stage->fromStation->name} - {$stage->toStation->name} <br/>
                            {/foreach}
                            "><span class="label label-success"> {$row->stageList|@count} </span></a>
                        {/if}
                    </td>
                    <td>
                        {if $row->dayOfWeek!=''}
                            {assign var=bday value=$row->dayOfWeek}
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
                        {if $row->releaseMinutes == '-1'}
                            Never Open
                        {else}
                            {$row->releaseMinutes/60} Hours
                        {/if}
                    </td>
                    <td>{$en_route_type[$row->enRouteType->code]}</td>
                    <td align="right">
                        <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="enRouteBookingDialog('{$row->code}');">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteEnRoute('{$row->code}');">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;
                    </td>
                    <td></td>
                </tr>
            {/foreach}
        </table>
    </div>
{else}
    <div class="well well-large "> No details dound!</div>
{/if}

<div id="en-route-booking-dialog" class="dialog-content-page hide">
    <div style="padding:15px;">
        <div class="row">
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="en_route_stage" class="req">Stages</label>
                    <div class="input-group col-md-12">
                        <select id="en_route_stage" class="form-control" multiple="multiple">
                            {foreach item=row from=$routes key=key}
                                <option value="{$key}">{$row}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="enroute_weekdays" class="req">Day of Week</label>
                    <div class="btn-group btn-group-days" id="enroute_weekdays" data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1" >M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="enroute_day_of_week" value="1">S</label>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 p_l_n">
                <div class="form-group">
                    <label for="en_route_type" class="req">Booking open pattern</label>
                    <div class="input-group col-md-12">
                        <select id="en_route_type" class="form-control">
                            <option value="">Select EnRoute Type</option>
                            {foreach item=row from=$en_route_type key=key}
                                <option value="{$key}">{$row}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="form-group">
                    <label for="en_route_release" class="req">Open before Hours</label>
                    <select id="en_route_release" class="form-control">
                        <option value="">Select Hours</option>
                        <option value="-1">Never Open</option>
                        {for $i=1; $i<=24; $i++}
                            <option value="{$i*60}">{$i} Hours</option>
                        {/for}
                    </select>
                </div>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <div class="row">
            <div class="alert" style="display: none;" id="en-route-action-state"></div>
            <div class="align-right">
                <input name="" id="hid-en-route-code" type="hidden" value="" />
                <button class="btn btn-success" type="button" onclick="saveEnRouteBooking();">Save</button>
                <button class="btn btn-default" type="button" onclick="closeEnRouteBookingDialog();">Cancel</button>
            </div>
        </div>
    </div>
</div>

<script>
    var enRouteData = {$result|json_encode};

    $('#en_route_stage').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '175px',
        dropLeft: true,
        buttonClass: 'btn btn-default en_route_stage'
    });

    $(".has-popover").popover({
        trigger: 'hover',
        placement : 'right',
        container: 'body',
        html: true
    });
</script>