function AdminNotifyDialog(code,datefrom,dateto,group,user,flag,name) {

    $('#adm-notify-dialog').css('background', '#fff');
    $('#adm-notify-dialog').removeClass('hide');
    $('#adm-notify-dialog').dialog({
        autoOpen: true,
        height: 450,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    if (_isdefined(code)) {

        $('#notify_code').val(code);
        var fdate = datefrom;
        var tdate = dateto;
        var date = fdate + ' | ' + tdate;
        $('#name').val(name);
        $('#fdate').val(date);
        if (group != '' && group != undefined) {
            $('input:radio[class=grp_radio]').prop('checked', true);
            $('.grp').show();
            $('.usr').hide();
            $('#group').val(group);
        } else {
            $('input:radio[class=usr_radio]').prop('checked', false);
            $('.grp').hide();
            $('.usr').show();
            $('#user').val(user);
        }
        $('#message').val($('#notify_mes_'+code).html());
        if (flag == 1) {
            $('.switch-id-cmt_flg').addClass('switch-on').removeClass('switch-off');
        } else {
            $('.switch-id-cmt_flg').addClass('switch-off').removeClass('switch-on');
        }

    } else {
        $('input:radio[class=grp_radio]').prop('checked', true);
        $('#name').val('');
        $('#fdate').val('');
        $('#group').val('');
        $('#user').val('');
        $('#message').val('');
    }

}

function cancelNotify() {
    $('#adm-notify-dialog').dialog('destroy');
    $('#adm-notify-dialog').hide();

}

function saveAdminNotify() {
    var data = {};

    data.activeFlag = 1;
    data.name = $('#name').val();
    data.noti_flag = $('input[name=noti_flag]:checked').val();
    if (data.noti_flag == 'group') {
        data.group = $('#group').val();
    } else {
        data.user = $('#user').val();
    }
    data.fdate = $('#fdate').val();
    data.code = $('#notify_code').val();
    data.message = $('#message').val();
    data.cmt_flg = $('#cmt_flg').val();
    if (data.cmt_flg == 'on') {
        data.cmt_flg = 1;
    } else {
        data.cmt_flg = 0;
    }
    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }

    if (data.noti_flag == 'group') {
        if ($('#group').val() == '') {
            $('#group').addClass('inp_error');
            err++;
        } else {
            $('#group').removeClass('inp_error');
        }

    } else if (data.noti_flag == 'user') {
        if ($('#user').val() == '') {
            $('#user').addClass('inp_error');
            err++;
        } else {
            $('#user').removeClass('inp_error');
        }
    }

    if ($('#fdate').val() == '') {
        $('#fdate').addClass('inp_error');
        err++;
    } else {
        $('#fdate').removeClass('inp_error');
    }

    if ($('#message').val() == '') {

        $('#message').addClass('inp_error');
        err++;
    } else {
        $('#message').removeClass('inp_error');
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
        url: base_url + "config/update-admin-notify",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelNotify();
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

function deleteNotify(option) {
  
    if (confirm('Do you want to delete this notification?')) {
        var data = {};

        data.activeFlag = 2;
        data.code = option.code;


        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-admin-notify",
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
                     checkURL();
                    return;
                }, 2000);
            }
        })
    }
}