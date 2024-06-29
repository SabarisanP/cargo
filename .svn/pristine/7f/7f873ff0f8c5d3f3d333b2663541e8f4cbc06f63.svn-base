function init_cargo_list(){
   $('.trip-date').datepicker({
        todayHighlight: true,
        format: "yyyy-mm-dd",
        //startDate: '-0m',
    });

    var date_new = new Date();
    $('.trip-date').datepicker("setDate", date_new); 
    $('.trip-date .today').addClass('active');
    
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        var tabload = $(this).attr('href');
        //e.target // activated tab
        //e.relatedTarget // previous tab
        //if (($(tabload).attr('data-load') == ' ' || $(tabload).attr('data-load') == undefined) && ($(this).attr('data-view') != '' && $(this).attr('data-view') != undefined)) {
        if ($(this).attr('data-type') != '' && $(this).attr('data-type') != undefined) {
            $(tabload).html(loading_big);
            $.ajax({
                type: "GET",
                url: "cargo/schedule-list?type=" + $(this).attr('data-type'),
                dataType: 'html',                
                success: function (res) {
                    $(tabload).html(res);
                    //$(tabload).attr('data-load', '1');
                }
            });
        }
        //}
    });
    
}


function searchCargoTrips(prm, date){
    var data = {}
    data.searchType = prm;
    data.date = $.datepicker.formatDate("yy-mm-dd", $('.trip-date').datepicker('getDate')); //$('.trip-date').datepicker('getDate');
    if (prm == 1) {
        if (date == '' || date == undefined) {
            data.date = $.datepicker.formatDate("yy-mm-dd", $('.trip-date').datepicker('getDate')); //$('.trip-date').datepicker('getDate');
        } else {
            data.date = date;
        }
        $('#trip-schedules-list').html(loading_big);
        $('.trip-form-control').hide();
    } else if (prm == 2) {
        data.date = $('#date-schedules-trips').val();
        $('#trip-table-list').html("<div align='center'>" + loading_big + "</div>");
    }
    $.ajax({
        type: "POST",
        url: "cargo/trip-list",
        data: data,
        dataType: 'html',     
        cache : false,
        success: function (res) {
            if (prm == 1) {
                $('#trip-schedules-list').html(res); //date-schedules-trips                
            } else if (prm == 2) {
                $('#trip-table-list').html(res);
            }
        }
    });
}

function closeCargoTripOptions() {
    $('#log').val('');
    $('.viw_mre_trp').each(function () {
        $(this).removeClass('hide');
        $(this).removeClass('active-row');
        $('#trp-sch-workspace').addClass('hide');
        $('#trp-workspace-content').html('');
        $('#mail_inbox tbody tr').each(function () {
            $(this).removeClass("hide");
        });
    });
}

function clearCargoForLoad() {
    $('#from-station').val('');
    $('#to-station').val('');
    $('#cargo-items-list').html(''); 
}

function getCargoForLoad() {
    var data = {};
    var c = $('#dptrip-stage').val();
    c = c.split('|');
    data.fromStation = c[0];
    data.toStation = c[1];
    data.fromBranch = $('#dptrip-from-branch').val();
    data.toBranch = $('#dptrip-to-branch').val();
    data.date = $('#date-schedules-trips').val();
    
    if (data.fromStation == '' || data.toStation == '') {
       return false;
    }
    
    $('#cargo-items-list').html('');
    $('#search-info-button').hide();
    $('#search-info-state').html(loading_small);
    
    $.ajax({
        type: "POST",
        url: "cargo/search-cargo-for-booking",
        data: data,
        dataType: 'html',
        success: function (res) {                       
            $('#search-info-state').html('');
            $('#search-info-button').show();
            $('#cargo-items-list').html(res);                
        }
    });
}

function checkAllCargoItems(ele){
    $(".cargo-items").prop('checked', $(ele).prop("checked"));
}

function checkLoadedAllCargoItems(ele) {
    $(".uncargo-items").prop('checked', $(ele).prop("checked"));
}

