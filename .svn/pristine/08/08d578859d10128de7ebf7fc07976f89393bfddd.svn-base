$( function() {
    $('#ab-stations').sliderNav();
    buildNameSpaceMappingStationPointList();
});
function buildStationPointMappingList(station_code) {
    $('#search-status').html('');
    $('#master-sp-list').show();
    var data = {};
    data.station_code = station_code;
    /*if(data.station_code=="") {
       $('#search-status').html('Please select a state');
       return;
    }*/

    $('#address-book').html('<div align="left">'+loading_big+'</div>');
    $('#result-panel').show();
    $('#contact-card').hide();
    $.ajax({
        type: "POST",
        url: base_url+"config/get-stations-point-mapping-namespace",
        data: data,
        success: function(response) {
           $('#address-book').html(response);           
           $('#address-book').sliderNav({navPosition:'right'});
            
        }
    });
    //buildNameSpaceMappingStationPointList();
}
function buildNameSpaceMappingStationPointList() {
    $('#search-status').html('');
    $('#namespace').html('<div align="left">'+loading_big+'</div>');
    $('#result-panel').show();
    $('#contact-card').hide();
    $.ajax({
        type: "POST",
        url: base_url+"config/get-namespace-stationpoint",
        success: function(response) {
           $('#namespace').html(response);
           //$('#namespace').sliderNav();
        }
    })
}
function addNamespaceStationPointMapping(mapDetails) {
    
    if(_isdefined(mapDetails)) {
      var data = {};
          data.name = mapDetails.name;
          data.activeFlag = 1;
          data.code = mapDetails.code;
          data.stationCode = mapDetails.stationCode;
          data.latitude = mapDetails.latitude;
          data.longitude = mapDetails.longitude;
       $('#namespace').html('<div align="left">'+loading_big+'</div>');
       $.ajax({
        type: "POST",
        url: base_url+"config/add-namespace-station-point",
        data: data,
        success: function(response) {
            buildNameSpaceMappingStationPointList();
            
        }
    });
    }    
    
}
function deleteStationPointNamespaceMapping(mapDetails) {
    
    if(_isdefined(mapDetails)) {
      var data = {};
          data.name = mapDetails.name;
          data.activeFlag = 2;
          data.code = mapDetails.code;
          data.stationCode = mapDetails.stationCode;
          data.latitude = mapDetails.latitude;
          data.longitude = mapDetails.longitude;
       $('#namespace').html('<div align="left">'+loading_big+'</div>');
       $.ajax({
        type: "POST",
        url: base_url+"config/delete-namespace-station-point",
        data: data,
        success: function(response) {
            buildNameSpaceMappingStationPointList();
            
        }
    });
    }    
    
}
