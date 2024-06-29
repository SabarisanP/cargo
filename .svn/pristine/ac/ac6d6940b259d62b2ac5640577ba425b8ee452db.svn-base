{if $schedulesclose|count==0} 
    <div class="well well-large"> Sorry! No closed schedule(s) available.</div>
{else}  

    <div class="table-responsive">
        <table class="table info_table table-hover" id="closed-sch-tbl">
            <thead>
                <tr>
                    <th>Schedule and Bus Type</th>
                    <th>Schedule ID</th>
                    <th>Date Range</th>
                    <th>From Station </th>
                    <th>To Station</th>
                    <th>Fare</th>
                    {*<th>Station</th>*}
                    <th>
                        <div class="pull-left"> 
                            <span class='txt_green' ><i class="fa fa-list"></i> {$schedulesclose|count} &nbsp;Found</span>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody>
                {foreach from=$schedulesclose item=schs key=keyname}
                    {if $keyname!=""}
                    <tr class="noborder">
                        <td colspan="7" class="noborder">
                            <div class="schedule-tag">
                                <h5 class="txt_orange">{$keyname}</h5>
                            </div>
                        </td>
                    </tr>
                    {/if}

                    {foreach from=$schs item=row name=inssch}
                    <tr id="sch-{$row['code']}" class="schd_rows {if $smarty.foreach.inssch.index==0}row-noborder{/if}">
                        <td>
                            <div class="pull-left">
                                <h5>{$row['name']}</h5>
                                <span class="text-muted">{$row['BusType']}</span>
                            </div>

                        </td>
                         <td> 
                            <div class="pull-left"> 
                                <span class='txt_green'>{$row['code']}</span>
                            </div>
                        </td>
                        <td>
                            <div class="pull-left">
                                 {$row['activeFrom']|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span>
                                {$row['activeTo']|date_format:$ns_date_format}<br/>
                                {if $row['scheduleTagList']}
                                    <span id="sch-tag-{$row['code']}" class="sch-tag" data-popover='popover' data-toggle='hover' data-container='body'
                                          data-content ='
                                          {foreach from=$row['scheduleTagList'] item=batag} 
                                              {$batag->name} <br/>
                                          {/foreach}'
                                    >
                                        <i class="fa fa-tags" aria-hidden="true"></i>
                                    </span>
                                {/if}
                                {if $row['sectorList']}
                                    <span id="sch-sector-{$row['code']}" class="sch-sector" data-popover='popover' data-toggle='hover' data-container='body'
                                          data-content ='
                                          {foreach from=$row['sectorList'] item=batag} 
                                              {$batag->name} <br/>
                                          {/foreach}'>
                                        <i class="fa fa-sliders" aria-hidden="true"></i>
                                    </span>
                                {/if}
                            </div>
                        </td>
                        <td>
                            <div class="pull-left">{if $row['startStation']==''}-{else}<span class='txt_green'><i class="fa fa-level-up"></i></span>&nbsp;{$row['startStation']}{/if}<br><span class="text-muted">{if $row['fromStationTime']!=''}{$row['fromStationTime']}{else}-{/if}</span></div> 
                        </td>
                        <td>
                            <div class="pull-left">{if $row['endStation']==''}-{else}<span class='txt_green'><i class="fa fa-level-down"></i></span>&nbsp;{$row['endStation']}{/if}<br><span class="text-muted">{if $row['toStationTime']!=''}{$row['toStationTime']}{else}-{/if}</span></div> 
                        </td>

                        <td> 
                            <div class="pull-left"> 
                                {if $row['faremin']!=''}
                                    <span class='txt_green'><i class="fa fa-rupee"></i></span>&nbsp;{$row['faremin']}
                                {/if}
                                {if  $row['faremax']!=''}
                                    , <span class='txt_green'><i class="fa fa-rupee"></i></span>&nbsp;{$row['faremax']}
                                {/if}    
                            </div>
                        </td>
                        {*<td>
                            <span data-container="body" data-toggle="popover" data-placement="top"  data-trigger="hover" data-content="{foreach item=st from=$row['station']} <span class='bold'> {$st['station']} </span><br /> {if is_array($st['stationPoint'])}{foreach item=stp key=key from=$st['stationPoint']}&nbsp;&nbsp;&nbsp;&nbsp;<span>{$stp['name']}</span>&nbsp;&nbsp;<span>{$stp['stationPointTime']}</span><br />{/foreach}{/if}{/foreach}"><span class='txt_green' ><i class="fa fa-map-marker"></i></span></span>
                        </td>*}
                        <td>
                            {assign var=estr value=10|mt_rand:2000}
                            <div class="btn-group">
                                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-cog"></i> <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu sch">
                                    <li>
                                        <a href="#schedules/edit-schedules?r={$estr|md5}&t=0&i={$row['code']}&type=closed" title="Edit schedules">Edit schedules</a>
                                    </li>
                                    <li>
                                        {assign var=rstr value=10|mt_rand:2000}
                                        <a href="#schedules/edit-schedules?r={$rstr|md5}&t=1&i={$row['code']}&type=closed" title="Edit Station">
                                            Edit Station
                                        </a>
                                    </li>
                                    <li> {assign var=stid value=10|mt_rand:2000}                                        
                                        <a href="#schedules/edit-schedules?r={$stid|md5}&t=3&i={$row['code']}&type=closed" title="Edit routes">
                                            Edit Routes
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <a href="javascript:;" onclick="setScheduleState('{$row['code']}', 9)" title="Open schedule" class="btn btn-default btn-xs"><i class="fa fa-eye"></i></a>
                            <a href="javascript:;" onclick="getScheduleAdvanceBookingGraph('{$row['code']}', '{$row['name']}')" title="Advance Booking" class="btn btn-default btn-xs"><i class="fa fa fa-bar-chart"></i></a>
                            <a href="javascript:;" title="Delete schedules" class="btn btn-default btn-xs"  onclick="deleteSchedule('{$row['code']}')"><i class="fa fa-trash-o ired"></i></a>
                                                     
                            
                            <!--<input type="checkbox" id="act_sch"  name="act_sch" class="bs_switch" data-size="small">-->
                        </td>
                    </tr>
                    {/foreach}
                {/foreach}
            </tbody>
        </table>
    </div>
    <script>
console.log({$schedulesclose|json_encode})
        

        $('.well').hide();


        $('[data-toggle=popover]').popover({
            container: "body",
            html: true
        });
        $('.sch-tag, .sch-sector').popover({
            container: "body",
            html: true,
            trigger : "hover"
        });



    </script>
{/if}