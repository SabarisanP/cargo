function saveDeviceDialog(option) {

    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger').hide();
    $('.edt_hide').show();

    var heig = 350;

    $('#btn-save').attr("onclick", "saveDevice()");
    $('.edt_hide').show();

    $('#name').val('');
    $('#service').val('');
    $('#form-buttons').show();

    $('#provider-dialog').dialog({
        autoOpen: true,
        height: heig,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    if (option.code != '') {
        // new_name = $('#am-' + option.code).find('.sp_name a').html();
        //var Sname_c = $('#am-' + option.code).find('.sp_name1').html();
        //var token_c = $('#am-' + option.code).find('.sp_token1').html();
        var cid = option.code;
        $('#name').val(option.name);
        $('#service').val(option.remarks);
        $('#token').val(option.token);
        $('#hid_provider_code').val(cid);
    }

    $(".ui-dialog-titlebar").hide();
}
function saveAuthDialog(code, name, payment, providercode) {

    var heig = 460;
    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state1').removeClass('alert-success').removeClass('alert-danger').hide();
    $('.edt_hide').show();
    $('#btn-save').attr("onclick", "saveParter()");
    $('.edt_hide').show();
    $('#form-buttonss').show();



    $('#partner-dialog').dialog({
        autoOpen: true,
        height: heig,
        width: 500,
        modal: true,
        resizable: false
    });
    if (code) {
        $('#part_name').val(name);
        $('#part_mode').val(payment);
        $('#partner_code').val(code);
        $('#pro_code').val(providercode);
    } else {        
        $('#part_mode').val('UR');
        $('#partner_code').val('');
        $('#pro_code').val('');

    }

    $(".ui-dialog-titlebar").hide();
    $(".ui-dialog-titlebar").hide();
}


function saveDevice() {

    var data = {};

    data.name = $('#name').val();
    data.remarks = $('#service').val();
    data.token = $('#token').val();
    data.code = $('#hid_provider_code').val();
    

    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
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

    $('#form-buttons').hide();
    $('#ur-form-loadings').html(loading_popup);
    $('#ur-form-loadings').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "device/update",
        data: data,
        success: function(response) {
            if (response.status == 1) {                
                window.setTimeout(function() {
                    cancelDeviceDialog();
                    checkURL();
                }, 3000);

            } else {
                $('#ur-form-loadings').html('');
                $('#ur-form-loadings').hide();
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-action-state').html(response.errorDesc);
                $('#usr-action-state').show();
                $('#form-buttons').show();
            }
        }
    });
}
function cancelDeviceDialog() {
    $('#provider-dialog').dialog('destroy');
    $('#provider-dialog').hide();
}
function cancelPartner() {
    $('#partner-dialog').dialog('destroy');
    $('#partner-dialog').hide();
}
function editDeviceStatus(am_code, am_name) {
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
        url: base_url + "device/disable",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                var chg = data.activeFlag == 1 ? 0 : 1;
                $('#sta-' + am_code).attr('data-status', chg);
                if ($('#sta-' + am_code).attr('data-status') == 1) {
                    $('#edt_pro_'+am_code).hide();
                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-check');
                    $('#lb-' + am_code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#edt_pro_'+am_code).show();
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

function generateDeviceOtp(device_code) {
    var data = {};
    data.deviceCode = device_code;

    $('#device-otp-dialog').css('background', '#fff');
    $('#device-otp-dialog').show();
    $('#device-otp-dialog').removeClass('hide');
    $('#device-otp-dialog').dialog({
        autoOpen: true,
        width: 400,
        maxWidth: 600,
        height: 250,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    
    $('#dev-otp-form').hide();
    $('#dev-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#dev-otp-action-state').html(loading_popup);
    $('#dev-otp-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "device/generate-device-otp",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#dev-otp-action-state').hide();

                $('#dev-otp-form').show();
                $('#dev-otp-code').html(response.data.code);
            } else {
                $('#dev-otp-action-state').show();
                $('#dev-otp-action-state').addClass('alert-error');
                $('#dev-otp-action-state').html(response.errorDesc);
                $('#dev-otp-form').hide();
            }
        }
    });
}

function closeDevOtp() {
    $('#device-otp-dialog').dialog('destroy');
    $('#device-otp-dialog').hide();
}

function deleteDevice(am_code, am_name, am_service) {
    if (confirm('Do you want to delete this device?')) {
        var data = {};
        data.code = am_code;
        data.name = am_name;
        data.serviceName = am_service;
        /* $('#action-status').html(loading_popup);
         $('#action-status').show();*/
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "device/delete",
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
        });
    }
}

var commission = {};
function getAuthList(code) {
    $('#usr-viw-rslt').html('<div align="left">' + loading_big + '</div>');
    $('.li_bk').addClass('li_bk');
    var data = {};
    data.code = code;
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "device/get-auth",
        data: data,
        async: true,
        success: function(response) {
            $('#hid_device_code').val(code);
            $('#usr-viw-rslt').html(response);
        }
    });
    
}

function setAuthType(type) {
    $('.pane_user').addClass('hide');
    $('.pane_group').addClass('hide');
    if(type=='UR') {
        $('.pane_user').removeClass('hide');
    } else {
        $('.pane_group').removeClass('hide');
    }
}

function saveAuth() {

    var data = {};
    // data.activeFlag = $('#usr_status').val();
    data.part_user = $('#part_user').val();
    data.part_group = $('#part_group').val();
    data.part_mode = $('#part_mode').val();
    data.device_code = $('#hid_device_code').val();
    data.activeFlag = 1;

    var err = 0;

   
    if (data.part_mode == "UR" && $('#part_user').val() == '') {
        $('#part_user').addClass('inp_error');
        err++;
    } else {
        $('#part_user').removeClass('inp_error');
    }
    
    if (data.part_mode == "GR" && $('#part_group').val() == '') {
        $('#part_group').addClass('inp_error');
        err++;
    } else {
        $('#part_group').removeClass('inp_error');
    }


    if (err > 0) {
        $('#usr-action-state1').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state1').html('Please enter/select the values in the field that are marked in red');
        $('#usr-action-state1').show();
        return false;
    } else {
        $('#usr-action-state1').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state1').html('');
        $('#usr-action-state1').hide();
    }
    
    $('#form-buttonss').hide();
    $('#ur-form-loading').html(loading_popup);
    $('#ur-form-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "device/save-auth",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-form-loading').hide();
                $('#ur-form-loading').html('');
                $('#usr-action-state1').removeClass('alert-danger').addClass('alert-success');
                $('#usr-action-state1').show();
                $('#usr-action-state1').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelPartner();
                    $('#pro-viw-' + data.device_code).trigger("click");
                }, 3000);

            } else {
                $('#ur-form-loading').html('');
                $('#ur-form-loading').hide();
                $('#usr-action-state1').removeClass('alert-success').addClass('alert-danger');
                $('#usr-action-state1').html(response.errorDesc);
                $('#usr-action-state1').show();
                $('#form-buttonss').show();
            }
        }
    });
}



function deleteAuthDevice(code) {
    if (confirm('Do you want to delete this auth?')) {
        var data = {}
        data.code = code;
        data.activeFlag = 9;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "device/delete-auth",
            data: data,
            success: function(response) {
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
                    getAuthList( $('#hid_device_id').val() );
                }, 2000);
            }
        })
    }
}