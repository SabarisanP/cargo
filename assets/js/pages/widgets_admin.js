function editWidgets(option) {
    $('#txt_am_name').removeClass('inp_error');
    $('#amenit-dialog').css('background', '#fff');
    $('#amt-form-bttons').show();
    $('#amenit-dialog').show();
    $('#amenit-dialog').removeClass('hide');

    $('#amenit-dialog').dialog({
        autoOpen: true,
        width: 600,
        maxWidth: 600,
        height: 350,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();

    $('#amt-form-bttons').show();
    $('#amenit-dialog').show();
    $('#amenit-dialog').removeClass('hide');
    $('#usr-action-state').html('');
    $('#usr-action-state').hide();


    $('#txt_am_name,#aid_am_code').val('');
    if (_isdefined(option)) {        
        $('#txt_am_name').val(option.name);
        $('#txt_am_calback').val(option.callbackFunction);
        $('#sel_am_status').val(option.activeFlag);
        $('#aid_am_code').val(option.code);
    } else {
        $('#new_amenities').val(1);
        $('#txt_am_name').val("");
        $('#txt_am_calback').val("");
        $('#sel_am_status').val("");
        $('#aid_am_code').val("");
    }
    
}
function saveWidgets() {
    var data = {};
    data.activeFlag = 1;
    data.name = $('#txt_am_name').val();
    data.callback = $('#txt_am_calback').val();
    data.code = $('#aid_am_code').val();
    
    var err = 0;
    if (data.name == '') {
        $('#txt_am_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_am_name').removeClass('inp_error');
    }
    
    if (data.callback == '') {
        $('#txt_am_calback').addClass('inp_error');
        err++;
    } else {
        $('#txt_am_calback').removeClass('inp_error');
    }

    if (err > 0) {
        $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state').html('Please enter the values in the field that are marked in red');
        $('#usr-action-state').show();
        return false;
    } else {
        $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state').html('');
        $('#usr-action-state').hide();
    }


    $('#amt-form-bttons').hide();
    $('#usr-action-state').html(loading_popup);
    $('#usr-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-widgets-admin",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('.er_msg').addClass('hide');
                $('#usr-action-state').show();
                $('#usr-action-state').removeClass('alert-danger');
                $('#usr-action-state').addClass('alert-success');

                $('#usr-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelAmAddEdit();
                    checkURL();
                    return;
                }, 2000);
            } else {
                $('#usr-action-state').show();
                $('#usr-action-state').addClass('alert-error');
                $('#usr-action-state').html(response.errorDesc);
                $('#amt-form-bttons').show();
                window.setTimeout(function() {
                    $('#usr-action-state').hide();
                    $('#amt-form-bttons').show();
                }, 3000);
            }
        }
    })
}
function cancelAmAddEdit() {
    $('#usr-action-state').hide();
    $('#amenit-dialog').dialog('destroy');
    $('#amenit-dialog').hide();
}


function deleteWidgets(am_code, am_name) {
    if (confirm('Do you want to delete this widget?')) {
        var data = {};
        data.activeFlag = 2;
        data.code = am_code;
    
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-widgets-admin",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#am-' + am_code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
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
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}
function editWidgetStatus(am_code, am_name) {
    var data = {};
    data.code = am_code;
    data.name = am_name;
    data.activeFlag = $('#sta-' + am_code).attr('data-status');
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-widgets-admin",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                var chg = data.activeFlag == 1 ? 0 : 1;
                $('#sta-' + am_code).attr('data-status', chg);
                if ($('#sta-' + am_code).attr('data-status') == 1) {
                    $('#at_edt_' + am_code).hide();
                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-check');
                    $('#lb-' + am_code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#at_edt_' + am_code).show();
                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-times');
                    $('#lb-' + am_code).removeClass('label-danger').addClass('label-success').html('Active');

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