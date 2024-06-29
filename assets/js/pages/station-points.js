var map;
var marker;
var geocoder = null;
var markersArray = [];
var map_js_loaded = false;
function getStationsDropdownByState() {
    var data = {};
    data.state_code = $('#sel_state_id').val();
    _getStations('station-list', 'dropdown', 'sel_station_id', '', '', data);
}

function toggleDirections() {
    $('#sec-directions').slideToggle('slow');
}

function getStationPointsList(id, tit, shortcode) {
    $('.li_bk').removeClass('li_bk');
    var data = {};
    data.station_code = id;
    data.shortCode = shortcode;
    $('#station-point-result').html('<div align="center">' + loading_big + '</div>');
    $('#station-point-result').show();
    $.ajax({
        type: "POST",
        url: base_url + "config/get-stationpoint-by-station",
        data: data,
        success: function(response) {
            $('#ns-' + data.station_code).addClass('li_bk');
            $('#station-point-result').removeClass('hide')
            $('#station-point-result').html(response).show();
            $('#stat_title').html(tit);
            $('#newStation').val(tit);
            $('#addedit_sel_station_id').val(id);
        }
    })
}

function clearSPsearch() {
    $('#result-panel').empty();
    $('.getStatesStationPoint').val('');
    $('#stations').val('');
}
function loadGoogleScript(url, callback)
{
    if (!map_js_loaded) {
        jQuery.getScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initializeMap')
                .done(function() {
                    //initializeMap();
                });
        map_js_loaded = true;
    }

}