function loadCargoToTrip(){
    $('#load-state').html('');
    var codes = [];
    $(".cargo-items:checked").each(function() {
       codes.push($(this).val()); 
    });
    
    if(codes.length<=0) {        
        $('#load-state').html('<span class="alert alert-danger">Please select atleast 1 cargo to load</span>');
        return false;
    }
    
    $('#load-state').html(loading_small);
    $('#btn-load').hide();
    var data = {};
    data.codes = codes;
    data.tripcode = $('#trips').val();
    
    $.ajax({
        type: "POST",
        url: "cargo/load-cargo-to-trip",
        data: data,
        dataType: 'json',
        success: function (res) {                       
            $('#load-state').html('<span class="alert alert-success">Your request processed successfully</span>');            
            window.setTimeout(function () {
                clearCargoForLoad();
            }, 2000);
        }
    });
}

function unloadCargoToTrip(){
    var codes = [];
    $(".uncargo-items:checked").each(function() {
       codes.push($(this).val()); 
    });
    
    if(codes.length<=0) {        
        $('#unload-state').html('<span class="alert alert-danger">Please select atleast 1 cargo to unload</span>');
        return false;
    }
    
    $('#unload-state').html(loading_small);
    $('#unbtn-load').hide();
    var data = {};
    data.codes = codes;
    data.tripcode = $('#trips').val();
    
    $.ajax({
        type: "POST",
        url: "cargo/unload-cargo-from-trip",
        data: data,
        dataType: 'json',
        success: function (res) {                       
            $('#unload-state').html('<span class="alert alert-success">Your request processed successfully</span>');            
            window.setTimeout(function () {
                getLoadedCargo(data.tripcode);
            }, 2000);
        }
    });
}

function getLoadedCargo(trip) {
    $('#unload-tab').html(loading_big);
    
    var data = {};
    data.tripCode = trip;
    $.ajax({
        type: "POST",
        url: "cargo/loaded-list-from-trip",
        data: data,
        dataType: 'html',
        success: function (res) {                       
            $('#unload-tab').html(res);             
        }
    });
}

function init_edit_cargo_schedules() {
    if( $('#ca-sch-code').val() != "") {
        $('#section-stations').removeClass('hidden');
        //$('#section-routes').removeClass('hidden');
        
        getCargoScheduleStations();
        getCargoScheduleRoutes();
    }
    
    $('#ca-sch-daterange').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
        //yearRange: '1930:+0',
    });
    
    $('#ca-sta-hours').timepicker({
        minuteStep: 1,
        showInputs:false,
        showMeridian:false,
    });
}


function showCargoAddStation(){
    if($('#ca-new-station').css('display')=='block') return;        
    $('#ca-new-station').show();  
}

function hideCargoAddStation(){
    $('#ca-new-station').hide();
    $('#ca-sch-sta-code').val('');
}

function saveBasicInfo(){
    $('#basic-info-state').html('');
    
    var data = {};
    data.scheduleName   = $.trim( $('#ca-sch-name').val() );
    data.dateRange      = $.trim( $('#ca-sch-daterange').val() );
    var dates = data.dateRange.split('|');
    data.fromDate = dates[0];
    data.toDate   = dates[1];
    data.scheduleCode   = $('#ca-sch-code').val();
    
    var err = 0;
    $('#ca-sch-name, #ca-sch-daterange').removeClass('parsley-error'); 
    
    if (data.scheduleName == '') {
        $('#ca-sch-name').addClass('parsley-error');
        err++;
    }
    
    if (data.dateRange == '') {
        $('#ca-sch-daterange').addClass('parsley-error');
        err++;
    }
    
    if (err > 0) {
        $('#basic-info-state').html('<div class="alert alert-danger">Please enter/select the values in the field that are marked in red</div>');
        return false;
    }
    $('#basic-info-button').hide();
    $('#basic-info-state').html(loading_small);
    
    $.ajax({
        type: "POST",
        url: "cargo/save-basic-info",
        data: data,
        dataType: 'json',
        success: function (res) {
            if (res.status == 1) {                
                $('#basic-info-state').html('<div class="alert alert-success">Your request has been processed successfully</div>');
                $('#ca-sch-code').val(res.data.code);
                $('#sch_tmp_code').html('Code : ' + res.data.code);                
                window.setTimeout(function () {
                    $('#basic-info-state').html('');
                    $('#basic-info-button').show();
                    $('#section-stations').removeClass('hidden');
                }, 2000);
                return true;
            } else {
                $('#basic-info-state').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                return false;
            }
        }
    });
}

