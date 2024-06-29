<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 12:40:29
  from 'E:\xampp\htdocs\cargo\application\views\site\admin\allstations.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bece5eeed74_90142795',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'accbd858f18a2cf3c37c95d9d32df0c16d4535d3' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\admin\\allstations.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bece5eeed74_90142795 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Stations Master</h3> 
    <span class="align-right"><?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SM-ADD'] > 0) {?><a href="javascript:;" class="btn btn-success  btn-sm" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['SM-ADD'] != 2) {?>onclick="editStation();"<?php }?>>Add New Station</a><?php }?></span></div>
<div id="main_wrapper">

    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contenta" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">

                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">

                                <div class="panel-body">
                                    <form class="form-inline" role="form">

                                        <div class="form-group">                                
                                            <div class="input-group" id="state-list">
                                                <select class="form-control" id="sel_state_id" >
                                                    <option value="">Select a State</option>   
                                                </select>
                                            </div>
                                        </div>

                                        <button type="button" class="btn btn-success" onclick="buildStationsList()">Get Stations</button> 

                                    </form> 
                                    <br />
                                    <div class="warning-text" id="search-status"></div>
                                    <div id="state-dialog" style="display: none">
                                        <div class="col-md-6">
                                            <form class="form-horizontal" action="#">
                                                <div class="form-group">
                                                    <label class="addedit_state_id">State</label>
                                                    <div class="" id="addedit-state-list">
                                                        <select class="form-control" id="addedit_state_id" >
                                                            <option value="">Select a State</option>   
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="txt_st_name">Name</label>
                                                    <div class="">
                                                        <input type="text" id="txt_st_name" class="form-control" placeholder="Station Name">
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="addedit_api_flag">API</label>
                                                    <div class="">
                                                        <select class="form-control" id="addedit_api_flag" >
                                                            <option value="1">Enable</option> 
                                                            <option value="0">Disable</option> 
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="addedit_lat">Latitude</label>
                                                    <div>
                                                        <input type="number" placeholder="Latitude" id="addedit_lat" name="Latitude"  class="form-control rs_no">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="addedit_lng">Longitude</label>
                                                    <div>
                                                        <input type="number" placeholder="Longitude" id="addedit_lng" name="Longitude"  class="form-control rs_no">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="addedit_rad">Radius</label>
                                                    <div class="input-group">
                                                        <input  placeholder="Radius" id="addedit_rad" name="Radius"  class="form-control rs_no">
                                                        <span class="input-group-addon">Km</span>
                                                    </div>
                                                </div>
                                                <br/>

                                                <input type="hidden" id="sel_st_status" name="sel_st_status" value="1" />

                                                <input type="hidden" id="hid_st_code" />
                                                <div class="align-center alert pull-left hgt-50" id="stm-form-action-state"></div>
                                                <div class="clear_fix_both"></div>
                                                
                                                <div class="align-right pull-right" id="form-buttons">
                                                    <button type="button" id="btn-save" class="btn btn-success" onclick="saveStation()">Update</button>
                                                    <button type="button" class="btn btn-default" onclick="cancelAddEditForm()">Cancel</button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="col-md-6">
                                            <div id="map_canvas" style="width: 95%;"></div>
                                        </div>
                                    </div>
                                    <div id="result-panel" class="hide">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="action-status"></div>
                                                <div id="address-book">

                                                </div>
                                            </div>
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
<?php echo '<script'; ?>
>
    function sm_loadstates() {
        _getAllStates('state-list', 'dropdown', 'sel_state_id', '', '');
        _getAllStates('addedit-state-list', 'dropdown', 'addedit_state_id', '', '');
    }
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
>
if (typeof google === 'object' && typeof google.maps === 'object') {
        initOrganizationMap();
    } else {
        jQuery.getScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initOrganizationMap');
    }

    function initOrganizationMap() {
        var location = new google.maps.LatLng(13.0827, 80.2707);

        var map = new google.maps.Map(document.getElementById('map_canvas'), {
            zoom: 12,
            center: location,
            streetViewControl: false,
            gestureHandling: 'greedy',
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        var marker = new google.maps.Marker({
            position: location,
            map: map,
            draggable: true
        });

        var getLatLng = function (e) {
            if ($('#addedit_lat').val().trim() && $('#addedit_lng').val().trim()) {
                location = new google.maps.LatLng($('#addedit_lat').val(), $('#addedit_lng').val());
                map.setZoom(12);
            } else {
                location = new google.maps.LatLng(13.0827, 80.2707);
                map.setZoom(12);
            }
            marker.setPosition(location);
            map.panTo(location);
        };

        var setLatLng = function (e) {
            $('#addedit_lat').val(e.latLng.lat());
            $('#addedit_lng').val(e.latLng.lng());
        };

        google.maps.event.addListener(marker, 'dragend', setLatLng);

        google.maps.event.addListener(map, 'click', function (e) {
            marker.setPosition(e.latLng);
            map.setZoom(18);
            map.panTo(e.latLng);
            setLatLng(e);
            getRadius();
        });
        
        var circle;      
        $('#addedit_rad').change(function() {
            var new_rad = Number($(this).val());
            var rad = new_rad * 1000;
            if (!circle || !circle.setRadius) {
              circle = new google.maps.Circle({
                map: map,
                radius: rad,
                fillColor: '#555',
                strokeColor: '#ffffff',
                strokeOpacity: 0.1,
                strokeWeight: 3
              });
              circle.bindTo('center', marker, 'position');
            } else circle.setRadius(rad);
        });

        $('#addedit_lat, #addedit_lng').on('change', getLatLng);
    }

    $('#addedit-state-list').on('change', function(){
        getLatLangStation();
    });
    
    function getLatLangStation(){
        var address = "";        
        var station = $('#txt_st_name').val();
        var state = $('#addedit_state_id option:selected').text();
        
        if(state != ''){
            address = state;
        }
            
        if(station != ''){
            address = station;
        }
        
        if(station != '' && state != ''){
            address = station + ',' +state;
        }
        
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {

        if (status == google.maps.GeocoderStatus.OK) {
            var latitude = results[0].geometry.location.lat();
            var longitude = results[0].geometry.location.lng();
            $('#addedit_lat').val(latitude).trigger('change');
            $('#addedit_lng').val(longitude).trigger('change');
        }});    
    }
<?php echo '</script'; ?>
><?php }
}