function editStationPoint(option) {
    $('#station-point-dialog').show();
    $('#station-point-dialog').css('background', '#FFFFFF');
    $('#station-point-dialog').dialog({
        autoOpen: true,
        height: 650,
        width: 970,
        modal: true,
        resizable: false,
    });

    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#st-form-action-state').html('');
    $('#st-form-action-state').hide();
    $('#txt_sp_name, #txt_sp_latitude, #txt_sp_longitude,  #hid_sp_code,#txt_sp_address,#txt_sp_landmark,#txt_sp_phone').val('');
    $('#lag_id,#lat_id').html('');
    $('#share_to_cust').prop('checked', false);
    $('#sec-directions').hide();
    //   google.maps.event.trigger(map, 'resize'); 
    //google.maps.event.addDomListener('load', initializeMap);
    manually_reset = false;
    if (_isdefined(option)) {
        $('#txt_sp_name').val(option.name);
        $('#txt_sp_latitude').val(option.latitude);
        $('#txt_sp_longitude').val(option.longitude);
        $('#txt_sp_address').val(option.address);
        $('#hid_sp_code').val(option.code);
        $('#txt_sp_landmark').val(option.landmark);
        $('#addedit_sel_station_id').val(option.station.code);
        $('#sel_sp_status').val(option.activeFlag);
        $('#hid_sp_code').val(option.code);
        $('#txt_sp_phone').val(option.number)
        $('#lag_id').html(option.latitude);
        $('#lat_id').html(option.longitude);
        $('#station_name').val(option.station.name);
        
        if($.trim(option.mapUrl) != '') {            
            $('#share_to_cust').prop('checked', true);
            toggleDirections();
        }        
        setDirLink();
    }
    if (!map_js_loaded) {
        loadGoogleScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initializeMap');
    } else {
        initializeMap();
    }
    dilg.push("#station-point-dialog");

    return false;
}
function saveStationPoint() {
    var data = {};
    data.name = $('#txt_sp_name').val().trim();
    data.latitude = $('#txt_sp_latitude').val();
    data.longitude = $('#txt_sp_longitude').val();

    data.address = $('#txt_sp_address').val();
    data.phone = $('#txt_sp_phone').val();
    data.landmark = $('#txt_sp_landmark').val();

    data.activeFlag = $('#sel_sp_status').val();
    data.code = $('#hid_sp_code').val();
    data.stationCode = $('#addedit_sel_station_id').val();
    
    data.share_dir = $('#share_to_cust').is(':checked') ? 1 : 0;
    
    $('.err_bor').removeClass('err_bor');
    $('#form-bttons').hide();
    $('#st-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#st-form-action-state').html(loading_popup);
    $('#st-form-action-state').show();
    var err = 0;
    if ($('#txt_sp_name').val() == '') {
        $('#txt_sp_name').addClass('err_bor');
        err++;
    }
    if ($('#txt_sp_address').val() == '') {
        $('#txt_sp_address').addClass('err_bor');
        err++;
    }
    if ($('#txt_sp_landmark').val() == '') {
        $('#txt_sp_landmark').addClass('err_bor');
        err++;
    }
    if ($('#txt_sp_phone').val() == '') {
        $('#txt_sp_phone').addClass('err_bor');
        err++;
    }
    if (err > 0) {
        $('#st-form-action-state').removeClass('alert-success');
        $('#st-form-action-state').addClass('alert-error alert-danger');
        $('#st-form-action-state').html('Please enter the values in the field that are marked in red.');
        $('#form-bttons').show();
        return false;
    }
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-station-point",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('.er_msg').remove();
                $('#st-form-action-state').removeClass('alert-danger');
                $('#st-form-action-state').addClass('alert-success');
                $('#st-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    if ($('#sp-' + response.data.code).html() == undefined) {
                        getStationPointsList(data.stationCode, $('#stat_title').html());
                    } else {
                        var tr = $('#sp-' + response.data.code);
                        tr.find('.sp_name').html(data.name);
                        tr.find('.sp_lat').html(data.address);
                        tr.find('.sp_lad').html(data.landmark);
                        tr.find('.sp_mno').html(data.phone);
                        tr.find('.ed-bt').attr('onclick', 'editStationPoint({"code":"' + response.data.code + '","name":"' + data.name + '","activeFlag":1,"latitude":"' + data.latitude + '","longitude":"' + data.longitude + '","address":"' + data.address + '","landmark":"' + data.landmark + '","number":"' + data.phone + '","mapUrl":"' + response.data.mapUrl + '","station":{"code":"' + data.stationCode + '","activeFlag":0}})');
                        tr.find('.del-bt').attr('onclick', 'deleteStationPoint("' + response.data.code + '", "' + data.name + '")');
                        tr.find('.act').attr('onclick', 'editStatusStationPoint("' + response.data.code + '", "' + data.name + '")');

                    }
                    cancelSPAddEdit();
                }, 3000);
            } else {
                $('#st-form-action-state').addClass('alert-error');
                $('#st-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}
function cancelSPAddEdit() {
    $('#station-point-dialog').dialog('close');
    removeArray("#station-point-dialog");
}
function getAddEditStationsDropdownByState() {
    var data = {};
    data.state_code = $('#addedit_sel_state_id').val();
    _getStations('addedit-station-list', 'dropdown', 'addedit_sel_station_id', '', '', data);
}

function deleteStationPoint(sp_code, sp_name) {
    if (confirm('Do you want to delete this station point?')) {
        var data = {};
        data.sp_code = sp_code;
        data.sp_name = sp_name

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-stationpoint",
            data: data,
            success: function(response) {
                if (response.status == 1) {

                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#sp-' + sp_code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
                    });
                } else {

                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}
function editStatusStationPoint(sp_code, sp_name, sp_longitude, sp_latitude, sp_point) {
    var data = {};
    data.sp_code = sp_code;
    data.activeFlag = $('#st_sts-' + sp_code).attr('data-status') == 1 ? 0 : 9;
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-status-stationpoint",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                if (data.activeFlag == 0) {
                    $('#edt_points_' + sp_code).hide();
                    $('#st_sts-' + sp_code).attr('data-status', 0);
                    $('#sta-' + sp_code).removeClass('fa-times').addClass('fa-check').attr('title', 'Click to disable');
                } else {
                    $('#edt_points_' + sp_code).show();
                    $('#st_sts-' + sp_code).attr('data-status', 1);
                    $('#sta-' + sp_code).removeClass('fa-check').addClass('fa-times').attr('title', 'Click to enable');
                }
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
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);

        }
    })

}
function initializeMap() {
    var pos = '';
    if ($('#txt_sp_latitude').val() != '' && $('#txt_sp_longitude').val() != '') {
        pos = new google.maps.LatLng($('#txt_sp_latitude').val(), $('#txt_sp_longitude').val())
        addMarker(pos);
    } else {
        pos = new google.maps.LatLng('','')
    }
    var myOptions = {
        zoom: 18,
        center: pos,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('map_canvas'), myOptions);
    geocoder = new google.maps.Geocoder();
    google.maps.event.addListener(map, 'click', function(e) {
        if (marker) {
            marker.setPosition(e.latLng);
            map.panTo(marker.getPosition());
        } else {
            //addMarker(e.latLng);
        }

        
    });

    if ($('#txt_sp_latitude').val() != '' && $('#txt_sp_longitude').val() != '') {
        addMarker(pos);
    }
    if ($('#txt_sp_latitude').val() == '' && $('#txt_sp_longitude').val() == '' && $('#newStation').val() != '') {

        var stationPoint = $('#newStation').val();
        geocoder.geocode({'address': stationPoint}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                clearOverlays();
                addMarker(results[0].geometry.location);
                $('#txt_sp_latitude').val(results[0].geometry.location.lat());
                $('#txt_sp_longitude').val(results[0].geometry.location.lng());
                $('#lag_id').html(results[0].geometry.location.lat());
                $('#lat_id').html(results[0].geometry.location.lng());
                setDirLink();
            } else {
                //alert("Geocode was not successful for the following reason: " + status);
            }
            
        });
    }
}

