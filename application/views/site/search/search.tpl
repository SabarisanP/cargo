
<div class="brand_top">
    <h3>Book Ticket</h3> 
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

                                    <div class="tabbable" id="tab">
                                        <ul class="nav nav-tabs">
                                            <li id="add-tab" title="Add new search" data-toggle="tooltip">
                                                <a href="javascript:;" onclick="addNewTab(event)"> <i class="fa fa-plus"></i> </a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">

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


<div id='trip-info' style="background-color: #fff;" class="hidden"></div>
<div id='trip-settings' style="background-color: #fff;" class="hidden"></div>

<input type="hidden" id="sch_code" value="">

<script id="template-trip-setings" type="text/template"> 
    <div class="">
        <div class="pull-right"> 
            <a title="close" href="javascript:;" class="btn-lg" onclick="close_settings_popup()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
        <div class="pull-left bold" id="trip-setting-head"> 
            Chennai to Ooty, 09-03-2016, 6:30 PM, 2+2 Semi Sleeper Non A/C
        </div>
    </div>
    
    
    <div class="clearfix">&nbsp;</div>
    
    <ul class="nav nav-tabs" id="tabs_s">
        <li class="active"><a data-toggle="tab" href="#s_fare_override_s">Fare Auto Override</a></li>
        {if $action_rights['SCH-SEAT-VISIBILITY']==1}
        <li><a data-toggle="tab" href="#s_seat_visiblity_s" onclick="load_seat_visiblity();">Seat Visiblity</a></li>
        {/if}
    </ul>
    
    <div class="tab-content" id="tabs_content_s">
        <div id="s_fare_override_s" class="tab-pane fade in active" style="max-height:450px; overflow-x:auto"></div>
        {if $action_rights['SCH-SEAT-VISIBILITY']==1}
        <div id="s_seat_visiblity_s" class="tab-pane fade" style="max-height:460px; overflow-x:auto"></div>
        {/if}
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
  <div id="search-panel">
    <div class="divide-10"></div>
    <form class="form-inline" role="form">
        <div class="row">
          <div class="col-sm-12 col-md-12 col-lg-11">
            <div class="row">
              <div class="col-sm-3 col-lg-2">
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
          </div>
        </div>
      </form>

  </div>
  
  <div class="clear_fix_both"></div>
  <br />
  
  <div class="cancel-terms"></div>
  <div class="row">
    <div id="cookie-result" class="col-xs-6"></div>
    <div id="cookie2-result" class="col-xs-6"></div>
  </div>
  
  <div id="result-panel"></div>
  
</div>
</script>
<script id="template-bus-list" type="text/template">
    <li class="clearfix ticket-row">
        <div class="col-xs-9 p_l_n" style="padding-right:0px;">
          <h7 class="pull-left"><span class="bold busCategory"></span>&nbsp;</h7>           
          <span class="pull-left trip-status p_l_15"></span>
          <span class="text-muted p_l_15">
                <i class="fa fa-clock-o"></i> 
                <span class="travelTime">6:15 AM</span>
          </span>&nbsp;
          <div class="clear_fix_both"></div>
          <p class="busVia col-xs-7 p_l_n text-muted">Via : </p>
          <p class=""> 
              <span data-toggle="popover" class="has-popover pp boarding" data-station="" data-tripcode="" data-tap="1">
                      <i class="fa fa-level-up"> </i>
                      <span class=" ftime">8:00 PM</span>
              </span> &nbsp; 
              <span data-toggle="popover" data-station="" data-tripcode="" data-tap="1" data-tip="1" class="arrival">
                      <i class="fa fa-level-down"></i> 
                      <span class=" ttime">6:15 AM</span>
              </span> &nbsp; 
              <span><i class="fa fa-list has-cancel-popover pull-left m-t-5" title="more details" data-toggle="tooltip"></i>&nbsp;</span>
          </p>
        </div>
        <div class="text-right pull-right">
          <p> <span title="Fare" class="fare text-danger bold"></span> &nbsp; 
              <span title="Discount" class="discount text-info bold"></span>
           </p>
          
          <p class="lead">
              <span class="label label-success">
                  <i class="fa fa-check"></i> 
                  <span class="seat-count"> </span> 
              </span>
           </p>
        </div>

        <div class="clearfix"></div>
        <div>
            {if $action_rights['SEARCH-TRIP-SETTINGS']==1}  
            <div class="pull-right settings">
                <p><i title="settings" data-toggle="tooltip" class="fa fa-cog fa-lg settings-icon has-cancel-popover" /></p>
            </div> 
            {/if}
            <div class="pull-left amenities"></div> 
        </div>
        <div class="clearfix"></div>
    </li>
