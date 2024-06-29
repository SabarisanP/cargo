<div class="brand_top">
    <h3>Add / Edit Travel Stops</h3> 
    <span class="align-right">        
        <a href="#config/travel-stops" class="btn btn-success" > <i class="fa fa-arrow-left"></i> Back</a>
    </span>
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
                                    <div class="row">
                                        <div class="col-md-6">
                                            <form role="form" class="form-horizontal" data-parsley-validate>
                                            <div class=" col-md-offset-2 col-md-8">

                                                <div class="form-group">
                                                    <label class="req" for="txt_sp_name">Name</label>                                                    
                                                    <div class="">
                                                        <input type="text" placeholder="Name" value="{$stop->name}" id="txt_sp_name" class="form-control">
                                                        <span class="help-block">Ex : A2B Restaurant, Shri Balaajee Bhavan</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="req" for="txt_sp_landmark">Land Mark</label>
                                                    <div class="">
                                                        <input type="text" placeholder="Land Mark" value="{$stop->landmark}" id="txt_sp_landmark" class="form-control">
                                                    </div>
                                                </div> 
                                                <div class="form-group">
                                                    <label for="txt_sp_phone">Stop Duration</label>
                                                    <div class="">
                                                        <select class="form-control" id="wait_duration" name="wait_duration">
                                                            <option value="10" {if $stop->minutes==10} selected="selected" {/if} >10 Minutes</option>
                                                            <option value="15" {if $stop->minutes==15} selected="selected" {/if}>15 Minutes</option>
                                                            <option value="20" {if $stop->minutes==20} selected="selected" {/if}>20 Minutes</option>
                                                            <option value="25" {if $stop->minutes==25} selected="selected" {/if}>25 Minutes</option>
                                                            <option value="30" {if $stop->minutes==30} selected="selected" {/if}>30 Minutes</option>
                                                            <option value="35" {if $stop->minutes==35} selected="selected" {/if}>35 Minutes</option>
                                                            <option value="40" {if $stop->minutes==40} selected="selected" {/if}>40 Minutes</option>
                                                            <option value="45" {if $stop->minutes==45} selected="selected" {/if}>45 Minutes</option>
                                                            <option value="50" {if $stop->minutes==50} selected="selected" {/if}>50 Minutes</option>
                                                            <option value="55" {if $stop->minutes==55} selected="selected" {/if}>55 Minutes</option>
                                                            <option value="60" {if $stop->minutes==60} selected="selected" {/if}>1 Hour</option>
                                                        </select>
                                                    </div>
                                                </div> 
                                                
                                                <div class="form-group">
                                                    <label for="food_type">Amenities</label>
                                                    <div class="">
                                                        <select class="form-control" id="amenities" name="amenities" multiple>
                                                            <option value=""></option>
                                                            {foreach name=o item=row key=value from=$stop_amenities}
                                                                <option {if count($stop->amenities) > 0 }{if  in_array($value, $stop->amenities)}selected="selected"{/if}{/if} value="{$value}"> {$row} </option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                        
                                                <div class="form-group">
                                                    <label for="food_type">Food Type</label>
                                                    <div class="">
                                                        <select class="form-control" id="food_type" name="fod_type">
                                                            <option value="ALL" {if $stop->itemType=='ALL'} selected="selected" {/if}>All</option>
                                                            <option value="VEG" {if $stop->itemType=='VEG'} selected="selected" {/if}>Veg</option>
                                                            <option value="NONVEG" {if $stop->itemType=='NONVEG'} selected="selected" {/if}>Non Veg</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="rest-room" class="req">Rest Room</label>
                                                    <div class="">
                                                        <select class="form-control" id="rest-room">
                                                            <option value="">Select</option>
                                                            {foreach item=value from=$travel_stop_restroom}
                                                                <option value="{$value}" {if $stop->restRoom == $value} selected="selected" {/if}>{$value}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                        
                                                <div class="align-right col-md-7 hide">Latitude: &nbsp;<span id="lag_id"></span>&nbsp; Longitude: &nbsp;<span id="lat_id"></span></div>
                                                    
                                                <div class="form-group">
                                                    <div id="st-form-action-state" class="align-center alert"></div>
                                                    <div class="align-right" id="form-bttons">
                                                        <button class="btn btn-success" type="button" onclick="saveStops();">Save</button>
                                                    </div>
                                                </div>
                                            </div>
                                                
                                            <input type="hidden" id="txt_sp_latitude" value="{$stop->latitude}">
                                            <input type="hidden" id="txt_sp_longitude" value="{$stop->longitude}">                                            
                                            <input type="hidden" id="hid_stop_code" value="{$stop->code}">
                                            
                                                           
                                        </form>
                                        </div>
                                        <div class="col-md-6">
                                            <div id="stops_map_canvas"></div>
                                        </div>
                                    </div>
                                </div><!--panel Body end-->
                            </div><!--panel end-->

                        </div>

                    </div><!--row end-->
                </div><!--content end-->
            </div>
        </div>
    </div>

</div>

<script>
    $(function() {
        $('#amenities').select2({
            placeholder: "Select Amenities"
        });
        
        if (typeof google === 'object' && typeof google.maps === 'object') {
            initializeStopsMap();
        } else {
            var map_js_loaded = false;
            jQuery.getScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initializeStopsMap')
            .done(function() {
                map_js_loaded = true;
            });
        }
        
    });    
</script>