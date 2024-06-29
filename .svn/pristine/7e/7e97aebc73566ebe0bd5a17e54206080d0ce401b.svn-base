function getDriverDetails(trip) {
    $('#vehicle-tab').html(loading_popup);
    var data = {};
    data.tripCode = trip;
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "schedules/get-driver-details",
        data: data,
        success: function (response) {
            if (response) {
                $('#vehicle-tab').html(response);
                $('#tripCode').val(trip);
            }
        }
    })
}

function getTripStages(stages, trip) {
    var select = '';
    select += "<select id='trpMap' class='form-control col-md-2' style='width:350px' name='trpMap'><option>Select a stage</option>";
    $.each(stages, function (k, stg) {
        if (stg.tripCode == trip) {
            var list = stg.stageList;
            $.each(list, function (k, list) {
                var fromTime = list.fromStation.dateTime;
                var splitfromTime = fromTime.split(" ");
                var toTime = list.toStation.dateTime;
                var splittoTime = toTime.split(" ");
                var from = " ( " + timeConversion(splitfromTime[1]) + " )";
                var to = " ( " + timeConversion(splittoTime[1]) + " )";
                select += "<option value='" + list.code + "'>" + list.fromStation.name + from + " - " + list.toStation.name + to + "</option>";
            });
        }
    });
    select += "</select>";
    $('#stages-tab').find('#triplist').html(select);
}

function timeConversion(time) {
    var timeString = time;
    var H = +timeString.substr(0, 2);
    var h = H % 12 || 12;
    var ampm = H < 12 ? " AM" : " PM";
    return timeString = h + timeString.substr(2, 3) + ampm;
}

function save_driver_info() {
    var data = {};
    data.trip_code = $('#tripCode').val();
    data.driver_name = $.trim($('#driver-name option:selected').data('name'));
    data.driver_phone = $.trim($('#driver-phone').val());
    data.driver_name2 = $.trim($('#driver2-name option:selected').data('name'));
    data.driver_phone2 = $.trim($('#driver2-phone').val());
    data.attender_name = $.trim($('#attender-name option:selected').data('name'));
    data.attender_phone = $.trim($('#attender-phone').val());
    data.remarks = $.trim($('#remarks').val());
    data.vehicle = $('#vehicles').val();
    data.primaryDriverCode = $('#driver-name').val();
    data.secondaryDriverCode = $('#driver2-name').val();
    data.attendantCode = $('#attender-name').val();
    
    data.tripdate = $('#hid-trip-date').val();
    $('#remarks_action').html('');
    
    
    
    $('.inp_error').removeClass('inp_error');
    if (data.vehicle == "") {
        $('#vehicles').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">Please select vehicle</div>');
        return;
    }
    
    if(data.primaryDriverCode=="") {
        $('#driver-name').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">Please enter driver name</div>');
        return;
        }        
        if(data.driver_phone=="") {
            $('#driver-phone').addClass('inp_error');
            $('#remarks_action').html('<div class="alert alert-danger">Please enter driver phone</div>');
                return;
        } 
    if(data.driver_phone != '' && !isValidPhonenumber(data.driver_phone)) {
        $('#driver-phone').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">please enter a valid phone number</div>');
        return;
    }
    if(data.driver_phone2 != '' && !isValidPhonenumber(data.driver_phone2)) {
        $('#driver2-phone').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">please enter a valid phone number</div>');
        return;
    }
    if(data.attender_phone != '' && !isValidPhonenumber(data.attender_phone)) {
        $('#attender-phone').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">please enter a valid phone number</div>');
        return;
    }
        
    if (data.driver_phone != '' && data.driver_phone == data.driver_phone2) {
        $('#driver-name').addClass('inp_error');
        $('#driver-phone').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">Please select different driver / attender</div>');
        return;
    }
    if (data.driver_phone2 != '' && data.driver_phone2 == data.attender_phone) {
        $('#driver2-name').addClass('inp_error');
        $('#driver2-phone').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">Please select different driver / attender</div>');
        return;
    }
    if (data.attender_phone != '' && data.attender_phone == data.driver_phone) {
        $('#attender-name').addClass('inp_error');
        $('#attender-phone').addClass('inp_error');
        $('#remarks_action').html('<div class="alert alert-danger">Please select different driver / attender</div>');
        return;
    }
    
    $('#btn_save_remarks').hide();
    $('#remarks_action').html('<div class="alert alert-success">Please wait...</div>');
    $.ajax({
        type: "POST",
        url: "tripchart/save-chart-info",
        data: data,
        dataType: 'json',
        async: false,
        success: function (res) {
            if (res.status == 1) {
                $('#remarks_action').html('<div class="alert alert-success">Details are updated.</div>');
                
                // activating icons
                if(data.driver_name!=='' || data.driver_phone !=='') {
                    $('#driver-'+data.trip_code).removeClass('btn-default').attr('title', data.driver_name+', '+data.driver_phone).addClass('btn-success','slow');    
                }
                var vehicle = _.find(vehicle_list, function(o) { return o.code == data.vehicle; });
                $('#regno-'+data.trip_code).removeClass('btn-default').attr('title', vehicle.registationNumber).addClass('btn-success','slow');
                
                if(vehicle.gpsDeviceVendor.code=="EZEEGPS") {
                    $('#trackicon-'+data.trip_code).removeClass('hide');
                    $('#trackicon-'+data.trip_code).find('a').bind('click', function() {
                        trackfleet(data.trip_code, vehicle.gpsDeviceCode);
                    });        
                }
                
                window.setTimeout(function () {
                    $('#remarks_action').html('');
                    $('#btn_save_remarks').show();
                }, 4000);
            }
            else {
                $('#remarks_action').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                $('#btn_save_remarks').show();
                window.setTimeout(function () {
                    $('#remarks_action').html('');
                }, 3000);
            }
        }
    });
}

