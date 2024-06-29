
function init_btrip_chart_page_actions(date) {
    $('.trip-chart-date').datepicker({
        todayHighlight: true,
        format: "yyyy-mm-dd"
    });
    /*if(date!="") {
        dates1 = date.split('-');        
        $('.trip-chart-date').datepicker('setDate', new Date(dates1[0], dates1[1]-1, dates1[2]));
        $('.trip-chart-date').datepicker('update');
        alert($.datepicker.formatDate("yy-mm-dd", $('.trip-chart-date').datepicker('getDate')))
    }*/
    
    
    
    if(date !=''){
        window.setTimeout(function() {
            searchBTripList(date);
        }, 100);
       
    } else {
        var date_new = new Date();
        $('.trip-chart-date').datepicker("setDate", date_new);
    }
    
    
}

function init_bchart_actions(){    
    $('#vehicle-id').select2({
        placeholder: "Select vehicle",
        escapeMarkup: function(markup) {
            return markup;
        }
    });
    if($('#driver-name').val() == 'NA') $('#driver-name').val('');
    if($('#driver-phone').val() == 'NA') $('#driver-phone').val('');
    if($('#remarks').val() == 'NA') $('#remarks').val('');
    
    $('#btn_save_notes').click( function() {
        $('#edit_notes_action').html('');
        $('#edit_notes_action').removeClass('alert-success').removeClass('alert-danger');
        
        var data = {}; 
        data.trip_code = trip_code;
        data.driver_name = $.trim($('#driver-name option:selected').data('name'));
        data.driver_phone = $.trim($('#driver-phone').val());
        data.driver_name2 = $.trim($('#driver2-name option:selected').data('name'));
        data.driver_phone2 = $.trim($('#driver2-phone').val());
        data.attender_name = $.trim($('#attender-name option:selected').data('name'));
        data.attender_phone = $.trim($('#attender-phone').val());
        data.vehicle = $.trim($('#vehicle-id').val());
        data.remarks = $.trim($('#notes').val());
        data.tripdate = tc_date;
        data.primaryDriverCode = $('#driver-name').val();
        data.secondaryDriverCode = $('#driver2-name').val();
        data.attendantCode = $('#attender-name').val();
        
        if(data.remarks=="") {
            $('#edit_notes_action').addClass('alert-danger').html('Notes updated successfully');
            return;
        }
        
        if(data.remarks.length>250) {
            $('#edit_notes_action').addClass('alert-danger').html('Notes should not exceeds 250 charactors');
            return;
        }
        
        $('#btn_save_remarks').hide();
        $('#btn-cancel-remarks').hide();
        $('#edit_notes_action').html(loading_small);
        
        $.ajax({
            type: "POST",
            url: "tripchart/save-chart-info",
            data: data,
            dataType: 'json',
            async: false,
            success: function(res) {
                $('#edit_notes_action').removeClass('alert-success').removeClass('alert-danger').addClass('alert-success').html('Notes updated successfully');
                window.setTimeout(function() {
                    $('#edit_notes_action').removeClass('alert-success').removeClass('alert-danger').html('');
                }, 4000);
            }
        });
    });
    
    $('#btn_save_remarks').click( function() {
        $('#remarks_action').html('');
        var data = {};        
        data.trip_code = trip_code;
        data.driver_name = $.trim($('#driver-name option:selected').data('name'));
        data.driver_phone = $.trim($('#driver-phone').val());
        data.driver_name2 = $.trim($('#driver2-name option:selected').data('name'));
        data.driver_phone2 = $.trim($('#driver2-phone').val());
        data.attender_name = $.trim($('#attender-name option:selected').data('name'));
        data.attender_phone = $.trim($('#attender-phone').val());
        data.vehicle = $.trim($('#vehicle-id').val());
        data.remarks = $.trim($('#notes').val());
        data.tripdate = tc_date;
        data.primaryDriverCode = $('#driver-name').val();
        data.secondaryDriverCode = $('#driver2-name').val();
        data.attendantCode = $('#attender-name').val();
        
        if(data.vehicle=="") {
            alert('Please select a vehicle');
            return;
        }
        if(data.primaryDriverCode=="") {
            alert('Please enter driver name');
            $('#driver-name').focus();
            return;
        }        
        if(data.driver_phone=="") {
            alert('Please enter driver phone');
            $('#driver-phone').focus();
            return;
        } else 

        if(data.driver_phone!="") {
            if(!$.isNumeric(data.driver_phone) || data.driver_phone.length < 10) {
                alert('Please enter valid driver phone');
                $('#driver-phone').select();
                return;
            }
        }
        
        $('.inp_error').removeClass('inp_error');
        if(data.driver_phone != '' && !isValidPhonenumber(data.driver_phone)) {
            $('#driver-phone').addClass('inp_error');
            alert('please enter a valid phone number');
            return;
        }
        if(data.driver_phone2 != '' && !isValidPhonenumber(data.driver_phone2)) {
            $('#driver2-phone').addClass('inp_error');
            alert('please enter a valid phone number');
            return;
        }
        if(data.attender_phone != '' && !isValidPhonenumber(data.attender_phone)) {
            $('#attender-phone').addClass('inp_error');
            alert('please enter a valid phone number');
            return;
        }
        
        if (data.driver_phone != '' && data.driver_phone == data.driver_phone2) {
            $('#driver-name').addClass('inp_error');
            $('#driver-phone').addClass('inp_error');
            alert('Please select different driver / attender');
            return;
        }
        if (data.driver_phone2 != '' && data.driver_phone2 == data.attender_phone) {
            $('#driver2-name').addClass('inp_error');
            $('#driver2-phone').addClass('inp_error');
            alert('Please select different driver / attender');
            return;
        }
        if (data.attender_phone != '' && data.attender_phone == data.driver_phone) {
            $('#attender-name').addClass('inp_error');
            $('#attender-phone').addClass('inp_error');
            alert('Please select different driver / attender');
            return;
        }
        
        $('#btn_save_remarks').hide();
        $('#btn-cancel-remarks').hide();
        $('#remarks_action').html(loading_small);
        
        $.ajax({
            type: "POST",
            url: "tripchart/save-chart-info",
            data: data,
            dataType: 'json',
            async: false,
            success: function(res) {
                window.setTimeout(function() {
                    window.location.reload();
                }, 1000);
            }
        });
    });
    
    $('#btn_send_sms').click( function() {
        $('#sms_action').html('');
        var data = {};
        data.sms_content = $.trim($('#sms_content').val());
        
        if(data.sms_content=="") {
            $('#sms_action').html('<div class="alert alert-danger">Please enter SMS message</div>');
            $('#sms_content').focus();
            return;
        } 
        
        $('#btn_send_sms').hide();
        $('#sms_action').html('<div class="alert alert-success">Please wait...</div>');
        
        $.ajax({
            type: "POST",
            url: "boardingtripchart/boarding-send-trip-sms",
            data: data,
            dataType: 'json',
            async: false,
            success: function(res) {
                $('#sms_action').html('<div class="alert alert-success">SMS has been sent</div>');
                window.setTimeout(function() {
                    $('#sms_action').html('');
                    $('#btn_send_sms').show();
                }, 4000);
            }
        });
        
    });
}

