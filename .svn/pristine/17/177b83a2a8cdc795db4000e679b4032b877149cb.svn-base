{if $searchType!=2}
    <div id="picker_new" style="display:none" ></div>
    <form role='form' class="form-horizontal cent">
        <div class='box_contents'>
            <input type="hidden" id="date-schedules-trips" value="{$tripDate}">
            <input type="hidden" id ="date_all">
            <div class="row">
                <div class="col-sm-2 text-center">
                    <a title="Click to view previous day schedules" data-toggle="tooltip" class="prev-day">
                        <i class="glyphicon glyphicon-chevron-left"></i>
                    </a>
                </div>
                <div class="col-sm-8 text-center">
                    <span id="picker-show" class="bold" style="cursor:pointer">{$tripDate|date_format:"%A %d-%b-%Y"}</span>
                </div>
                <div class="col-sm-2 text-center">
                    <a title="Click to view next day schedules" data-toggle="tooltip" style="cursor:pointer" class="next-day">
                        <i class="glyphicon glyphicon-chevron-right"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="pull-left col-md-3"><br>
            <div id="trip-error"></div>
        </div>
                
        <input type="hidden" id="hid-trip-date" value="" />  
        
    </form>    

    <div class='clear_fix_both'></div>



    <script>
        $(function () {
            $("[data-toggle='tooltip']").tooltip();
        });

        function tripUpdate(code, state) {

            var data = {};
            data.trip_state = state;
            data.trip_code = code;
            $('#loading_trip').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "schedules/update-trip",
                data: data,
                success: function (res) {
                    if (res.status == 1) {
                        $('#loading_trip').html('');
                    }
                }
            })
        }

        $(document).ready(function () {

            $('#picker_new').datepicker({
                format: 'yyyy-mm-dd'
            });
            $('#picker-show').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                startDate: '-0m',
            });

            $('#picker-show').datepicker().on('changeDate', function (ev) {

                var dates = $('#picker-show').datepicker('getDate');

                dates.setTime(dates.getTime() + (1000 * 60 * 60 * 24))

                var d = dates;
                var curr_date = d.getDate() - 1;
                var curr_month = d.getMonth() + 1;

                var curr_year = d.getFullYear();
                if (curr_month < 10) {
                    curr_month = '0' + curr_month;
                }
                if (curr_date < 10) {
                    curr_date = '0' + curr_date;
                }



                var date_format = curr_year + '-' + curr_month + '-' + curr_date;
                var date_new = $('#picker-show').datepicker('getDate');
                $('#picker_new').datepicker("setDate", date_new);
                $('#picker-show').html( moment(date_format,'YYYY-MM-DD').format('dddd DD-MMM-YYYY') );
                $('#date-schedules-trips').val(date_format);

                searchTrip(2);


            });

            var new_date = $('#date-schedules-trips').val();
            $('#picker_new').datepicker("setDate", new_date);
            $('.next-day').on("click", function () {
                closeTripOptions();
                $('.prev-day').show();
                var date = $('#picker_new').datepicker('getDate');


                date.setTime(date.getTime() + (1000 * 60 * 60 * 24))

                var d = date;
                var curr_date = d.getDate();
                var curr_month = d.getMonth() + 1;

                var curr_year = d.getFullYear();
                if (curr_month < 10) {
                    curr_month = '0' + curr_month;
                }
                if (curr_date < 10) {
                    curr_date = '0' + curr_date;
                }



                var date_format = curr_year + '-' + curr_month + '-' + curr_date;

                $('#picker_new').datepicker("setDate", date);                ;
                $('#picker-show').html( moment(date_format,'YYYY-MM-DD').format('dddd DD-MMM-YYYY') );
                $('#date-schedules-trips').val(date_format);

                searchTrip(2);
            });

            $('.prev-day').on("click", function () {
                closeTripOptions();
                var date = $('#picker_new').datepicker('getDate');
                date.setTime(date.getTime() - (1000 * 60 * 60 * 24))
                $('#picker_new').datepicker("setDate", date);
                var d = date;
                var curr_date = d.getDate();
                var curr_month = d.getMonth() + 1;
                var curr_year = d.getFullYear();
                if (curr_month < 10) {
                    curr_month = '0' + curr_month;
                }
                if (curr_date < 10) {
                    curr_date = '0' + curr_date;
                }
                var date_new = new Date();
                if (date >= date_new) {

                } else {
                    $('.prev-day').hide();
                }

                var date_format = curr_year + '-' + curr_month + '-' + curr_date;

                $('#picker_new').datepicker("setDate", date);
                $('#picker-show').html(moment(date_format,'YYYY-MM-DD').format('dddd DD-MMM-YYYY'));
                $('#date-schedules-trips').val(date_format);

                searchTrip(2);
            });
        });
    </script>


    <div class="table-responsive" id="trip-table-list">
    
       
        
    {/if} 
    
    {if $schedules|count==0} 
        <div class="well well-large"> Sorry! No trips were found on the requested date.</div>
    {else}    

        <table class="table info_table" id="mail_inbox">
            <thead>
                <tr>
                    <th>Name</th>                
                    <th>Schedule / # <a href="javascript:;" title="Service Number"><i class="fa fa-info-circle"></i></a> </th>
                    <th>From Station</th>        
                    <th>To Station</th>
                    <th>Fare</th>
                    <th>Seats</th>
                    <th>Booked</th>
                    <th>Vacant</th>
                    <th>Occupancy</th>
                    <th>                        
                        <span class='txt_green' > <i class="fa fa-list"></i> {$totalTripCount}&nbsp;Trip(s)</span>
                    </th>
                </tr></thead>
            <tbody>
                {assign var="tot_seats" value=0}
                {assign var="tot_booked" value=0}
                {assign var="tot_vacant" value=0}
                {foreach from=$schedules item=tcate key=tcatekey }
                    
                    {if $tcatekey!=""}
                    <tr class="noborder">
                        <td colspan="10" class="noborder">
                            <div class="schedule-tag">
                                <h5 class="txt_orange">{$tcatekey}</h5>
                            </div>
                        </td> 
                    </tr>   
                    {/if}
                    
                    {foreach from=$tcate item=row key=new name=inssch}
                    
                    {assign var="stages_count" value=count($row->stageList)-1}
                    <tr id="trp-{$row->tripCode}">

                        <td  class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}" >
                            <span class="bold">{$row->schedule->name} </span> 
                            <a href="javascript:;" data-toggle="popover" class="has-popover via" id="via-{$row->tripCode}"> &nbsp;<i class="fa fa-location-arrow"> </i> via</a>
                            <br>
                            {$row->busTypeName}
                            <br>
                            <div class="btn-group">
                                {if $row->tripInfo->busVehicle->registationNumber!=""}
                                    <button id="regno-{$row->tripCode}" type="button" class="btn btn-success btn-xs" title="{$row->tripInfo->busVehicle->registationNumber}" data-toggle="tooltip1"><i class="fa fa-bus"></i></button>
                                {else}
                                    <button id="regno-{$row->tripCode}" type="button" class="btn btn-default btn-xs" title="Vehicle not added" data-toggle="tooltip1"><i class="fa fa-bus"></i></button>
                                {/if}
                                {if $row->tripInfo->driverName!=""}
                                    <button id="driver-{$row->tripCode}" type="button" class="btn btn-success btn-xs " title="{$row->tripInfo->driverName}, {$row->tripInfo->driverMobile}" data-toggle="tooltip1"><i class="fa fa-male fa-lg"></i></button>
                                {else}
                                    <button id="driver-{$row->tripCode}" type="button" class="btn btn-default btn-xs" title="Driver not added" data-toggle="tooltip1"><i class="fa fa-male fa-lg"></i></button>
                                {/if}

                                {assign var="gps_sms" value=0}
                                {assign var="hpy_sms" value=0}
                                {assign var="dri_sms" value=0}

                                {if $row->tripInfo->notificationStatus|count>0}
                                    {foreach from=$row->tripInfo->notificationStatus item=st}
                                        {if $st=='TINFO'}
                                            {assign var="dri_sms" value=1}
                                        {elseif $st=='HPYJY'}
                                            {assign var="hpy_sms" value=1}
                                        {elseif $st=='GPSTK'}
                                            {assign var="gps_sms" value=1}
                                        {/if}    
                                    {/foreach}    
                                {/if}    

                                {if $hpy_sms==1}
                                    <button type="button" class="btn btn-success btn-xs " title="Happy Journey SMS sent" data-toggle="tooltip1"><i class="fa fa-smile-o fa-lg"></i></button>                         
                                {/if}

                                {if $dri_sms==1}
                                    <button type="button" class="btn btn-success btn-xs " title="Driver info SMS sent" data-toggle="tooltip1"><i class="fa fa-mobile fa-lg"></i></button>                         
                                {/if}

                                {if $gps_sms==1}
                                    <button type="button" class="btn btn-success btn-xs " title="GPS SMS sent" data-toggle="tooltip1"><i class="ion-android-locate fa-lg"></i></button>                         
                                {/if}
                            </div>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <div class="btn-group">
                                <span id="bc-{$row->tripCode}" ><i class="fa fa-eye fa-lg"></i></span>
                            </div>
                            
                            {if $tripindays<=1 && $action_rights['BUS-GPS-LIVE-TRACK']==1}
                            &nbsp;&nbsp;
                                {if $row->tripInfo->busVehicle->gpsDeviceVendor->code=='EZEEGPS'}
                                <div class="btn-group">
                                    <a href="javascript:;" onclick="trackfleet('{$row->tripCode}','{$row->tripInfo->busVehicle->gpsDeviceCode}')" title="track bus location"><i class="ion-ios7-navigate-outline ion-lg txt_green" ></i></a>
                                </div>
                                {else}
                                <div class="btn-group hide" id="trackicon-{$row->tripCode}">
                                    <a href="javascript:;" title="track bus location"><i class="ion-ios7-navigate-outline ion-lg txt_green" ></i></a>
                                </div>
                                {/if}
                            {/if}
                        </td>

                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >
                            <span class='txt_green'>
                                {$row->schedule->code} <br>
                            </span>
                            {if $row->schedule->serviceNumber!=''}
                                <span class="warning-text">{$row->schedule->serviceNumber}</span>
                            {else}
                                <span title="service number not available">-</span>
                            {/if}  
                            {if $is_super_namespace==1}
                            <br><span class='notes text-muted'>{$row->tripCode}</span>
                            {/if}
                        </td>                   
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >
                            <span class='txt_green'>
                                <i class="fa fa-level-up"></i>
                            </span>&nbsp;{$row->stageList[0]->fromStation->name}&nbsp;
                            <br>
                            <span class="text-muted">{$row->stageList[0]->fromStation->dateTime|date_format:'%I:%M %p'}</span>
                        </td>                
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" > 
                            <span class='txt_green'>
                                <i class="fa fa-level-down"></i>
                            </span>&nbsp;{$row->stageList[0]->toStation->name}&nbsp;
                            <br>
                            <span class="text-muted">{$row->stageList[0]->toStation->dateTime|date_format:'%I:%M %p'}
                                {if $row->stageList[0]->fromStation->dateTime|date_format:'%d' != $row->stageList[0]->toStation->dateTime|date_format:'%d'}
                                    Next Day
                                {/if}
                            </span>
                        </td>
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >                            
                            <span data-toggle="popover" class="has-popover dotted-underline" id="fare-{$row->tripCode}">
                                <span class='txt_green'>
                                    <i class="fa fa-rupee"></i>
                                </span>{$row->stageList[0]->stageFare[0]->fare}
                            </span>
                            <br />
                        </td>
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >{$row->bus->totalSeatCount}</td>
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >
                            {if $row->bookedSeatCount>0}
                                {assign var="t" value=$row->bookedSeatCount/$row->bus->totalSeatCount}
                                {assign var="t" value=$t*100}
                            {else}
                                {assign var="t" value=0}  
                            {/if}
                            {$row->bookedSeatCount}
                        </td>
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >
                            {assign var="tv" value=$row->bus->totalSeatCount}
                            {if $row->bookedSeatCount>0}
                                {assign var="tv" value=$row->bus->totalSeatCount-$row->bookedSeatCount}
                            {/if}
                            {assign var="t" value=$tv/$row->bus->totalSeatCount}
                            {assign var="t" value=$t*100}
                            {$row->bus->totalSeatCount-$row->bookedSeatCount}
                        </td>
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" >
                            {if $row->bookedSeatCount>0}
                                {assign var="t" value=$row->bookedSeatCount/$row->bus->totalSeatCount}
                                {assign var="t" value=$t*100}
                            {else}
                                {assign var="t" value=0}  
                            {/if}
                            {assign var="vacant" value={$row->bus->totalSeatCount-$row->bookedSeatCount}}
                            <div class="trip-pie" id="trip-pie-{$row->tripCode}" data-percent="{$t}" data-seats="{$row->bus->totalSeatCount}" data-booked="{$row->bookedSeatCount}" data-vacant="{$vacant}" style="height:50px;width:50px" ></div>
                        </td>
                        <td class="v-a-c {if $smarty.foreach.inssch.index==0} noborder {/if}" data-stages="{count($row->stageList)}" >                                                       
                            
                            <span id="btn-state-{$row->tripCode}" data-state="{$row->tripStatus->code}" >
                            {if $row->tripStatus->code =='TPY'}                                   
                                <label class="badge badge-default">Not Yet Opened</label>
                            {else if $row->tripStatus->code == 'TPO'}
                                <label class="badge badge-success">Booking Open</label>
                            {else if $row->tripStatus->code == 'TPC' && $row->stageList[0]->stageStatus->code == 'TPO' }
                                <label class="badge badge-danger" title="Manually closed"> <i class="fa fa-user" aria-hidden="true"></i>&nbsp; Booking Closed</label>
                            {else if $row->tripStatus->code == 'TPC'}
                                <label class="badge badge-danger" title="Auto closed">Booking Closed</label>
                            {else if $row->tripStatus->code == 'TCA'}                                    
                                <label class="badge badge-warning">Trip Cancelled</label>
                            {/if} 
                            </span>
                            
                            
                            {if $action_rights['SCH-TRIP-DRIVER-DETAILS']==1 || $action_rights['SCH-TRIP-STAGES']==1}
                                <a id="{$row->tripCode}" data-stagec="{$row->stageList[0]->code}" title="More Options" class="viw_mre_trp btn btn-default btn-xs">
                                    <i class="fa fa-arrow-down"></i>
                                </a>
                            {/if} 
                            
                            {if $action_rights['SCH-VIEW-TRIP-ACTION']==1 && 
                                    ( $row->tripStatus->code == 'TPO' || $row->tripStatus->code == 'TPC' || $row->tripStatus->code =='TPY' 
                                      || $is_super_namespace==1)}
                            <div class="btn-group" id="btg-{$row->tripCode}">
                                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-cog"></i> <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu sch"> 
                                    
                                    <li {if $row->tripStatus->code == 'TPC'} class="hide" {/if} id="mnu-TPC-{$row->tripCode}" >                                    
                                        <a href="javascript:;" onclick="setTripBookingStatus('{$row->tripCode}','TPC');" title="click to close bookings">
                                            Close Bookings
                                        </a>
                                    </li>                                    
                                    <li {if $row->tripStatus->code == 'TPO' || $row->tripStatus->code == 'TPY'} class="hide" {/if} id="mnu-TPO-{$row->tripCode}"> 
                                        <a href="javascript:;" onclick="setTripBookingStatus('{$row->tripCode}','TPO');" title="click to open bookings">
                                            Open Bookings
                                        </a>
                                    </li>                                    
                                    <li {if $row->tripStatus->code == 'TCA'} class="hide" {/if} id="mnu-TCA-{$row->tripCode}"> 
                                        <a href="javascript:;" onclick="setTripBookingStatus('{$row->tripCode}','TCA');" title="click to cancel this trip">
                                            Cancel this trip
                                        </a>
                                    </li>
                                    
                                    {if $is_super_namespace==1 }
                                        <li> 
                                            <a href="javascript:;" onclick="resetTripCache('{$row->tripCode}');" title="click to clear this trip cache">
                                                Reset cache
                                            </a>
                                        </li>
                                    {/if}
                                    
                                    {if $is_super_namespace==1 }
                                    <li>                                    
                                        <a href="javascript:;" onclick="pushSchedule('{$row->tripCode}', '{$row->schedule->code}');" title="Send to redBus">
                                            Send to redBus
                                        </a>
                                    </li>
                                    {/if}
                                </ul>
                            </div>
                            {/if}

                        </td>

                    </tr>

                    <!-- <tr>
                         <td class="bor-0" colspan="7"> 
                             <div class="sctp-{$row->schedule->code} tbs-sctrp" style="display:none"></div>
                         </td>
                     </tr> -->
                <input type="hidden" value="{$row->tripCode}" id="trips">
                {assign var="tot_seats" value=$tot_seats+$row->bus->totalSeatCount}
                {assign var="tot_booked" value=$tot_booked+$row->bookedSeatCount}
                {assign var="tot_vacant" value=$tot_vacant+($row->bus->totalSeatCount-$row->bookedSeatCount)}
                
                
            {/foreach} 
            {/foreach}
            {if $tot_booked>0}
                {assign var="t" value=$tot_booked/$tot_seats}
                {assign var="t" value=$t*100}
            {else}
                {assign var="t" value=0}  
            {/if}
            <tr>
                <td colspan="5">&nbsp;</td>
                <td class="bold text-danger"><br>{$tot_seats}</td>
                <td class="bold text-danger"><br>{$tot_booked}</td>
                <td class="bold text-danger"><br>{$tot_vacant}</td>
                <td class="bold text-danger">
                    <div class="trip-pie" id="trip-pie-all" data-percent="{$t}" data-seats="{$tot_seats}" data-booked="{$tot_booked}" data-vacant="{$tot_vacant}" style="height:50px;width:50px" ></div>
                </td>
                <td class="bold text-danger"><div>&nbsp;</div></td>
            </tr>
            <tr>
                <td colspan="11">&nbsp;</td>
            </tr>

            </tbody>
        </table>
        {if $searchType!=2}
        </div>
    {/if}
{/if}

