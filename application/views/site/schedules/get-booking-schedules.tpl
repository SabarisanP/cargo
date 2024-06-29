<table class="table table-hover table-design tab-wid-100" id='booking-schedules-list'>
    <tr>
        <th>Open From</th>
        <th>Close To</th>
        <th width="15%">Day of Week</th>
        <th>Date Range</th>
        <th>Group</th>
        <th>Stage</th>
        <th>Booking</th>
        <th width="10%"></th>
    </tr>
    {foreach item=bkg from=$booking}
        <tr class="sch-bk-{$bkg->code} {if count($bkg->overrideList) > 0} trhover {/if}" onclick="viewBookingExceptionOverride('{$bkg->code}')">
            <td>{$bkg->openTime}</td>
            <td>{$bkg->CloseTime}</td>
            <td>
                {if $bkg->dayOfWeek == 'ALRNATE'}
                    <span class="label label-info">Alternate Days</span>
                {else}
                    {if $bkg->dayOfWeek!=''}
                        {assign var=bday value=$bkg->dayOfWeek} 
                        <div class="btn-group btn-group-days-display">                                    
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                        </div> 
                    {else}    
                        -
                    {/if}                    
                {/if}
            </td>
            <td>
                {if $bkg->activeFrom=='' && $bkg->activeTo==''}
                    -
                {else}
                    {if $bkg->activeFrom!=''}
                        {$bkg->activeFrom|date_format:$ns_date_format}
                    {else}
                        -
                    {/if}
                    {if $bkg->dayOfWeek != 'ALRNATE'}
                        <span class="glyphicon glyphicon-resize-horizontal"></span>
                        {if $bkg->activeTo!=''}
                            {$bkg->activeTo|date_format:$ns_date_format}
                        {else}
                            -
                        {/if}
                    {/if}
                {/if}
            </td>
            <td>{if $bkg->group->name!=""}{$bkg->group->name}{else} All Group{/if}</td>
            <td>
             {if $bkg->fromStation->name!=""}{$bkg->fromStation->name} - {$bkg->toStation->name}{else} All Stage{/if}   
            </td>
            <td>
                <input type="checkbox" data-route="{$bkg->fromStation->code}-{$bkg->toStation->code}" data-code="{$bkg->code}" {if $bkg->allowBookingFlag=="1"}checked="checked"{/if} id="openclosed" name="openclosed" class="bs_switch" data-on-text="Open" data-off-text="Close" value="1" data-size="small"> 
            </td>
            <td>
                <a class="edit pTip_top" title="Edit" title="Edit booking" onclick='editBookingschedules({$bkg|json_encode})'>
                    <i class="fa fa-pencil"></i>
                </a>&nbsp;
                <a href="javascript:;" class="pTip_top" title="Delete booking" onclick="deleteBookingschedules('{$bkg->code}')">
                    <i class="fa fa-trash-o"></i>
                </a>&nbsp;
                <a class="pTip_top" title="Add booking exception/Override" href="javascript:;"  onclick="bookingExceptionDialog('{$bkg->code}', '{$bkg->group->code}')">                    <i class="fa fa-exclamation-circle"></i>
                </a>&nbsp;
            </td>
            <td> <span id="load_{$bkg->code}"></span></td>
        </tr>

        {if count($bkg->overrideList) > 0}
            <tr class="bok-sch-exp-{$bkg->code} bok-exp-ovr-lst-hide">
                <td colspan="6">
                    <div class="pull-left"><span class="text-danger"> Exception List </span></div>
                    <table class="table table-hover remove-bottom">
                        {foreach key=key from=$bkg->overrideList item=bokexp}
                            {if $bokexp->openMinitues=='-1'}
                                <tr class="bk-eo-del-{$bokexp->code}">
                                    <td width="15%">{$bokexp->activeFrom|date_format:$ns_date_format}&nbsp;&nbsp;to&nbsp;&nbsp;{$bokexp->activeTo|date_format:$ns_date_format} </td>
                                    <td width="11%">{if $bokexp->dayOfWeek!=''}
                                        <div class="btn-group btn-group-days-display">
                                            {assign var=sxday value=$bokexp->dayOfWeek}        
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
                                <td width="13%">&nbsp;</td>
                                <td width="6%" align="right">
                                    <a class="edit pTip_top" title="Edit" title="Edit booking exception" onclick='editBookingExpSchedules({$bkg|json_encode},"{$bokexp->code}")'>
                                        <i class="fa fa-pencil"></i>
                                    </a>&nbsp;
                                    <a class="delete pTip_top" title="Delete booking exception" href="javascript:;" onclick="deleteBookingExpOvrSchedules('{$bokexp->code}', '{$bkg->code}')">
                                        <i class="fa fa-trash-o"></i>
                                    </a>&nbsp;
                                </td>
                            </tr>
                            {/if}   

                                {/foreach}
                                </table>
                            </td>
                        </tr>

                        <tr class="bok-sch-ove-{$bkg->code} bok-exp-ovr-lst-hide">
                            <td colspan="6">
                                <div class="pull-left"><span class="text-danger"> Override List </span></div>
                                <table class="table table-hover">
                                    {foreach key=key from=$bkg->overrideList item=bokexp}

                                        {if $bokexp->openMinitues!='-1'}
                                            <tr class="bk-eo-del-{$bokexp->code}">
                                                <td  width="16%">{$bokexp->activeFrom|date_format:$ns_date_format}&nbsp;&nbsp;to&nbsp;&nbsp;{$bokexp->activeTo|date_format:$ns_date_format} </td>
                                                <td  width="16%">{if $bokexp->dayOfWeek!=''}
                                                    <div class="btn-group btn-group-days-display">
                                                        {assign var=sxday value=$bokexp->dayOfWeek}        
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
                                            <td  width="24%">{$bokexp->openTime}</td>
                                            <td  width="14%">{$bokexp->CloseTime}</td>
                                            <td  width="4%">{if $bokexp->allowBookingFlag == 1} <span class="label label-success">Open</span> {else} <span class="label label-danger">Close</span> {/if}</td>
                                            <td  width="5%" align="right">
                                                <a class="edit pTip_top" title="Edit" title="Edit booking exception" onclick='editBookingOvrSchedules({$bkg|json_encode},"{$bokexp->code}")'>
                                                    <i class="fa fa-pencil"></i>
                                                </a>&nbsp;
                                                <a class="delete pTip_top" title="Delete booking exception" href="javascript:;"  onclick="deleteBookingExpOvrSchedules('{$bokexp->code}', '{$bkg->code}')">
                                                    <i class="fa fa-trash-o"></i>
                                                </a>&nbsp;
                                            </td>
                                        </tr>
                                        {/if}   

                                            {/foreach}
                                            </table>
                                        </td>
                                    </tr>
                                    {/if}
                                        {/foreach}    
                                        </table>
                                        <div class="clear_fix_both"></div>
                                        <br />

                                        <a href="javascript:;"  class="pTip_top" title="Add new booking" id="toggle-booking"><i class="fa fa-plus"></i>&nbsp;Add Booking</a>
                                        <div class="clear_fix_both"></div>
                                        <br />
                                        <div class="box_content  col-md-11 toggle-booking-list">
                                            <div class="pull-left">
                                                <label> Open days/time</label>
                                                <div class="pull-left">
                                                    <div class="col-md-12 p_l_n">
                                                        <select id="open-day-booking" class="form-control">
                                                            <option value="">Days</option>
                                                            {for $d=0 to 90}
                                                                <option value="{$d}">{$d}</option>    
                                                            {/for}
                                                            <option value="100">100</option>
                                                            <option value="110">110</option>
                                                            <option value="120">120</option>
                                                        </select>
                                                    </div>
                                                </div>



                                                <div class="pull-left">
                                                    <div class="col-md-12  p_l_n">
                                                        <select id="open-hour-booking" class="form-control">
                                                            <option value="">Hours</option>
                                                            {for $h=0 to 23}
                                                                <option value="{$h}">{$h}</option>    
                                                            {/for}   
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="pull-left">
                                                    <div class="col-md-12 p_l_n">
                                                        <select id="open-min-booking" class="form-control">
                                                            <option value="">min</option>
                                                            {for $m=0 to 59}
                                                                <option value="{$m}">{$m}</option>    
                                                            {/for}   
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="pull-left">
                                                <label>Close time</label>
                                                <div class="pull-left">
                                                    <div class="col-md-12 p_l_n">
                                                        <select id="close-hour-booking" class="form-control">
                                                            <option value="">Hours</option>
                                                            <option value="-1">Till last boading point</option>
                                                            <option value="5">05 minutes</option>
                                                            <option value="15">15 minutes</option>
                                                            <option value="30">30 minutes</option>
                                                            <option value="45">45 minutes</option>
                                                            <option value="60">1 hour</option>
                                                            <option value="75">1.15 hours</option>
                                                            <option value="90">1.30 hours</option>
                                                            <option value="105">1.45 hours</option>
                                                            <option value="120">2 hours</option>
                                                            <option value="135">2.15 hours</option>
                                                            <option value="150">2.30 hours</option>
                                                            <option value="165">2.45 hours</option>
                                                            <option value="180">3 hours</option>
                                                            <option value="195">3.15 hours</option>
                                                            <option value="210">3.30 hours</option>
                                                            <option value="225">3.45 hours</option>
                                                            <option value="240">4 hours</option>
                                                            <option value="255">4.15 hours</option>
                                                            <option value="270">4.30 hours</option>
                                                            <option value="285">4.45 hours</option>
                                                            <option value="300">5 hours</option>
                                                            <option value="360">6 hours</option>
                                                            <option value="420">7 hours</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="pull-left">
                                                    <div class="pull-left">
                                                        <div class="col-md-12 p_l_n">
                                                            <select id="booking-group-schedules" class="form-control">
                                                                <option value="" selected="selected">All Group</option>
                                                                {foreach item=row from=$groups} 
                                                                    {if $row['name']!='' && $row['name']!='code'}
                                                                        <option value="{$row['code']}">{$row['name']}</option>
                                                                    {/if}
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="pull-left">
                                                <div class="pull-left">
                                                    <div class="col-md-12 p_l_n"><br>
                                                        <select id="route_stg" class="form-control" style="position:relative;top:5px">
                                                            <option value="" selected="selected">All Stage</option>
                                                             {foreach item=route from=$routes}
                                                                <option value='{$route["from"]}-{$route["to"]}'>{$route['name']}</option>
                                                             {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="pull-left">
                                                <label>Booking</label>
                                                <div class="col-md-12 m-t-5">
                                                    <div class="form-group">
                                                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" checked="checked" id="openclose" name="openclose" class="bs_switch" data-on-text="Open" data-off-text="Close" value="1" data-size="small">&nbsp;&nbsp;
                                                    </div>
                                                </div>
                                            </div>  
                                            <div class="pull-left booking-button m-t-5">
                                                <label>&nbsp;</label>
                                                <input type="hidden" id="hid-sch-bkg-code" value =""/>
                                                <button class="btn btn-success btn-xs" type="button" onclick="saveBookingSchedules()">Save</button>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            
                                            <a href="javascript:;"  class="pTip_top" title="Advanced Options" id="toggle-advanced-options" onclick="toggleAdvOpt();"><i class="fa fa-plus"></i>&nbsp;Advanced</a>
                                            <div class="clear_fix_both"></div>
                                           
                                            <div class="row" id="adv-opt-row" style="display:none">
                                                <div class="col-md-3 form-group">
                                                    <label class="p_l_15" for=""></label>
                                                    <div class="col-md-12">
                                                        <label><input type="radio" name="adv-type" id="rad-day" value="DAY">&nbsp;Day of Week</label>
                                                        <label><input type="radio" name="adv-type" id="rad-alt" value="ALT">&nbsp;Alternate</label>
                                                        <input type="hidden" id="adv-type-selected">
                                                    </div>
                                                </div>
                                                <div class="col-md-3 form-group adv-type-day" style="display:none">
                                                    <label class='col-md-12' for="adv-day-date">Date Range</label>
                                                    <div class="col-md-12"> 
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            <input type="text" name="adv-day-date" id="adv-day-date" class="form-control" readonly="true" value="">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3 form-group adv-type-day" style="display:none">
                                                    <label class="col-md-12" >Day of week</label>
                                                    <div class="col-md-12">
                                                        <div class="btn-group btn-group-days" id="adv-week-days" data-toggle="buttons">
                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                <input type="checkbox" name="adv-week-days" value="1">S</label>
                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                <input type="checkbox" name="adv-week-days" value="1">M</label>
                                                            <label class="btn btn-success btn-xs chk-btn ">
                                                                <input type="checkbox" name="adv-week-days" value="1">T</label>
                                                            <label class="btn btn-success btn-xs chk-btn ">
                                                                <input type="checkbox" name="adv-week-days" value="1">W</label>
                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                <input type="checkbox" name="adv-week-days" value="1">T</label>
                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                <input type="checkbox" name="adv-week-days" value="1">F</label>
                                                            <label class="btn btn-success btn-xs chk-btn">
                                                                <input type="checkbox" name="adv-week-days" value="1">S</label>
                                                        </div> 
                                                    </div>
                                                </div> 
                                                <div class="form-group col-md-2" id="adv-type-alt" style="display:none">
                                                    <label for="adv-date">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="from" class="form-control sdate" id="adv-date" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="booking-schedules-exception" class="dialog-content-page" style="display: none">
                                            <div class="col-xs-12">
                                                <ul class="nav nav-tabs" id="tabs_bok_exp">
                                                    <li class="active"><a data-toggle="tab" href="#bok-expt">Exception</a></li>
                                                    <li><a data-toggle="tab" href="#bok-ovr">Override</a></li>
                                                </ul>
                                                <div class="tab-content" id="tabs_content_a">
                                                    <div id="bok-expt" class="tab-pane fade in active">
                                                        <form role="form" id="bok-exp-sch" class="form-horizontal">

                                                            <div class="form-group">
                                                                <label class='req col-md-3' for="station-exception-schedules-date">Date</label>
                                                                <div class="col-md-9"> 
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                        <input type="text" name="bok-exp-scd-date" id="bok-exp-scd-date" class="form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class='req col-md-3' for="group">Group</label>
                                                                <div class="col-md-9"> 
                                                                    <select id="booking-group-exp-schedules" class="form-control" disabled>
                                                                        <option value="" selected="selected">All Group</option>
                                                                        {foreach item=row from=$groups} 
                                                                            {if $row['name']!='' && $row['name']!='code'}
                                                                                <option value="{$row['code']}">{$row['name']}</option>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label  class="req col-md-3" >Day of week</label>
                                                                <div class="col-md-5">
                                                                    <div class="btn-group btn-group-days" id="bok-except-week-days" data-toggle="buttons">
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-except-week" value="1">S</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-except-week" value="1">M</label>
                                                                        <label class="btn btn-success btn-xs chk-btn ">
                                                                            <input type="checkbox" name="bok-except-week" value="1">T</label>
                                                                        <label class="btn btn-success btn-xs chk-btn ">
                                                                            <input type="checkbox" name="bok-except-week" value="1">W</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-except-week" value="1">T</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-except-week" value="1">F</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-except-week" value="1">S</label>
                                                                    </div> 
                                                                </div>
                                                            </div> 

                                                            <div class="pull-left" id="book-sch-exo-loading"></div>
                                                            <input type="hidden" name="bok-sch-exp-code" id="bok-sch-exp-code" />
                                                            <input type="hidden" name="bok-sch-exp-code" id="hid-bok-sch-exp-code" />
                                                            <div class="pull-right" id="routes-sch-exp-button">
                                                                <button class="btn btn-success" type="button" onclick="saveBookingExceptionSchedules()">Save</button>
                                                                <button class="btn btn-default" type="button" onclick="cancelBookingExceptionSchedulesDialog();">Cancel</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                    <div id="bok-ovr"  class="tab-pane fade">
                                                        <form role="form" id="bok-ovr-sch" class="form-horizontal">
                                                            <div class="form-group">
                                                                <label class='req col-md-3' for="bok-ovr-scd-date">Date</label>
                                                                <div class="col-md-9"> 
                                                                    <div class="input-group">
                                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                        <input type="text" name="bok-ovr-scd-date" id="bok-ovr-scd-date" class="form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class='req col-md-3'> Open days/time</label>
                                                                <div class="col-md-9"> 
                                                                    <div class="pull-left">
                                                                        <div class="col-md-12 p_l_n">
                                                                            <select id="open-day-ovr-booking" class="form-control">
                                                                                <option value="">Days</option>
                                                                                <option value="-1">Always open</option>
                                                                                {for $d=1 to 90}
                                                                                    <option value="{$d}">{$d}</option>    
                                                                                {/for}   
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="pull-left">
                                                                        <div class="col-md-12  p_l_n">
                                                                            <select id="open-hour-ovr-booking" class="form-control">
                                                                                <option value="">Hours</option>
                                                                                {for $h=0 to 23}
                                                                                    <option value="{$h}">{$h}</option>    
                                                                                {/for}   
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="pull-left">
                                                                        <div class="col-md-12 p_l_n">
                                                                            <select id="open-min-ovr-booking" class="form-control">
                                                                                <option value="">min</option>
                                                                                {for $m=0 to 59}
                                                                                    <option value="{$m}">{$m}</option>    
                                                                                {/for}   
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            
                                                            <div class="row">
                                                                <div class="form-group col-md-8">
                                                                    <label  class="req col-md-5" >Closed time</label>
                                                                    <div class="col-md-7">       
                                                                        <select id="close-hour-exp-booking" class="form-control">
                                                                            <option value="">Hours</option>
                                                                            <option value="-1">Still last boading point</option>
                                                                            <option value="15">15 min</option>
                                                                            <option value="30">30 min</option>
                                                                            <option value="45">45 min</option>
                                                                            <option value="60">1 hour</option>
                                                                            <option value="75">1.15 hour</option>
                                                                            <option value="90">1.30 hour</option>
                                                                            <option value="105">1.45 hour</option>
                                                                            <option value="120">2 hour</option>
                                                                            <option value="135">2.15 hour</option>
                                                                            <option value="150">2.30 hour</option>
                                                                            <option value="165">2.45 hour</option>
                                                                            <option value="180">3 hour</option>
                                                                            <option value="195">3.15 hour</option>
                                                                            <option value="210">3.30 hour</option>
                                                                            <option value="225">3.45 hour</option>
                                                                            <option value="240">4 hour</option>
                                                                            <option value="255">4.15 hour</option>
                                                                            <option value="270">4.30 hour</option>
                                                                            <option value="285">4.45 hour</option>
                                                                            <option value="300">5 hour</option>
                                                                        </select>

                                                                    </div>
                                                                </div>

                                                                <div class="form-group col-md-4">
                                                                    <label class="req col-md-7 p_r_n">Booking</label>
                                                                    <div class="col-md-5">
                                                                        <input type="checkbox" id="bok-ovr-openclose" name="openclose" class="bs_switch" data-on-text="Open" data-off-text="Close" value="1" data-size="small">
                                                                    </div>                                                                   
                                                                </div>
                                                            </div>
                                                                            
                                                            <div class="form-group">
                                                                <label  class="req col-md-3" >Day of week</label>
                                                                <div class="col-md-5">
                                                                    <div class="btn-group btn-group-days" id="bok-ovr-week-days" data-toggle="buttons">
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">S</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">M</label>
                                                                        <label class="btn btn-success btn-xs chk-btn ">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">T</label>
                                                                        <label class="btn btn-success btn-xs chk-btn ">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">W</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">T</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">F</label>
                                                                        <label class="btn btn-success btn-xs chk-btn">
                                                                            <input type="checkbox" name="bok-ovr-week" value="1">S</label>
                                                                    </div> 
                                                                </div>
                                                            </div> 
                                                            <div class="pull-left" id="book-sch-ovr-loading"></div>
                                                            <input type="hidden" name="rout-sch-exp-code" id="rout-sch-ovr-code" />
                                                            <input type="hidden" name="bok-sch-ovr-code" id="hid-bok-sch-ovr-code" />
                                                            <div class="pull-right" id="routes-sch-exp-button">
                                                                <button class="btn btn-success" type="button" onclick="saveBookingOverrideSchedules()">Save</button>
                                                                <button class="btn btn-default" type="button" onclick="cancelBookingExceptionSchedulesDialog();">Cancel</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <script>
                                            // $('.pTip_top').powerTip({ placement: 'n' });
                                            $('input[name="bok-exp-scd-date"],input[name="bok-ovr-scd-date"], input[name="adv-day-date"]').daterangepicker({
                                                buttonClasses: ['btn', 'btn-sm'],
                                                format: 'YYYY-MM-DD',
                                                separator: ' | '
                                            });
                                             $('#adv-date').datepicker({
                                                format: 'yyyy-mm-dd',
                                                autoclose: true,
                                                changeMonth: true
                                            });
                                            $('.bok-exp-ovr-lst-hide').hide();
                                            $('.bs_switch').bootstrapSwitch('size', 'small');

                                            $('.bs_switch').on('switchChange.bootstrapSwitch', function (e, data) {
                                                var $el = $(data.el), value = data.value;
                                                if ($(this).attr('id') == 'openclosed') { //   schedule status update    
                                                    var booking_code = $(this).attr('data-code');
                                                    var state = 0;
                                                    if (value) {
                                                        var state = 1
                                                    }
                                                    var stg = $(this).data('route');
                                                    updateScheduleBookingStatus(booking_code, state, stg);
                                                }
                                            });
                                            $('input[name="adv-type"]').on('change', function(e) {
                                                $('#adv-type-alt').hide();
                                                $('.adv-type-day').hide();
                                                if(this.value == "DAY"){
                                                    $('.adv-type-day').show();
                                                    $('#adv-type-selected').val('DAY');
                                                } else if(this.value == "ALT"){
                                                    $('#adv-type-alt').show();  
                                                    $('#adv-type-selected').val('ALT');                                                  
                                                }
                                            });
                                        </script>