function getCargoScheduleStations() {
    var data = {};
    data.scheduleCode = $('#ca-sch-code').val();    
    $('#section-stations-list').html(loading_popup);
    
    $.ajax({
        type: "POST",
        url: "cargo/get-schedule-stations",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#section-stations-list').html(res);
            if(ca_sch_stations.length>=2) {
                $('#section-routes').removeClass('hidden');
            }
            hideCargoAddRoute();
        }
    });
}

function deleteCargoStation(i) {
    var data = {};
    data.stationCode = ca_sch_stations[i].code;
    data.scheduleCode = $('#ca-sch-code').val();
     var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
    $.ajax({
        type: "POST",
        url: "cargo/delete-schedule-station",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                getCargoScheduleStations();
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
    });
}

function editCargoStation(i) {
    
    esta = ca_sch_stations[i];
    $('#ca-sch-sta-code').val(esta.code);
    $('#ca-sta-seq').val(esta.stationSequence);
    $('#ca-station').val(esta.station.code);
    var m = esta.minitues;
    if(Number(esta.dayFlag) == 2) m = Number(m) - 1440;
    else if(Number(esta.dayFlag) == 3) m = Number(m) - 2880;
    
    //$('#ca-sta-hours-mins').val(m);
    //$('#ca-sta-hours').val(m);    
    $('#ca-day-flag').val(esta.dayFlag);
    
    var picker = $('#ca-sta-hours').data('timepicker');
    picker.setTime(esta.formatedTime);
   
    
    showCargoAddStation();
}

function addCargoStation(){
    var data = {};
    
    data.schStationCode = $('#ca-sch-sta-code').val();
    if(data.schStationCode!='') {
        data.sationSequence = $('#ca-sta-seq').val();
    } else {
        data.sationSequence = parseInt( $('#max-seq').val() )+1;
        if( isNaN(data.sationSequence) ) data.sationSequence = 1;
    }
    
    data.scheduleCode = $('#ca-sch-code').val();
    data.stationCode   = $('#ca-station').val();
    var picker = $('#ca-sta-hours').data('timepicker');    
    data.stationMins   = picker.getTime();
    data.stationDay   = $('#ca-day-flag').val();
    
    $('#ca-station').removeClass('parsley-error'); 
    
    if (data.stationCode == '') {
        $('#ca-station').addClass('parsley-error');
        return;
    }
    
    $('#ca-new-station-button').hide();
    $('#ca-new-station-state').html(loading_small);
    
    $.ajax({
        type: "POST",
        url: "cargo/save-schedule-station",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                hideCargoAddStation();
                getCargoScheduleStations();                
                $('#ca-new-station-state').html('');
                $('#ca-new-station-button').show();
                $('#ca-sta-code').val('');
                $('#ca-sch-sta-code').val('');
                $('#ca-sta-seq').val('');                
            } else {
                $('#ca-new-station-state').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                return false;
            }
        }
    });
    
}

function getStationsAdded() {
    h = '<option value="">Select Station</option>';	
    $.each(ca_sch_stations, function(key, art) {
        h = h+'<option value="'+art.station.code+'">'+art.station.name+'</option>';            
    }); 
    return h;
}

function showCargoAddRoute(){
    var s = getStationsAdded();
    $('#ca-from-station').html(s);
    $('#ca-to-station').html(s);
    
    $('#ca-new-route').show();
}

function hideCargoAddRoute(){
    $('#ca-new-route').hide();
    $('#ca-sch-route-code').val('');
}

function getCargoScheduleRoutes() {
    var data = {};
    data.scheduleCode = $('#ca-sch-code').val();    
    $('#section-routes-list').html(loading_popup);
    
    $.ajax({
        type: "POST",
        url: "cargo/get-schedule-routes",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#section-routes-list').html(res);            
        }
    });
}