function boarding_tripStatusUpdate(code, state){
    var data = {};
    data.trip_state = state;
    data.trip_code = code;       
    var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "schedules/update-trip",
        data: data,
        success: function(res) {
            if (res.status == 1) {
                 loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                console.log('Trip closed')
            }else{
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

function boarding_close_print_chart(code){
    if(confirm('Do you want to close booking?')) {
        var data = {};
        data.trip_state = 'TPC';
        data.trip_code = code;        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "schedules/update-trip",
            data: data,
            success: function(res) {
                if (res.status == 1) {
                    console.log('Trip closed')
                }
            }
        });
        boarding_print_trip_chart(code);
    }
}

function searchBTripList(date) {
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
        url: "boardingtripchart/boarding-trip-list",
        data: data,
        dataType: 'html',
        success: function(res) {
            $('#tc-back').removeClass('hidden');
            $('#trip-table-list').html(res);
            /*$('#trip-list-chart-table').dataTable({
                "aaSorting": [[1, "asc"]]
            }); */
            if($('.trip-pie').length) {
                $('.trip-pie').each( function() {
                    var ele = '#'+$(this).attr('id');
                    var tmp = $(this).attr('data-percent');
                    if(parseInt(tmp)<=30) {
                        var color = '#c0392b';
                    } else if(parseInt(tmp)>=31 && parseInt(tmp)<=50) {                        
                        var color = '#d7af0d';
                    } else if(parseInt(tmp)>=51 && parseInt(tmp)<=70) {
                        var color = '#4fbeba';
                    } else {
                        var color = '#2ca02c';
                    }
                    console.log(ele);
                    chartdata = [
                        { label: "Booked", data: $(this).attr('data-booked'), color: color },
                        { label: "Vacant", data: $(this).attr('data-vacant'), color: '#efefef' },
                    ];
                    $.plot(ele, chartdata, {
                        grid: { clickable: true,  hoverable: true },
                        series: {
                            pie: {
                                show: true,
                                radius: 3/4,
                                label: {
                                    show: false
                                },
                                innerRadius: 0
                            }
                        },
                        legend: { show: false },
                        tooltip: true,
                        tooltipOpts: {
                                content: "%p.0%, %s",
                            shifts: {
                                x: 20,
                                y: 0
                            },
                            defaultTheme: false
                        }
                    });
                });                
            }
        }
    });
}
function backToSelectDate() {
    $('.trip-list-form-control').show();
    $('#trip-table-list').html('');
    $('#tc-back').addClass('hidden');
}

