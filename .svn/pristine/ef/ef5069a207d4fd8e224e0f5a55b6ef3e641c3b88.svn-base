<div class="brand_top">
    <h3>Dashboard</h3>
    {if $action_rights['MIN-LIVE-BOOKING']==1}
    <span class="align-right"><a href="#ticket/progress" class="btn btn-success btn-sm"><i class="ion-arrow-right-b"></i>&nbsp;Live Booking</a></span>
    {/if}
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                       
                        <div class="dash_full2">
                            <div class="row" style="padding-top:18px" >
                                
                                <div class="col-md-6">
                                    <div class="row">
                                        
                                        <div class="col-md-12 quick-link-div">
                                            
                                            <div class="row">
                                                {if $action_rights['bookBusTickets']==1}
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="{if $search_url!=""}#{$search_url}{else}#search/minimized{/if}" class="quick_links" data-label="Quick Link Book">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_f"><i class="fa fa-shopping-cart"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Book Tickets</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                                {/if}        
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="#search/print-ticket" class="quick_links" data-label="Quick Link Print">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_g"><i class="fa fa-print"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Print Tickets</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                                {if $action_rights['cancelBusTickets']==1}
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="#search/cancel-ticket" class="quick_links" data-label="Quick Link Cancel">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_a"><i class="fa fa-times"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Cancel Tickets</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                                {/if}
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="#profile/edit-profile" class="quick_links" data-label="Quick Link Profile">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_d"><i class="fa fa-gears"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Profie</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                {if $action_rights['confirmPhoneBook']==1}                                                
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="#phonebooking/confirm?term=today" class="quick_links" data-label="Quick Link PhoneBook">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_f"><i class="fa fa-mobile-phone"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Phone Bookings</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>  
                                                {/if}
                                                
                                                {if $action_rights['activeTrips']==1}
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="#schedules" class="quick_links" data-label="Quick Link Trips">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_f"><i class="fa fa-road"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Trips</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>  
                                                {/if}
                                                
                                                {if $action_rights['boardingPointTripchart']==1}
                                                <div class="col-lg-3 col-xs-12 col-sm-6">
                                                    <div class="panel panel-default">
                                                        <a href="#boardingtripchart/boarding-tripchart" class="quick_links" data-label="Quick Link Tripchart">
                                                        <div class="stat_box stat_up1">                                                        
                                                            <div class="stat_ico"></div>
                                                            <div class="stat_content">
                                                                <span class="stat_count">
                                                                    <div class="stat_ico color_f"><i class="fa fa-list"></i></div>
                                                                </span>
                                                            </div>
                                                            <div class="stat_content pd_16 text-align-center">
                                                                <span class="stat_name bold">Tripchart</span>
                                                            </div>                                                        
                                                        </div>
                                                        </a>
                                                    </div>
                                                </div>
                                                {/if}
                                            </div>

                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-ticket"></i> Quick Book</div>

                                                <form class="form" role="form">
                                                    <div class="col-sm-4 col-tb-4">
                                                        <div class="form-group">
                                                            <div class="input-group col-md-12">

                                                                <select class="form-control from" id="from-station">
                                                                    <option value="">Select From</option>
                                                                    {foreach item=station from=$stations key=code}
                                                                        <option value="{$code}">{$station}</option>
                                                                    {/foreach}    
                                                                </select>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="fl col-tb-4" style="padding-right:13px;padding-top: 5px;">
                                                        <a href="javascript:;" onclick='interchangeStationsHome()' title="swift stations"><i class="fa fa-exchange fa-lg"></i></a>
                                                    </div>            

                                                    <div class="col-sm-4 col-tb-4 p_l_n">
                                                        <div class="form-group col-sm-12">
                                                            <div class="input-group col-md-12">
                                                                <select class="form-control to" id="to-station">
                                                                    <option value="">Select Destination</option>
                                                                </select>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-2 col-tb-4 p_l_n">
                                                        <div class="form-group ">
                                                            <label class="sr-only" for="sdate-search">Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" class="form-control sdate" id="sdate-search" readonly="true" placeholder="Date">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-1 col-tb-4 p_l_n">
                                                        <button type="button" class="btn btn-success btn-search" id="quick-search">Search</button>  &nbsp
                                                    </div>
                                                </form>
                                                <div class="clear_fix_both"></div> <br>
                                            </div>
                                        </div>

                                    </div>
                                    <br>  
                                    
                                    {if $action_rights['findEditTickets']==1}
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="heading_b"><i class="fa fa-search"></i> Quick Find</div>

                                                <form class="form-inline" role="form">
                                                    <div class="col-sm-8">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-search"></i></span>
                                                                <input type="text" class="form-control sdate" id="quick-find-term" placeholder="PNR / Mobile / Email">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-3">
                                                        <button type="button" class="btn btn-success" onclick="initQuickFind();">Find</button>  &nbsp;
                                                    </div>
                                                </form>
                                                <div class="clear_fix_both"></div> <br>
                                            </div>
                                        </div>
                                    </div>                                    
                                    <br>
                                    {/if}
                                    
                                    <div class="row hide">
                                        <div class="col-md-12"> 
                                            <div class="panel panel-default">                                        
                                                <div class="heading_b"><i class="fa fa-link"></i> Quick Links</div>
                                                <div class="panel-body panel_body_a">
                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    {if $action_rights['SCH-EDIT']==1 && 
                                        $action_rights['USR-FILTER-TRANS']==1 &&
                                        $action_rights['UBR-USER-FILTER']==1 &&
                                        $action_rights['SCH-VIEW-TRIPS']==1}
                                       
                                    <div class="row ">
                                        <div class="col-md-12">                                                    
                                            <div class="panel panel-default"> 
                                                <div class="heading_b">
                                                    <div class="pull-right f12" style="padding-top: 4px;">&nbsp;&nbsp;{$smarty.now|date_format:$ns_date_format}</div>
                                                    
                                                    <div class="pull-right">
                                                        <div class="btn-group btn-group-toggle btn-group-xs" id="snapopt" data-toggle="buttons">
                                                            <label class="btn" title="Graph View">
                                                              <input type="radio" name="snapoptions" id="option1" value="pie"> <i class="fa fa-bar-chart"></i>
                                                            </label>
                                                            <label class="btn" title="Table View">
                                                              <input type="radio" name="snapoptions" id="option2" value="tbl"> <i class="fa fa-list-ul"></i>
                                                            </label>                                                           
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="pull-left"><i class="glyphicon glyphicon-stats"></i> Occupancy & Sales Summary <span class="f12" id="summary_at"></span></div>
                                                    <div class="">&nbsp;</div>
                                                </div>
                                                    <div id="occupancy_pane" style="padding-left: 10px; padding-right: 10px;" class="hide">
                                                    <div class="row live-cells">
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell">
                                                            <div class="text-center count" id="trip_count">0</div>
                                                            <div class="text-center labeltxt">Trips</div>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell">
                                                            <div class="text-center count" id="seats_count">0</div>
                                                            <div class="text-center labeltxt">Total Seats</div>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell">
                                                            <div class="text-center count" id="booked_count">0</div>
                                                            <div class="text-center labeltxt">Booked</div>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell">
                                                            <div class="text-center count" id="pbooked_count">0</div>
                                                            <div class="text-center labeltxt">Phone Book</div>
                                                        </div>                                                            
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell">
                                                            <div class="text-center count" id="vacant_count">0</div>
                                                            <div class="text-center labeltxt">Vacant</div>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2 cell">
                                                            <div class="text-center count" style="padding-left: 15px;" >
                                                                <div id="occu_count" style="height:60px;width:60px;"></div>
                                                            </div>
                                                            <!--<div class="text-center labeltxt">Occupancy</div>-->
                                                        </div>
                                                    </div>
                                                </div>
                                                <br>
                                                <div id="summary_pie" style="height: 360px;" class="hide"></div>
                                                <div id="summary_table" style="min-height: 360px;" class="hide"></div>
                                            </div>
                                        </div>
                                    </div>
                                    {else}
                                                                        
                                    {if $action_rights['VOC-AUTO-GENET']==1}                                    
                                    <div class="row">
                                        <div class="col-md-12"> 
                                            <div class="panel panel-default">                                                
                                                <div class="heading_b"><i class="fa fa-money"></i> Payment Due</div>
                                                <div class="panel-body panel_body_a" id="payment-vouchers"></div>
                                            </div>
                                        </div>                                      
                                    </div>
                                    <br>
                                    {/if}                                   
                                    
                                    <div class="row ">
                                        <div class="col-md-12">                                                    
                                            <div class="panel panel-default">                                                
                                                <div class="heading_b"><i class="fa fa-envelope-o"></i> Notifications</div>
                                                <div id="notify"></div>                                                
                                            </div>                                                
                                        </div>
                                    </div>
                                    
                                    <br>
                                    <div class="row">
                                        <div class="col-md-12"> 
                                            <div class="panel panel-default">                                                
                                                <div class="heading_b"><i class="fa fa-money"></i> Recent Bookings</div>
                                                <div class="panel-body panel_body_a" id="recent-bookings"></div>
                                            </div>
                                        </div>                                      
                                    </div> 
                                     
                                    {/if}    
                                </div>
                            </div>
                        </div><!--content end-->
                    </div>
                </div>
            </div>

        </div>
        <div style="height:0px;" class="clear_fix_both"></div>
    </div>
</div>
                                
<script type="text/template" id="tmpl_sshottable">
    <table class="table table-hover" style="width:90%;" align="center">
        <thead>
        <tr class="">
            <th class="bold text-left" >Group</th>
            <th class="bold text-right" >Seats</th>
            <th class="bold text-right" >Ratio</th>
            <th class="bold text-right" >Gross Revenue</th>            
        </tr>
        </thead>
        <tbody id="sstblbody">
        </tbody>
    </table>
    <div class="row">
        <div class="col-md-offset-1">
        <div class="note text-muted">* Gross revenue amount inclusive of commission, discount & GST.</div>
        </div>
    </div>
    
</script>
<script type="text/template" id="tmpl_sshotrow">    
    <tr>
        <td class="text-left grpname"></td>
        <td class="text-right seats"></td>        
        <td class="text-right ratio"></td>
        <td class="text-right confrev"></td>
    </tr>        
</script>
                                    
                                
<script>
    var routes1 = {$routes|json_encode};
    function init_dashboard() {
        //today_sales_summary();
        //cumulativeLine();
        //init_date_range();
        //init_charts();
    }
</script>
 