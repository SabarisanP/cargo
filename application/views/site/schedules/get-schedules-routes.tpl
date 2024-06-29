<div class="table-responsive">
    <table class="table table-hover" style="width: 90%;" id="sch-route-fare-table">
        <thead>
            <tr>
                <th width="30%">Route</th>
                    {foreach item=seat from=$seattype}
                        {if $seat['code'] != 'RRM' && $seat['code'] != 'FRS'}
                        <th data-seatcode="th-{$seat['code']}">{$seat['Type']}</th>
                        {/if}
                    {/foreach}
                <th width="10%" class="text-right">Action</th>
            </tr>
        </thead>
        <tbody>
            {foreach item=route key=fromtocode from=$routes}
                <tr>
                    <td>{$route['name']}</td>
                    {foreach item=seat from=$seattype}
                        {if $seat['code'] != 'RRM' && $seat['code'] != 'FRS'}
                            <td data-seatcode="{$seat['code']}" data-rfcode="{$route['fare'][$seat['code']]['code']}">
                                {if $route['fare'][$seat['code']]['fare']}
                                    &#8377; {$route['fare'][$seat['code']]['fare']}
                                {else}
                                    -
                                {/if}
                            </td>
                        {/if}
                    {/foreach}
                    <td align="right" nowrap>
                        <input type="hidden" id="routefare-{$fromtocode}" class="routes-ext" data-from="{$route['from']}" data-to="{$route['to']}" value="{array_values($route['fare'])|json_encode|escape}">
                        <a href="javascript:;" title="Edit Route Fare" onclick="editScheduleRouteFare('{$fromtocode}')"><i class="fa fa-pencil fa-lg"></i></a>&nbsp;
                        <a href="javascript:;" title="Delete Route Fare" onclick="deleteScheduleRouteFare('{$fromtocode}')"><i class="fa fa-trash-o fa-lg"></i></a>
                        {if $is_super_namespace==1}&nbsp;
                            <a href="javascript:;" title="Old Fares" data-toggle="popover" data-content="
                                        {foreach item=seat from=$seattype}
                                            {if $seat['code'] != 'RRM' && $seat['code'] != 'FRS'}
                                            {$route['fare'][$seat['code']]['fare'] = null}
                                            {/if}
                                        {/foreach}
                                        {foreach item=fare from=$route['fare']}
                                            {if $fare['fare']}
                                            <b>{$fare['busSeatType']->name} : </b> {$fare['fare']}<br/>
                                            {/if}
                                        {/foreach}
                                        "><i class="fa fa-info-circle fa-lg"></i></a>
                        {/if}
                    </td>
                </tr>
            {/foreach}
            <tr id="routes-schedules-form-div" style="display: none;">
                <td>
                    <div class="row">
                        <div class="col-xs-5 p_r_n">
                            <select id="routes-schedules-from" class="form-control" onchange="changeToRoutes(this.value)">
                                <option value="">Select From</option>
                                {foreach key=key from=$station item=st}
                                    {if count($station)-1 != $key}
                                        <option value="{$st->station->code}">{$stationName[$st->station->code]}</option>
                                    {/if}
                                {/foreach}   
                            </select>
                        </div>
                        <div class="col-xs-5 p_r_n">
                            <select id="routes-schedules-to" class="form-control">
                                <option value="">Select To</option>
                                {foreach key=key from=$station item=st}
                                    {if $key!=0}
                                        <option value="{$st->station->code}">{$stationName[$st->station->code]}</option>
                                    {/if}
                                {/foreach} 
                            </select>
                        </div>
                    </div>
                </td>
                {foreach item=seat from=$seattype}
                    {if $seat['code'] != 'RRM' && $seat['code'] != 'FRS'}
                        <td>
                            <div class="col-xs-10 p_l_n p_r_n">
                                <input type="number" class="routes-fare input form-control no-spin mw-100px" data-seattype="{$seat['code']}" placeholder="{$seat['Type']}" required/>
                            </div>
                        </td>
                    {/if}
                {/foreach}
                <td align="right" class="v-a-c" nowrap>
                    <input type="hidden" value="" name="routes-code" id="routes-code" />
                    <button class="btn btn-success btn-sm" type="button" onclick="saveRoutesFareSchedulesv2();">Save</button>
                    <button class="btn btn-default btn-xs" type="button" onclick="cancelRoutesSchedulesDialog();" title="Close">
                        <i class="fa fa-times-circle"></i>
                    </button>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div class="col-md-6 p_l_n" id="routes-fare-sch-loading"></div>
<div class="clear_fix_both"></div>

<div>
    <a title="Add new routes" href="javascript:;" onclick="routesSchedulesDialog();">
        <i class="fa fa-plus"></i>&nbsp;Add Routes
    </a>
</div>

{if $is_super_namespace==1}
<script>
    $('[data-toggle="popover"]').popover({
        trigger: 'hover',
        placement: 'right',
        container: 'body',
        html: true
    });
</script>
{/if}