function editCargoRoute(i) {
    showCargoAddRoute();
    esta = ca_sch_routes[i];
    $('#ca-sch-route-code').val(esta.code);   
    $('#ca-from-station').val(esta.fromStation.code);
    $('#ca-to-station').val(esta.toStation.code);
}

function deleteCargoRoute(i){
    var data = {};
    data.routeCode = ca_sch_routes[i].code;
    data.scheduleCode = $('#ca-sch-code').val();
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        url: "cargo/delete-schedule-route",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                getCargoScheduleRoutes();
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
    });
}

function addCargoRoute(){
    var data = {};
    
    data.schRouteCode = $('#ca-sch-route-code').val();
    data.scheduleCode = $('#ca-sch-code').val();
    data.fromStationCode = $('#ca-from-station').val();
    data.toStationCode   = $('#ca-to-station').val();
    
    $('#ca-from-station, #ca-to-station').removeClass('parsley-error'); 
    
    if (data.fromStationCode == '') {
        $('#ca-from-station').addClass('parsley-error');
        return;
    }
    if (data.toStationCode == '') {
        $('#ca-to-station').addClass('parsley-error');
        return;
    }
    
    if (data.fromStationCode == data.toStationCode) {
        alert('From and To stations should not be same');
        return;
    }
    
    if (typeof ca_sch_routes !== "undefined") {
        var al = false;    
        $.each(ca_sch_routes, function(key, art) {
            if(art.fromStation.code == data.fromStationCode && art.toStation.code == data.toStationCode) {
              al = true;  
            }           
        }); 

        if(al) {
            alert('Selected route already added');
            return;
        }
    }

    $('#ca-new-route-button').hide();
    $('#ca-new-route-state').html(loading_small);
    
    $.ajax({
        type: "POST",
        url: "cargo/save-schedule-route",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                hideCargoAddRoute();
                getCargoScheduleRoutes();                
                $('#ca-new-route-state').html('');
                $('#ca-new-route-button').show();                
                $('#ca-sch-route-code').val('');
            } else {
                $('#ca-new-route-state').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                return false;
            }
        }
    });
    
}


function init_cargo_trip_chart_page_actions(date) {
    $('.trip-chart-date').datepicker({
        todayHighlight: true,
        format: "yyyy-mm-dd"
    });
    
    $('.trip-chart-date').datepicker("setDate", new Date()); 
    $('.trip-chart-date .today').addClass('active');
    
    if(date !=''){
        window.setTimeout(function() {
            searchCargoTripChartList(date);
        }, 100);
       
    }
}

function searchCargoTripChartList(date) {
    var data = {}
    if(date!='' && date != 1){
        data.tripDate = date;   
    }else{
        data.tripDate = $.datepicker.formatDate("yy-mm-dd", $('.trip-chart-date').datepicker('getDate'));
    }
    $('.trip-list-form-control').hide();
    $('#trip-table-list').html(loading_big)
    $.ajax({
        type: "POST",
        url: "cargo/trip-chart-list",
        cache : false,
        data: data,
        dataType: 'html',
        async: false,
        success: function(res) {
            $('#tc-back').removeClass('hidden');
            $('#trip-table-list').html(res);
        }
    });
}
function backToCargoSelectDate() {
    $('.trip-list-form-control').show();
    $('#trip-table-list').html('');
    $('#tc-back').addClass('hidden');
}

function print_cargo_trip_chart(code) {
    var url = base_url + "cargo/trip-chart-details?print=1&tc="+code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
    wo.print();
}

function setScheduleState(code, state) {

    var data = {};
    data.sch_state = state;
    data.sch_code = code;
    var txt = '';
    if (state == 0) {
        txt = 'Do you want to close this schedule, please make sure all advance booking tickets are transfered to other schedule?';
    } else if (state == 9) {
        txt = 'Do you want to activate / open this schedule?';
    }
    
    swal({
        title: "Are you sure?",
        text: txt,
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        confirmButtonText: "Yes, Continue!",
        closeOnConfirm: false
    }, function () {
        $('#loading_trip').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/set-schedule-state",
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    $('#sch-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove();
                    });
                    $('#loading_trip').html('');
                    swal("Success!", "Schedule has been open.", "success");
                }
            }
        });
    });
}