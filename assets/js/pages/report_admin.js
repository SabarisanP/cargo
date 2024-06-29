function editReport(option) {

    $('#pg-organization-dialog').css('background', '#fff');
    $('#pg-organization-dialog').removeClass('hide');
    $('#pg-organization-dialog').dialog({
        autoOpen: true,
        height: 550,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    if (_isdefined(option)) {
        $('#txt_g_name').val(option.name);
        $('#txt_g_days').val(option.daysLimit);
        $('#txt_g_decription').val(option.description);
        $('#txt_g_query').val(option.query);
        $('#id_oz_code').val(option.code);
    } else {
        $('#txt_g_name').val('');
        $('#txt_g_days').val('45');
        $('#txt_g_decription').val('');
        $('#txt_g_query').val('');
        $('#id_oz_code').val('');
    }

}
function saveReport() {
    var data = {};
    
    data.activeFlag = 1;
    data.name = $('#txt_g_name').val().trim();
    data.daysLimit = $('#txt_g_days').val().trim();
    data.description = $('#txt_g_decription').val().trim();
    data.query = $('#txt_g_query').val().trim();
    data.code = $('#id_oz_code').val();

    var err = 0;
    
    if ($('#txt_g_name').val() == '') {
        $('#txt_g_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_g_name').removeClass('inp_error');
    }
    
    if ($('#txt_g_days').val() == '') {
        $('#txt_g_days').addClass('inp_error');
        err++;
    } else {
        $('#txt_g_days').removeClass('inp_error');
    }
    
    if ($('#txt_g_query').val() == '') {
        $('#txt_g_query').addClass('inp_error');
        err++;
    } else {
        $('#txt_g_query').removeClass('inp_error');
    }
    

    if (err > 0) {
        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#org-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#org-form-action-state').show();
        return false;
    } else {
        $('#org-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#org-form-action-state').hide();
    } 
    
    $('#form-bttons').hide();
    $('#org-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#org-form-action-state').html(loading_popup);
    $('#org-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-report-admin",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelReport();
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
function cancelReport() {
    $('#pg-organization-dialog').dialog('destroy');
    $('#pg-organization-dialog').hide();
}


function deleteReport(option) {
    if (confirm('Do you want to delete this report?')) {
        var data = {};

        data.activeFlag = 2;
        data.name = option.name;      
        data.description = option.description;
        data.query = option.query;
        data.code = option.code;
        data.daysLimit = option.daysLimit;


        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-report-admin",
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
function editStatusReport(option, obj) {

    var data = {};

    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;
    data.name = option.name;      
    data.description = option.description;
    data.query = option.query;
    data.code = option.code;
    data.daysLimit = option.daysLimit;


    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-report-admin",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#edt_sch_' + option.code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $('#edt_sch_' + option.code).show();
                    $(obj).find('.fa').removeClass('fa-check').addClass('fa-times').attr('title', 'Click to disable');//1
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
