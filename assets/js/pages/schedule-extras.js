function clearAllExtraWorkSpace() {
    $('#bulk_station_point_exception').html('');
}

function getAllStationPointException() {
    $('#bulk_station_point_exception').html(loading_small);
    var data = {};    
    $.ajax({
        type: "POST",
        url: "scheduleextras/get-station-point-exceptions",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#bulk_station_point_exception').html(res);
        }
    });
}

function showAllSpExceptionDialog(code) {
    $('#all-sp-exception-dialog').css('background', '#fff');
    $('#all-sp-exception-dialog').removeClass('hide');
    $('#all-sp-exception-dialog').show();
    $('#all-sp-exception-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();  
    
    $('#aspe_statiopoint').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropRight: true
    });
    
    $('#aspe_schedules').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true
    });
    
    if(code!='') {
        var obj = _.find(exceptions, function(o) { return o.code == code; });
        
        $('#aspe_code').val(code);
        $('#aspe_station').val(obj.station.code); 
        $('#aspe_daterange').val(obj.activeFrom + ' | ' + obj.activeTo);
        $('#aspe_releaseminutes').val(obj.releaseMinutes);
        $('#aspe_weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = obj.dayOfWeek;
        var res = str.split("");
        $("input[name='aspe_day_of_week']").each(function (i) {
            $(this).removeAttr("checked");            
            if (res[i] == 1) {
                $(this).prop('checked', true);
                $(this).parent().addClass('active');
            }
        });
        
        $.each(obj.scheduleList, function(i, sch) {
            $('option[value="'+sch.code+'"]', $('#aspe_schedules')).prop('selected', true);
        }); 
        $('#aspe_schedules').multiselect('refresh');

        getStationPoints(obj.station.code);
        $.each(obj.stationPointList, function(i, point) {
            $('option[value="'+point.code+'"]', $('#aspe_statiopoint')).prop('selected', true);
        }); 
        $('#aspe_statiopoint').multiselect('refresh');
        
        $('#aspe_boardingflag').prop('checked', obj.boardingFlag == 1);
        $('#aspe_droppingflag').prop('checked', obj.droppingFlag == 1);        
    } else {    
        $('#aspe_station').val('');        
        $('#aspe_statiopoint').val('');
        $('#aspe_schedules').val('');
        $('#aspe_releaseminutes').val(0);

        $('#aspe_daterange').val('');
        $('#aspe_weekdays').find("input[name='aspe_day_of_week']").each(function (i) {
            $(this).attr("checked", "checked");//.addClass('active');        
            $(this).parent().addClass('active');
        });
        $('#aspe_code').val('');
        
        $('#aspe_boardingflag').prop('checked', true).parent('.form-group').removeClass('text-danger');
        $('#aspe_droppingflag').prop('checked', false).parent('.form-group').removeClass('text-danger');
    }
    $('#aspe_station, #aspe_statiopoint, #aspe_daterange').removeClass('inp_error');
}

function closeAllSpExceptionDialog() {
    $('#all-sp-exception-dialog').dialog('destroy');
    $('#all-sp-exception-dialog').hide();
}

function getStationPoints(code) {
    var data = {};
    data.stationCode = code;
    
    $('#aspe_statiopoint').addClass('hide');
    $('#aspe_statiopoint').multiselect('destroy');
    $('#spaction').removeClass('hide');
    $('#spaction').html(loading_small);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "scheduleextras/get-stationpoints",
        data: data,
        async:false,
        success: function (response) {
            if (response.status == 1) {                
                var html = '';
                $.each(response.data, function(i, point) {
                    html += '<option value="'+point.code+'">'+point.name+'</option>';
                }); 
                $('#aspe_statiopoint').html(html);
                $('#aspe_statiopoint').multiselect({
                    maxHeight: 200,
                    numberDisplayed: 1,
                    buttonWidth: '200px',
                    dropRight: true
                });                                
                $('#aspe_statiopoint').removeClass('hide');
                $('#spaction').addClass('hide');
            } else {
               
            }
        }
    });
}