function setDirLink() {    
    var lat = $('#txt_sp_latitude').val();
    var lang = $('#txt_sp_longitude').val();
    
    var link = 'http://www.google.com/maps/place/'+lat+','+lang;    
    $('#a_directions').attr('href', link);
    
    $('#a_directions').show();
    if(lat == "" || lang == "") {
        $('#a_directions').hide();
    }
}

var manually_reset = false;
function addMarker(location) {
    var marker = new google.maps.Marker({
        position: location,
        map: map,
        draggable: true
    });
    google.maps.event.addListener(marker, 'dragend', function(evt) {
        $("#txt_sp_latitude").val(evt.latLng.lat());
        $("#txt_sp_longitude").val(evt.latLng.lng());
        $('#lag_id').html(evt.latLng.lat());
        $('#lat_id').html(evt.latLng.lng());
        setDirLink();
        manually_reset = true;
    });
    markersArray.push(marker);
}
function clearOverlays() {
    /*if (markersArray) {
        for (i in markersArray) {
            markersArray[i].setMap(null);
        }
    }*/
    for (var i = 0; i < markersArray.length; i++) {
        markersArray[i].setMap(null);
    }
}
$(document).ready(function() {
    $("#txt_sp_name").blur(function(e) { // bind click event to link
        var t_sp = $('#hid_sp_code').val();
        if(manually_reset == true || t_sp != "") {
            return;
        }
        
        e.preventDefault();
        var new_station = $('#newStation').val();

        if (new_station != '') {
            var name = $('#txt_sp_name').val();
            var stationPoint = new_station + ',' + name;
        } else {
            var main_station = $('#station_name').val();
            var name = $('#txt_sp_name').val();
            stationPoint = main_station + ',' + name;

        }
        geocoder.geocode({'address': stationPoint}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                clearOverlays();
                addMarker(results[0].geometry.location);
                $('#txt_sp_latitude').val(results[0].geometry.location.lat());
                $('#txt_sp_longitude').val(results[0].geometry.location.lng());
                $('#lag_id').html(results[0].geometry.location.lat());
                $('#lat_id').html(results[0].geometry.location.lng());
                setDirLink();
            } else {
                //alert("Geocode was not successful for the following reason: " + status);
            }
        });
    });

    $("#txt_sp_address").blur(function(e) {

//        if ($("#txt_sp_address").val() == '') {
//            alert('Please enter city/address');
//            return false;
//        }
//        var val = $("#txt_sp_address").val();
//        var new_station = $('#newStation').val();
//        var name = $('#txt_sp_name').val();
//        var main_station = $('#station_name').val();
//        if (val != '') {
//            if (new_station != '') {
//                var stationPoint = new_station + ',' + name + ',' + val;
//
//            } else {
//                stationPoint = main_station + ',' + name + ',' + val;
//            }
//        }
//        geocoder.geocode({'address': stationPoint}, function(results, status) {
//            if (status == google.maps.GeocoderStatus.OK) {
//                map.setCenter(results[0].geometry.location);
//                clearOverlays();
//                addMarker(results[0].geometry.location);
//                $('#txt_sp_latitude').val(results[0].geometry.location.lat());
//                $('#txt_sp_longitude').val(results[0].geometry.location.lng());
//                $('#lag_id').html(results[0].geometry.location.lat());
//                $('#lat_id').html(results[0].geometry.location.lng());
//            } else {
//                alert("Geocode was not successful for the following reason: " + status);
//            }
//        });
    });



});