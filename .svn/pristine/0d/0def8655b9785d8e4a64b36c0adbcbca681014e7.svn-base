function saveModes(option) {

    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger').hide();
    $('.edt_hide').show();

    var heig = 270;
    // $('#txt_name,#txt_lname,#txt_email,#txt_mobile,#grp_list,#org_list,#hid_usr_code,#txt_usr_name').val('');
    $('#btn-save').attr("onclick", "saveMode()");
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
        var new_name = $('#am-' + option.code).find('.sp_name').html();

        var Sname_c = option.serviceName;
        var cid = option.code;
        $('#name').val(new_name);
        $('#service').val(Sname_c);
        $('#hid_provider_code').val(cid);

    }


    $(".ui-dialog-titlebar").hide();
}
function saveMode() {

    var data = {};
    // data.activeFlag = $('#usr_status').val();
    data.name = $('#name').val();

    data.code = $('#hid_provider_code').val();
    data.mo_disable = menu_permission['PG-MO-DISABLE'];
    data.mo_edit = menu_permission['PG-MO-EDIT'];
    data.mo_del = menu_permission['PG-MO-DELETE'];

    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }


    if (err > 0) {
        $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#usr-action-state').show();
        return false;
    } else {
        $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state').html('');
        $('#usr-action-state').hide();
    }

    $('#form-buttons').hide();
    $('#ur-form-loading').html(loading_popup);
    $('#ur-form-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/add-payment-modes",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('.er_msg').addClass('hide');
                $('#ur-form-loading').hide();
                $('#ur-form-loading').html('');
                $('#usr-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-action-state').show();
                $('#form-buttons').hide();

                $('#am-' + data.code).find('.sp_name').html(data.name);

                $('#usr-action-state').html('Your request has been completed successfully');
                var li = $('li.amt-db').clone();
                if (data.code == '') {
                    li.attr('id', "am-" + response.data.code);
                    li.find(".sp_name").html(response.data.name);//lb
                    li.find("#lb").attr('id', "lb-" + response.data.code);
                    li.find("#sta").attr('id', "sta-" + response.data.code);
                    if (data.mo_disable > 0) {
                        if (data.mo_disable == 1) {

                            li.find(".edsts").attr('onclick', "editModeStatus('" + response.data.code + "', '" + response.data.name + "')");//lb
                            
                        } else {
                            li.find(".edsts").attr('onclick', "");//lb    
                            
                        }
                    } else {
                        li.find(".edsts").hide();
                    }
                    if (data.mo_edit > 0) {
                        if (data.mo_edit == 1) {
                            li.find(".edat").attr('onclick', "saveModes({\"code\":\"" + response.data.code + "\",\"name\":\"" + response.data.name + "\",\"activeFlag\":" + response.data.activeFlag + "})");
                             li.find(".edat").attr('id',"edt_mod_"+response.data.code);
                        } else {

                            li.find(".edat").attr('onclick', "");
                             li.find(".edat").attr('id',"edt_mod_"+response.data.code);
                        }
                    } else {
                        li.find(".edat").hide();
                    }

                    if (data.mo_del > 0) {
                        if (data.mo_del == 1) {
                            li.find(".delam").attr('onclick', "deleteMode('" + response.data.code + "', '" + response.data.name + "')");//lb
                        } else {
                            li.find(".delam").attr('onclick', "");
                        }
                    } else {
                        li.find(".delam").hide();
                    }



                    li.removeClass('hide amt-db');
                    $('#user_list_search').append(li);
                }
                window.setTimeout(function() {
                    cancelMode();
                }, 3000);

            } else {
                $('#ur-form-loading').html('');
                $('#ur-form-loading').hide();
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-action-state').html(response.errorDesc);
                $('#usr-action-state').show();
                $('#form-buttons').show();
            }
        }
    });
}
function cancelMode() {
    $('#provider-dialog').dialog('destroy');
    $('#provider-dialog').hide();
}
function editModeStatus(am_code, am_name) {
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
        url: base_url + "config/status-modes",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                var chg = data.activeFlag == 1 ? 0 : 1;
                $('#sta-' + am_code).attr('data-status', chg);
                if ($('#sta-' + am_code).attr('data-status') == 1) {
                    $('#edt_mod_' + am_code).hide();
                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-check');
                    $('#lb-' + am_code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#edt_mod_' + am_code).show();
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

function deleteMode(am_code, am_name) {
    if (confirm('Do you want to delete this payment mode?')) {
        var data = {};
        data.code = am_code;
        data.name = am_name;

        /* $('#action-status').html(loading_popup);
         $('#action-status').show();*/
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-modes",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    /* $('#action-status').removeClass('alert-danger');
                     $('#action-status').addClass('alert-success');
                     $('#action-status').html('Your request has been completed successfully');    */
                    $('#am-' + am_code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    /* $('#action-status').addClass('alert-error');
                     $('#action-status').html('Sorry! Problem in processing your request');*/
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
