function editAmenities(option) {
    $('#txt_am_name').removeClass('inp_error');
    $('#amenit-dialog').css('background', '#fff');
    $('#amt-form-bttons').show();
    $('#amenit-dialog').show();
    $('#amenit-dialog').removeClass('hide');

    $('#amenit-dialog').dialog({
        autoOpen: true,
        width: 600,
        maxWidth: 600,
        height: 200,
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
          var new_name = $('#am-' + option.code).find('.sp_name').html();
        $('#txt_am_name').val(new_name);
        $('#sel_am_status').val(option.activeFlag);
        $('#aid_am_code').val(option.code);

    } else {
        $('#new_amenities').val(1);
    }
    dilg.push("#amenit-dialog");
}
function saveAmenities() {
    var data = {};
    data.activeFlag = $('#sel_am_status').val();
    data.name = $('#txt_am_name').val();
    data.code = $('#aid_am_code').val();
    data.amet_disable = menu_permission['AMNTY-DISABLE'];
    data.amet_edit = menu_permission['AMNTY-EDIT'];
    data.amet_del = menu_permission['AMNTY-DELETE'];
    var err = 0;
    if (data.name == '') {
        $('#txt_am_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_am_name').removeClass('inp_error');
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
        url: base_url + "config/update-amenities",
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
                    $('#am-' + data.code).find('.sp_name').html(data.name);
                    if ($('#new_amenities').val() == 1) {
                        $('#new_amenities').val('');
                        var li = $('li.amt-db').clone();
                        li.attr('id', "am-" + response.data.code);
                        li.find(".sp_name").html(response.data.name);//lb
                        li.find("#lb").attr('id', "lb-" + response.data.code);
                        li.find("#sta").attr('id', "sta-" + response.data.code);

                        if (data.amet_disable > 0) {
                            if (data.amet_disable == 1) {
                                li.find(".edsts").attr('onclick', "editStatus('" + response.data.code + "', '" + response.data.name + "')");//lb
                            } else {
                                li.find(".edsts").attr('onclick', "");//lb    
                            }
                        }
                        else {
                            li.find(".edsts").hide();
                        }

                        if (data.amet_edit > 0) {
                            if (data.amet_edit == 1) {
                                li.find(".edat").attr('onclick', "editAmenities({\"code\":\"" + response.data.code + "\",\"name\":\"" + response.data.name + "\",\"activeFlag\":" + response.data.activeFlag + "})");
                                li.find(".edat").attr('id', "at_edt_" + response.data.code);
                            } else {
                                li.find(".edat").attr('onclick', "");
                                li.find(".edat").attr('id', "at_edt_" + response.data.code);
                            }
                        }
                        else {
                            li.find(".edat").hide();
                        }
                        if (data.amet_del > 0) {
                            if (data.amet_del == 1) {
                                li.find(".delam").attr('onclick', "deleteAmenities('" + response.data.code + "', '" + response.data.name + "')");//lb
                            } else {
                                li.find(".delam").attr('onclick', "");//lb  
                            }
                        }
                        else {
                            li.find(".delam").hide();//lb  
                        }
                        li.removeClass('hide amt-db');
                        $('#user_list_search').append(li);
                    }
                }, 3000);
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


function deleteAmenities(am_code, am_name) {
    if (confirm('Do you want to delete this amenities?')) {
        var data = {};
        data.am_code = am_code;
        data.am_name = am_name
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-amenities",
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
function editStatus(am_code, am_name) {
    var data = {};
    data.am_code = am_code;
    data.am_name = am_name;
    data.activeFlag = $('#sta-' + am_code).attr('data-status');
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/status-amenities",
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