</script>
<script id="template-busmap-list" type="text/template">
<div class="pull-right"> 
<a id="refresh" title="Refresh" data-toggle="tooltip" href="javascript:;">
    <i class="fa fa-repeat f17"></i>
</a>
<a id="close"  title="Clear" data-toggle="tooltip" href="javascript:;"><i class="fa fa-times f17"></i></a>
</div>

<div class="clear_fix_both hidden" id="trip-status">
    <div class="align-center alert alert-danger"></div>
</div>

    <div class="busmap-list">
          
        <div align="center" class="busmap col-xs-12"> 
        <div class="seat-map-over upper-layer col-md-12 hide">
            <div class="seat-map-over-all">
                <div class="col-xs-1  seat-map-driver-head">
                    <div class="seat-map-upper">
                    </div>
                    <p class="vertical-text">Upper</p>
                </div>
                <div class="col-xs-11 upper" style="width:auto;height: auto;">
    
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </div>

        <div class="clear_fix_both"></div><br />
        
        <div class="seat-map-over col-xs-12">
            <div class="seat-map-over-all">
                <div class="col-xs-1 seat-map-driver-head">
                    <div class="seat-map-driver">&nbsp;
                    </div>
                    <div class="seat-map-selayer hide">
                        <p class="vertical-text">Lower</p>
                    </div>
                </div>
                <div class="col-xs-12 lower" style="width:auto;height: auto;">
 
                </div>
            </div>
            <div class="clear_fix_both"></div>
        </div> 
        
        
       
        </div><!--
        <div class="col-xs-4">
                
            <div class="seat-available-gents seat-lay-details mrg-3 .AM">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AM">Available Male</div>
                <div class="clear_fix_both .AM"></div>
            <div class="seat-available-ladies seat-lay-details mrg-3 .AF">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AF">Available Ladies</div>
                <div class="clear_fix_both .AF"></div>
            <div class="seat-available-all seat-lay-details mrg-3 .AL">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AL">Allocated for all</div>
                <div class="clear_fix_both .AL"></div>
            <div class="seat-available-you seat-lay-details mrg-3 .AY">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AY">Allocated for You</div>
                <div class="clear_fix_both .AY"></div>
            <div class="seat-available-other seat-lay-details mrg-3 .AO">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .AO">Allocated for Other</div>
                <div class="clear_fix_both .AO"></div>
            <div class="seat-booked-gents seat-lay-details mrg-3 .BM">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .BM">Booked for Male</div>
                <div class="clear_fix_both .BM"></div>
            <div class="seat-booked-ladies seat-lay-details mrg-3 .BF">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .BF">Booked for ladies</div>
                <div class="clear_fix_both .BF"></div>
            <div class="seat-booked-blocked seat-lay-details mrg-3 .TBL .BL">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf .TBL .BL">Blocked Seat</div>
                <div class="clear_fix_both .TBL .BL"></div>
            <div class="seat-now-select seat-lay-details mrg-3">&nbsp;</div>
            <div class="col-xs-9 txt-alg-lf">Selected Seat</div>
                <div class="clear_fix_both"></div>
        
       </div>-->
      <div class="clear_fix_both"></div><br />

      <div id="bus-result-list-action" class="tempform"><div class="well well-large" align="center">Please select a seat to get more options.</div></div>
    
</div>
        
