function editCredentials(option) {

    $('#pg-organization-dialog').css('background', '#fff');
    $('#pg-organization-dialog').removeClass('hide');
    $('#pg-organization-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');


    $('#txt_oz_name,#txt_oz_address1,#txt_oz_address2, #aid_oz_code ,#aid_oz_stationCode,#station_list').val('');

    if (_isdefined(option)) {
        $('#gateway').val(option.gatewayProvider.code);
        $('#sel_oz_status').val(option.activeFlag);
        $('#url').val(option.returnUrl);
        $('#service').val(option.serviceChargeValue);
        $('#filename').val(option.propertiesFileName);
        $('#Attribute').val(option.attr1);
        $('#code_edit').val(option.code);
        $('#key').val(option.accessKey);
        // alert(option.percentageFlag);
        if (option.percentageFlag == 1) {
            $('input:checkbox[name=flag]').prop("checked", true);
        }
        $('#Accesscode').val(option.accessCode);
        $('#Customer').val(option.customerBare);


    } else {
        // alert('no');
        $('#url').val('');
        $('#gateway').val('');
        $('#service').val('');
        $('#filename').val('');
        $('#Attribute').val('');
        $('#code_edit').val('');
        $('#key').val('');
        $('input:checkbox[name=flag]').attr('checked', false);
        $('#Accesscode').val('');
        $('#Customer').val('');
    }

}
function saveCredential() {

    var data = {};

    data.activeFlag = $('#sel_oz_status').val();
    data.returnUrl = $('#url').val();
    data.accesskey = $('#key').val();
    data.gatewayProvider = $('#gateway').val();
    //data.serviceChargeValue = $('#service').val();
    data.propertiesFileName = $('#filename').val();
    data.attr1 = $('#Attribute').val();
    //data.percentageFlag = $('#flag:checked').val() ? 1 : 0;
    data.accessCode = $('#Accesscode').val();
    //data.customerBare = $('#Customer').val();
    data.code = $('#code_edit').val();

    var err = 0;
    if ($('#gateway').val() == '') {
        $('#gateway').addClass('inp_error');
        err++;
    } else {
        $('#gateway').removeClass('inp_error');
    }

    if ($('#url').val() == '') {
        $('#url').addClass('inp_error');
        err++;
    } else {
        $('#url').removeClass('inp_error');
    }

    if ($('#key').val() == '') {
        $('#key').addClass('inp_error');
        err++;
    } else {
        $('#key').removeClass('inp_error');
    }
//    if ($('#service').val() == '') {
//        $('#service').addClass('inp_error');
//        err++;
//    } else {
//        $('#service').removeClass('inp_error');
//    }
    if ($('#filename').val() == '') {
        $('#filename').addClass('inp_error');
        err++;
    } else {
        $('#filename').removeClass('inp_error');
    }
    if ($('#Accesscode').val() == '') {

        $('#Accesscode').addClass('inp_error');
        err++;
    } else {
        $('#Accesscode').removeClass('inp_error');
    }
//    if ($('#Customer').val() == '') {
//        $('#Customer').addClass('inp_error');
//        err++;
//    } else {
//        $('#Customer').removeClass('inp_error');
//    }

    if (err > 0) {
        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#org-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#org-form-action-state').show();
        return false;
    } else {
        $('#org-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#org-form-action-state').hide();
    }

//    if (isNaN(data.serviceChargeValue))
//    {
//        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
//        $('#org-form-action-state').html('Please enter valid service charge value');
//        $('#org-form-action-state').show();
//        return false;
//    }
//    if (isNaN(data.customerBare))
//    {
//        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
//        $('#org-form-action-state').html('Please enter valid customer bare');
//        $('#org-form-action-state').show();
//        return false;
//    }



//    var reg = (/^HTTP|HTTP|http(s)?:\/\/(www\.)?[A-Za-z0-9]+([\-\.]{1}[A-Za-z0-9]+)*\.[A-Za-z]{2,40}(:[0-9]{1,40})?(\/.*)?$/);
//
//    if (!reg.test(data.returnUrl)) {
//        err++;
//        $('#org-form-action-state').show();
//        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger');
//        $('#org-form-action-state').html('Please enter valid URL');
//        $('#url').addClass('inp_error');
//        return false;
//    } else {
//        $('#url').removeClass('inp_error');
//    } 


    $('#form-bttons').hide();
    $('#org-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#org-form-action-state').html(loading_popup);
    $('#org-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-credentials",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelOrganization();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#org-form-action-state').addClass('alert-danger');
                $('#org-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}
function cancelOrganization() {
    $('#pg-organization-dialog').dialog('destroy');
    $('#pg-organization-dialog').hide();

}


function deleteCredentials(option) {
    if (confirm('Do you want to delete this credential?')) {
        var data = {};

        data.activeFlag = 2;

        data.returnUrl = option.returnUrl;
        data.gatewayProvider = option.gatewayProvider.code;
        data.serviceChargeValue = option.serviceChargeValue;
        data.propertiesFilename = option.propertiesFileNAme;
        data.attr1 = option.attr1;
        data.percentageFlag = option.percentageFlag;
        data.accessCode = option.accessCode;
        data.customerBare = option.customerBare;
        data.code = option.code;
        //data.stationCode = option.stationCode;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-credentials",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#oz-' + response.data.code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
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
function editStatusCredentials(option, obj) {

    var data = {};


    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;

    data.returnUrl = option.returnUrl;
    data.gatewayProvider = option.gatewayProvider.code;
    data.serviceChargeValue = option.serviceChargeValue;
    data.propertiesFilename = option.propertiesFileNAme;
    data.attr1 = option.attr1;
    data.percentageFlag = option.percentageFlag;
    data.accessCode = option.accessCode;
    data.customerBare = option.customerBare;
    data.code = option.code;


    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-credentials",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#cre_edt_' + option.code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $('#cre_edt_' + option.code).show();
                    $(obj).find('.fa').removeClass('fa-check').addClass('fa-times').attr('title', 'Click to disable');//1
                }
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                //  checkURL();
                //   return;
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
