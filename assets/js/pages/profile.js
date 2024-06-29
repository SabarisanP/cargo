function saveProfile() {
    var data = {};
    var err = 0;
    data.activeFlag = 1;
    data.name = $('#e_name').val();
    data.code = $('#e_code').val();
    data.pin = $('#e_pin').val();
    data.timeFormat = $('#tme_for').val();
	
    data.state = $('#ecs_state').val();
    data.reschedulable = $.map($('#nsp_reschedule').val() || [], function(val) {
	return { code: val };
    });
    data.sharetriplist = $.map($('#nsp_sharetripslist').val() || [], function(val) {
	return { code: val };
    });
    data.sharetripchart = $.map($('#nsp_sharetripchart').val() || [], function(val) {
	return { code: val };
    });
    data.sharetripchartallpax = $.map($('#nsp_sharetripchartallpax').val() || [], function(val) {
	return { code: val };
    });
    
    data.expirePasswordGroup = $.map($('#exp_pwd_grp').val() || [], function(val) {
    return { code: val };
    });
    
    data.otpVerifyGroup = $.map($('#otp_verify_grp').val() || [], function(val) {
    return { code: val };
    });
    
    if (data.name == '') {
        $('#e_name').addClass('inp_error');
        err++;
    }
    else {
        $('#e_name').removeClass('inp_error');
    }

    if (data.pin == '') {
        $('#e_pin').addClass('inp_error');
        err++;
    }
    else {
        $('#e_pin').removeClass('inp_error');
    }

    $('#ecs_state').removeClass('inp_error');
    if (data.state == '') {
        $('#ecs_state').addClass('inp_error');
        err++;
    }
    
    if ($('input[name=ph_bkg]:checked').val() == undefined) {
        data.phoneBookingflag = false;
    }
    else {
        data.phoneBookingflag = true;
    }
    
//    if ($('input[name=sms_chk]:checked').val() == undefined) {
//        data.smsNotificationFlag = false;
//    }
//    else {
//        data.smsNotificationFlag = true;
//    }
    
    data.smsNotificationFlag = $("#smsnotification label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
	
	data.emailNotificationFlagCode = $("#emailnotification label").map(function () {
        return +($(this).hasClass("active"));
    }).get();
	
    data.timeFormat = $('#tme_for').val();
    if (data.timeFormat == '') {
        $('#tme_for').addClass('inp_error');
        err++;
    }
    else {
        $('#tme_for').removeClass('inp_error');
    }
    
    if ($('input[name=drop]:checked').val() == undefined) {
        data.droppingPointRequriedFlag = false;
    }
    else {
        data.droppingPointRequriedFlag = true;
    }
   if ($('input[name=drop]:checked').val() == undefined) {
       data.droppingPointRequriedFlag = false;
   }
   else {
       data.droppingPointRequriedFlag = true;
   }

    data.dateFormate = $('#date_for').val();
    if (data.dateFormate == '') {
        $('#date_for').addClass('inp_error');
        err++;
    } else {
        $('#date_for').removeClass('inp_error');
    }
    data.shortCode = $('#shortcode').val();
    if (data.shortCode == '') {
        $('#shortcode').addClass('inp_error');
        err++;
    }

    else if (!data.shortCode.match(/^[a-zA-Z]+$/)) {
        $('#shortcode').addClass('inp_error');
        err++;
        $('#usr-org-state').addClass('alert-danger');
        $('#usr-org-state').html('Please enter valid pnr code');
        return false;
    }
    else {
        $('#pnr').removeClass('inp_error');
    }
    data.domainURL = $('#url').val();
    if (data.domainURL == '') {
        $('#url').addClass('inp_error');
        err++;
    } else {
        $('#url').removeClass('inp_error');
    }
    data.whatsappProviderCode = $('#e_whatsappProviderCode').val();
    data.sendarMailName = $('#mail_name').val();

    data.whatsappNotificationFlagCode = $("#whatsappNotificationFlagCode label").map(function () {
        return +($(this).hasClass("active"));
    }).get();

    if (data.sendarMailName == '') {
        $('#mail_name').addClass('inp_error');
        err++;
    } else {
        $('#mail_name').removeClass('inp_error');
    }
    data.sendarSMSName = $('#sms_name').val();
    if (data.sendarSMSName == '') {
        $('#sms_name').addClass('inp_error');
        err++;
    } else {
        $('#sms_name').removeClass('inp_error');
    }
    data.smsSenderCode = $('#sms_code').val();
    if (data.smsSenderCode == '') {
        $('#sms_code').addClass('inp_error');
        err++;
    } else {
        $('#sms_code').removeClass('inp_error');
    }
    data.smsProviderCode = $('#sms_provider').val();
    data.instantCancellationMinitues = $('#ins_can_min').val();
    if (data.instantCancellationMinitues == '') {
        $('#ins_can_min').addClass('inp_error');
        err++;
    } else {
        $('#ins_can_min').removeClass('inp_error');
    }

    data.autoGenerateVoucherFlag = ( $('#auto_gen_voucher').is(":checked") ) ? 1 : 0;
    data.allowDirectLogin = ( $('#allow_direct_login').is(":checked") ) ? 1 : 0;
    
    
    data.supportNumber = $('#e_supportno').val().trim();    
    if (data.supportNumber == '') {
        $('#e_supportno').addClass('inp_error');
        err++;
    } else {
        $('#e_supportno').removeClass('inp_error');
    }
    
    data.city = $('#e_city').val();    
    data.pincode = $('#e_pincode').val();
    data.address = $('#e_address').val().trim();

    data.ewayBillVendorCode = $('#ewaybill-vendor').val();
    data.balanceOnManageExpense = [];
    data.notificationPreferences = $('#notification_mode').val();

    $.each($('#nsp_balanceOnManageExpense').val() || [], function (i, code) {
        data.balanceOnManageExpense.push({ code : code });
    });

    if (err > 0) {
        $('#usr-org-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-org-state').html('Please enter/select the values in the field that are marked in red');
        $('#usr-org-state').show();
        return false;
    } else {
        $('#usr-org-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-org-state').html('');
        $('#usr-org-state').hide();
    }

    $('#ur-org-loading').html(loading_popup);
    $.ajax({
        type: "POST",
        url: base_url + "profile/add-profile",
        data: data,
        dataType: "json",
        success: function (response) {
            if (response.status == 1) {
                $('#ur-org-loading').html('');
                $('#usr-org-state').show();
                $('#usr-org-state').removeClass('alert-danger');
                $('#usr-org-state').addClass('alert-success');
                $('#usr-org-state').html('Your request has been completed successfully');
                // $('#form-org-bttons').html('');
                window.setTimeout(function () {
                    $('#usr-org-state').hide();
                }, 3000);
            } else {
                $('#ur-org-loading').html('');
                $('#usr-org-state').show();
                $('#usr-org-state').removeClass('alert-success');
                $('#usr-org-state').addClass('alert-danger');
                $('#usr-org-state').html(response.errorDesc);
            }
        }
    });

}

function changePassword() {
    var data = {};

    data.oldpassword = $('#old-password').val();
    data.newpassword = $('#new-password').val();
    data.confirm = $('#confirm-password').val();
    var err = 0;
    if (data.oldpassword == '') {
        $('#old-password').addClass('inp_error');
        err++;
    } else {
        $('#old-password').removeClass('inp_error');
    }

    if (data.newpassword == '') {
        $('#new-password').addClass('inp_error');
        err++;
    } else {
        $('#new-password').removeClass('inp_error');
    }
    if (data.confirm == '') {
        $('#confirm-password').addClass('inp_error');
        err++;
    } else {
        $('#confirm-password').removeClass('inp_error');
    }

    if (err > 0) {
        $('#pwd-rps-loading').html('');
        $('#pwd-rps-loading').hide();
        $('#pwd-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#pwd-action-state').html('Please enter the values in the field that are marked in red');
        $('#pwd-action-state').show();
        return false;
    }

    if (data.newpassword.length < 6) {
        $("#new-password").addClass('inp_error');
        $('#pwd-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#pwd-action-state').html('Password should be minimum 6 charactors.');
        $('#pwd-action-state').show();
        return false;

    } else {
        $("#new-password").removeClass('inp_error');
        $('#pwd-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#pwd-action-state').html('');
        $('#pwd-action-state').hide();
    }
    if (data.newpassword != data.confirm) {
        $('#pwd-rps-loading').html('');
        $('#pwd-rps-loading').hide();
        $('#pwd-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#confirm-password').addClass('inp_error');
        $('#pwd-action-state').show();
        $('#pwd-action-state').html('Please enter the same password as above.');
        return false;
    } else {
        $('#pwd-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#confirm-password').removeClass('inp_error');
        $('#pwd-action-state').html('');
        $('#pwd-action-state').hide();
    }
    $('#pwd-form-bttons').hide();
    $('#fpwd-rps-loading').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "profile/change-password",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#pwd-form-bttons').hide();
                $('#pwd-action-state').show();
                $('#pwd-action-state').removeClass('alert-danger');
                $('#pwd-action-state').addClass('alert-success');

                $('#pwd-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {

                }, 3000);
            } else {
                $('#pwd-action-state').show();

                $('#pwd-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#pwd-action-state').html(response.errorDesc);
                $('#pwd-form-bttons').show();

                $('#pwd-form-bttons').show();

            }
        }
    })

}

