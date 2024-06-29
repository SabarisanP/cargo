<div class="brand_top">
    <h3>Schedules List </h3>     
    {if $action_rights['SCH-ADD']==1}
    <span class="align-right">
        <span id="loading_trip"></span>&nbsp;&nbsp;
        <button class="btn btn-default" onclick="showScheduleOccupancy()" title="Overall advance booking summary"><i class="fa fa-bar-chart-o fa-lg"></i></button> &nbsp;&nbsp;
        <a href="#schedules/edit-schedules" class="btn btn-success  btn-sm">Add Schedule</a>
    </span>
    {/if}
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div>
                                        <ul class="nav nav-tabs" id="tabs_a">
                                            {if $action_rights['SCH-VIEW-TRIPS']==1} <li class="active"><a data-toggle="tab" href="#trip-schedules">Trips</a></li>{/if}
                                            {if $action_rights['SCH-VIEW-ACT-SCHEDULES']==1}<li><a data-toggle="tab" id="active" href="#active-schedules" data-view="get-active-schedules">Active Schedules</a></li>{/if}
                                            {if $action_rights['SCH-VIEW-CLS-SCHEDULES']==1}<li><a data-toggle="tab" id="closed" href="#close-schedules"  data-view="get-closed-schedules">Closed Schedules</a></li>{/if}
                                            {if $action_rights['SCH-VIEW-EXP-SCHEDULES']==1}<li><a data-toggle="tab" id="expired" href="#expired-schedules"  data-view="get-expire-schedules">Expired Schedules</a></li>{/if}
                                            {if $action_rights['SCH-VIEW-INCL-SCHEDULES']==1}<li><a data-toggle="tab" id="incomplete" href="#incomplete-schedules"  data-view="get-partial-schedules">Incomplete Schedules</a></li>{/if}
                                            {if $action_rights['SCH-VIEW-SCHEDULES-ETRAS']==1}<li><a data-toggle="tab" id="extra" href="#schedule-extras"  data-view="get-schedule-extras">Extras</a></li>{/if}
                                        </ul>
                                        <div class="tab-content" id="tabs_content_a">
                                            <div id="trip-schedules" class="tab-pane fade in active">
                                                <div class="trip-form-control col-md-offset-2 col-md-7">

                                                    <div class="t_a_ce bold">Please select a date and click "get trips".</div>
                                                    <br />
                                                    <div class="trip-date col-xs-offset-4"></div>
                                                    <br />
                                                    <button class='btn btn-success btn-block col-xs-offset-4 wid-250' onclick="searchTrip(1)">Get Trips</button>
                                                </div> 

                                                <div id="trip-schedules-list">

                                                </div>
                                            </div>
                                            <div id="active-schedules" class="tab-pane fade">

                                            </div>
                                            <div id="close-schedules" class="tab-pane fade">

                                            </div>
                                            <div id="expired-schedules" class="tab-pane fade">

                                            </div>
                                            <div id="incomplete-schedules" class="tab-pane fade">

                                            </div>
                                            <div id="schedule-extras" class="tab-pane fade">
                                                
                                            </div>

                                        </div>    
                                    </div>
                                </div>
                            </div><!--panel end-->
                        </div>
                    </div>
                </div><!--contents end-->
            </div><!--row end-->
        </div><!--Container end-->
    </div><!--Page content-->
</div><!--Main wrapper-->

<div class="hide" id="schedule-occupancy-dialog" style="background-color: #fff;">
        <div style="padding:3px;">

            <div class="row">
                <div class="col-md-11 col-lg-11">
                    <span class="bold">Advance Booking Trends</span> &nbsp;&nbsp; <span class="f12" id="responsetime"></span>
                </div> 
                <div class="col-md-1">            
                    <a class="align-right" onclick="closeScheduleOccupancy()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
                </div>
            </div>               
            
            <div class="row">
                <div class="col-lg-12">  
                    <div id="sch-occupancy-panel">
                        
                    </div>
                </div>
            </div>    
                                        
        </div>
</div>


<!-- push to API agent popup -->
<div class="hide" id="sch-push" style="background-color: #fff;">
    <form role="form" id="form_org" class="form-horizontal" autofocus="off">
        <div class="col-lg-12 col-sm-12 col-xs-12 pd_16">
            <label>Choose the options to send redBus</label>
            <div class="row pd_16">
                <div class="col-md-6">
                    <label class="req" for="push-tripdate">Trip Date</label>
                    <div class="input-group">
                        <input type="text" name="from" class="form-control sdate" id="push-tripdate" readonly="true" placeholder="Date From">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    </div>
                </div>
                <div class="col-md-5">
                    <label for="push-tilldays">No of days to be refreshed</label>
                    <div class="input-group col-md-12">
                        <select id="push-tilldays" class="form-control" >
                            <option value="1">1 day</option> 
                            <option value="5">Next 5 days</option>
                            <option value="10">Next 10 days</option>                                                                    
                        </select>       
                    </div>
                </div>
                <div class="clear_fix_both"></div><br/>
                <div class="col-md-12">
                    <label class="req" for="push-routes">Routes</label>
                    <div id="push-routes-cont"></div>
                </div>
            </div>
        </div>
        <br>
        <div class="col-lg-12 col-sm-12 col-xs-12 pd_16">
            <label class="checkbox-inline">
                <input type="checkbox" class="push-stations" value="1">&nbsp;New station added?
            </label>
        </div>
        
        <div class="col-md-12 clear_fix_both"><br/>                
            <div class="hide alert text-right" id="push-action"></div>
            <div class="text-right" id="push-buttons">
                <input type="hidden" id="push_trip_code" value="">
                <input type="hidden" id="push_sch_code" value="">
                <button class="btn btn-success" type="button" onclick="doPushSchedule();">Send</button>
                <button class="btn btn-default" type="button" onclick="closePushPopup();">Close</button>
            </div>
        </div>
    </form>
</div> 


<input type="hidden" id="tb" value="{$smarty.get.type}">
<input type="hidden" id="date" value="{$smarty.get.date}">
<script>
    function init_schedules_page() {
        if ($('#date').val() != '') {
            init_schedules_page_actions($('#date').val());
             $('#main_page_content').css('opacity' ,'1');
        } else {
            init_schedules_page_actions(1);
        }
    }

    if ($('#tb').val() != '') {
        var acts = $('#tb').val();
        $('#' + acts).trigger('click');
        $('#main_page_content').css('opacity', '1');
    }

</script>
