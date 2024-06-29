{if $schedulesactive|count==0} 
    <div class="well well-large"> Sorry! No active schedule(s) available.</div>
{else}  
    <div class="table-responsive">
        <div class="box_content1 search-filter">
            <div class="col-md-3"> 
                <label for="name">Schedule Name</label>
                <!-- <input type="text" name="schd_name" id="schd_name" class="form-control">-->

                <select id="schd_name" class="form-control">  
                    <option value="">Select</option>
                    {foreach from=$schedulesactive item=row}
                        <option value="{$row['name']}">{$row['name']}</option>   
                    {/foreach}
                </select>

            </div>
            <div class="col-md-3"> 
                <label for="from">From Station</label>
                <select id="schd_from" class="form-control">  
                    <option value="">Select</option>
                    {foreach from=$from item=row}
                        <option value="{$row}">{$row}</option>   
                    {/foreach}
                </select>
            </div>
            <div class="col-md-3"> 
                <label for="from">To Station</label>
                <select id="schd_to" class="form-control">  
                    <option value="">Select</option>
                    {foreach from=$to item=row}
                        <option value="{$row}">{$row}</option>   
                    {/foreach}
                </select>
            </div>
            <div class="col-md-2">
                <label>&nbsp;</label>
                <button class="btn btn-success btn-sm" type="button" onclick="filterSchedule()">&nbsp;Search</button>
                <button  type="button" class="btn btn-default btn-sm" onclick="closeFilterSchedule()">&nbsp;Cancel</button>
            </div>
        </div>

        <div class="clear_fix_both"></div>
        <br>
        <div class="content hide" id="filter1">
        </div>
        <div class="content hide" id="filter2">
        </div>
        <div class="content hide" id="filter3">
        </div>

        <table class="table info_table table-hover" id="act-sch-tbl" width="100%">
            <thead>
                <tr class="noborder">
                    <th width="25%"><!--<a href="javascript:;" id="busname" class="trigger" >-->Name and Bus Type<!--</a>--></th>
                    <th width="10%">Schedule ID</th>
                    <th width="15%">Date Range</th>
                    <th width="12%"><!--<a href="javascript:;" id="busf" class="trigger1" data-placement="left">-->From Station <!--</a>--></th>
                    <th width="12%"><!--<a href="javascript:;" id="bust" class="trigger2">-->To Station<!--</a>--></th>                    
                    <th width="10%">Fare</th>
                        {*<th>Station</th>*}
                    <th width="10%">
            <div class="pull-left"> 
                <span class='txt_green' ><i class="fa fa-list"></i> {$totalSchedules} &nbsp;Found</span>
                 &nbsp;&nbsp;
                <span><a title="Filter Schedules" href="javascript:;" id="filter"><i class="fa fa-filter"></i></a></span>
            </div>
            </th>
            </tr>
            </thead>
            <tbody>
                
                {foreach from=$schedulesactive item=tag key=keyname }   
                    
                    {if $keyname!=""}
                    <tr class="noborder">
                        <td colspan="7" class="noborder">
                            <div class="schedule-tag">
                                <h5 class="txt_orange">{$keyname}</h5>
                            </div>
                        </td> 
                    </tr>   
                    {/if}
                    
                    {foreach from=$tag item=row name=inssch}  
                    <tr class="schd_rows" id="sch-{$row['code']}" data-name="{$row['name']}" data-from="{$row['startStation']}" data-to="{$row['endStation']}">
                        <td width="25%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if} >
                            <div class="pull-left">
                                <h5>{$row['name']}</h5>
                                <span class="text-muted">{$row['BusType']} </span>
                            </div>

                        </td>
                        <td width="10%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if}> 
                            <div class="pull-left"> 
                                <span class='txt_green'>{$row['code']}</span><br>
                                <span class='warning-text'>{$row['serviceNumber']}</span>
                            </div>
                        </td>
                        <td width="15%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if}>
                            <div class="pull-left">
                                {$row['activeFrom']|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span>
                                {$row['activeTo']|date_format:$ns_date_format} 
                                <br>
                                {if $row['daysDiff1']>3}
                                    {if $row['daysDiff']<=7 && $row['dayOfWeek']==1111111}
                                        <span class="label label-success">Special</span>
                                    {elseif $row['daysDiff']>7 && $row['dayOfWeek']==1111111}
                                        <span class="label label-default">Regular</span>
                                    {else}
                                        <span class="label label-info">Weekend</span>
                                    {/if}
                                {else if $row['daysDiff1']<3}   
                                    {if $row['daysDiff']<=7 && $row['dayOfWeek']==1111111}
                                        <span class="label label-success">Special</span>
                                    {elseif $row['daysDiff']>7 && $row['dayOfWeek']==1111111}
                                        <span class="label label-danger">Ending soon</span>
                                    {else}
                                        <span class="label label-info">Weekend</span>
                                    {/if}
                                {/if}
                                {if $row['scheduleTagList']}
                                    <span id="sch-tag-{$row['code']}"  class="sch-tag">
                                        <i class="fa fa-tags" aria-hidden="true"></i>
                                    </span>
                                {/if}
                                {if $row['sectorList']}
                                    <span id="sch-sector-{$row['code']}"  class="sch-sector">
                                        <i class="fa fa-sliders" aria-hidden="true"></i>
                                    </span>
                                {/if}
                            </div>
                        </td>
                        <td width="12%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if}>
                            <div class="pull-left">
                                {if $row['startStation']==''}
                                    -
                                {else}
                                    <span class='txt_green'><i class="fa fa-level-up"></i></span>
                                    &nbsp;{$row['startStation']}
                                {/if}<br>
                                <span class="text-muted">
                                    {if $row['fromStationTime']!=''}
                                        {$row['fromStationTime']}
                                    {else}-
                                    {/if}
                                </span>
                            </div> 
                        </td>
                        <td width="12%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if}>
                            <div class="pull-left">
                                {if $row['endStation']==''}
                                    -
                                {else}
                                    <span class='txt_green'><i class="fa fa-level-down"></i></span>
                                    &nbsp;{$row['endStation']}
                                {/if}<br>
                                <span class="text-muted">
                                    {if $row['toStationTime']!=''}
                                        {$row['toStationTime']}
                                    {else}-
                                    {/if}
                                </span>
                            </div> 
                        </td>
                        <td width="10%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if}> 
                            <div class="pull-left"> 
                                {if $row['faremin']!=''}
                                    <span class='txt_green'><i class="fa fa-rupee"></i></span>&nbsp;{$row['faremin']}
                                    {/if}
                                    {if  $row['faremax']!=''}
                                    , <span class='txt_green'><i class="fa fa-rupee"></i></span>&nbsp;{$row['faremax']}
                                    {/if}    
                            </div>
                        </td>
                        <td width="16%" {if $smarty.foreach.inssch.index==0} class="noborder" {/if}>
                            {assign var=estr value=10|mt_rand:2000}
                            <div class="pad-top8"></div>
                            <div class="btn-group">
                                {if $action_rights['SCH-EDIT-BUTTON']==1} 
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        <i class="fa fa-cog"></i> <span class="caret"></span>
                                    </button>{/if}
                                    {if $action_rights['SCH-EDIT']==1 || 
                                        $action_rights['SCH-EDIT-STATION']==1 || 
                                        $action_rights['SCH-EDIT-ROUTES']==1}
                                        <ul class="dropdown-menu sch">
                                            {if $action_rights['SCH-EDIT']==1}
                                                <li class>
                                                    <a href="#schedules/edit-schedules?r={$estr|md5}&t=0&i={$row['code']}&type=active" title="Edit Schedule">Edit Schedule</a>
                                                </li>
                                            {/if}
                                            {if $action_rights['SCH-EDIT-STATION']==1}
                                                <li>
                                                    {assign var=rstr value=10|mt_rand:2000}
                                                    <a href="#schedules/edit-schedules?r={$rstr|md5}&t=1&i={$row['code']}&type=active" title="Edit Station">
                                                        Edit Station
                                                    </a>
                                                </li>
                                            {/if}
                                            {if $action_rights['SCH-EDIT-ROUTES']==1}
                                                <li> {assign var=stid value=10|mt_rand:2000}                                        
                                                    <a href="#schedules/edit-schedules?r={$stid|md5}&t=3&i={$row['code']}&type=active" title="Edit routes">
                                                        Edit Routes
                                                    </a>
                                                </li>
                                            {/if}
                                            
                                            <li>                                    
                                                <a href="javascript:;" onclick="cloneSchedule('{$row['code']}');" title="Clone this schedule">
                                                    Save As
                                                </a>
                                            </li>
                                            
                                            <li> 
                                                <a href="javascript:;" title="Export details" onClick="exportSchedule('{$row['code']}')">
                                                    Export Details
                                                </a>
                                            </li>
                                        </ul>
                                    {/if}
                                            </div>

                                            {if $action_rights['SCH-CLOSE']==1} 
                                                <a href="javascript:;" onclick="setScheduleState('{$row['code']}', 0)" title="Close Schedule" class="btn btn-default btn-xs"><i class="fa fa fa-eye-slash"></i></a>
                                                <a href="javascript:;" onclick="getScheduleAdvanceBookingGraph('{$row['code']}', '{$row['name']}')" title="Advance Booking Trends" class="btn btn-default btn-xs"><i class="fa fa fa-bar-chart"></i></a>
                                            {/if}
                                            {if $action_rights['SCH-VIEW-MORE-OPTION']==1}  
                                                <a id="schs-{$row['code']}"  data-schedule-code="{$row['code']}" title="More Options" class="viw_mre btn btn-default btn-xs" data-bus-type = "{$row['BusCode']}"><i class="fa fa-arrow-down"></i></a>
                                            {/if}
                                        </td>
                                    </tr>

                                    {/foreach}
                                    
                                    {/foreach}
                                        <tr id="com-workspace">
                                            <td colspan="7" style="background-color:#fff;">
                                                <div id="act-sch-workspace" class="hide">
                                                    <div class="pull-right">
                                                        <a href="javascript:;" title="Close options" class="btn-lg"  onclick="closeScheduleOptions()">
                                                            <i class="fa fa-times-circle ired fa-lg"></i>
                                                        </a>
                                                    </div>
                                                    <div id="sch-workspace-content"></div>    
                                                </div>
                                                <div class="err-act" id="err" style="position:relative;left:126px;display:none"></div>
                                                <div class="err-acts"></div>
                                            </td>                                            
                                        </tr>

                                    </tbody>
                                </table>  

                            </div>
                            
                            <!-- clone popup -->
                            <div class="hide" id="sch-clone" style="background-color: #fff;">
                                <form role="form" id="form_org" class="form-horizontal ">
                                <div class="">
                                    <div class="col-lg-12 col-sm-12 col-xs-12">
                                         
                                        <label>Please select options want to copied</label>
                                        
                                        <ul class="user_list">
                                            
                                            <li>                                                 
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="STATION" class="chk_sch_clone">
                                                    <lable>Stations</lable>
                                                </div>                                                 
                                            </li>
                                            
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="STATIONPOINT" class="chk_sch_clone">
                                                    <lable>Station Points</lable>
                                                </div>                                                
                                            </li>
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="BUS" class="chk_sch_clone">
                                                    <lable>Bus Type</lable>
                                                </div>                                                
                                            </li>
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="STAGEFARE" class="chk_sch_clone">
                                                    <lable>Fare</lable>
                                                </div>                                                
                                            </li>
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="TERMS" class="chk_sch_clone">
                                                    <lable>Cancellation Terms</lable>
                                                </div>                                                
                                            </li>                                            
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="CONTROL" class="chk_sch_clone">
                                                    <lable>Booking Control</lable>
                                                </div>                                                
                                            </li>
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="DISCOUNT" class="chk_sch_clone">
                                                    <lable>Discount</lable>
                                                </div>                                                
                                            </li>
                                            <li>                                                
                                                <div class="radio1">
                                                    <input type="checkbox" checked="checked" id="" value="VISIBILITY" class="chk_sch_clone">
                                                    <lable>Visiblity Rights</lable>
                                                </div>                                                
                                            </li>
                                             
                                        </ul>
                                    
                                        
                                    </div>  
                                    
                                    <br/> 
                                    <div class="clear_fix_both">
                                        <div class="col-lg-12 col-sm-12 col-xs-12">
                                            <div class="text-right">
                                                <div class="col-lg-offset-3 col-sm-offset-3 col-xs-offset-3 col-lg-4 col-sm-4 col-xs-4 text-right">
                                                    <div class="radio1">
                                                        <input type="radio" checked="checked" id="sch_clone_type_same" name="sch_clone_type" value="ONWARD" class="chk_sch_clone_type">
                                                        <lable for="sch_clone_type_same">As Same</lable>
                                                    </div>
                                                </div>
                                                <div class="col-lg-5 col-sm-5 col-xs-5 text-right">
                                                    <div class="radio1">
                                                        <input type="radio" id="sch_clone_type_reverse" name="sch_clone_type" value="RETURN" class="chk_sch_clone_type">
                                                        <lable for="sch_clone_type_reverse">As Opposite Service</lable>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>                                
                                <br/><br/>
                                <div class=" clear_fix_both">                                    
                                    <div class=" text-right" id="save-as-bttons">
                                        <input type="hidden" id="clone_sch_id" value="">
                                        <button class="btn btn-success" type="button" onclick="doClone();">Continue</button>
                                        <button class="btn btn-default" type="button" onclick="closeClonePopup();">Cancel</button>
                                    </div>
                                    <div class=" text-right hide alert" id="save-as-action">
                                        
                                    </div>
                                </div> 
                                </form>
                            </div>            
                                        
                            <input type="hidden" id="log" value="">
                            <input type="hidden" id="ref" value="">
                            <input type="hidden" id="rel" value="">
                            <input type="hidden" id="excp" value="">
                            <input type="hidden" id="visible" value="">
                            <input type="hidden" id="discount" value="">
                            <input type="hidden" id="visibility_r" value="">
                            <input type="hidden" id="sch_code" value="">
                            <input type="hidden" id="station_sch" value="">
                            <input type="hidden" id="canc_sch" value="">
                            <input type="hidden" id="book_sch" value="">
                            <input type="hidden" id="rout_sch" value="">
                            <input type="hidden" id="sfare" value="">
                            <input type="hidden" id="schfare" value="">
                            <input type="hidden" id="schtimeoverride" value="">
                            <input type="hidden" id="schgallery" value="">
                            <input type="hidden" id="schstops" value="">
                            <input type="hidden" id="schdp" value="">   
                            <input type="hidden" id="bus-type-sch-seat" value="">
                            <script type="text/template" id="sch-options">
                                <div class="tabbable tabs-left">
                                <ul class="nav nav-tabs" id="tabs_c">
                                <li class="active"><a data-toggle="tab" href="#basic_info" id="bs_sch">Basic Info</a></li>
                                <li><a data-toggle="tab" id="exception" href="#exp">Exception</a></li>
                                
                                {if $action_rights['SCH-SEAT-VISIBILITY']==1}
                                    <li><a data-toggle="tab" href="#seat_visiblity" id="seat-visi" >Seat Visiblity</a></li>
                                {/if}                 
                                
                                {if $action_rights['SCH-FARE-OVERRIDE']==1}
                                    <li><a data-toggle="tab" href="#schedule_fare" id="schedule-fare" >Fare Auto Override</a></li>
                                {/if}   
                                {if $action_rights['SCH-VIW-ADV-BOOK']==1}
                                <li>
                                    <a data-toggle="tab" href="#schedule_calendar" id="schedule-calendar">Trip Calendar</a>
                                </li>
                                {/if}    
                                
                                <li><a data-toggle="tab" id="rights" href="#visib_rights">Visibility Rights</a></li>
                                                               
                                {if $action_rights['SCH-GENDER-PREF']==1}
                                <li><a data-toggle="tab" id="reference" href="#referenced">Seat Preference</a></li>
                                {/if}
                                    
                                {if $action_rights['SCH-TIME-OVERRIDE']==1}
                                <li><a data-toggle="tab" href="#schedule_time_override" id="schedule-time-override" >Time Auto Override</a></li>
                                {/if}                                 
                                
                                {if $action_rights['SCH-SEAT-AUTO-RELES']==1}
                                <li><a data-toggle="tab" id="release" href="#released">Auto Release / Confirm</a></li>
                                {/if}                                 
                                    
                                {if $action_rights['SCH-SEAT-FARE']==1}
                                <li><a data-toggle="tab" href="#seat_fare" id="seat-fare" >Seat Fare</a></li>     
                                {/if}
                                    
                                {if $action_rights['SCH-GALLERY']==1}
                                <li><a data-toggle="tab" href="#schedule_gallery" id="schedule-gallery" >Photo Gallery</a></li>
                                {/if}
                                
                                {if $action_rights['SCH-TRAVEL-STOPS']==1}
                                <li><a data-toggle="tab" href="#schedule_stops" id="schedule-stops" >Travel Stops</a></li>
                                {/if}
                                    
                                {if $action_rights['SCH-DYNAMIC-FARE']==1}
                                <li><a data-toggle="tab" href="#schedule_dynamicprice" id="schedule-dynamicprice" >Dynamic Pricing</a></li>
                                {/if}
                                    
                                {if $action_rights['SCH-BUSTYPE-OVERRIDE']==1}    
                                <li><a data-toggle="tab" href="#schedule_bus_override" id="schedule-bus-override" >Change Bus Type</a>
                                </li>
                                {/if}
                                
                                {if $action_rights['SCH-ENROUTE-BOOKING']==1}
                                <li><a data-toggle="tab" href="#en_route_booking" id="en-route-booking" >En-Route Booking</a>
                                </li>
                                {/if}
                                </ul>
                                
                                    
                                <div class="tab-content" id="tabs_content_c">
                                <div id="basic_info" class="tab-pane in active sch-act">
                                <span id="load_basic"></span>
                                </div>
                                <div id="exp" class="tab-pane sch-act">
                                <span id="load_exp"></span>
                                </div>
                                <div id="seat_visiblity" class="tab-pane sch-act">
                                <span id="load"></span>
                                </div>
                                <div id="schedule_caldr" class="tab-pane sch-act">
                                    <div class="monthly" id="sch-monthly"></div>
                                </div>
                                <div id="visib_rights" class="tab-pane sch-act">
                                <span id="load_rights"></span>
                                </div> 
                                <div id="released" class="tab-pane sch-act">
                                <span id="load_released"></span>
                                </div> 
                                <div id="referenced" class="tab-pane sch-act">
                                <span id="load_referenced"></span>
                                </div> 
                                <div id="seat_fare" class="tab-pane sch-act">
                                <span id="load_fare"></span>
                                </div>
                                <div id="schedule_fare" class="tab-pane sch-act">
                                <span id="load_schfare"></span>
                                </div>
                                <div id="schedule_time_override" class="tab-pane sch-act">
                                    <span id="load_schtime"></span>
                                </div>
                                <div id="schedule_gallery" class="tab-pane sch-act">
                                    <span id="load_schgallery"></span>
                                </div>
                                <div id="schedule_stops" class="tab-pane sch-act">
                                    <span id="load_schstops"></span>
                                </div>
                                <div id="schedule_dp" class="tab-pane sch-act">
                                    <span id="load_schdp"></span>
                                </div>
                                <div id="schedule_bus_over" class="tab-pane sch-act">
                                    <span id="load_sch_bus"></span>
                                </div>
                                <div id="en_route_booking" class="tab-pane sch-act">
                                    <span id="en_route"></span>
                                </div>
                                </div>
                              </div>
                            </script>
                            <script type="text/template" id="info">
                              
                              <ul class="nav nav-tabs-2" id="tabs_c">
                                <li class="fl"><a data-toggle="tab" id="schinfo" href="#schi">Schedule Details</a></li>
                                {if $action_rights['SCH-AUDIT-LOG']==1}
                                    <li class="fl"><a data-toggle="tab" href="#audit_log" id ="audit">Audit Log</a></li>
                                {/if}
                                <li class="fl"><a data-toggle="tab" id="station" href="#stat">Station</a></li>
                                <li class="fl"><a data-toggle="tab" id="booking" href="#book">Booking</a></li>
                                <li class="fl"><a data-toggle="tab" id="route" href="#rout">Route & Fare</a></li>
                                <li class="fl"><a data-toggle="tab" id="cancel" href="#canc">Cancellation</a></li>
                               </ul>      
                              <div class="clear_fix_both"></div> 
                              <div class="tab-content">
                                 <div id="stat" class="tab-pane tab2">
                                    <span id="station-schedules-list"></span>
                                 </div>
                                 <div id="audit_log" class="tab-pane tab2">
                                     <span id="load_audit"></span>
                                 </div> 
                                 <div id="rout" class="tab-pane tab2">
                                     <span id="route-list"></span>
                                 </div>
                                <div id="book" class="tab-pane tab2">
                                   <span id="book-list"></span>
                                </div>
                                 <div id="canc" class="tab-pane tab2">
                                     <span id="cancel-list"></span>
                                 </div>
                                 <div id="schi" class="tab-pane tab2">
                                    <div class=" pd_bt_45">
                                    <div class="col-xs-12 p_l_n">
                                    <div>
                                    <label class="col-md-12" style="font-size:13px" id="sch_name"></label>
                                    </div>
                                    </div>
                                    <div class="col-xs-6 p_l_n">
                                    <div>
                                    <label for="txt_m_name" class="col-md-4" style="font-size:13px">From Station  </label>
                                    <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="from_sch"></label>
                                    </div>
                                    </div>
                                    <div class="col-xs-6 p_l_n">
                                    <div>
                                    <label for="txt_m_name" class="col-md-4" style="font-size:13px">To Station:</label>
                                    <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="to_sch"></label>
                                    </div>
                                    </div>   
                                    <div class="clear_fix_both"></div>
                                    <div class="col-xs-6 p_l_n">
                                    <div>
                                    <label for="txt_m_name" class="col-md-4" style="font-size:13px">Date Range  </label>
                                    <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="date_sch"></label>
                                    </div>
                                    </div>
                                    <div class="col-xs-6 p_l_n">
                                    <div>
                                    <label for="txt_m_name" class="col-md-4" style="font-size:13px">Bus Type </label>
                                    <label class="col-md-8" style="font-weight:lighter;font-size:13px" id="bus_sch"></label>
                                    </div>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div class="col-xs-6 p_l_n">
                                    <div>
                                    <label for="txt_m_name" class="col-md-4">Fare </label>
                                    <label class="col-md-8" style="font-weight:lighter" id="fare_sch"><br/>                    
                                    </label>
                                    </div>
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="col-xs-6 p_l_n">
                                    <div >
                                    <label for="txt_m_name" class="col-md-4" >BusCode  </label>
                                    <label class="col-md-8" style="font-weight:lighter" id="travel_sch"></label>
                                    </div>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div class="col-xs-6 p_l_n">
                                    <div>
                                    <label for="txt_m_name" class="col-md-4">Day Of Week </label>
                                    <div class="btn-group btn-group-days" id="week_days" data-toggle="buttons">
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">S</label>
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">M</label>
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">T</label>
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">W</label>
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">T</label>
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">F</label>
                                        <label class="btn btn-success btn-xs chk-btn">
                                            <input type="checkbox" checked="checked" name="busweek" value="0">S</label>
                                    </div> 
                                    </div> 
                                    </div>
                                    </div>
                                    </div>
                                    </div>
                                </div>  
                            </script>    
                            <script>
                               
                                var activeSchedule = {$schedulesactive_raw|json_encode};
                                $('.bs_switch').bootstrapSwitch('size', 'mini');
                                $('.well').hide();
                                $('[data-toggle=popover]').popover({
                                    container: "body",
                                    html: true
                                });
                                $.each(activeSchedule, function(t,tik){
                                    var tagContent = '';
                                    if( _isdefined(tik.scheduleTagList) ) {
                                        $.each(tik.scheduleTagList, function(t,pik){
                                            tagContent += pik.name+'<br/>';
                                        });

                                        $("#sch-tag-"+tik.code).popover({
                                                trigger: 'hover',
                                                placement : 'right',
                                                content:tagContent,
                                                html: true
                                        });
                                    }
                                    
                                    var sectorContent = '';
                                    if( _isdefined(tik.sectorList) ) {
                                        $.each(tik.sectorList, function(t,row){
                                            sectorContent += row.name+'<br/>';
                                        });
                                    }
                                    
                                    $("#sch-sector-"+tik.code).popover({
                                            trigger: 'hover',
                                            placement : 'right',
                                            content:sectorContent,
                                            html: true
                                    });
                                });
                                $('.viw_mre').click(function () {
                                    if(!$('#sch-workspace-content').html()){
                                        $('#trip-settings').html('');   //  clear trip setting container to aviod conflit

                                        var code = $(this).attr('data-schedule-code');
                                        $('.schd_rows').removeClass('last-active');
                                        $('#sch-' + code).addClass('last-active open');

                                        $('#visibility_r').val('');
                                        $('#visible').val('');
                                        $('#station_sch').val('');
                                        $('#canc_sch').val('');
                                        $('#rout_sch').val('');
                                        $('#book_sch').val('');
                                        $('#log').val('');
                                        $('#ref').val('');
                                        $('#rel').val('');
                                        $('#excp').val('');
                                        $('#sfare').val('');
                                        $('#schfare').val('');
                                        $('#schdp').val('');
                                        $('#schtimeoverride').val('');

                                        $('#sch_code').val(($(this).attr("data-schedule-code")));
                                        $('#bus-type-sch-seat').val(($(this).attr("data-bus-type")));
                                        $('#act-sch-tbl tbody tr').each(function () {
                                            $(this).addClass("hide");
                                        });
                                        $('#sch-' + $(this).attr("data-schedule-code")).removeClass('hide');
                                        $(this).removeClass("hide");
                                        $(this).addClass("active-row");
                                        $('#com-workspace').removeClass("hide");
                                        $('#act-sch-workspace').removeClass('hide');
                                        $('#sch-workspace-content').html($('#sch-options').html());
                                        $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('.tab-pane').find('#load').html(loading_popup);
                                        $('#act-sch-tbl').removeClass("no-footer");
                                        $('#act-sch-tbl').removeClass("no-footer");
                                        $('#seat-visi').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#seat_visiblity').addClass('active');
                                            if ($('#visible').val() != '1') {
                                                getSeatVisiblitySchedules();
                                                init_seat_visiblity(); //   init seat visiblity options.
                                            }
                                            $('#visible').val(1);
                                        });

                                        $('#rights').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            if ($('#visibility_r').val() != '1') {
                                                getScheduleRights();
                                            }
                                            $('#visibility_r').val(1);
                                        });

                                        $('#disc').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            if ($('#discount').val() != '1') {
                                                getScheduleDiscount();
                                            }
                                            $('#discount').val(1);
                                        });

                                        $('#release').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            //$('.sch-act').removeClass('active');
                                            //$('#released').addClass('active');
                                            //$('li').removeClass('active');
                                            //$(this).parent('li').addClass('active');
                                            if ($('#rel').val() != '1') {
                                                getScheduleSeatAutoRelease();
                                            }
                                            $('#rel').val(1);
                                        });

                                        $('#reference').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#referenced').addClass('active');
                                            //$('li').removeClass('active');
                                            //$(this).parent('li').addClass('active');
                                            if ($('#ref').val() != '1') {
                                                getScheduleSeatPreference();
                                            }
                                            $('#ref').val(1);
                                        });
                                        $('#seat-fare').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#seat_fare').addClass('active');
                                            if ($('#sfare').val() != '1') {
                                                getSeatFare();
                                                // init_seat_visiblity(); //   init seat visiblity options.
                                            }
                                            $('#sfare').val(1);
                                        });

                                        $('#schedule-fare').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_fare').addClass('active');
                                            if ($('#schfare').val() != '1') {
                                                getScheduleAutoOverride();
                                                // init_seat_visiblity(); //   init seat visiblity options.
                                            }
                                            $('#schfare').val(1);
                                        });

                                        $('#schedule-time-override').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_time_override').addClass('active');
                                            if ($('#schtimeoverride').val() != '1') {
                                                getScheduleTimeAutoOverride();
                                                // init_seat_visiblity(); //   init seat visiblity options.
                                            }
                                            $('#schtimeoverride').val(1);
                                        });

                                        $('#schedule-gallery').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_gallery').addClass('active');
                                            if ($('#schtimegallery').val() != '1') {
                                                getScheduleGallery();
                                            }
                                            $('#schtimegallery').val(1);
                                        });

                                        $('#schedule-stops').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_stops').addClass('active');
                                            if($('#load_schstops').is(':empty')){
                                                getTravelStops();
                                            }
                                        });

                                        $('#schedule-dynamicprice').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_dp').addClass('active');
                                            //if ($('#schdp').val() != '1') {
                                                getDynamicPricingMaster();
                                            //}
                                            $('#schdp').val(1);
                                        });

                                        $('#exception').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            $('.sch-act').removeClass('active');
                                            $('#exception_list').addClass('active');
                                            if ($('#excp').val() != '1') {
                                                getScheduleExceptions();
                                            }
                                            $('#excp').val(1);
                                        });
                                        $('#schedule-calendar').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            var sch_code = $('#sch_code').val();
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_caldr').addClass('active');
                                            if(!$('#sch-monthly-'+sch_code).html()){
                                                $('#schedule_caldr').html('<div class="monthly" id="sch-monthly-'+sch_code+'"></div>');
                                                getScheduleCalendar();
                                            }
                                        });
                                        
                                        $('#schedule-bus-override').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            var sch_code = $('#sch_code').val();
                                            $('.sch-act').removeClass('active');
                                            $('#schedule_bus_over').addClass('active');
                                            if($('#load_sch_bus').is(':empty')){
                                                getScheduleBusOverride();
                                            }
                                        });

                                        $('#en-route-booking').click(function () {
                                            clearAllTabWorkSpace();
                                            $('#err').html('');
                                            var sch_code = $('#sch_code').val();
                                            $('.sch-act').removeClass('active');
                                            $('#en_route_booking').addClass('active');
                                            if($('#en_route').is(':empty')){
                                                getEnRouteBooking();
                                            }
                                        });


                                        $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#basic_info').html($('#info').html());

                                        $('#schinfo').trigger('click');
                                        $('#bs_sch').click(function(){
                                             $('#schinfo').trigger('click');
                                        });

                                        $('#audit').click(function () {
                                            $('.tab2').removeClass('active');
                                            $('#err').html('');
                                            $('.err-act').html('');
                                            if ($('#log').val() != '1') {
                                                getAuditLog();
                                            }
                                            $('#log').val(1);
                                        });

                                        $('#booking').click(function () {
                                            $('#err').html('');
                                            if ($('#book_sch').val() != '1') {
                                                $('.tab2').removeClass('active');
                                                $('#book').addClass('active');
                                                bookingschedulesAct();
                                            }
                                            $('#book_sch').val(1);
                                        });

                                        $('#station').click(function () {
                                            $('#err').html('');
                                            if ($('#station_sch').val() != '1') {
                                                $('.tab2').removeClass('active');
                                                $('#stat').addClass('active');
                                                getSchedulesStation(1);
                                                $('#sts').remove();
                                                $('span[id|="sta_act"]').remove();
                                                $('span[id|="sta_act_ovr"]').remove();
                                            }
                                            $('#station_sch').val(1);
                                        });


                                        $('#cancel').click(function () {
                                            $('#err').html('');
                                            if ($('#canc_sch').val() != '1') {
                                                $('.tab2').removeClass('active');
                                                $('#canc').addClass('active');
                                                cancelSchedules(1);
                                                $('.panel-info').removeClass('panel');
                                                $('div[id|="sta_can"]').remove();
                                            }
                                            $('#canc_sch').val(1);
                                        });

                                        $('#route').click(function () {
                                            $('#err').html('');
                                            if ($('#rout_sch').val() != '1') {
                                                $('.tab2').removeClass('active');
                                                $('#rout').addClass('active');
                                                load_sch_routes();
                                            }
                                            $('#rout_sch').val(1);

                                        });


                                        $.each(activeSchedule, function (t, tik) {
                                            var sch_cd = $('#sch_code').val();
                                            if (sch_cd == tik.code) {
                                                $('#from_sch').html(tik.startStation + ' ' + tik.fromStationTime);
                                                $('#to_sch').html(tik.endStation + ' ' + tik.toStationTime);
                                                $('#date_sch').html(tik.activeFrom + ' to ' + tik.activeTo);
                                                $('#bus_sch').html(tik.BusType);
                                                $('#fare_sch').html(tik.faremin);
                                                $('#travel_sch').html(tik.BusCode);
                                                var dayofweek = tik.dayOfWeek;
                                                var res = dayofweek.split("");                                            
                                                $("input[name='busweek']").each(function (i) {
                                                    if (res[i] == 1) {
                                                        $(this).attr("checked", "checked");//.addClass('active');
                                                        $(this).parent().addClass('active');
                                                    }

                                                });
                                            }
                                        });
                                    }
                                });
                                var busnames = '';
                                var busfrom = '';
                                var busto = '';
                                $.each(activeSchedule, function (t, tik) {
                                    busnames += '<input type="checkbox" class="vehicleChkBox" id="' + tik.name + '">   ' + tik.name + "<br>";
                                    busfrom += '<input type="checkbox" class="vehicleChkBox1" id="' + tik.startStation + '">   ' + tik.startStation + "<br>";
                                    busto += '<input type="checkbox" class="vehicleChkBox2" id="' + tik.endStation + '">   ' + tik.endStation + "<br>";
                                });
                                $('#filter1').html(busnames);
                                $('#filter2').html(busfrom);
                                $('#filter3').html(busto);

                                $(function () {
                                    
                                    $('.search-filter').hide();
                                    $('#filter').click(function(){
                                        $('.search-filter').toggle('slow');
                                        closeFilterSchedule();
                                    });
                                    
                                    $('.trigger').popover({
                                        html: true,
                                        content: function () {
                                            return $('#filter1').html();
                                        }
                                    });
                                    $('.trigger1').popover({
                                        html: true,
                                        content: function () {
                                            return $('#filter2').html();
                                        }
                                    });
                                    $('.trigger2').popover({
                                        html: true,
                                        content: function () {
                                            return $('#filter3').html();
                                        }
                                    });
                                    $('body').on('click', '.vehicleChkBox', function () {
                                        if ($('input:checkbox:checked').length == 0) {
                                            $('.schd_rows').show();
                                            $(this).prop('checked', false);
                                        } else {
                                            $('.schd_rows').hide();
                                            if ($("input.vehicleChkBox1:checked").length > 0) {
                                                $('input.vehicleChkBox1:checked').each(function () {
                                                    if ($(this).prop('checked') == true) {
                                                        var schd_name = $(this).attr('id');
                                                        $('#act-sch-tbl tbody tr[data-from="' + schd_name + '"]').show();
                                                    }
                                                });
                                            }
                                            if ($("input.vehicleChkBox2:checked").length > 0) {
                                                $('input.vehicleChkBox2:checked').each(function () {
                                                    if ($(this).prop('checked') == true) {
                                                        var schd_name = $(this).attr('id');
                                                        $('#act-sch-tbl tbody tr[data-to="' + schd_name + '"]').show();
                                                    }
                                                });
                                            }

                                            $('input.vehicleChkBox:checked').each(function () {
                                                if ($(this).prop('checked') == true) {
                                                    var schd_name = $(this).attr('id');
                                                    $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"]').show();
                                                }
                                            });
                                        }
                                    });

                                    $('body').on('click', '.vehicleChkBox1', function () {
                                        if ($('input:checkbox:checked').length == 0) {
                                            $('.schd_rows').show();
                                            $(this).prop('checked', false);
                                        } else {
                                            $('.schd_rows').hide();
                                            if ($("input.vehicleChkBox:checked").length > 0) {
                                                $('input.vehicleChkBox:checked').each(function () {
                                                    if ($(this).prop('checked') == true) {
                                                        var schd_name = $(this).attr('id');
                                                        $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"]').show();
                                                    }
                                                });
                                            }
                                            if ($("input.vehicleChkBox2:checked").length > 0) {
                                                $('input.vehicleChkBox2:checked').each(function () {
                                                    if ($(this).prop('checked') == true) {
                                                        var schd_name = $(this).attr('id');
                                                        $('#act-sch-tbl tbody tr[data-to="' + schd_name + '"]').show();
                                                    }
                                                });
                                            }
                                            $('input.vehicleChkBox1:checked').each(function () {
                                                if ($(this).prop('checked') == true) {
                                                    var schd_name = $(this).attr('id');
                                                    $('#act-sch-tbl tbody tr[data-from="' + schd_name + '"]').show();
                                                }
                                            });
                                        }
                                    });


                                    $('body').on('click', '.vehicleChkBox2', function () {
                                        if ($('input:checkbox:checked').length == 0) {
                                            $('.schd_rows').show();
                                            $(this).prop('checked', false);
                                        } else {
                                            $('.schd_rows').hide();
                                            if ($("input.vehicleChkBox:checked").length > 0) {
                                                $('input.vehicleChkBox:checked').each(function () {
                                                    if ($(this).prop('checked') == true) {
                                                        var schd_name = $(this).attr('id');
                                                        $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"]').show();
                                                    }
                                                });
                                            }
                                            if ($("input.vehicleChkBox1:checked").length > 0) {
                                                $('input.vehicleChkBox1:checked').each(function () {
                                                    if ($(this).prop('checked') == true) {
                                                        var schd_name = $(this).attr('id');
                                                        $('#act-sch-tbl tbody tr[data-from="' + schd_name + '"]').show();
                                                    }
                                                });
                                            }
                                            $('input.vehicleChkBox2:checked').each(function () {
                                                if ($(this).prop('checked') == true) {
                                                    var schd_name = $(this).attr('id');
                                                    $('#act-sch-tbl tbody tr[data-to="' + schd_name + '"]').show();
                                                }
                                            });
                                        }
                                    });
                                });
                                
                                
                                function filterSchedule(){
                                     var schd_name = $('#schd_name').val();
                                     var schd_from = $('#schd_from').val();
                                     var schd_to = $('#schd_to').val();
                                     if(schd_from !='' || schd_to !='' || schd_name !=''){
                                     $('.schd_rows').hide();
                                     $('.parsley-error').removeClass('parsley-error');
                                     /*if(schd_name !=''){
                                      $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"]').show();
                                     }
                                     if(schd_from !=''){
                                      $('#act-sch-tbl tbody tr[data-from="' + schd_from + '"]').show();
                                     }
                                     if(schd_to !=''){
                                      $('#act-sch-tbl tbody tr[data-to="' + schd_to + '"]').show();
                                     }*/
                                     if(schd_name !='' && schd_from !='' && schd_to !=''){
                                         $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"][data-from="' + schd_from + '"][data-to="' + schd_to + '"]').show();
                                     }else if(schd_name !='' && schd_from !=''){
                                         $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"][data-from="' + schd_from + '"]').show();
                                     }else if(schd_name !='' && schd_to !=''){
                                         $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"][data-to="' + schd_to + '"]').show();
                                     }else if(schd_from !='' && schd_to !=''){
                                         $('#act-sch-tbl tbody tr[data-from="' + schd_from + '"][data-to="' + schd_to + '"]').show();
                                     }else if(schd_name !=''){
                                         $('#act-sch-tbl tbody tr[data-name="' + schd_name + '"]').show();
                                     }else if(schd_from !=''){
                                         $('#act-sch-tbl tbody tr[data-from="' + schd_from + '"]').show();
                                     }else if(schd_to !=''){
                                         $('#act-sch-tbl tbody tr[data-to="' + schd_to + '"]').show();
                                     }
                                  }else{
                                      $('#schd_name,#schd_from,#schd_to').addClass('parsley-error');
                                  }
                                }
                                function closeFilterSchedule(id){
                                    $('#schd_name,#schd_from,#schd_to').val('');
                                    $('.schd_rows').show();
                                    $('.parsley-error').removeClass('parsley-error');
                                }
                                
                                function clearAllTabWorkSpace() {
                                    $('#visibility_r').val('');
                                    $('#visible').val('');
                                    $('#station_sch').val('');
                                    $('#canc_sch').val('');
                                    $('#rout_sch').val('');
                                    $('#book_sch').val('');
                                    $('#log').val('');
                                    $('#ref').val('');
                                    $('#rel').val('');
                                    $('#excp').val('');
                                    $('#sfare').val('');
                                    $('#schfare').val('');
                                    $('#schtimeoverride').val('');

                                    $('#sch-workspace-content').find('.tabbable').find('.tab-content').find('#seat_visiblity').html("");
                                }
                                
                            </script>
                            {/if}
                            <link rel="stylesheet" href="assets/css/monthly.css">