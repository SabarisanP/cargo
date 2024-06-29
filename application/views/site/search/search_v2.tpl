
<!--<div class="brand_top">
    <h3>Book Ticket</h3> 
</div>-->
<div id="main_wrapper" style="width: 100%">
    <div class="page_content" >
        <div id="container-fluid" >
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-offset-1 col-lg-10 col-md-12 col-sm-12 col-xs-12" data-usergroup="{$usr_group_id}">
                            <div class="row">                                                                    
                                <div class="tabbable" id="tab">
                                    <ul class="nav nav-tabs">
                                        <li id="add-tab" title="Add new search tab">
                                            <a href="javascript:;" onclick="addNewTab(event)"> <i class="fa fa-plus"></i> </a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">

                                    </div>
                                </div>
                                
                            </div><!--panel end-->
                        </div>
                        
                    </div>
                    
                    <!--<div id="result-panel-1"></div> -->

                </div><!--contents end-->
            </div><!--row end-->
        </div><!--Container end-->
    </div><!--Page content-->
</div><!--Main wrapper-->


<div id='trip-info' style="background-color: #fff;" class="hidden"></div>
<div id='trip-settings' style="background-color: #fff;" class="hidden dialog-content-page"></div>
<div id='seat-preference-dialog' style="background-color: #fff;" class="hidden dialog-content-page">
    <div class="pull-right"> 
        <a title="close" class="btn-lg" href="javascript:;" onclick="closeSetSeatPreference()"> <i class="fa fa-times-circle fa-lg"></i> </a>
    </div>
    
    <div class="clearfix"></div><br><br>
    <div class="" id='dialog-content'>Do you want to Set Seat Preference</div>
    
    <div class="col-md-12 text-right">
        <input type="hidden" id="hid-seat-pref-gender">
        <button type="button" class="btn btn-success btn-confirm" onclick="confirmSetSeatPreference()">Confirm</button>
    </div>
</div>



<script id="template-trip-setings" type="text/template">
    <div style="padding:0px 10px;">                               
        <div class="pull-right"> 
            <a title="close" href="javascript:;" class="btn-lg" onclick="refreshBusLayout()" style="position:relative;"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>                
        <div id="trip-workspace"></div>        
    </div>

</script> 

<script id="template-trip-info" type="text/template">
    <div class="pull-right"> 
        <a title="close" class="btn-lg" href="javascript:;" onclick="close_info_popup()"> <i class="fa fa-times-circle fa-lg"></i> </a>
    </div>
    
    <div class="clearfix"></div>

    <ul class="nav nav-tabs" id="tabs_a_exp">
        <li class="active"><a data-toggle="tab" href="#t-policy">Cancellation Policy</a></li>
        <li><a data-toggle="tab" href="#t-points">Station Points</a></li>
        <!-- <li><a data-toggle="tab" href="#t-map" id="tabmap">Route Map</a></li>-->
    </ul>

    <div class="tab-content f12" id="tabs_content_exp">
        <div id="t-policy"  class="tab-pane fade in active ">           
            <div id="policy-loader" class="text-danger"></div>
            <div class="hidden" id="i-policy">
                <table class="table ">
                    <thead>
                          <tr>
                            <th width="50%">&nbsp</th>
                            <th>Deduction</th>
                            <th>Refund</th>
                            <th>Charges</th>
                          </tr>
                        </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="t-points" class="tab-pane fade">            
            <div class="info-popup-container">
                <div class="" id="i-boarding"></div>
            </div>
        </div>

        <div id="t-map" class="tab-pane fade hidden">
            <div class="map-locations text-center" ></div>
            <div id="g-map"></div>
        </div>

    </div>
</script>    

<script id="template-searchform" type="text/template">
<div>
    <div class="panel panel-default">
        <div id="search-panel">
          <form class="form-inline" role="form">
            <div class="row">
              <div class=" col-lg-offset-2 col-sm-3 col-lg-2">
                <div class="form-group">
                  <div class="input-group"> <span class="input-group-addon"><i class="fa fa-level-up"></i></span>
                    <select class="form-control from">
                      <option value=""></option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="col-sm-1 text-center" style="padding-top: 5px;"> <a href="javascript:;" id="a_interchange" title="swift stations"><i class="fa fa-exchange fa-lg"></i></a> </div>
              <div class="col-sm-3 col-lg-2">
                <div class="form-group">
                  <div class="input-group"> <span class="input-group-addon"><i class="fa fa-level-down"></i></span>
                    <select class="form-control to">
                      <option value=""></option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="col-sm-2 col-lg-2">
                <div class="form-group">
                  <label class="sr-only" for="sdate-search">Date</label>
                  <div class="input-group"> <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" class="form-control sdate" id="sdate-search" readonly="true" placeholder="Date">
                  </div>
                </div>
              </div>
              <div class="col-sm-3 col-lg-2">
                <button type="button" class="btn btn-success btn-search" onclick="dosearch()">Search</button>
                &nbsp
                <button type="button" class="btn btn-default btn-clear">Clear</button>
              </div>
            </div>
          </form>
        </div>
    </div>
    
    <div class="row">
        <div id="cookie2-result" class="col-lg-12 text-center" style="padding:5px">
            <span class="bold"> Recent Searches </span> (click on any item for quick search)
        </div>
        <div id="cookie-result" class="col-lg-12"></div>
    </div>
  
    <div id="result-panel"></div>