<tr id="trp-workspace">
    <td colspan="6" style="background-color:#fff;">
        <div id="trp-sch-workspace" class="hide">
            <div class="pull-right">
                <a href="javascript:;" title="Close options" class="btn-lg"  onclick="closeTripOptions()">
                    <i class="fa fa-times-circle ired"></i>
                </a>
            </div>
            <div id="trp-workspace-content"></div>    
        </div>
        <div class="err-act" id="err" style="position:relative;left:126px;display:none"></div>
        <div class="err-acts"></div>
    </td>                                            
</tr>


<script  type="text/template" id="get-schedules-tab">
    <div class="tabbable tabs-left">
        <ul class="nav nav-tabs" id="trip_tabs">
            {if $action_rights['SCH-TRIP-STAGES']==1}
                <li class="active"><a data-toggle="tab" href="#stages-tab" id="stages">Stages & SMS</a></li>        
            {/if}
            {if $action_rights['SCH-TRIP-DRIVER-DETAILS']==1}  
                <li><a data-toggle="tab" href="#vehicle-tab" id="vehicle">Vehicle & Driver</a></li>
            {/if}            
           
            {if $action_rights['TRIP-CANCEL-REQUEST']==1}
                <li><a data-toggle="tab" href="#tripcancel-tab" id="tripcancel">Trip Cancel</a></li>
            {/if}
                
            <li><a data-toggle="tab" href="#triptransaction-tab" id="triptransaction">Transactions</a></li>
            
            {if $action_rights['SCH-AUDIT-LOG']==1}
            <li><a data-toggle="tab" href="#tripaudti-tab" id="tripaudti">Activity Log</a></li>
            {/if}
                
            {if $action_rights['SCH-BUSTYPE-OVERRIDE']==1}      
            <li><a data-toggle="tab" href="#migrateseats-tab" id="migrateseats">Migrate Seats</a></li>
            {/if}
        </ul>

        <div class="tab-content" id="tabs_content_a">
            {if $action_rights['SCH-TRIP-DRIVER-DETAILS']==1}
                <div id="vehicle-tab" class="tab-pane fade"></div>
            {/if}
            {if $action_rights['SCH-TRIP-STAGES']==1}
                <div id="stages-tab" class="tab-pane fade in active exp-tb">
                    <span id="triplist"></span><br><br><br><span id="map"><div class="well well-large">Please select stage to get busmap</div></span>                    
                </div>
            {/if}
                     
            {if $action_rights['TRIP-CANCEL-REQUEST']==1}
                <div id="tripcancel-tab" class="tab-pane fade"></div>
            {/if}
            <div id="triptransaction-tab" class="tab-pane fade"></div>
            <div id="tripaudti-tab" class="tab-pane fade"></div>
            <div id="migrateseats-tab" class="tab-pane fade"></div>
        </div>
    </div>
