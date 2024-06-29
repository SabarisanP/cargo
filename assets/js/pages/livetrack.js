var map_js_loaded = false;
var map = '';
var infoWindow = '';
var g_tripcode = '';
var g_devicecode = '';
var tmm = '';
var runtracker = false;
var polyline = '';

function trackfleet(tripcode, devicecode) {  
    ga_track_event('Trip Info', 'GPS Tracking', 'Track Bus Location');
    g_tripcode = tripcode;
    g_devicecode = devicecode;
    
    $('#track_fleet_container #trip-setting-head').html('<div class="pt10">Live Tracking</div>').css('width','90%');
    $('#track_fleet_container').css('background', '#fff');
    $('#track_fleet_container').removeClass('hide');
    $('#track_fleet_container').show();
    $('#track_fleet_container').dialog({
        autoOpen: true,
        height: 650,
        width: $(window).width() * 0.8,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();    
    embeddGoogleMap();    
}

function closeLiveTrackPopup() {
    $('#track_fleet_container').dialog('destroy');
    $('#track_fleet_container').hide();
    $('#track_map_canvas').html('');
    runtracker = false;
}

function embeddGoogleMap(){
    if (!map_js_loaded) {
        jQuery.getScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initializeGMap')
            .done(function() {
                //initializeMap();
            });
        map_js_loaded = true;
    } else {
        initializeGMap();
    }
}

function initializeGMap() {
    var pos = '';
    tmm = '';
    pos = new google.maps.LatLng('13.0827','80.2707');

    var myOptions = {
        zoom: 16,
        center: pos,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        gestureHandling: 'greedy'
    };
    map = new google.maps.Map(document.getElementById('track_map_canvas'), myOptions);
    infoWindow = new google.maps.InfoWindow();    
    var trafficLayer = new google.maps.TrafficLayer().setMap(map);
    getTripStagesPoints();
    runtracker = true;
    liveTrackFleet();
}

function liveTrackFleet() {
    if(!runtracker) {
        return;
    }
    var data = {};
    data.deviceCode = g_devicecode;  
    data.tripCode = g_tripcode;  
    $.ajax({
        type: "post",
        dataType: 'json',
        url: base_url+"search/get-fleet-live-feed",
        data: data,
        success:function(response) {
            if(response.status==1) {
                var myLatlng = new google.maps.LatLng(response.latitude,response.longitude);
                if(tmm=="") {
                    tmm = new google.maps.Marker({
                        position: myLatlng,
                        map: map,
                        title: '',
                        icon : base_url+'assets/img/bus-marker.png'
                    });  
                } else {
                    if(!tmm.getPosition().equals(myLatlng)){
                        polyline = new google.maps.Polyline({
                            path: [tmm.getPosition(),myLatlng],
                            geodesic: true,
                            strokeColor: '#FF0000',
                            strokeOpacity: 1.0,
                            strokeWeight: 4
                        });                       
                        polyline.setMap(map);
                    }
                    tmm.setPosition( myLatlng );
                }
                var statebadge = '';
                if (parseInt(response.ignition) == 1 && parseInt(response.speed) > 0) {
                    statebadge = '<span class="badge badge-success">running</span>';
                }

                if (parseInt(response.ignition) == 0 || parseInt(response.speed) <= 0) {
                    statebadge = '<span class="badge badge-danger">stop</span>';
                }
                google.maps.event.addListener(tmm, 'mouseover', function() {  
                    var iwContent = '<div id="iw_container">' +
                        '<div class="iw_title"><i class="fa fa-bus "> </i>&nbsp; &nbsp;' + response.registationNumber +'</div>' +
                        '<div class="iw_content" style="max-width:250px">'+                            
                            '<table align="left" width="100%" cellpadding="8">'+
                            '<tr>'+
                                '<td width="7%" style="padding:2px;"><i class="fa fa-tachometer"> </i></td>'+
                                '<td style="padding:2px;">' + response.speed + ' Km/h&nbsp;' + statebadge +'</td>'+
                            '</tr>'+
                            '<tr>'+
                                '<td style="padding:2px;"><i class="fa fa-clock-o"> </i></td>'+
                                '<td style="padding:2px;">' + moment(response.updatedTime).format("h:mm:ss a")+' , '+moment(response.updatedTime).fromNow() + '</td>'+
                            '</tr>'+
                            '<tr>'+
                                '<td style="padding:2px;"><i class="fa fa-map-marker"> </i></td>'+
                                '<td style="padding:2px;">' + response.address.replaceAll(',',', ') +'</td>'+
                            '</tr>'+
                            '</table>'+
                        '</div>'+
                        '</div>';
                    infoWindow.setContent(iwContent);
                    infoWindow.open(map, tmm);
                });
                map.panTo(myLatlng); 
                
                var content =   '<div class="pt10"><div class="col-xs-4 p_l_n p_r_n">' +
                                    '<span class="col-xs-12 p_l_n p_r_n">Live Tracking</span>'+                        
                                    '<br/><span class="col-xs-12 p_l_n p_r_n"><i class="fa fa-bus "></i>&nbsp;' + response.registationNumber +
                                    '</span><br/><span class="col-xs-12 p_l_n p_r_n"><i class="fa fa-tachometer "> </i>&nbsp;' + response.speed + ' Km/h &nbsp; ' + statebadge +
                                '</div><div class="col-xs-8 p_l_n p_r_n">' +
                                '<span class="col-xs-6 p_l_n p_r_n">&nbsp;</span>'+   
                                    '</span><span class="col-xs-12 p_l_n p_r_n"><i class="fa fa-map-marker "> </i>&nbsp;' + '  ' + response.address.replaceAll(',',', ')+
                                    '</span><br/><span class="col-xs-12 p_l_n p_r_n"><i class="fa fa-clock-o "> </i>&nbsp;' + moment(response.updatedTime).format("h:mm:ss a")+' , '+moment(response.updatedTime).fromNow() +
                                '</span></div></div>';

                $('#track_fleet_container #trip-setting-head').html(content);
            }
            
            window.setTimeout( function() { 
                liveTrackFleet();
            }, 60000);
        }
    });
}

function getTripStagesPoints() {
    var data = {};
    data.tripCode = g_tripcode;   
    $.ajax({
        type: "post",
        dataType: 'json',
        url: base_url+"search/get-trip-stage-boardingpoints",
        data: data,
        success:function(response) {
            if(response.status==1) {
                var pos = 0;
                $(response.data).each(function(i, stage) {
                    $(stage.fromStation.stationPoint).each(function(p, point) {
                        pos++;
                        var myLatlng = new google.maps.LatLng(point.latitude,point.longitude);
                        var t= new google.maps.Marker({
                            position: myLatlng,
                            map: map,
                            title: '',
                            icon : base_url+'assets/img/bp-marker.png',
                            label: {
                                text: (pos).toString(), 
                                color: "white"
                            }
                        });
                        
                        google.maps.event.addListener(t, 'mouseover', function() {  
                            var iwContent = '<div id="iw_container">' +
                                '<div class="iw_title">' + point.name +', '+stage.fromStation.name+'</div>' +
                                '<div class="iw_content" style="max-width:250px">'+                            
                                    '<table align="left" width="100%" cellpadding="8">'+
                                    '<tr>'+
                                        '<td style="padding:2px;">' + moment(point.dateTime).format("h:mm a") + '</td>'+
                                    '</tr>'+
                                    '<tr>'+
                                        '<td style="padding:2px;">' + point.landmark + '</td>'+
                                    '</tr>'+
                                    '<tr>'+
                                        '<td style="padding:2px;">' + point.number + '</td>'+
                                    '</tr>'+
                                '</div>'+
                                '</div>';
                            infoWindow.setContent(iwContent);
                            infoWindow.open(map, t);
                        });
                        
                    });
                });
            }
        }
    });    
}