</div>    
</script>
<script id="template-bus-list" type="text/template">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="panel panel-default">
                <table class="table info_table"> 
                
                 <tr class="ticket-row2"> 
                    <td align="left" width="30%" style="border:none;">   
                        <div class="route">
                            <span class="bold from_route">Chennai</span> - <span class="bold to_route">Chennai</span>&nbsp;&nbsp;
                            <a href="javascript:;" data-toggle="popover" class="has-popover via"><i class="fa fa-location-arrow"> </i> via</a>
                        </div> 
                        
                    </td>
                    <td width="10%">
                        <span data-toggle="popover" class="has-popover pp boarding bold" data-station="" data-tripcode="" data-tap="1">
                            <i class="fa fa-level-up"> </i> 
                            <span class=" ftime">8:00 PM</span> 
                        </span>
                    </td>
                    <td width="10%">
                        <span data-toggle="popover" data-station="" data-tripcode="" data-tap="1" data-tip="1" class="arrival bold"> 
                          <i class="fa fa-level-down"></i> 
                          <span class=" ttime">6:15 AM</span> 
                        </span> 
                    </td>
                    <td class="text-center">
                        <span class="serviceno warning-text bold" title="service number"></span>
                    </td>
                    <td class="text-center">
                        <span class="tripinfo-bus hide"><a class="tracklink" href="javascript:;"><i class="fa fa-bus fa-lg"></i></a></span> &nbsp;&nbsp;
                        {if $action_rights['BUS-GPS-LIVE-TRACK']==1}
                        <span class="tripinfo-track hide"><a class="tracklink" href="javascript:;" title="track bus location"><i class="fa fa-location-arrow fa-lg" style="font-size:18px;"></i></a></span>                     
                        {/if}
                    </td>
                    <td colspan="2" align="right" style="border:none;">
                        <div title="Discount" class="discount text-info bold"></div>
                    </td>
                </tr>
        
                <tr class="ticket-row ticket-row2">                   
                  <td width="30%" align="left" style="border:none;">                                               
                      <div class="busCategory"></div>
                  </td>
                  <td width="10%" align="left" style="border:none;">                        
                        <a href="javascript:;" data-toggle='tooltip' title="click to know more details" class="has-cancel-popover">Cancellation Policy</a>
                  </td>
                  <td width="10%" align="left" style="border:none;">                      
                      <i class="fa fa-clock-o"></i> 
                      <span class="travelTime" data-toggle='tooltip' title="journey duration">6:15 AM</span>
                  </td>
                  <td width="10%" align="center" style="border:none;">
                        <span class="trip-status"></span> 
                  </td>
                  <td width="10%" align="center" style="border:none;">
                       <div title="Fare" class="fare"></div>                       
                  </td>
                  <td width="10%" align="center" style="border:none;">
                       <span class="seat-count"> </span>
                  </td>
                  <td width="10%" align="center" style="border:none;">
                       <button onclick="" class="btn btn-success view-button" type="button">View Seats</button>
                  </td>
                </tr>
                <tr>
                    <td colspan="1" align="left">
                        <div class="hide settings">
                            <a  data-toggle='tooltip' title="refresh bus layout" href="javascript:;" onclick="refreshBusLayout();">
                                <i class="fa fa-repeat"></i> refresh
                            </a> &nbsp;&nbsp;
                            {if $action_rights['SCH-VIW-ADV-BOOK']==1}
                            <a  data-toggle='tooltip' title="Advance Booking and Fare Trends" href="javascript:;" id="occupancy-graph" >
                                <i class="fa fa fa-bar-chart"> </i> booking trends
                            </a> &nbsp;&nbsp;   
                            {/if}
                                
                            {if $action_rights['SCH-AUDIT-LOG']==1}    
                            <a  data-toggle='tooltip' title="audit log" href="javascript:;" id="audit-log" >
                                <i class="fa fa fa-history"> </i> log
                            </a> &nbsp;&nbsp;
                            {/if}
                        </div>
                    </td>
                    <td colspan="3" align="left">                        
                        <span class="amenities"></span>
                    </td>
                    <td colspan="3" align="right">
                        <div class="hide settings">  
                            {if $action_rights['SCH-GENDER-PREF']==1}
                            <a href="javascript:;" data-toggle='tooltip' title="View all Gender Preference"  onclick="showSeatPreferenceList();"><i class="fa fa-male" aria-hidden="true"></i> Gender Preference</a> &nbsp;
                            {/if}
                                
                            {if $action_rights['DELETE-QUOTA']==1}
                            <a href="javascript:;" data-toggle='tooltip' title="view all quotas"  onclick="showQuotaList();"><i class="fa fa-ticket"> </i> quota</a> &nbsp;
                            {/if}
                            
                            {if $action_rights['MNG-TRIP-FARE']==1}
                            <a href="javascript:;" data-toggle='tooltip' title="change this trip fare"  onclick="showFareList();"><i class="fa fa-rupee"> </i> fare</a> &nbsp;
                            {/if}
                                
                            <!--<a href="javascript:;" data-toggle='tooltip' title="update vehicle and driver"  onclick="showFareList();"><i class="fa fa-rupee"> </i> fleet</a> &nbsp;
                            <a href="javascript:;" data-toggle='tooltip' title="send sms to passengers"  onclick="showFareList();"><i class="fa fa-rupee"> </i> sms</a> &nbsp;
                            <a href="javascript:;" data-toggle='tooltip' title="view trip chart"  onclick="showFareList();"><i class="fa fa-rupee"> </i> trip chart</a> &nbsp;
                            -->
                            {if $action_rights['SEARCH-TRIP-SETTINGS']==1}
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" title="more options">
                                        <i class="fa fa-cog fa-lg"></i> <span class="caret"></span> 
                                    </button>
                                    <ul class="dropdown-menu tripmore">
                                        {if $action_rights['SCH-SEAT-VISIBILITY']==1}
                                        <li><a href="javascript:;" class="settings-icon" data-ref="visiblity" title="manage seat quota">seat visibility</a></li>
                                        {/if}
                                        {if $action_rights['SCH-FARE-OVERRIDE']==1}    
                                        <li><a href="javascript:;" class="settings-icon" data-ref="fareoverride" title="manage extended fare">fare auto override</a></li>
                                        {/if}                                            
                                        {if $action_rights['boardingPointTripchart']==1}   
                                        <li><a href="javascript:;" class="settings-icon" id="boardingtripchart" title="boarding point trip chart" target="_blank">boarding point trip chart</a></li>
                                        {/if}
                                        {if $action_rights['SCH-VIEW-TRIP-ACTION']==1 || $is_super_namespace==1}
                                            <li role="separator" class="divider"></li>
                                            <li><a href="javascript:;" class="settings-icon close-adv-booking" title="click to close bookings">Close Bookings</a></li>
                                            <li><a href="javascript:;" class="settings-icon open-adv-booking" title="click to open bookings">Open Bookings</a></li>
                                        {/if}
                                    </ul>
                                </div>                            
                            {/if}
                            
                            <!--<a href="javascript:;"><i class="fa fa-list"> </i> trip chart</a> &nbsp;-->
                        </div>
                    </td>
                </tr>
                <tr class="tr_buslayout"></tr>
                </table>
            </div>
        </div>
    </div>
   <div class="" style="height:5px;"></div>    
