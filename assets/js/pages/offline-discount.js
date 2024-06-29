function init_offline_discount_page() {
    $(".xtr_groups").popover({
        placement : 'top', 
        html: 'true',
        trigger : "hover",
        content : function() {
            var c = $(this).attr('data-code');
            var html = '<table width="300">';
            html += '<tr><td align="center"><b>Groups<b></td></tr>';
            $.each(discounts, function(keys, values) {
                if (values.code == c) {
                    grps = values.groupCode;
                    $.each(grps, function(i, grpcode) {
                        grpcode = $.trim(grpcode);
                        var ogroup = _.find(groups, function(o) { return o.code == grpcode; });  
                        html += '<tr><td align="center">'+ogroup.name+'</td></tr>';
                    });                        
                }
            });
            html += '</table>'; 
            return html;
        }    
    });
    
    $(".xtr_schedule").popover({
        placement : 'top', 
        html: 'true',
        trigger : "hover",
        content : function() {
            var c = $(this).attr('data-code');
            var html = '<table width="300">';
            html += '<tr><td align="center"><b>Schedules<b></td></tr>';
            $.each(discounts, function(keys, values) {
                if (values.code == c) {
                    schcodes = values.scheduleCode;
                    $.each(schcodes, function(i, schcode) {
                        schcode = $.trim(schcode);
                        var sch = _.find(schedules, function(o) { return o.code == schcode; });  
                        html += '<tr><td align="center">'+sch.name+'</td></tr>';
                    });                        
                }
            });
            html += '</table>'; 
            return html;
        }    
    });
    
    $(".xtr_route").popover({
        placement : 'top', 
        html: 'true',
        trigger : "hover",
        content : function() {
            var c = $(this).attr('data-code');
            var html = '<table width="300">';
            html += '<tr><td align="center"><b>Routes<b></td></tr>';
            $.each(discounts, function(keys, values) {
                if (values.code == c) {
                    rcodes = values.routeCode;
                    $.each(rcodes, function(i, schcode) {
                        rcode = $.trim(schcode);
                        rcode = rcode.split('-');
                        
                        var route = _.find(routes, function(o) { return o.fromStation.code == rcode[0] && o.toStation.code == rcode[1]; });  
                        html += '<tr><td align="center">'+route.name+'</td></tr>';
                    });                        
                }
            });
            html += '</table>'; 
            return html;
        }    
    });
}

