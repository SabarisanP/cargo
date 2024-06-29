var markersArray = [];
var map = '';
var marker = '';
function initializeStopsMap() {
    var pos = new google.maps.LatLng('11.127123','78.656891');
    marker = '';
    
    var myOptions = {
        zoom: 6,
        center: pos,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('stops_map_canvas'), myOptions);
    
    if ($('#txt_sp_latitude').val() != '' && $('#txt_sp_longitude').val() != '') {
        pos = new google.maps.LatLng($('#txt_sp_latitude').val(), $('#txt_sp_longitude').val())
        addStopsMarker(pos);
    } 
    
    geocoder = new google.maps.Geocoder();
    google.maps.event.addListener(map, 'click', function(e) {
        if (marker) {
            marker.setPosition(e.latLng);            
            map.panTo(marker.getPosition());
            setLatLang(e.latLng);
        } else {
            pos = new google.maps.LatLng(e.latLng.lat(), e.latLng.lng());
            addStopsMarker(e.latLng);
        }
    });
}

function addStopsMarker(location) {
    marker = new google.maps.Marker({
        position: location,
        map: map,
        draggable: true
    });
    map.panTo(marker.getPosition());
    setLatLang(location);
    
    google.maps.event.addListener(marker, 'dragend', function(evt) {
        setLatLang(evt.latLng);
    });   
}

function setLatLang(evt) {    
    $("#txt_sp_latitude").val(evt.lat());
    $("#txt_sp_longitude").val(evt.lng());
    $('#lag_id').html(evt.lat());
    $('#lat_id').html(evt.lng());
}

function saveStops() {
    var data = {};
     
    data.name = $.trim( $('#txt_sp_name').val() );
    data.latitude = $.trim($('#txt_sp_latitude').val());
    data.longitude = $.trim($('#txt_sp_longitude').val());    
    data.landmark = $.trim($('#txt_sp_landmark').val());
       
    data.waitingtime = $.trim($('#wait_duration').val());
    data.amenities = $('#amenities').val() || [''];
    data.food_type = $.trim($('#food_type').val());
    data.restRoom = $('#rest-room').val();
    
    data.code = $('#hid_stop_code').val();    
    
    $('.err_bor').removeClass('err_bor');
    
    if(data.latitude=="" || data.longitude=="") {
        $('#st-form-action-state').addClass('alert-danger');
        $('#st-form-action-state').html('Please select a place in map.');
        return;
    }    
    
    $('#form-bttons').hide();
    $('#st-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#st-form-action-state').html(loading_popup);
    $('#st-form-action-state').show();
    var err = 0;
    
    
    if (data.name == '') {
        $('#txt_sp_name').addClass('err_bor');
        err++;
    }
    
    if (data.landmark == '') {
        $('#txt_sp_landmark').addClass('err_bor');
        err++;
    }
        
    if (data.restRoom == '') {
        $('#rest-room').addClass('err_bor');
        err++;
    }
    
    if (err > 0) {
        $('#st-form-action-state').removeClass('alert-success');
        $('#st-form-action-state').addClass('alert-danger');
        $('#st-form-action-state').html('Please enter the values in the field that are marked in red.');
        $('#form-bttons').show();
        return false;
    }
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/save-travel-stops",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('.er_msg').remove();
                $('#st-form-action-state').removeClass('alert-danger');
                $('#st-form-action-state').addClass('alert-success');
                $('#st-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    window.location.href = '#config/travel-stops';
                }, 3000);
            } else {
                $('#st-form-action-state').addClass('alert-error');
                $('#st-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}

function editStatusStop(code, flag) {
    var msg = 'Do you want to disable this stop?';
    var flagchange = 0;
    if(flag==0) {
        msg = 'Do you want to activate this stop?';
        flagchange = 1;
    }
    
    if (confirm(msg)) {
        var data = {};        
        data.stop = _.find(mas_stops, function(o) { return o.code == code; });   
        data.stop.activeFlag = flagchange;
        
        var loading_overlay = iosOverlay({
            text: "Please wait...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-travel-stop",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#stop-'+code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove();
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                    checkURL();
                }, 2000);
            }
        })
    }
}

function deleteStop(code) {
    if (confirm('Do you want to delete this stop?')) {
        var data = {};        
        data.stop = _.find(mas_stops, function(o) { return o.code == code; });   
        data.stop.activeFlag = 2;
        
        var loading_overlay = iosOverlay({
            text: "Please wait...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-travel-stop",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#stop-'+code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove();
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}
