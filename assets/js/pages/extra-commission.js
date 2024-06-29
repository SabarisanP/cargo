//$('.selectpicker').selectpicker();

function editCommission(option) {
    //$('#group').trigger('click');
    $('#commission-dialog').css('background', '#fff');
    $('#commission-dialog').removeClass('hide');
    $('#commission-dialog').dialog({
        autoOpen: true,
        height: 550,
        width: 850,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#comm-form-bttons').show();
    $('#comm-form-action-state').html('');
    $('#comm-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    
    $('#schedule').multiselect("deselectAll", false).multiselect("refresh");
    $('#route').multiselect("deselectAll", false).multiselect("refresh");
    
    $('#schedule').multiselect('destroy');
    $('#route').multiselect('destroy');
        
    $('#schedule').multiselect({
        maxHeight: 300,
        numberDisplayed: 1,
        enableFiltering: true,
        buttonWidth: '200px',
    });
    $('#route').multiselect({
        maxHeight: 300,
        numberDisplayed: 1,
        enableFiltering: true,
        buttonWidth: '200px',
        dropRight: true
    });

    if (_isdefined(option)) {
        $('#code').val(option.code);
        
        var strWard = [];
        if( _isdefined(option.schedule) ) {
            $.each(option.schedule, function (keys, values) {
                strWard.push(values.code);
            });
            $('#schedule').multiselect('select', strWard);
        }
        
        var r = [];
        if( _isdefined(option.route) ) {
            $.each(option.route, function (keys, values) {
                r.push(values.code);
            });
            $('#route').multiselect('select', r);
        }

        $('#name').val(option.name);
        $('#date_comm').val(option.activeFrom + ' | ' + option.activeTo);
        $('#comm_value').val(option.commissionValue);
        if (option.commissionValueType.code == "PER") {
            $('#disc_type').prop("checked", true);
            $('#per').show();
            $('#rs').hide();
        } else {
            $('#disc_type').attr('checked', false);
            $('#per').hide();
            $('#rs').show();
        }
        $('input[name=comm_date][value=' + option.dateType + ']').prop("checked", true);
        $('#role').val(option.roleType);

        if (option.roleType == 'UR') {
            $('#select').hide();
            $('#select_usr').show();
            $('#user').val(option.user.code);
        } else if (option.roleType == 'GR' && option.group != '' && option.group != null) {
            $('#select').show();
            $('#select_usr').hide();
            $('#group').val(option.group.code);
        } else {
            $('#select').show();
            $('#select_usr').hide();
            $('#group').val('all');
        }

        $('#exp-weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = option.dayOfWeek;
        var res = str.split("");
        $("input[name='station-point-weeks-comm']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }
        });
        
        $('#ec_min_seat_count').val(option.minSeatCount);
        $('#ec_min_ticket_fare').val(option.minTicketFare);
        $('#max_comission_limit').val(option.maxCommissionLimit);
        $('#max_xtr_comm_amt').val(option.maxExtraCommissionAmount);
        $('#slab_id').val(option.commissionSlab && option.commissionSlab.code);  
        $('#over-base-comm').prop('checked', option.overrideCommissionFlag == 1);

    } else {
        $('#code').val('');
        $('#name').val('');
        $('#schedule').val('');
        $('#date_comm').val('');
        $('#group').val('all');
        $('#comm_value').val('');
        $('#exp-weekdays').find("input[name='station-point-weeks-comm']").each(function (i) {
            $(this).attr("checked", "checked"); //.addClass('active');        
            $(this).parent().addClass('active');
        });
        $('#disc_type').prop("checked", true);
        $('input[name=comm_date][value=TXN]').prop("checked", true);
        $('#role').val('GR');
        $('.selectpicker').selectpicker('refresh');
        
        $('#ec_min_seat_count').val('');
        $('#ec_min_ticket_fare').val('');
        $('#max_comission_limit').val('');
        $('#max_xtr_comm_amt').val('');
        $('#slab_id').val('');
        $('#over-base-comm').prop('checked', true);
    }
}

$('#disc_type').change(function () {
    if (this.checked) {
        $('#per').show();
        $('#rs').hide();
    }
    else {
        $('#per').hide();
        $('#rs').show();
    }
});

function saveCommission() {
    var data = {};

    data.name = $('#name').val();
    data.schedule = $('#schedule').val();
    data.route = $('#route').val();
    var dateDisc = $('#date_comm').val();
    var date = dateDisc.split('|');
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.dayOfWeek = $("input[name='station-point-weeks-comm']").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.comm_date = $('#comm_date:checked').val();
    data.comm_value = $('#comm_value').val();
    data.percentageFlag = $('#disc_type:checked').val() ? 1 : 0;
    data.role = $('#role').val();
    data.code = $('#code').val();
    data.overrideCommissionFlag = +$('#over-base-comm').is(':checked');

    if (data.role == 'UR') {
        data.user = $('#user').val();
    } else if (data.role == 'GR') {
        data.group = $('#group').val();
        if (data.group == 'all') {
            data.group = '';
        }
    }
    
    data.min_seat_count = $('#ec_min_seat_count').val();
    data.min_ticket_fare = $('#ec_min_ticket_fare').val();
    data.max_commission_limit = $('#max_comission_limit').val();
    data.max_xtr_com_amt = $('#max_xtr_comm_amt').val();
    data.slab_id = $('#slab_id').val();
    
    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }

//    if ($('#schedule').val() == '' || $('#schedule').val() == null) {
//        $('.show-tick').addClass('inp_error');
//        err++;
//    } else {
//        $('.show-tick').removeClass('inp_error');
//    }

    if ($('#date_comm').val() == '') {
        $('#date_comm').addClass('inp_error');
        err++;
    } else {
        $('#date_comm').removeClass('inp_error');
    }
    if ($('#comm_value').val() == '') {
        $('#comm_value').addClass('inp_error');
        err++;
    } else {
        $('#comm_value').removeClass('inp_error');
    }


    if (err > 0) {
        $('#comm-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#comm-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#comm-form-action-state').show();
        return false;
    } else {
        $('#comm-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#comm-form-action-state').hide();
    }

    if (data.role == 'UR')
    {
        if (data.user == '') {
            $('#comm-form-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#comm-form-action-state').html('Please select user');
            $('#user').addClass('inp_error');
            $('#comm-form-action-state').show();
            return false;
        } else {
            $('#user').removeClass('inp_error');
        }
    }



    $('#comm-form-bttons').hide();
    $('#comm-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#comm-form-action-state').html(loading_popup);
    $('#comm-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-extra-commission",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#comm-form-bttons').hide();
                $('#comm-form-action-state').removeClass('alert-danger');
                $('#comm-form-action-state').addClass('alert-success');
                $('#comm-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelCommission();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#comm-form-action-state').addClass('alert-error');
                $('#comm-form-action-state').html(response.errorDesc);
                $('#comm-form-bttons').show();
            }
        }
    })
}