function getTripMap(stageCode) {
    var data = {};
    data.stageCode = stageCode;
    $('#map').html(loading_small);
    $.ajax({
        type: "POST",
        url: "schedules/get-trip-busmap",
        data: data,
        dataType: 'html',
        success: function (res) {
            if (res) {
                $('#map').html(res);
            }
        }
    });
}

function getTripMap1() {
    var data = {};
     $('.tcks').remove();
     $('#table-transfer').addClass('hidden');
    if($('#trpMap1').val() == '0'){
          $('#right-search').addClass('hidden');
        $('#maps').html('<div class="well well-large">Please select stage to get busmap</div>');
        return false;
    }
    data.stageCode = $('#trpMap1').val();
    $('#maps').html(loading_small);
    $.ajax({
        type: "POST",
        url: "tripexpenses/get-trip-busmap-transfer",
        data: data,
        dataType: 'html',
        success: function (res) {
            if (res) {
                $('#maps').html(res);                
            }
        }
    });
}

function getTripExpenses(trip) {
    var data = {};
    data.tripcode = trip;
    $('#tripexpanses-tab').html(loading_small);
    $.ajax({
        type: "POST",
        url: "tripexpenses/trip-expenses",
        data: data,
        dataType: 'html',
        async: true,
        success: function (res) {
            if (res) {
                $('#tripexpanses-tab').html(res);
                $("#add-expenses").click(function () {
                    $('#trip-expense-list').hide();
                    $("#addexpenses").removeClass('hide');
                    $(this).hide();
                });
            }
        }
    });
}