function saveAllStationPointException() {
    var data = {};
        
    data.station = $.trim($('#aspe_station').val());
    data.stationPoints = $.trim($('#aspe_statiopoint').val());
    data.schedules = $.trim($('#aspe_schedules').val());
    
    var dateRange = $('#aspe_daterange').val();
    var date = dateRange.split('|');
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    
    data.releaseBefore = $('#aspe_releaseminutes').val();
    
    data.code = $('#aspe_code').val();
    
    data.dayOfWeek = $("input[name='aspe_day_of_week']").map(function () {
        return + $(this).is(':checked');
    }).get();   
    
    data.boardingFlag = +$('#aspe_boardingflag').is(':checked');
    data.droppingFlag = +$('#aspe_droppingflag').is(':checked');
    
    $('#aspe_station, .multiselect, #aspe_daterange').removeClass('inp_error');
    
    var err = 0;
    if (data.station == '') {
        $('#aspe_station').addClass('inp_error');
        err++;
    } 
    
    if (data.stationPoints == '' || data.stationPoints == 'null') {
        $('.multiselect').addClass('inp_error');
        err++;
    } 

    if (dateRange == '') {
        $('#aspe_daterange').addClass('inp_error');
        err++;
    }
    
    if(data.boardingFlag == 0 && data.droppingFlag == 0) {
        $('#aspe_boardingflag').parent('.form-group').addClass('text-danger');
        $('#aspe_droppingflag').parent('.form-group').addClass('text-danger');
        err++;
    } else {
        $('#aspe_boardingflag').parent('.form-group').removeClass('text-danger');
        $('#aspe_droppingflag').parent('.form-group').removeClass('text-danger');        
    }

    if (err > 0) {
        $('#aspe-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#aspe-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#aspe-form-action-state').show();
        return false;
    } else {
        $('#aspe-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#aspe-form-action-state').hide();
    }

    $('#aspe-form-buttons').hide();
    $('#aspe-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#aspe-form-action-state').html(loading_popup);
    $('#aspe-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "scheduleextras/update-station-point-exceptions",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#aspe-form-buttons').hide();
                $('#aspe-form-action-state').removeClass('alert-danger');
                $('#aspe-form-action-state').addClass('alert-success');
                $('#aspe-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    closeAllSpExceptionDialog();
                    getAllStationPointException();
                }, 3000);
            } else {
                $('#aspe-form-action-state').show();
                $('#aspe-form-action-state').addClass('alert-danger');
                $('#aspe-form-action-state').html(response.errorDesc);
                $('#aspe-form-buttons').show();
            }
        }
    });
}

function deleteAllSpException(code) {
    var obj = _.find(exceptions, function(o) { return o.code == code; });
    obj.activeFlag = 2;
    
    if (confirm('Do you want to delete this rule?')) {
        var data = {}
        data.rule = obj;
        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "scheduleextras/delete-station-point-exceptions",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        getAllStationPointException();
                        return;
                    }, 2000);
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
}

function showScheduleOccupancy() {
    $('#schedule-occupancy-dialog').css('background', '#fff');
    $('#schedule-occupancy-dialog').removeClass('hide');
    $('#schedule-occupancy-dialog').show();
    $('#schedule-occupancy-dialog').dialog({
        autoOpen: true,
        height: $( window ).height()-50,
        width: $( window ).width()-100,
        modal: true,
        resizable: false
    });
    
    $(".ui-dialog-titlebar").hide();
    
    $('#sch-occupancy-panel').html(loading_big);
    var data = '';
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "scheduleextras/schedule-occupancy-summary-meta",
        data: data,
        success: function (response) {
            $('#sch-occupancy-panel').html(response);
        }
    });
    
    ga_track_event('All Schedule Trends', 'All Schedule Occupancy Trends', "View all schedule occuapncy trends");
                        
}

function closeScheduleOccupancy() {
    $('#schedule-occupancy-dialog').dialog('destroy');
    $('#schedule-occupancy-dialog').hide();
    setTimeout(function() {
        $('#sch-occupancy-panel').html('');
    }, 2000)
    
}

function getAllVirtualSeatBlocker() {
    $('#virtual_seat_blocker_div').html(loading_small);
    var data = {};
    $.ajax({
        type: "POST",
        url: "scheduleextras/virtual-seats",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#virtual_seat_blocker_div').html(res);
        }
    });
}

function getTicketRescheduleTerms() {
    $('#ticket_reschedule_terms_div').html(loading_small);
    var data = {};
    $.ajax({
        type: "POST",
        url: "scheduleextras/ticket-reshedule-terms",
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#ticket_reschedule_terms_div').html(res);
        }
    });
}

function getScheduleExtrasDiscount() {
    $('#schedule_extras_discount_div').html(loading_small);
    var data = {};
    $.ajax({
        type: 'POST',
        url: 'scheduleextras/schedule-discount',
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#schedule_extras_discount_div').html(res);
        }
    });
}

function getScheduleExtrasGenderRules() {
    $('#schedule_extras_gender_rule_div').html(loading_small);
    var data = {};
    $.ajax({
        type: 'POST',
        url: 'scheduleextras/schedule-gender-rules',
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#schedule_extras_gender_rule_div').html(res);
        }
    });
}

function getBreakevenSettings() {
    $('#schedule_extras_breakeven_div').html(loading_small);
    var data = {};
    $.ajax({
        type: 'POST',
        url: 'scheduleextras/breakeven-settings',
        data: data,
        dataType: 'html',
        success: function (res) {
            $('#schedule_extras_breakeven_div').html(res);
        }
    });
}