function cancelCommission() {
    $('#commission-dialog').dialog('destroy');
    $('#commission-dialog').hide();
}

//
//$('#group').on('click', function () {
//    $('#select').html(loading_small);
//    $.ajax({
//        type: "POST",
//        dataType: 'html',
//        url: base_url + "config/get-commission-group",
//        data: '',
//        success: function (response) {
//            if (response) {
//                $('#select').html(response);
//            }
//        }
//    });
//});

$('#role').on('change', function () {
    if (this.value == 'UR') {
        $('#select').hide();
        $('#select_usr').show();
        $('#user').val('');
    } else if (this.value == 'GR') {
        $('#select').show();
        $('#select_usr').hide();
        $('#group').val('all');
    }
});


function deleteCommission(opt) {
    if (confirm('Do you want to delete this extra commission ?')) {
        var data = {}
        data.code = opt.code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-extra-commission",
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
        })
    }
}

function CommExceptionDialog(code, exc_code, name, from, to, week) {
    $('#comm-exp-form-buttons').show();
    $('#comm-exp-form-action-state').html('');
    $('#comm-exp-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#comm-exception-dialog').css('background', '#fff');
    $('#comm-exception-dialog').removeClass('hide');
    $('#comm-exception-dialog').show();
    $('#comm-exception-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 500,
        modal: true,
        resizable: false
    });
    $('#commission_code').val(code);

    if (code != '' && exc_code != undefined) {
        $('#comm_exp_disc_name').val(name);
        $('#comm_exp_code').val(exc_code);
        $('#comm_exp_disc_date').val(from + ' | ' + to);
        $('#exp-disc-weekdays').find('.active').removeClass('active').removeAttr("checked");
        var str = week;
        var res = str.split("");
        $("input[name='exp-week-comm']").each(function (i) {
            if (res[i] == 1) {
                $(this).attr("checked", "checked");//.addClass('active');
                $(this).parent().addClass('active');
            }
        });

    } else {
        $('#comm_exp_disc_name').val('');
        $('#comm_exp_code').val('');
        $('#comm_exp_disc_date').val('');
        $('#exp-disc-weekdays').find("input[name='exp-week-comm']").each(function (i) {
            $(this).attr("checked", "checked");//.addClass('active');        
            $(this).parent().addClass('active');
        });
    }


    $(".ui-dialog-titlebar").hide();
}
function cancelCommissionExceptionDialog() {
    $('#comm-exception-dialog').dialog('destroy');
    $('#comm-exception-dialog').hide();
}