function editProfile() {
    var data = {};

    data.name = $('#username').val();
    data.email = $('#email').val();
    data.code = $('#usr_code').val();
    data.pay_mode = $('#pg_code').val();

    var err = 0;
    if (data.name == '') {
        $('#username').addClass('inp_error');
        err++;
    } else {
        $('#username').removeClass('inp_error');
    }

    if (data.email == '') {
        $('#email').addClass('inp_error');
        err++;
    } else {
        $('#email').removeClass('inp_error');
    }

    if (err > 0) {
        $('#usr-edit-states').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-edit-states').html('Please enter/select the values in the field that are marked in red');
        $('#usr-edit-states').show();
        return false;
    } else {
        $('#usr-edit-states').addClass('alert-success').removeClass('alert-danger');
        $('#usr-edit-states').html('');
        $('#usr-edit-states').hide();
    }

    $('#edit-form-bttons').hide();
    $('#edit-rps-loading').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "profile/edit-user-profile",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#edit-rps-loading').html('');
                $('#usr-edit-states').show();
                $('#usr-edit-states').html('Your changes were updated successfully, new changes will take effect on your next login.');
                window.setTimeout(function () {
                    $('#usr-edit-states').html('');
                    $('#usr-edit-states').hide();
                    $('#edit-form-bttons').show()
                }, 3000);
            } else {

            }
        }
    });
}