</script>
<script id="template-busmap-list" type="text/template">
<div class="col-lg-12">
  <!--<div class="row">    
        <div class="col-lg-12 text-right">             
            <a id="close"  title="Clear" data-toggle="tooltip" href="javascript:;"><i class="fa fa-times f17"></i></a>
        </div>
    </div>-->
    
  <div class="row">
    <div class="col-lg-12 hidden" id="trip-status">
      <div class="text-center alert alert-danger"></div>
    </div>
  </div>
  
  
  
  <div class="row">
    <div class="busmap-list col-lg-6 col-md-6 col-sm-6">
    
    
        <div class="row">
            <div class="col-lg-6 text-center">
                {if $action_rights['PHB-SHOW-TKT-INFO']==1}
                <div class="row">
                    <div class="col-sm-3 p_r_n">
                        <div class="dropdown">
                            <button class="btn btn-default btn-xs dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true" style="width: 35px;">
                                <i class="fa fa-plus"></i>
                                <span class="caret">
                            </button>
                            <ul class="dropdown-menu text-left" aria-labelledby="s-selection">
                                <li><a href="javascript:;" onclick="doSeatSelection('seat-select-visibility', this);">Select All Vacant</a></li>
                                <li><a href="javascript:;" onclick="doSeatSelection('seat-booked-blocked', this);">Select All Blocked</a></li>
                                <li><a href="javascript:;" onclick="doSeatUnSelection(this);">Deselect All</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-9 p_l_n">
                        <ul class="busmap-summary hide">
                            <li><div  class="circle-box" id="s-boarding"><i class="fa fa-level-up"></i></div></li>
                            <li><div  class="circle-box" id="s-route"><i class="fa fa-road"></i></div></li>
                            <li><div  class="circle-box" id="s-bookedby"><i class="fa fa-user"></i></div></li>
                            <li><div  class="circle-box" id="s-gender"><i class="fa fa-male"></i></div></li>
                        </ul>
                    </div>
                </div>
                {/if}
            </div>
            <div class="col-lg-5">
                {if $action_rights['SCH-GENDER-PREF']==1}
                <div class="dropdown pull-left hide" id="gender-preference-panel">
                    <button class="btn btn-primary dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                        Gender
                        <span class="caret">
                    </span></button>
                    <ul class="dropdown-menu text-left" aria-labelledby="s-selection">
                        <li><a href="javascript:;" onclick="setSeatPreference('M')">Set To Male</a></li>
                        <li><a href="javascript:;" onclick="setSeatPreference('F')">Set To Female</a></li>
                    </ul>
                </div>
                {/if}
                {if $action_rights['ADD-QUOTA']==1}
                <div id="detailedquotabuttonpanel" class=" p_l_15 pull-left hide">
                    <button class="btn btn-primary btn-sm" type="button"  onclick="setQuotaSeatsPane()">Quota</button>
                </div>
                {/if}
            </div>
        </div>
      
        
      <div align="center" class="busmap">
        <div class="seat-map-over upper-layer col-md-12 hide">
          <div class="seat-map-over-all">
            <div class="col-xs-1  seat-map-driver-head">
              <div class="seat-map-upper"> </div>
              <p class="vertical-text">Upper</p>
            </div>
            <div class="col-xs-11 upper" style="width:auto;height: auto;"> </div>
          </div>
          <div class="clear_fix_both"></div>
        </div>
        <div class="clear_fix_both"></div>
        <div class="seat-map-over col-xs-12">
          <div class="seat-map-over-all">
            <div class="col-xs-1 seat-map-driver-head">
              <div class="seat-map-driver">&nbsp; </div>
              <div class="seat-map-selayer hide">
                <p class="vertical-text">Lower</p>
              </div>
            </div>
            <div class="col-xs-12 lower" style="width:auto;height: auto;"> </div>
          </div>
          <div class="clear_fix_both"></div>
        </div>
      </div>
      
      {if $action_rights['MNG-QUOTA']==1}
      <div id="trip_quota_container" class="hide">
            <div id='add-quota-panel'>
              <div class="toggle-seat-list">
                <div class="row">
                    <div class="col-sm-12">
                    <span class="bold">Seats selected for Allocation / Block : </span>
                    <span id="quota_sel_seats">U12, L9</span>
                    </div>
                </div>
                <div class="row">
                  <div class="col-sm-7">
                   {if $action_rights['ROUTE-QUOTA']==1}
                    <div class="form-group m_b_5">
                        <label class="radio-inline p_t_n">
                            <input type="radio" data-view="user-assignee" value="UR" id="alloc-quota-scope" name="alloc-quota-scope" checked>User
                        </label>
                        <label class="radio-inline p_t_n">
                            <input type="radio" data-view="stage-assignee" value="SG" id="alloc-quota-scope" name="alloc-quota-scope">Route
                        </label>
                    </div>
                    {/if}
                    <div class="col-sm-7 p_l_n quota-user-cont">
                      <label class="req">Users</label>
                      <select id='quota-user' class="form-control">
                          <option  value="">Select a user</option>
                          {foreach name=o item=grpusr from=$groupusers.groups}
                              <optgroup label="{$grpusr->name}">
                              {foreach name=o item=usr from=$groupusers.users} 
                                  {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                                      <option  value="{$usr.code}">{$usr.name}</option>      
                                  {/if}
                              {/foreach}      
                              </optgroup>
                          {/foreach}                                 
                      </select>
                    </div>
                    {if $action_rights['ROUTE-QUOTA']==1}
                    <div class="col-sm-7 p_l_n alloc-quota-route-cont hide">
                        <label class="req">Routes</label>
                        <select id='alloc-quota-route' class="form-control"></select>
                    </div>
                    {/if}
                    <div class="col-sm-5 p_l_n">
                      <label >Release Before <a class="note" href="javascript:;" title="Seats will be released automatically"><i class="fa fa-exclamation-circle"></i></a></label>
                      <select id='quota-rele-time' class="form-control">
                          <option value="-1">Never Release</option>
                          <option value="60">01 hour</option>
                          <option value="120">02 hours</option>
                          <option value="180">03 hours</option>
                          <option value="240">04 hours</option>
                          <option value="300">05 hours</option>
                          <option value="360">06 hours</option>
                          <option value="420">07 hours</option>
                          <option value="480">08 hours</option>
                          <option value="540">09 hours</option>
                          <option value="600">10 hours</option>
                          <option value="660">11 hours</option>
                          <option value="720">12 hours</option>
                          <option value="1440">01 Day</option>
                          <option value="2880">02 Days</option>
                          <option value="4320">03 Days</option>
                          <option value="5760">04 Days</option>
                          <option value="7200">05 Days</option>
                          <option value="10080">07 Days</option>
                          <option value="14400">10 Days</option>
                          <option value="43200">30 Days</option>
                      </select>
                    </div>
                    <div class="col-sm-12 p_l_n">
                        <label>Remarks</label>
                        <textarea name="remarks" id="aloc-remarks" class="form-control remarks rs_no" placeholder="Remarks"></textarea>
                    </div>
                  </div>
                  <div class="col-sm-4">
                    <label>&nbsp;</label><br/>
                    <button class="btn btn-success btn-sm" type="button" onclick="saveQuotaSeats()">Allocate</button><br/><br/>
                    <button class="btn btn-danger btn-sm" type="button"  onclick="blockQuotaSeats()">&ensp;Block&ensp;&nbsp;</button>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12" id="quota-pane">
                    
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <div  id="quota-action-error"></div>
                  </div>
                </div>
              </div>
            </div>
            
          </div>
  
          <div id="trip_release_container" class="hide">
            <div id='add-quota-panel'>
              <div class="toggle-seat-list">
                <div class="row">
                    <div class="col-sm-12 text-center">
                    <span class="bold">Seats selected for release : </span>
                    <span id="release_sel_seats">U12, L9</span>
                    </div>
                </div>
        
                <div class="row" id="release-button">                  
                  <div class="col-sm-12 text-center">
                    <button class="btn btn-success btn-sm" type="button" onclick="releaseQuotaSeats()"><i class="fa fa-eye"></i>&nbsp;Release</button>
                    <!--<button  type="button" class="btn btn-default btn-sm" onclick="clearQuotaSeats()">&nbsp;Clear</button>-->                    
                  </div>
                </div>
                
                <div class="row">
                  <div class="col-sm-12"> <br>
                    <div class="text-center"  id="release-action-error"></div>
                  </div>
                </div>
                
              </div>
            </div>
            
          </div>
       {/if}   
    </div>
    
    <div class="col-lg-6 col-md-6 col-sm-6">
      <div id="bus-result-list-action" class="tempform">
        <br><br><br><div class="well well-large" align="center">Please select a seat to get more options.</div>
      </div>
      
      <div id="quota-list-action" class="hide"></div>
      <div id="fare-list-action" class="hide"></div>
      <div id="preference-list-action" class="hide"></div>
      
    </div>
  </div>
</div>
       
</script>

<script id="template-booked-summary" type="text/template">
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6">
            <div class="bold">Boardings</div>
            <div id="s-boarding"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6">
            <div class="bold">Route</div>
            <div id="s-route"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6">
            <div class="bold">Booked by</div>
            <div id="s-bookedby"></div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6">
            <div class="bold">Gender</div>
            <div id="s-gender"></div>
        </div>
    </div>
</script>

<script id="template-book-list" type="text/template">
<div align="center" class="busmap-container"> 
    <form role="form" class="form-inline">
        <div class="row">
            <div class="form-group col-xs-4">
                <div class="input-group">
                    <input type="text" placeholder="Phone / Mobile" id="mobileno" maxlength="10" name="mobileno" onblur="loadPassengerDetails()" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                </div>
            </div>
            
            <div class="form-group col-xs-4">                                                                            
                <select class="form-control bod-pnt wid-p-100" id="bording-point">
                    <option>Bording Points</option>
                </select>
            </div>
            
            <div class="form-group  col-xs-4 drp-lst">                                                                            
                <select class="form-control drp-pnt wid-p-100" id="dropping-point">
                    <option value="">Dropping Points</option>
                </select>
            </div>    
        </div>
                        
        
        <div class="form-group col-xs-5 hide">
            <div class="input-group">
                <input type="email" placeholder="Email Address" id="emailaddress" name="emailaddress"  class="form-control">
                <span class="input-group-addon">@</span>
            </div>
        </div>   
     
        <div class="passenger-info">                                    
            <table class="table" id="bus-contact-list">
            <thead>
                 <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Seat No</th>
                    <th>Gender</th>
                    <th>Fare</th> 
                    <th>Discount</th>               
                </tr>
            </thead>
            <tbody>        
            </tbody>
            </table>
        </div>
     
        <div>
            <table class="table">
            <tr>
                {if $action_rights['ON-BEHALF-BOOKING']==1 || $action_rights['AGENT-SERVICE-CHARGES']==1}
                    <td width="30%" valign="top">
                        {if $action_rights['ON-BEHALF-BOOKING']==1}
                        <span class="bold">On Behalf of</span> <br>        
                        <select class="form-control wid-p-100" id="offlineuser">
                            <option value="">Select a user</option>
                            {foreach name=o item=row from=$offlineusers}                                                                        
                                <option  value="{$row->code}">{$row->name}</option>                                                                      
                            {/foreach}
                        </select>
                        {/if}

                        {if $action_rights['AGENT-SERVICE-CHARGES']==1}
                            <span class="bold">Service Charges</span> <br>                
                            <input type="text"  class="form-control wid-p-100" id="agentservicecharges" maxlength="3" onblur="recalculateSplDiscount(this);" value="0" />
                            <span class="text-muted">max  <i class="fa fa-rupee"></i>100 per seat</span>
                        {/if} 
                    </td>                       
                {/if}

                {if $action_rights['SPL-DISCOUNT']==1 || $action_rights['OFFLINE-PAY-MODE']==1}    
                <td width="20%" valign="top">
                    {if $action_rights['SPL-DISCOUNT']==1}
                        <span class="bold">Discount</span> <br>                
                        <input type="text"  class="form-control wid-p-100" id="spldiscount" onblur="recalculateSplDiscount(this);" value="0" />   
                    {/if}
                    {if $action_rights['OFFLINE-PAY-MODE']==1}
                    <span class="bold">Payment Mode</span> <br>                
                    <select class="form-control wid-p-100" id="offlinepaytype">
                        <option value="CASH">Cash</option> 
                        <option value="CCD">Card</option>
                    </select>
                    <span class="text-muted">&nbsp;</span>
                    {/if}
                </td>
                {/if}
                <td width="50%" valign="top" style="vertical-align:top;">
                    <span class="bold">Remarks</span> <br>
                    <textarea name="remarks" id="remarks" class="form-control remarks rs_no wid-250" style="height:fit-content; " placeholder="Remarks"></textarea>
                </td>
            </tr>
            </table>
        </div>
        
        <div class="clear_fix_both text-left">         
            <div class="row">
                <div class="col-md-4">                
                    <div style="padding:10px 0px;">
                        <label class="checkbox-inline">
                            <input type="checkbox" value="1" class="gstpanel" id="gstpanel" name="gstinputs" onchange="toggleGstOptions(this)">Request GST Invoice &nbsp;&nbsp; 
                        </label>
                    </div>
                </div>                         
            </div>        
        </div>
        <div class="clear_fix_both text-left hide" id="gst-formcontainer">         
            <div class="row">            
                <div class="col-md-4">                    
                    <input type="text" class="form-control" id="gst_gstin" name="gst_gstin" placeholder="GSTIN" maxlength="15" />                   
                </div>                

                <div class="col-md-4">                    
                    <input type="text" class="form-control" id="gst_tradename" name="gst_tradename" placeholder="GST Trade Name" maxlength="100" />                   
                </div>
                <div class="col-md-4">                    
                    <input type="text" class="form-control" id="gst_email" name="gst_email" placeholder="Business Email" maxlength="100" />                   
                </div>                 
            </div>        
        </div>
    
        {if $action_rights['PHB-ALLOWED']==1}
        <div class="clear_fix_both text-left">         
            <div class="row">
                <div class="col-md-4">                
                    <div style="padding:10px 0px;">
                        <label class="checkbox-inline">
                            <input type="checkbox" value="1" class="viewBookList" id="phoneBooking" name="phoneBooking" onchange="togglePBOptions(this)">{$phonebook_label} &nbsp;&nbsp; 
                        </label>
                    </div>
                </div>

                {if $action_rights['SRP-LINKPAY']==1}
                <div class="col-md-3">                    
                    <div style="padding:10px 0px;">
                        <label class="checkbox-inline">
                            <input type="checkbox" id="enable-linkpay" name="enable-linkpay"> Enable Linkpay
                        </label>       
                    </div>                    
                </div> 
                {/if}

                <div class="col-md-5">                
                    <div  id="phone-blocking-options" class="hide">                       
                            <select class="form-control wid-p-100" id="release-min-override">
                            {foreach item=row from=$pb_release key=key}
                            <option value={$key}>{$row}</option>
                            {/foreach}
                            </select>
                    </div>
                </div>
            </div>        
        </div>
        {/if}
        
        <div class="passenger-info btn-booking" align="left">
            {if $action_rights['WALKIN-DISCOUNT']==1}
            <label class="checkbox-inline">
                <input type="checkbox" value="" class="viewBookList" id="chkofflinediscount" name="chkofflinediscount">Walk-in discount &nbsp;&nbsp; 
            </label>
            {/if}
            {if $action_rights['ALLOW-FREE-SERVICE-TCK']==1}
            <label class="checkbox-inline">
                <input type="checkbox" value="" class="viewBookList" id="chkfreeservice" name="chkfreeservice">Free Ticket &nbsp;&nbsp; 
            </label>
            {/if}
        </div>
        
        {if $action_rights['SRP-GO-GREEN']==1}
        <div class="gogreenpanel" align="left"> <br>
            <div class="row">
                <div class="col-sm-12 col-xs-12">
                    <label class="checkbox-inline">
                        <input type="checkbox" value="" class="viewBookList" id="gogreendonation" name="gogreendonation" checked="true">
                        Add <i class="fa fa-rupee"></i>10 to your transaction as donation(<b>uncheck if you do not wish to donate</b>) For more details, visit <a href="http://gogreen.parveentravels.com/" target="_blank">gogreen.parveentravels.com</a>
                    </label>
                </div>
            </div>
        </div>
        {/if}
        
        <div class="clear_fix_both"></div><br />
     
        <div class="row" align="center">
            <div class="col-lg-12">
                <span class="text-danger bold"> Seats : </span> &nbsp; <span class="seat-list"></span> 
                <span> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Seat Fare :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="seat-fare">0</span>
                </span>
                <span id="boarding-fare-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Boarding Fare :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="boarding-fare">0</span>
                </span>
                <span id="dropping-fare-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Dropping Fare :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="dropping-fare">0</span>
                </span>
                <span id="discount-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Discount :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="discount">0</span>
                </span>
                <span id="femalediscount-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Female Discount :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="total-femalediscount">0</span>
                </span>
                <span id="tax-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">GST :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="total-tax">0</span>
                </span>
                <span id="gogreen-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Go Green :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="total-gogreen">0</span>
                </span>
                <span id="service-container" class="hidden no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Service Charges :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="total-service">0</span>
                </span>                
                <span class="no-wrap"> 
                    &nbsp;&nbsp;&nbsp;<span class=" text-danger bold">Payable :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="fare bold">0</span>
                </span>
            </div>
        </div>

        <div class="passenger-info error-list" align="center"></div>
      
        <div id="payment-gate" style="display:none" align="center">
          <div>
               <label class="">Please select a payment method</label>
               <select class="form-control pygt " id="payment-gateway">
                  <option value="">Payment Method</option>
               </select>
          </div>
          <br />  
          <div class="" align="center">
              <button type="button" class="btn btn-success btn-pg-confirm">Pay & Confirm</button>
              <button type="button" class="btn btn-default btn-pg-cancel">Cancel</button>
          </div>
       </div>
      
        <div class="clear_fix_both"></div><br /> 
     
        <div class="passenger-info btn-booking" align="right">        
            {if $action_rights['BOOK-ON-OTP']==1}
                <br><br>
                <input type="text" class="form-control" id="bookingotp" size="6" value="" placeholder="OTP" /> 
                <button type="button" class="btn btn-success btn-getotp">Get OTP</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            {/if}
            <button type="button" class="btn btn-default btn-cancel">Clear</button>
            <button type="button" class="btn btn-success btn-confirm {if $action_rights['BOOK-ON-OTP']==1}hide{/if}">Confirm</button>
        </div>
     
        <br>   
        <div id="offlinediscountstatus" class="alert hide" align="center"></div>
     
    </form>
</div>
</script>
<script id="template-contact-list" type="text/template">
    <tr>
    <td>
    <input type="text" name="name" id="name" class="form-control name" placeholder="Name"/>
    </td>
    <td>
    <input type="text" name="age" id="age" class="form-control age" size="3" maxlength="3" placeholder="Age"/>
    </td>
    <td align="center"><span class="seat-no"></span></td>
    <td>
    <label class="radio-inline">
    <input type="radio" class="gen male" value="M" id="gender" name="gender">
    M
    </label>
    <label class="radio-inline">
    <input type="radio" class="gen female" value="F" id="gender" name="gender">
    F
    </label>

    </td>
    <td><span class="seat-fare-list"></span></td>
   <td><span class="discount-list"></span></td>
    
    </tr>
</script> 



<script id="template-success-button" type="text/template">
<div class="clear_fix_both"></div><br />
    
<div class="">
  <div class="row pb5">
    <div class="col-sm-5">
      <div class="bold">PNR</div>
      <div id="pnr">THAGAJC59Q76</div>
    </div>
    <div class="col-sm-5">
      <div class="bold">Route</div>
      <div id="route">-</div>
    </div>
  </div>
  
  <div class="row pb5">
    <div class="col-sm-5">
      <div class="bold">Boarding</div>
      <div id="boarding">J.K Complex (  8:00 PM ), 74491-32224,74492-32224 </div>
    </div>
    
    <div class="col-sm-5">
      <div class="bold">Passenger Mobile</div>
      <div id="mobile">9600004321</div>
    </div>

  </div>
  
  <div class="row pb5">    
    <div class="col-sm-5">
      <div class="bold">Booked By</div>
      <div id="bookedby">Ticketgoose</div>
    </div>
    <div class="col-sm-5 col-md-5">
      <div class="bold">Booked At</div>
      <div id="bookedat">19/10/2016 12:59 PM </div>
    </div>
  </div>
</div>

<div class="">
  <div class="table-responsive">
    <table id="dt_report_table" class="table" style="border:1px solid #dddddd">
      <thead>
        <tr bgcolor="#F5F5F5">
          <th style="border:1px solid #dddddd">Passenger Name</th>
          <th style="border:1px solid #dddddd;text-align:center ">Seat No.</th>
          <th style="border:1px solid #dddddd;text-align:center ">Gender</th>
          <th style="border:1px solid #dddddd;text-align:center ">Age</th>
          <th style="border:1px solid #dddddd;text-align:center ">Fare</th>
        </tr>
      </thead>
      <tbody class="body_table">
        
      </tbody>
    </table>
  </div>
</div>

<div class="col-md-12">
    <div class="align-center alert alert-danger" style="display:none;" id="notify-action-state"></div>
</div>
    
<div class="row" align="center" style="padding-top:10px;"> 
    <div class="col-md-2">
        <button class="btn btn-danger btn-clr">Clear</button>
    </div>
    <div class="col-md-10 text-right"> 
        {if $action_rights['CHNG-TRVL-STATUS']==1}
        <div class="btn-travel-status dropdown dropup d-inline-block">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Travel Status <span class="caret"></span>
            </button>
            <ul class="dropdown-menu dropdown-menu-right text-left">
                <li><a href="javascript:;" class="btn-traveled">Travelled</a></li>
                <li><a href="javascript:;" class="btn-not-traveled">Not Travelled</a></li>
            </ul>&emsp;
        </div>
        {/if}       
        
        <div class="dropdown dropup d-inline-block">
            <button class="btn btn-success dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown">
                Modify
                <span class="caret">
            </span></button>
            <ul class="dropdown-menu dropdown-menu-right text-left" aria-labelledby="s-selection">
                {if $action_rights['SCH-TRIP-SEAT-TRANSFER']==1}
                <li><a href="javascript:;" class=" btn-transfer">Transfer</a></li>
                {/if}
                {if $action_rights['findEditTickets']==1}
                <li><a href="javascript:;" class=" btn-editticket">Edit</a></li>
                {/if}
                <li><a href="javascript:;" class="btn-cnl">Cancel</a></li>
            </ul>&emsp;
        </div>
        
        <div class="dropdown dropup d-inline-block">
            <button class="btn btn-primary dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown">
                Print
                <span class="caret">
            </span></button>
            <ul class="dropdown-menu dropdown-menu-right text-left" aria-labelledby="s-selection">
                <li><a href="javascript:;" class="btn-print">Print</a></li>
                <li><a href="javascript:;" class="btn-mini-print">Mini Print</a></li>
            </ul>&emsp;
        </div>
                
        <div class="dropdown dropup d-inline-block">
            <button class="btn btn-default dropdown-toggle" type="button" id="s-selection" data-toggle="dropdown">
                Notify
                <span class="caret">
            </span></button>
            <ul class="dropdown-menu dropdown-menu-right text-left" aria-labelledby="s-selection">                
                <li class="dropdown-header"><b><i class="fa fa-large fa-mobile" aria-hidden="true"></i>&emsp;SMS</b></li>
                <li><a href="javascript:;" class="btn-notify-tkt" data-notify-type="SMS">Ticket Details</a></li>
                <li><a href="javascript:;" class="btn-notify-tkt" data-notify-type="RSNDGPSHJ">Driver Contact / GPS Tracking</a></li>
                <li class="divider" role="seperator"></li>
                <li class="dropdown-header"><b><i class="fa fa-lg fa-whatsapp" aria-hidden="true"></i>&emsp;WhatsApp</b></li>
                <li><a href="javascript:;" class="btn-notify-whatsapp" data-notify-type="TICKET">Ticket Details</a></li>
                <li><a href="javascript:;" class="btn-notify-whatsapp" data-notify-type="RSNDGPSHJ">Driver Contact / GPS Tracking</a></li>
                <li class="divider" role="seperator"></li>
                <li class="dropdown-header"><b><i class="fa fa-md fa-envelope-o" aria-hidden="true"></i>&emsp;E-mail</b></li>
                <li><a href="javascript:;" class="btn-notify-tkt" data-notify-type="MAIL">Email Ticket details</a></li>
                <li><a href="javascript:;" class="btn-notify-tkt" data-notify-type="INVOICE">Email GST Invoice</a></li>
            </ul>&emsp;
        </div>
        
        <button class="btn btn-default btn-moreinfo">More</button>
    </div>       
</div>

</script> 

<script id="template-quota-container" type="text/template">
<div class="row">    
    <div class="row">
        <div class="col-sm-6">
          <label class="req"  class="req">
          User
          </label>
          {if $action_rights['ADD-QUOTA-TO-OTHERS']==1}
          <select id='detailed-quota-user' class="form-control">
              <option  value="">Select a user</option>
              {foreach name=o item=grpusr from=$groupusers.groups}
                  <optgroup label="{$grpusr->name}">
                  {foreach name=o item=usr from=$groupusers.users} 
                      {if $usr.groupcode == $grpusr->code && $usr.activeFlag == 1}
                          <option  value="{$usr.code}">{$usr.name}</option>      
                      {/if}
                  {/foreach}      
                  </optgroup>
              {/foreach}                                 
          </select>
          {else}
              {$usr_login_name}
              <input type="hidden" id="detailed-quota-user" value="{$usr_login_id}">
          {/if}
        </div>
          
        <div class="col-sm-5">
          <label >Release Before <a class="note" href="javascript:;" title="Seats will be released automatically"><i class="fa fa-exclamation-circle"></i></a></label>
          <select id='detailed-quota-rele-time' class="form-control">
              <option value="-1">Never Release</option>
              <option value="60">01 hour</option>
              <option value="120">02 hours</option>
              <option value="180">03 hours</option>
              <option value="240">04 hours</option>
              <option value="300">05 hours</option>
              <option value="360">06 hours</option>
              <option value="420">07 hours</option>
              <option value="480">08 hours</option>
              <option value="540">09 hours</option>
              <option value="600">10 hours</option>
              <option value="660">11 hours</option>
              <option value="720">12 hours</option>
              <option value="1440">01 Day</option>
              <option value="2880">02 Days</option>
              <option value="4320">03 Days</option>
              <option value="5760">04 Days</option>
              <option value="7200">05 Days</option>
              <option value="10080">07 Days</option>
              <option value="14400">10 Days</option>
              <option value="43200">30 Days</option>
          </select>
        </div>
    </div>
    
    <div class="row">  
        <div class="col-sm-11">
            <table class="table" id="quota-contact-list">
                <thead>
                    <tr>
                        <th width="20%">Seat No</th>
                        <th width="20%">Gender</th>
                    </tr>
                </thead>
            <tbody>
            </tbody>
            </table>
        </div>
    </div>    
        
    <div class="row"> 
        <div class="col-sm-11">
            <br>
            <div class="row hide" align="center" id="quotarow-action"></div>
            <div class="row" align="center" style="padding-top:10px;" id="quotarow-button"> 
                <div class="col-md-12 text-right">
                    <button class="btn btn-default btn-quotaclr">Clear</button>&nbsp;     
                    <button class="btn btn-success btn-quotaconfirm">Confirm</button> 
                </div>       
            </div>
        </div>
   </div> 
        
</div>
</script>
<script id="template-quota-pane-seat-list" type="text/template">
    <tr class="quota-row">
        <td align="left" width="20%"><span class="seat-no"></span></td>
        <td>
            <label class="radio-inline">
                <input type="radio" class="gen male" value="M" id="gender" name="gender"> M
            </label>
            <label class="radio-inline">
                <input type="radio" class="gen female" value="F" id="gender" name="gender"> F 
            </label>
        </td>
    </tr>
</script>

<script id="template-live-booking-ticket" type="text/template">
<div class="clear_fix_both"></div><br />
    
<div class="">
  <div class="row pb5">
    <div class="col-sm-5">
      <div class="bold">PNR</div>
      <div id="pnr">THAGAJC59Q76</div>
    </div>
    <div class="col-sm-5">
      <div class="bold">Route</div>
      <div id="route">Sivakasi To Bangalore</div>
    </div>
  </div>
  
  <div class="row pb5">
    <div class="col-sm-5">
      <div class="bold">Boarding</div>
      <div id="boarding">J.K Complex (  8:00 PM ), 74491-32224,74492-32224 </div>
    </div>
    
    <div class="col-sm-5">
      <div class="bold">Passenger Mobile</div>
      <div id="mobile">9600004321</div>
    </div>

  </div>
  
  <div class="row pb5">    
    <div class="col-sm-5">
      <div class="bold">Booked By</div>
      <div id="bookedby">Ticketgoose</div>
    </div>
    <div class="col-sm-5 col-md-5">
      <div class="bold">Booked At</div>
      <div id="bookedat">19/10/2016 12:59 PM </div>
    </div>
  </div>
</div>

<div class="">
  <div class="table-responsive">
    <table id="dt_report_table" class="table" style="border:1px solid #dddddd">
      <thead>
        <tr bgcolor="#F5F5F5">
          <th style="border:1px solid #dddddd">Passenger Name</th>
          <th style="border:1px solid #dddddd;text-align:center ">Seat No.</th>
          <th style="border:1px solid #dddddd;text-align:center ">Gender</th>
          <th style="border:1px solid #dddddd;text-align:center ">Age</th>
          <th style="border:1px solid #dddddd;text-align:center ">Fare</th>
        </tr>
      </thead>
      <tbody class="body_table">
        
      </tbody>
    </table>
  </div>
</div>

<div class="row hide" align="center" id="livebooking-action"></div>
    
<div class="row" align="center" id="livebooking-button-pane" style="padding-top:10px;"> 
    <div class="col-md-2">
        <button class="btn btn-danger btn-liveclr">Clear</button>
    </div>
    <div class="col-md-10 text-right">         
        <button class="btn btn-primary btn-release">Force Release</button>        
    </div>       
</div>

</script> 
<script id="template-booked-cancel" type="text/template">
    <div class="cancel-booked-ticket" align="center"> 
    <div id="pnr-code"></div>
    <table class="table" id="booked-contact-list">
        <thead>
            <tr>
                <th>Action</th> 
                <th>Name</th>
                <th>Age</th>
                <th>Seat No</th>
                <th>Fare</th>
                <th>Gender</th>
                <th>Status</th>
                <th>Refund Amount</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div class="clear_fix_both"></div><br />

    <div class="passenger-info cancel-error-list" align="center"></div>

    <div class="clear_fix_both"></div><br />
    <div class="passenger-info" align="center"> 
        <button type="button" class="btn btn-success btn-cancel">Cancel</button>
        <button type="button" class="btn btn-default btn-Clear">Clear</button>
    </div>
    </div>
</script>  
<script id="template-booked-cancel-list" type="text/template">
    <tr>
    <td>  
    <input class="tick" name="ticked-booked" id="ticked-booked" value="" type="checkbox" />
    </td>
    <td>
    <span class="name"></span>
    </td>
    <td>
    <span class="age"></span>
    </td>
    <td>
    <span class="seat-no"></span>
    </td>
    <td>
    <span class="fare"></span>
    </td>
    <td>
    <span class="gender"></span>
    </td>
    <td>
    <span class="status"></span>
    </td>
    <td>
    <span class="refund-amount"></span>
    </td>
    </tr>
</script> 
<div class="hide" id="travel-status-seats">
    <div class="" style="min-height: 200px;">
        <div class="col-lg-12 col-sm-12 col-xs-12">
            <label id="lbl-title">Please select the seats</label>
            <ul class="user_list">                                            
                <li>                                                 
                    <div>
                        <input type="checkbox" checked="checked" name="ts-checkbox" value="">
                        <lable></lable>
                    </div>                                                 
                </li>
            </ul>
        </div>
    </div>
    <div class="clear_fix_both">                                    
        <div class="text-right" id="travel-status-action"></div>
    </div> 
    <div class="clear_fix_both"> 
        <div class="text-right" id="ts-btn-pane">
            <button class="btn btn-success" type="button" id="travel-status-btn" onclick="changeTravelStatus();">Update</button>
            <button class="btn btn-default" type="button" onclick="closeTravelStatusdialog();">Cancel</button>
        </div>
        <div class="text-right" id="ts-info">
            <span class="text-muted"><i class="fa fa-info-circle"></i> Upon successfull update, selected seats are opened again for booking.</span>
        </div>
    </div> 
</div>

<script>
    var routes = {$route|json_encode};
    var stations = {$stations|json_encode};
    var q_from = '{$smarty.request.from}';
    var q_to = '{$smarty.request.to}';
    var q_date = '{$smarty.request.date}';
    var login_user_id = '{$usr_login_id}';

    function init_search_page() {
        initSearchTabs();
    }
    
    $(function() {
        $("[data-toggle='tooltip']").tooltip();
    });

</script>    