function saveCommissionException() {

    var data = {};

    var dateExp = $('#comm_exp_disc_date').val();
    var date = dateExp.split('|');
    var data = {}

    data.name = $('#comm_exp_disc_name').val();
    data.dayOfWeek = $("input[name='exp-week-comm']").map(function () {
        return +$(this).is(':checked');
    }).get();
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    data.commissionCode = $('#commission_code').val();
    data.code = $('#comm_exp_code').val();

    var err = 0;
    if ($('#comm_exp_disc_name').val() == '') {
        $('#comm_exp_disc_name').addClass('inp_error');
        err++;
    } else {
        $('#comm_exp_disc_name').removeClass('inp_error');
    }

    if ($('#comm_exp_disc_date').val() == '') {
        $('#comm_exp_disc_date').addClass('inp_error');
        err++;
    } else {
        $('#comm_exp_disc_date').removeClass('inp_error');
    }


    if (err > 0) {
        $('#comm-exp-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#comm-exp-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#comm-exp-form-action-state').show();
        return false;
    } else {
        $('#comm-exp-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#comm-exp-form-action-state').hide();
    }


    $('#comm-exp-form-buttons').hide();
    $('#comm-exp-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#comm-exp-form-action-state').html(loading_popup);
    $('#comm-exp-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-extra-commission-exception",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#comm-exp-form-buttons').hide();
                $('#comm-exp-form-action-state').removeClass('alert-danger');
                $('#comm-exp-form-action-state').addClass('alert-success');
                $('#comm-exp-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelCommissionExceptionDialog();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#comm-exp-form-action-state').show();
                $('#comm-exp-form-action-state').addClass('alert-danger');
                $('#comm-exp-form-action-state').html(response.errorDesc);
                $('#comm-exp-form-buttons').show();
            }
        }
    })
}


function viewCommissionExceptionOverride(e, code) {
    var source = e.target || e.srcElement;
    if (source.nodeName != "TD")
        return;
    $('.station-sch-exp-' + code + ',.station-sch-ove-' + code).toggle('slow');
    $('#stationExcTab-' + code).toggle('slow');
    $('#stationExceTab-' + code).toggle('slow');

}

function deleteCommExceptionDialog(code, exp_code) {
    if (confirm('Do you want to delete this commission exception?')) {
        var data = {}
        data.commission_code = code;
        data.code = exp_code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-extra-commission-exception",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        checkURL();
                    }, 3000);
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