function getTripBusMap(stages, trip) {
    var data = {};
    // data.tripcode = trip;
    data.stageCode = trip;
    $('#tickettransfer-tab').html(loading_small);
    $.ajax({
        type: "POST",
        url: "tripexpenses/get-trip-busmap",
        data: data,
        dataType: 'html',
        async: true,
        success: function (res) {
            if (res) {
                $('#tickettransfer-tab').html(res);
                var select = '';
                select += "<select id='trpMap1' class='form-control' onchange='getTripMap1()'><option value='0'>Select a stage</option>";
                $.each(stages, function (k, stg) {
                    if (stg.tripCode == trip) {
                        var list = stg.stageList;
                        $.each(list, function (k, list) {
                            var fromTime = list.fromStation.dateTime;
                            var splitfromTime = fromTime.split(" ");
                            var toTime = list.toStation.dateTime;
                            var splittoTime = toTime.split(" ");
                            var from = " ( " + timeConversion(splitfromTime[1]) + " )";
                            var to = " ( " + timeConversion(splittoTime[1]) + " )";
                            select += "<option value='" + list.code + "'>" + list.fromStation.name + from + " - " + list.toStation.name + to + "</option>";
                        });
                    }
                });
                select += "</select>";
                $('#triplist-transfer').html(select);
            }
        }
    });
}

    function getTripBusMapSearch(stage) {
        var data = {};
        // data.tripcode = trip;
        data.stageCode = stage;
        $('#ticket-search').html(loading_small);
        $.ajax({
            type: "POST",
            url: "tripexpenses/get-trip-busmaps-search",
            data: data,
            dataType: 'html',
            async: true,
            success: function (res) {
                if (res) {
                    $('#ticket-search').html(res);
                }
            }
        });
    }

    function processSMS() {
        var data = {};
        
        data.trip_id = $('#trpMap').val();
        data.trip_code = $('#trpcode').val();
        data.sms_type = $('#sms-type').val();
        data.sms_reason = $('#sms-reason').val();
        data.sms_boarding_point = $('#sms-boargin-point').val();
        data.sms_support_no = $.trim( $('#sms-support-no').val() );
        data.sms_delay_time = $.trim( $('#sms-delay-time').val() );
        
        var pnr = [];
        $('input[class="chk_ticket"]:checked').each(function() {
            pnr.push(this.value);
        });
        if(pnr.length<=0) {
            alert('Please select atleast one PNR');
            return;
        }        
        data.pnr = pnr.join(',');
        
        if(data.sms_type=="" && data.sms_type != "SNDGPS" && data.sms_type != "RSNDGPSHJ") {
            alert('Please select type');
            $('#sms-type').focus();
            return;
        }        
        if(data.sms_reason=="" && data.sms_type != "SNDGPS" && data.sms_type != "RSNDGPSHJ") {
            alert('Please select a reason');
            $('#sms-reason').focus();
            return;
        }
        
        if(data.sms_type=="TBPC") {
            
            if(data.sms_boarding_point=="") {
                alert('Please select a boarding point');
                $('#sms-boargin-point').focus();
                return;
            } else {
                data.boarding = sms_boarding[data.sms_boarding_point].name;
                data.boardinglandmark = sms_boarding[data.sms_boarding_point].landmark;
                data.boardingtime = sms_boarding[data.sms_boarding_point].time;
            }            
            
        } else if(data.sms_type=="TDELAY" || data.sms_type=="TEARLY") {
            if(data.sms_delay_time=="") {
                alert('Please enter time');
                $('#sms-delay-time').focus();
                return;
            }
        }
        
        if(data.sms_support_no=="" && data.sms_type != "SNDGPS" && data.sms_type != "RSNDGPSHJ") {
            alert('Please enter support contact number');
            $('#sms-support-no').focus();
            return;
        } else if( !isValidPhonenumber(data.sms_support_no) && data.sms_type != "SNDGPS" && data.sms_type != "RSNDGPSHJ") {
            alert('Please enter valid support contact number');
            $('#sms-support-no').focus();
            return;            
        }
             
        $('#sms-form-container').hide();
        
        $('#resendsms-action-container').show();
        $('#resendsms-action-container').removeClass('alert-success alert-danger').html(loading_small);
        
        $.ajax({
            type: "POST",
            dataType: 'json',            
            url: base_url + "schedules/send-trip-sms-v2",
            data: data,
            success: function (response) {                    
                if (response.status == 1) {
                    $('#resendsms-action-container').addClass('alert-success').html('SMS sent successfully');
                } else {                        
                    $('#resendsms-action-container').addClass('alert-danger').html(response.errorDesc);
                }
                window.setTimeout(function(){
                    $('#resendsms-action-container').hide();
                    $('#sms-filter-container').show();
                }, 2000);   
            }
        });
        
    }
    
    function relaySMS(pnr, data, cntr){        
        data.pnr = pnr[cntr-1];
        $('#action-info').html('Sending '+cntr+' of '+pnr.length);
        $.ajax({
            type: "POST",
            dataType: 'json',            
            url: base_url + "schedules/send-trip-sms",
            data: data,
            success: function (response) {                    
                if (response.status == 1) {                        
                    var p = (cntr/pnr.length) * 100;                        
                    $('.progress-bar').css('width',p+'%');                        
                    cntr++;

                    if(cntr>pnr.length) {
                        window.setTimeout(function(){
                            $('#sms-action-container').hide();
                            $('#sms-filter-container').show();
                        }, 2000);                            
                    } else {
                        relaySMS(pnr, data, cntr)
                    }
                }
            }
        });        
    }
    
    function sendTripSms() {
        var pnr = [];
        $('input[class="chk_ticket"]:checked').each(function() {
            pnr.push(this.value);
        });
        if(pnr.length<=0) {
            $('#pnr-validation-state').addClass('alert').addClass('alert-danger').html('Please select atleast one PNR');
            return;
        }
        
        $('#sms-filter-container').hide();
        $('#sms-form-container').show();
    }
    
    function clearSMS(){
        $('#sms-filter-container').show();
        $('#sms-form-container').hide();
    }
    
    function setSMSTypeReasons(type) {
        var html="<option selected='selected' value=''>Select a reason</option>";
        if(type != "" && type != "SNDGPS" && type != "RSNDGPSHJ") {
            var rea = eval(sms_type_reasons[type]);               
            $.each(rea, function(index) {
                html += "<option value="+index+">"+rea[index]+"</option>";
            });       
        }
        $('#sms-reason').html(html);
        $('#sms-reason').show();
        $('#div-boarding').hide();
        //$('#div-support-no').hide();
        $('#div-delay-time').hide();
        if(type=="TBPC") {
            $('#div-boarding').show();
            $('#div-support-no').show();
        } else if(type=="TDELAY" || type=="TEARLY") {
            $('#div-delay-time').show();
        } else if(type=="SNDGPS") {
            $('#sms-reason').hide();
            $('#div-support-no').hide();
        } else if(type=="RSNDGPSHJ") {
            $('#sms-reason').hide();
            $('#div-delay-time').hide();
            $('#div-support-no').hide();
        }
    }
    
    function togglePNRcheckboxs(){
        $('.chk_ticket').prop('checked', false);
        var filter = $('#brd_pnt').val();
        if(filter=='select') {
            $('.chk_ticket').prop('checked', $('#chk_ticket_all').prop("checked"));
        } else {
            filter = filter.replace(/\s+/g, '');
            filter = filter.replace(/"/g, "").replace(/'/g, "").replace(/\(|\)/g, "");
            $('[id = brd_' + filter + ']').find('.chk_ticket').each(function() {
                $(this).prop('checked', $('#chk_ticket_all').prop("checked"));
            });
        }   
        setActivePNRCount();
    }

    function setActivePNRCount(){
        var sel_pnr_cnt = 0;
        $('input[class="chk_ticket"]:checked').each(function() {
            sel_pnr_cnt++;
        });
        $('#pnr-validation-state').removeClass('alert').removeClass('alert-danger');
        $('#pnr-validation-state').html('<br>' + sel_pnr_cnt +' PNR selected');
    }
    function getTripTransactionHistroy(trip) {
        var data = {};
        data.trip_code = trip;
        $('#triptransaction-tab').html(loading_small);
        $.ajax({
            type: "POST",
            url: "schedules/get-trip-transactions",
            data: data,
            dataType: 'html',
            success: function (res) {                
                $('#triptransaction-tab').html(res);                
            }
        });
    }
    
    function getTripAuditHistroy(trip) {
        var data = {};
        data.trip_code = trip;
        $('#tripaudti-tab').html(loading_small);
        $.ajax({
            type: "POST",
            url: "schedules/get-trip-history",
            data: data,
            dataType: 'html',
            success: function (res) {                
                $('#tripaudti-tab').html(res);                
            }
        });
    }
    
    function resetTripCache(trip) {
        var data = {};
        data.trip_code = trip;
        
        var loading_overlay = iosOverlay({
            text: "Reseting",
            icon: "fa fa-spinner fa-spin"
        });
        
        $.ajax({
            type: "POST",
            url: "schedules/reset-trip-cache",
            data: data,
            dataType: 'json',
            success: function (response) {                
                if (response.status == 1) {
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
        });
    }
    
    function tripcancel(trip) {
        var data = {};
        data.trip_code = trip;
        $('#tripcancel-tab').html(loading_small);
        $.ajax({
            type: "POST",
            url: "schedules/trip-cancel",
            data: data,
            dataType: 'html',
            success: function (res) {
                $('#tripcancel-tab').html(res);
            }
        });
    }
    
    function migrateSeats(trip) {
        var data = {};
        data.tripCode = trip;
        var tripdata = _.find(tripStages, function (o) {
            return o.tripCode == data.tripCode;
        });  
        data.travelDate = $('#hid-trip-date').val();
        data.fromCode = tripdata.stage.fromStation.code;
        data.toCode = tripdata.stage.toStation.code;
        data.id = 1;
        
        $('#migrateseats-tab').html(loading_small);
        $.ajax({
            type: "POST",
            url: "schedules/migrate-seats",
            data: data,
            dataType: 'html',
            success: function (res) {                
                $('#migrateseats-tab').html(res);                
            }
        });
    }
    
    function saveSeatMigrate(){
        var data = {};
        var err = 0;
        data.ticketCode = $('#hid-seat-pnr').val();        
        data.seatCodes = [];
        
        $('.migrate-to').each(function(i, val){
            if($(this).attr('data-new') == undefined || $(this).attr('data-new') == '') {
                err++;
                return false;
            } else {
                data.seatCodes[i] = $(this).attr('data-old')+'-'+$(this).attr('data-new');
            }
        });
        data.seatCodes = data.seatCodes.join(',');       
        
        if (err > 0) {
            $('#seat-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#seat-action-state').html('Please select new seats.');
            $('#seat-action-state').show();
            return false;
        } else {
            $('#seat-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#seat-action-state').html('');
            $('#seat-action-state').hide();
        }
        $('#seat-action-state').show();
        $('#seat-action-state').html(loading_popup);        
        
        $.ajax({
            type: "POST",
            url: "schedules/save-migrate-seats",
            data: data,
            dataType: 'json',
            success: function (res) {                
                if(res.status == 1){
                    $('#seat-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#seat-action-state').html('Seat name updated successfully');
                    window.setTimeout(function () {
                        $('#migrateseats').click();
                    }, 3000);
                } else {
                    $('#seat-action-state').addClass('alert-danger').removeClass('alert-success');
                    $('#seat-action-state').html(res.errorDesc);
                }
            }
        });
    }
    
    function migratePNRSeats(seats, pnr){
        $('#busmap-cont').removeClass('hide');
        $('#busmap-cont-well').addClass('hide');
        $('#seat-action-state').hide();
        $('#busmap-cont .seat-transfer-to').removeClass('seat-transfer-to');
        $('#migrate-mismatch .last-active').removeClass('last-active');
        
        var fromStation, toStation;
        $.each(seats, function(i,val){
            fromStation = val.fromStation.code;
            toStation = val.toStation.code;
            return false;
        });
        
        var data = {};
        data.tripCode = $('#migrate-tripcode').val();        
        data.travelDate = $('#hid-trip-date').val();
        data.fromCode = fromStation;
        data.toCode = toStation;
        data.id = 1;
        
        $('#busmap-cont').html(loading_small);
        $.ajax({
            type: "POST",
            url: "schedules/migrate-busmap",
            data: data,
            dataType: 'html',
            success: function (res) {                
                $('#busmap-cont').html(res);  
                $('#tr-'+pnr).addClass('last-active');
                $('#hid-seat-pnr').val(pnr);
                $('#spn-pnr').html(pnr);
                $('#target-migrate tbody').html('');

                $.each(seats, function(i,val){
                    $('#target-migrate tbody').append('<tr class="migrate-from">\n\
                        <td>'+val.passengerName+'</td>\n\
                        <td>'+val.passengerAge+'</td>\n\
                        <td>'+val.gender+'</td>\n\
                        <td>'+val.seatName+'</td>\n\
                        <td class="migrate-to migrate-to-'+i+'" data-old="'+val.seatCode+'"></td>\n\
                    </tr>');
                });              
            }
        });
    }
    
    function clearSeatMigrate(){
        $('#busmap-cont').addClass('hide');
        $('#busmap-cont-well').removeClass('hide');
        $('#busmap-cont .seat-transfer-to').removeClass('seat-transfer-to');
        $('#migrate-mismatch .last-active').removeClass('last-active');
        $('#target-migrate tbody').html('');
        $('#seat-action-state').hide();
    }
    