function UpdateToken() {
    var data = {};
    data.code = $('#usr_code').val();
    data.token = $("#token").val();
    var err = 0;

    if ($("#token").val() == '') {
        $("#token").addClass('inp_error');
        err++;
    } else {
        $("#token").removeClass('inp_error');
    }

    if (err > 0) {
        $('#usr-token-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-token-state').html('Please enter API token');
        $('#usr-token-state').show();
        return false;
    } else {
        $('#usr-token-state').addClass('alert-success').removeClass('alert-danger');
        $('#usr-token-state').html('');
        $('#usr-token-state').hide();
    }

    $('#edit-token-bttons').hide();
    $('#ur-token-loading').html(loading_popup);
    $('#ur-token-loading').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "profile/update-token",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#ur-token-loading').html('');
                $('#ur-token-loading').hide();
                $('#usr-token-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-token-state').show();
                $('#usr-token-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    $('#usr-token-state').html('');
                    $('#usr-token-state').hide();
                    $('#edit-token-bttons').show();
                    $('.api-tk').removeClass('req');
                    $('#token').hide();
                    $('.lab_tkn').show();
                    $('#tkn_edt').show();
                    $('.token_btn').hide();
                    $('.pd_lts_31').addClass('pd_lt_31').removeClass('pd_lts_31');
                    $('.mr_27').addClass('mr_17').removeClass('mr_27');
                    $('#token').val('');
                    $('#tkn_txt').html(response.data.apiToken);
                }, 3000);
            } else {
                $('#ur-token-loading').html('');
                $('#ur-token-loading').hide();
                $('#usr-token-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-token-state').html(response.errorDesc);
                $('#usr-token-state').show();
                $('#edit-token-bttons').show();
            }
        }
    });
}

function saveNotiStatus() {
    var data = {};
    var err = 0;

    data.typeList = $('#alert-event-types').val();

    if (err > 0) {
        $('#alert-noti-state').removeClass('alert-success').addClass('alert-danger');
        $('#alert-noti-state').html('Please enter/select the values in the field that are marked in red');
        $('#alert-noti-state').show();
        return false;
    }

    $('#alert-noti-state').removeClass('alert-danger').removeClass('alert-success');
    $('#alert-noti-state').html(loading_popup);
    $('#alert-noti-state').show();

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'profile/update-notification-subscription',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#alert-noti-state').removeClass('alert-danger').addClass('alert-success');
                $('#alert-noti-state').html('Your request has been completed successfully');
                setTimeout(function () {                    
                    $('#alert-noti-state').hide();
                }, 3000);
            } else {
                $('#alert-noti-state').addClass('alert-danger');
                $('#alert-noti-state').html(response.errorDesc);
            }
        }
    });
}