function boarding_print_trip_chart(code) {
    var url = base_url + "boardingtripchart/boarding-trip-chart-list?print=1&tc="+code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}
function boarding_print_trip_chart_medium(code) {
    var url = base_url + "boardingtripchart/boarding-trip-chart-list?medium=1&print=1&tc="+code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}
function boarding_mini_print_trip_chart(code) {
    var url = base_url + "boardingtripchart/boarding-trip-chart-list?mini=1&print=1&tc="+code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}

function boarding_print_layout_chart(code) {
    var url = base_url + "boardingtripchart/boarding-trip-chart-list?layout=1&print=1&tc="+code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}

function backToTripList() {
    //$('.trip-list-form-control').show();
    //$('#trip-table-list').html('');
    //$('#tc-back').addClass('hidden');    
}

function toggleRemarks() {
    $('#chart_notes_container').toggle();
    $('#chart_meta_container').hide();
}

function toggleChartMeta() {
    $('#chart_meta_container').toggle();
    $('#chart_notes_container').hide();
}

function print_route_agent_sheet(){
    $('#agent-grp-dialog').css('background', '#fff');
    $('#agent-grp-dialog').removeClass('hide');
    $('#agent-grp-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 570,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('.user_list').html('');
    var data = {};
    $.ajax({
        type: "GET",
        dataType: 'json',
        url: base_url + "boardingtripchart/agent-organizations",
        data: data,
        success: function(res) {
            
            $('.user_list').html('');
            $.each(res, function(rekey, reval) {                
                var list = $('#tmpl-agent-group').html();
                list = $(list).clone();
                
                $(list).find('#name').html( reval.name+' ( '+reval.userCount+' )' );
                $(list).find('#btn-print').attr( 'onclick', 'print_payments_sheet("'+reval.code+'", "'+reval.name+'");' );   
                
                $('.user_list').append(list);
            });
        }
    });
}

function close_agent_group_popup(){
    $('#agent-grp-dialog').dialog('destroy');
    $('#agent-grp-dialog').hide();
}

function print_payments_sheet(code, route){
    var url = base_url + "boardingtripchart/agent-payment-sheet-print?ag="+code+'&date='+tc_date+'&route='+route;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}

function close_rto_popop(){
    $('#rto-field-dialog').dialog('destroy');
    $('#rto-field-dialog').hide();
}

function boarding_print_rto_chart(code) {
    $('#rto-field-dialog').css('background', '#fff');
    $('#rto-field-dialog').removeClass('hide');
    $('#rto-field-dialog').dialog({
        autoOpen: true,
        height: 450,
        width: 550,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();    
    
    $('.fare_opt').bind('change',function() {
        $('#rto-action').html('');
        if( $(this).val() == 1) {
            $('#manual_fare').addClass('hide');
        } else {
            $('#manual_fare').removeClass('hide');
            $('#fld_fare_value').focus();
        }
    });
    
    var t = ($.cookie("rtofields"))? JSON.parse($.cookie("rtofields")) :{};
    
    if(t.booked_at==0) $('#fld_booked_at').attr('checked', false);
    if(t.booked_by==0) $('#fld_booked_by').attr('checked', false);
    if(t.pass_name==0) $('#fld_pass_name').attr('checked', false);
    if(t.pass_age==0) $('#fld_pass_age').attr('checked', false);
    if(t.pass_gender==0) $('#fld_pass_gender').attr('checked', false);
    if(t.pass_contact==0) $('#fld_pass_contact').attr('checked', false);
    if(t.from_station==0) $('#fld_from').attr('checked', false);
    if(t.to_station==0) $('#fld_to').attr('checked', false);
    if(t.boarding_pt==0) $('#fld_boarding_pt').attr('checked', false);
    if(t.booked_type==0) $('#fld_booked_type').attr('checked', false);
    if(t.booked_at==0) $('#fld_booked_at').attr('checked', false);
    if(t.booked_at==0) $('#fld_booked_at').attr('checked', false);
    
    if(t.fare==1) {
        $('#fld_fare1').attr('checked', true);
        $('#manual_fare').addClass('hide');
    } else if(t.fare==2) {
        $('#fld_fare2').attr('checked', true);
        $('#manual_fare').removeClass('hide');
        $('#fld_fare_value').focus();
    }    
    if(t.print_size==1) { 
        $('#fld_size1').attr('checked', true); 
    } else if(t.print_size==2) {
        $('#fld_size2').attr('checked', true);
    }
    
}

function print_rto_chart() {
    $('#rto-action').html('');
    var data = {};
    data.booked_at = $('#fld_booked_at').is(':checked') ? 1 : 0;
    data.booked_by = $('#fld_booked_by').is(':checked') ? 1 : 0;
    data.pass_name = $('#fld_pass_name').is(':checked') ? 1 : 0;
    data.pass_age = $('#fld_pass_age').is(':checked') ? 1 : 0;
    data.pass_gender = $('#fld_pass_gender').is(':checked') ? 1 : 0;
    data.pass_contact = $('#fld_pass_contact').is(':checked') ? 1 : 0;
    data.from_station = $('#fld_from').is(':checked') ? 1 : 0;
    data.to_station = $('#fld_to').is(':checked') ? 1 : 0;
    data.boarding_pt = $('#fld_boarding_pt').is(':checked') ? 1 : 0;
    data.booked_type = $('#fld_booked_type').is(':checked') ? 1 : 0;
    data.fare = $("input[name='fld_fare']:checked"). val();    
    data.manual_fare = $('#fld_fare_value').val();
    data.print_size = $("input[name='fld_size']:checked"). val();
    if(data.fare==1) data.manual_fare = 0;
    else {
        if(data.manual_fare=="") {
            $('#rto-action').html('<div class="alert alert-danger">Fare should be 601 to 2500</div>');
            $('#fld_fare_value').focus();
            return false;
        } else if(parseInt(data.manual_fare)<= 600 || parseInt(data.manual_fare) > 2500) {
            $('#rto-action').html('<div class="alert alert-danger">Fare should be 601 to 2500</div>');
            $('#fld_fare_value').focus();
            return false;
        }
    }    
    
    $.cookie("rtofields", JSON.stringify(data), { expires: 365 });
    
    var url = base_url + "boardingtripchart/boarding-trip-chart-list?rto=1&print=1&tc="+trip_code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
    
    close_rto_popop();
}

function print_rto_without_via() {
    var data = {};
    data.booked_at = $('#fld_booked_at').is(':checked') ? 1 : 0;
    data.booked_by = $('#fld_booked_by').is(':checked') ? 1 : 0;
    data.pass_name = $('#fld_pass_name').is(':checked') ? 1 : 0;
    data.pass_age = $('#fld_pass_age').is(':checked') ? 1 : 0;
    data.pass_gender = $('#fld_pass_gender').is(':checked') ? 1 : 0;
    data.pass_contact = $('#fld_pass_contact').is(':checked') ? 1 : 0;
    data.from_station = $('#fld_from').is(':checked') ? 1 : 0;
    data.to_station = $('#fld_to').is(':checked') ? 1 : 0;
    data.boarding_pt = $('#fld_boarding_pt').is(':checked') ? 1 : 0;
    data.booked_type = $('#fld_booked_type').is(':checked') ? 1 : 0;
    data.fare = $("input[name='fld_fare']:checked"). val();    
    data.manual_fare = $('#fld_fare_value').val();
    data.print_size = $("input[name='fld_size']:checked"). val();
    if(data.fare==1) data.manual_fare = 0;
    $.cookie("rtofields", JSON.stringify(data), { expires: 365 });
    
    var url = base_url + "boardingtripchart/boarding-trip-chart-list?rto=1&novia=1&print=1&tc=" + trip_code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");

    close_rto_popop();
}