</script>

<input type="hidden" id="vehicle_select" />
<input type='hidden' id='trpcode' />

<script>        
    var tripStages = {$schedules_raw|json_encode};
    var nativeNamespace = "{$native_namespace}";
</script>

{literal}
<script>
    $('#push-tripdate').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '0d',
        endDate: '+3m',
        changeMonth: true
    });
    
    $.each(tripStages, function(key, trip) {
        
        var tripcode = trip.tripCode;
        var bcstate = {};
        bcstate.TPO = 0;
        bcstate.TPY = 0;
        bcstate.TPC = 0;
        
        //var bc = '<table width="500" class="table table-striped"><thead><tr> <th>Stage</th><th>Group</th><th>Open At</th> <th>Close At</th></tr></thead><tbody class="body_table">';
        var bc = '<table width="500" class="table table-striped"><thead><tr> <th>Stage</th><th>Group</th><th>Open At</th> <th>Close At</th><th>Status</th></tr></thead><tbody class="body_table">';
        $.each(trip.statusList, function(conkey, con) {
            var od = moment(con.openDate).format('DD-MM-YYYY hh:mm A')+'<br>'+moment(con.openDate, "YYYY-MM-DD HH:mm:ss").fromNow();
            var cd = moment(con.closeDate).format('DD-MM-YYYY hh:mm A')+'<br>'+moment(con.closeDate, "YYYY-MM-DD HH:mm:ss").fromNow();
            var r = 'All stage';
            var g = 'All group';
            if(_isdefined(con.fromStation)) {
                r = con.fromStation.name + ' - '+ con.toStation.name;
            }
            if(_isdefined(con.group)) {
                g = con.group.name;
            }
            
            var s = '<span class="badge badge-danger">Closed</span>';
            if(con.tripStatus.code=="TPC") {
                bcstate.TPC++;
            }             
            if(con.tripStatus.code=="TPO") {
                bcstate.TPO++;
                s = '<span class="badge badge-success">Open</span>';
            } else if(con.tripStatus.code=="TPY") {
                bcstate.TPY++;
                s = '<span class="badge badge-default">Yet To Open</span>';
            } else if(con.tripStatus.code=="TCA") {
                s = '<span class="badge badge-warning">Cancelled</span>';
            }
            //bc += '<tr><td>'+r+'</td><td>'+g+'</td><td>'+od+'</td><td>'+cd+'</td></tr>';
            bc += '<tr><td>'+r+'</td><td>'+g+'</td><td>'+od+'</td><td>'+cd+'</td><td>'+s+'</td></tr>';            
        });
        bc += '<tr><td colspan="5" align="right"><span class="warning-text">*</span> as per schedule settings</td></tr>';
        bc += '</tbody></table>';
        
        //  booking control icon color
        var bcclass = '';
        if(bcstate.TPC==0 && bcstate.TPY==0 && bcstate.TPO >0) {
            bcclass = 'success-text';
        } else if(bcstate.TPO==0) {
            bcclass = '';
            $('#bc-'+tripcode).find('i').removeClass('fa-eye').addClass('fa-eye-slash');
            
        } if( (bcstate.TPC>0 || bcstate.TPY>0) && bcstate.TPO > 0) {
            bcclass = 'info-text';
        }        
        $('#bc-'+tripcode).find('i').removeClass('success-text').removeClass('info-text');
        $('#bc-'+tripcode).find('i').addClass(bcclass);
        
        //console.log(tripcode+' - '+bcstate.TPC+'|'+bcstate.TPO+'|'+bcstate.TPY);

        $('#bc-'+tripcode).popover({
            container:'body',
            content:bc,
            html:true,
            placement:'right',
            trigger:'hover',
        });
        
        //via routes popover
        var viaContent = '<table><tr><th>Via Routes</th><th></th></tr>';
        $.each(trip.viaRoutes, function(i, via) {
            viaContent += '<tr><td>'+via.name+'</td><td>&nbsp;&nbsp;&nbsp;'+moment(via.dateTime).format('hh:mm A')+'</td></tr>';
        });
        viaContent += '</table>';
        
        $("#via-"+tripcode).popover({
            trigger: 'hover',
            placement : 'right',
            content:viaContent,
            html: true
        });
        
        //fare popover
        var fareContent = '<table><tr><th>Route</th>';
        $.each(trip.stageList, function(i, stp) {
            $.each(stp.stageFare, function(i, stf) {
                fareContent += '<th>&nbsp;'+stf.seatName+'&nbsp;</th>';
            });
            return false;
        });
        fareContent += '<tr>';
        $.each(trip.stageList, function(i, stp) {
            fareContent += '<tr><td>'+stp.fromStation.name+' - '+stp.toStation.name+'</td>';
            $.each(stp.stageFare, function(i, stf) {
                fareContent += '<td align="center">'+stf.fare+'</td>';
            });
            fareContent += '</td></tr>';
        });
        fareContent += '</table>';
        
        $("#fare-"+tripcode).popover({
            trigger: 'hover',
            placement : 'right',
            content:fareContent,
            html: true
        });
        
    });
    
    
    $('.viw_mre_trp').click(function () {
        $('#vehicle_select').val('');
        var trip = $(this).attr('id');
        var stagec = $(this).data('stagec');
        $('#mail_inbox tbody tr').each(function () {
            $(this).addClass("hide");
        });
        $('#trpcode').val(trip);
        $('#trp-' + $(this).attr("id")).removeClass('hide');

        $('.last-active').removeClass('last-active');
        $('#trp-' + $(this).attr("id")).addClass('last-active');

        $(this).removeClass("hide");
        $(this).addClass("active-row");
        $('#trp-workspace').removeClass("hide");
        $('#trp-sch-workspace').removeClass('hide');
        $('#trp-workspace-content').html($('#get-schedules-tab').html());
        $('#mail_inbox').removeClass("no-footer");
        $('#mail_inbox').removeClass("no-footer");
        getTripStages(tripStages, trip);
        $('#vehicle').click(function () {
            if ($('#vehicle_select').val() != 1) {
                getDriverDetails(trip);
                $('#vehicle_select').val(1);
            }
        });

        $('#trpMap').on("change", function () {
            if (this.value != '') {
                getTripMap(this.value);
            }
        });

        $('#tripexpenses').click(function () {
            getTripExpenses(trip);
        });

        $('#tickettransfer').click(function () {
            //stagec
            getTripBusMap(tripStages, trip);
        });

        $('#triptransaction').click(function () {
            getTripTransactionHistroy(trip);
        });
        
        $('#tripcancel').click(function () {
            tripcancel(trip);
        });
        
        $('#tripaudti').click(function () {
            getTripAuditHistroy(trip);
        });

        $('#migrateseats').click(function () {
            migrateSeats(trip);
        });

    });
    
    function setTripBookingStatus(code, state) {
        if( state == 'TPC' ) {
            title = "Do you want to close the bookings for this trip?";
            txt = 'This action will stop further bookings from all the channels.';
        } else if (state == 'TPO') {
            title = "Do you want to open the bookings for this trip?";
            txt = 'This action will open bookings in all the channels.';
        } else if (state == 'TCA') {
            title = "Do you want to cancel this trip?";
            txt = 'This action will close further bookings in all the channels and will not be open again.';
        }        
        swal({
                title: title,
                text: txt,
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "Yes, Continue!",
                closeOnConfirm: false
            },
            function(){
                var data = {};
                data.trip_state = state;
                data.trip_code = code;
                
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "schedules/update-trip",
                    data: data,
                    success: function (res) {
                        if (res.status == 1) {
                            $('#mnu-TPC-'+code).addClass('hide');
                            $('#mnu-TPO-'+code).addClass('hide');
                            $('#mnu-TCA-'+code).addClass('hide');
                            
                            if(state == 'TPC'){
                                //$('#btn-state-'+code).html("<button type=\"button\" onclick=\"setTripBookingStatus('"+code+"','TPO');\" class=\"btn btn-danger btn-xs\" title=\"click to close booking\" data-toggle=\"tooltip\">Open</button>");
                                $('#btn-state-'+code).html('<label class="badge badge-danger" title="Manually closed"><i class="fa fa-user" aria-hidden="true"></i>&nbsp; Booking Closed</label>');
                                swal("Booking Closed!", "Booking has been closed.", "success"); 
                                
                                $('#mnu-TPO-'+code).removeClass('hide');
                                $('#mnu-TCA-'+code).removeClass('hide');
                            
                            } else if(state == 'TPO'){                                
                                //$('#btn-state-'+code).html("<button type=\"button\" onclick=\"setTripBookingStatus('"+code+"','TPC');\" class=\"btn btn-primary btn-xs\" title=\"click to open booking\" data-toggle=\"tooltip\">Closed</button>");
                                $('#btn-state-'+code).html('<label class="badge badge-success">Booking Open</label>');
                                swal("Booking Open!", "Booking has been open.", "success");
                                
                                $('#mnu-TPC-'+code).removeClass('hide');
                                $('#mnu-TCA-'+code).removeClass('hide');
                            } else if(state == 'TCA'){                                
                                //$('#btn-state-'+code).html("<button type=\"button\" onclick=\"setTripBookingStatus('"+code+"','TPC');\" class=\"btn btn-primary btn-xs\" title=\"click to open booking\" data-toggle=\"tooltip\">Closed</button>");
                                $('#btn-state-'+code).html('<label class="badge badge-warning">Trip Cancelled</label>');
                                swal("Trip Cancelled!", "Trip has been cancelled.", "success");
                                
                                $('#tripcancel-status-warning').addClass('hide');   //  remove trip status warning in trip cancel screen.
                                
                                if(nativeNamespace=='bits' || nativeNamespace=='aprbits'){
                                    $('#mnu-TPO-'+code).removeClass('hide');
                                    $('#mnu-TPC-'+code).removeClass('hide');
                                } else {
                                    $('#btg-'+code).hide();
                                }
                            }                            
                            $('#btn-state-'+code).attr('data-state',state);                            
                        }
                    }
                });                
            }
        );  
    }
</script>
{/literal}