function deleteOfflineDiscount(code) {
    var obj = _.find(discounts, function(o) { return o.code == code; });
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
            url: base_url + "config/delete-offline-discount",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        checkURL();
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

function showOfflineDiscountDialog(opt) {
    $('#od-disc-form-buttons').show();
    $('#od-disc-form-action-state').html('');
    $('#od-disc-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#offline-discount-dialog').css('background', '#fff');
    $('#offline-discount-dialog').removeClass('hide');
    $('#offline-discount-dialog').show();
    
    $('#offline-discount-dialog').dialog({
        autoOpen: true,
        height: 550,
        width: 750,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    $('#od_groups').multiselect({
        maxHeight: 300,
        numberDisplayed: 1,
        buttonWidth: '200px',
    });
    
    $('#od_schedules').multiselect({
        maxHeight: 300,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropRight: true
    });
    
    $('#od_routes').multiselect({
        maxHeight: 300,
        numberDisplayed: 1,
        buttonWidth: '200px',
    });
    
    if (opt != '') {
        var obj = _.find(discounts, function(o) { return o.code == opt; });        
        
        $('#od_name').val(obj.name);
        $('#od_date_range').val(obj.activeFrom + ' | ' + obj.activeTo);       
        $('#od-weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = obj.dayOfWeek;
        var res = str.split("");
        $("input[name='od_day_of_weeks']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }

        });
        
        $('#od_disc_value').val(obj.value);
        if (obj.percentageFlag == true) {
            $('#od_disc_type').attr('checked', true);
        } else {
            $('#od_disc_type').attr('checked', false);
        }        
        $('input[name=od_date_type][value=' + obj.travelDateFlag + ']').prop("checked", true);
        
        $.each(obj.groupCode, function(i, grpcode) {
            grpcode = $.trim(grpcode);
            $('option[value="'+grpcode+'"]', $('#od_groups')).prop('selected', true);
        }); 
        $('#od_groups').multiselect('refresh');
        
        $.each(obj.routeCode, function(i, code) {
            code = $.trim(code);
            $('option[value="'+code+'"]', $('#od_routes')).prop('selected', true);
        }); 
        $('#od_routes').multiselect('refresh');
        
        $.each(obj.scheduleCode, function(i, code) {
            code = $.trim(code);
            $('option[value="'+code+'"]', $('#od_schedules')).prop('selected', true);
        }); 
        $('#od_schedules').multiselect('refresh');
        
        
        $('#od_ticket_fare').val(obj.minTicketFare);
        $('#od_min_seat_count').val(obj.minSeatCount);
        $('#od_max_discount_amount').val(obj.maxDiscountAmount);
        
        $('#od_code').val(obj.code);
    }
    else {
        $('#od_name').val('');
        $('#od_date_range').val('');
        $('#od-weekdays').find("input[name='od_day_of_weeks']").each(function (i) {
            $(this).attr("checked", "checked");//.addClass('active');        
            $(this).parent().addClass('active');
        });
        
        $('#od_disc_value').val('');        
        $('#od_disc_type').attr('checked', false);
        $('input[name=od_data_type][value=true]').prop("checked", true);
        
        $('#od_groups').val('');        
        $('#od_schedules').val('');     
        $('#od_routes').val('');     
                
        $('#od_ticket_fare').val('');
        $('#od_min_seat_count').val('');
        $('#od_max_discount_amount').val('');
        $('#od_code').val('');
    }
}

function cancelOfflineDiscountDialog() {
    $('#offline-discount-dialog').dialog('destroy');
    $('#offline-discount-dialog').hide();
}

function saveOfflineDiscount() {
    var data = {};

    var dateRange = $('#od_date_range').val();
    var date = dateRange.split('|');

    data.name = $.trim($('#od_name').val());
    data.dayOfWeek = $("input[name='od_day_of_weeks']").map(function () {
        return +$(this).is(':checked');
    }).get();    
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    
    data.discountValue = $.trim($('#od_disc_value').val());
    data.dateFlag = $('#od_date_type:checked').val();
    data.percentageFlag = $('#od_disc_type:checked').val() ? 'true' : 'false';
    
    data.group = $('#od_groups').val();
    data.scheduleCode = $('#od_schedules').val();
    data.routeCode = $('#od_routes').val();
    
    data.minFare = $.trim($('#od_ticket_fare').val());
    data.minSeat = $.trim($('#od_min_seat_count').val());
    data.maxDiscountAmount = $.trim($('#od_max_discount_amount').val());
    
    data.code = $('#od_code').val();
    
    var err = 0;
    if (data.name == '') {
        $('#od_name').addClass('inp_error');
        err++;
    } else {
        $('#od_name').removeClass('inp_error');
    }

    if (dateRange == '') {
        $('#od_date_range').addClass('inp_error');
        err++;
    } else {
        $('#od_date_range').removeClass('inp_error');
    }

    if (data.discountValue == '') {
        $('#od_disc_value').addClass('inp_error');
        err++;
    } else {
        $('#od_disc_value').removeClass('inp_error');
    }
    if (data.dateFlag == '') {
        $('#od_disc_type').addClass('inp_error');
        err++;
    } else {
        $('#od_disc_type').removeClass('inp_error');
    }

    if (err > 0) {
        $('#od-disc-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#od-disc-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#od-disc-form-action-state').show();
        return false;
    } else {
        $('#od-disc-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#od-disc-form-action-state').hide();
    }


    $('#od-disc-form-buttons').hide();
    $('#od-disc-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#od-disc-form-action-state').html(loading_popup);
    $('#od-disc-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-offline-discount",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#od-disc-form-buttons').hide();
                $('#od-disc-form-action-state').removeClass('alert-danger');
                $('#od-disc-form-action-state').addClass('alert-success');
                $('#od-disc-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelOfflineDiscountDialog();
                    checkURL();
                }, 3000);
            } else {
                $('#od-disc-form-action-state').show();
                $('#od-disc-form-action-state').addClass('alert-danger');
                $('#od-disc-form-action-state').html(response.errorDesc);
                $('#od-disc-form-buttons').show();
            }
        }
    })
}