</script>   
<script id="template-book-list" type="text/template">
<div align="center" class="busmap-container"> 
        <div align="center">
            <span class="text-danger bold"> Seats : </span> &nbsp; <span class="seat-list">&nbsp;</span> &nbsp; 
            <span> 
                <span class=" text-danger bold">Seat Fare :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="seat-fare">0</span>
            </span>
           
            <span id="tax-container" class="hidden"> 
                <span class=" text-danger bold">Tax :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="total-tax">0</span>
            </span>
    
            <span id="service-container" class="hidden"> 
                <span class=" text-danger bold">Service Charges :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="total-service">0</span>
            </span>
    
            <span id="discount-container" class="hidden"> 
                <span class=" text-danger bold">Discount :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="discount">0</span>
            </span>
            <span> 
                <span class=" text-danger bold">Total Fare :</span> <i class="fa fa-rupee"></i>&nbsp;<span class="fare">0</span>
            </span>
        </div>
            
        <div class="clear_fix_both"></div><br>
        
    <form role="form" class="form-inline">
<div class="passenger-info">

            <div class="form-group col-xs-5">
                <div class="input-group">
                    <input type="text" placeholder="Phone / Mobile" id="mobileno" maxlength="10" name="mobileno" onblur="loadPassengerDetails()" class="form-control">
                    <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                </div>
            </div>
            <div class="form-group col-xs-5">
                <div class="input-group">
                    <input type="email" placeholder="Email Address" id="emailaddress" name="emailaddress"  class="form-control">
                    <span class="input-group-addon">@</span>
                </div>
            </div>
            

            </div>
            <div class="clear_fix_both"></div><br/>
            <div class="form-group col-xs-5">                                                                            
                <select class="form-control bod-pnt wid-p-100" id="bording-point">
                    <option>Bording Points</option>
                </select>
            </div>
           <div class="form-group  col-xs-5 drp-lst hide">                                                                            
                <select class="form-control drp-pnt wid-p-100" id="dropping-point">
                    <option value="">Dropping Points</option>
                </select>
            </div>
     <div class="clear_fix_both"></div><br>
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
            <td width="30%">
            
                {if $action_rights['ON-BEHALF-BOOKING']==1}
                    <span class="bold">On Behalf of</span> <br>                
                    <select class="form-control wid-p-100" id="offlineuser">
                        <option value="">Select a user</option>
                        {foreach name=o item=row from=$groupusers.users}                                                                        
                            <option  value="{$row.code}">{$row.name}</option>                                                                      
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
            {if $action_rights['SPL-DISCOUNT']==1}    
            <td width="20%">
                <span class="bold">Discount</span> <br>                
                <input type="text"  class="form-control wid-p-100" id="spldiscount" maxlength="4" onblur="recalculateSplDiscount(this);" value="0" />                                                   
            </td>
            {/if}
            <td width="50%">
                <span class="bold">Remarks</span> <br>
                <textarea name="remarks" id="remarks" class="form-control remarks rs_no wid-250" placeholder="Remarks"></textarea>
            </td>
        </tr>
        </table>
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
      
     <div class="clear_fix_both"></div>
     <div class="passenger-info btn-booking" align="center">
        {if $action_rights['PHB-ALLOWED']==1}
        <label class="checkbox-inline">
	        <input type="checkbox" value="1" class="viewBookList" id="phoneBooking" name="phoneBooking">&nbsp;Phone booking &nbsp; 
	</label>
        {/if}
        <button type="button" class="btn btn-default btn-cancel">Cancel</button>
        <button type="button" class="btn btn-success btn-confirm">Confirm</button>
     </div>
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
    <div class="passenger-info" align="center"> 
    <button type="button" class="btn btn-success btn-print">Print ticket</button>
    <button type="button" class="btn btn-success btn-cnl">Cancel ticket</button>
    <button type="button" class="btn btn-default btn-clr">Clear</button>
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


<script>
    var routes = {$route|json_encode};
    var stations = {$stations|json_encode};
    var q_from = '{$smarty.request.from}';
    var q_to = '{$smarty.request.to}';
    var q_date = '{$smarty.request.date}';
    function init_search_page() {
        initSearchTabs();
    }
    
    $(function() {
        $("[data-toggle='tooltip']").tooltip();
    });

</script>    
