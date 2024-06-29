
<div class="brand_top">
    <h3>Analytics</h3>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-md-8">
                            
                            <div class="panel panel-default">
                                
                                <div class="heading_b">Today Occupancy </div>
                                <div class="row occupancy-cells">
                                    <div class="col-md-2">
                                        <div class="text-center count" id="trips_count" data-percent="100"><span>{$today_occupancy['t_trips']}</span></div>
                                        <div class="text-center labeltxt">Trips</div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="text-center count" id="seats_count" data-percent="100"><span>{$today_occupancy['t_seats']}</span></div>
                                        <div class="text-center labeltxt">Seats</div>
                                    </div>
                                    <div class="col-md-2">
                                        {assign var=tb value=$today_occupancy['t_booked_seats'] / $today_occupancy['t_seats']}
                                        {assign var=tb value=$tb*100}                                        
                                        <div class="text-center count" id="bo_count" data-percent="{$tb}" ><span>{$today_occupancy['t_booked_seats']}</span></div>
                                        <div class="text-center labeltxt">Booked</div>
                                    </div>
                                    <div class="col-md-2">
                                        {assign var=tp value=$today_occupancy['t_pbooked_seats'] / $today_occupancy['t_seats']}
                                        {assign var=tp value=$tp*100}
                                        <div class="text-center count" id="pbl_count" data-percent="{$tp}"><span>{$today_occupancy['t_pbooked_seats']}</span></div>
                                        <div class="text-center labeltxt">Phone Book</div>
                                    </div>
                                    <div class="col-md-2">
                                        {assign var=tv value=$today_occupancy['t_vacant_seats'] / $today_occupancy['t_seats']}
                                        {assign var=tv value=$tv*100}
                                        <div class="text-center count" id="vac_count" data-percent="{$tv}"><span>{$today_occupancy['t_vacant_seats']}</span></div>
                                        <div class="text-center labeltxt">Vacant</div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="trip-pie" id="trip-pie" data-booked="{$tb+$tp}" data-vacant="{$tv}" style="height:70px;width:70px" ></div>
                                    </div>
                                </div>
                                        
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="panel panel-default">
                                
                                <div class="heading_b">Today Sales</div>
                                <div class="row today-sales">
                                    <div class="col-md-7">
                                        <table cellpadding='5' width='100%'>
                                            <tr>
                                                <td>Booking</td>
                                                <td><i class="fa fa-rupee"></i> {$today_occupancy['t_booked_amount']|number_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Cancellation Revenue</td>
                                                <td><i class="fa fa-rupee"></i> {$today_occupancy['t_cancel_revnue']|number_format}</td>
                                            </tr>
                                            <tr>
                                                <td>Commission</td>  
                                                <td><i class="fa fa-rupee"></i> {$today_occupancy['t_commission']|number_format}</td>
                                            </tr>
                                        </table>                                       
                                    </div>
                                    
                                    <div class="col-md-5 net">
                                        <div class="text-center labeltxt">Net Sales</div>
                                        <div class="text-center amount"><i class="fa fa-rupee"></i> 
                                            {($today_occupancy['t_booked_amount']+$today_occupancy['t_cancel_revnue']-$today_occupancy['t_commission'])|number_format}
                                        </div>
                                    </div>    
                                    
                                </div>
                                        
                            </div>
                        </div>
                        
                    </div>
                    
                    <br>
                    
                    <div class="row">      
                        <div class="col-md-12">
                            <div class="panel panel-default">
                            
                                <div class="heading_b">Trip Occupancy</div>
                                
                                <div class="row">                                    
                                    <div class="col-md-10 chart-options">
                                        <ul class="pull-right">
                                            <li class="" data-type="L3M">LAST 3 MONTHS</li>
                                            <li class="" data-type="L1M">LAST MONTH</li>
                                            <li class="" data-type="L30D">LAST 30 DAYS</li>
                                            <li class="" data-type="TODAY">TODAY</li>
                                            <li class="" data-type="N30D">NEXT 30 DAYS</li>
                                        </ul>                                        
                                    </div>                                    
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-12" id="trip-chart" style="min-width: 300px; height: 400px; margin: 0 auto"></div>
                                </div>
                                
                            </div>
                        </div>
                    </div>    
                </div>                   
            </div>                    
        </div>                
    </div>
</div>       

<script>
var trip_info = '';
function _init_analytics() {
    init_analytics_page();
}
</script>