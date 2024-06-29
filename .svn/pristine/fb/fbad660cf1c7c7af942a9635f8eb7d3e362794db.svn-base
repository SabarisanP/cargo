

function cancelRtAddEdit() {
    $('#form-action-state').hide();
    $('#route-dialog').dialog('close');
    removeArray("#route-dialog");

}
function allRoutesDialog(option, id) {

    $('.inp_error').removeClass('inp_error');
    $('#usr-org-state').hide();
    $('#form-org-bttons').show();
    if (id == 1) {
        $('[name=Rf]').val('');
        $('[name=Rt]').val('');
        $('#chk_new').val(2);
        
        $('#route_min_fare').val('350');
        $('#route_max_fare').val('3000');
    } else {
        $('#chk_new').val('');
    }

    if (id == 3) {
        $('#test').val(1);
    } else {
        $('#test').val('');
    }

    $('#edit-user-organization').dialog({
        autoOpen: true,
        height: 400,
        width: 550,
        maxWidth: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    if (_isdefined(option)) {
        $('#txt_am_name').val(option.name);
        $('#sel_am_status').val(option.activeFlag);
        $('#aid_am_code').val(option.code);

    } else {
        $('#new_amenities').val(1);
    }
    if (option != '') {
        var fid = option.fromStation.code;
        var tid = option.toStation.code;
        var cid = option.code;
        $('[name=Rf]').val(fid);
        $('[name=Rt]').val(tid);
        $('#code').val(cid);
        $('#route_min_fare').val(option.minFare);
        $('#route_max_fare').val(option.maxFare);
    }
}

function saveNewRoute() {

    var err = 0;
    if ($('#sel_route_frm_id').val() == '') {
        $('#sel_route_frm_id').addClass('inp_error');
        err++;
    } else {
        $('#sel_route_frm_id').removeClass('inp_error');
    }

    if ($('#sel_route_to_id').val() == '') {
        $('#sel_route_to_id').addClass('inp_error');
        err++;
    } else {
        $('#sel_route_to_id').removeClass('inp_error');
    }
    
    if ($('#route_min_fare').val() == '') {
        $('#route_min_fare').addClass('inp_error');
        err++;
    } else {
        $('#route_min_fare').removeClass('inp_error');
    }
    
    if ($('#route_max_fare').val() == '') {
        $('#route_max_fare').addClass('inp_error');
        err++;
    } else {
        $('#route_max_fare').removeClass('inp_error');
    }


    if (err > 0) {
        $('#usr-org-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-org-state').html('Please select the values in the field that are marked in red');
        $('#usr-org-state').show();
        return false;
    } else {
        $('#usr-org-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-org-state').html('');
        $('#usr-org-state').hide();
    }

    $('#set_id').val('');


    $.each(routes, function(k, vls) {
        if ($('#sel_route_frm_id').val() == vls.fromStation.code && $('#sel_route_to_id').val() == vls.toStation.code && $('#code').val() != vls.code)
        {
            $('#set_id').val(3);
        }
    });


    if ($('#set_id').val() == 3) {
        $('#usr-org-state').show();
        $('#usr-org-state').removeClass('alert-success');
        $('#usr-org-state').addClass('alert-danger');
        $('#usr-org-state').html('Route already exists ');
        return false;
    }
    else if ($('#sel_route_to_id').val() == $('#sel_route_frm_id').val()) {
        $('#usr-org-state').show();
        $('#usr-org-state').removeClass('alert-success');
        $('#usr-org-state').addClass('alert-danger');
        $('#sel_route_to_id').addClass('inp_error');
        $('#usr-org-state').html('Departure and destination stations should not be same');
        return false;
    }


    else {
        $('#usr-org-state').hide();
    }



    var data = {};
    data.fromStation = $('#sel_route_frm_id').val();
    data.toStation = $('#sel_route_to_id').val();
    data.activeFlag = 1;
    data.code = $('#aid_am_code').val();
    data.rt_disable = menu_permission['ROTE-DISABLE'];
    data.rt_edit = menu_permission['ROTE-EDIT'];
    data.rt_del = menu_permission['ROTE-DELETE'];
    data.minFare = $('#route_min_fare').val();
    data.maxFare = $('#route_max_fare').val();

    var from = $("#sel_route_frm_id option:selected").text();
    var to = $("#sel_route_to_id option:selected").text();

    var route = from + ' - ' + to;


    $('#ur-org-loading').html(loading_small);
    $('#form-org-bttons').hide();
    $.ajax({
        type: "POST",
        url: base_url + "config/add-routes",
        data: data,
        dataType: "json",
        success: function(response) {
            if (response.status == 1) {

                // Push newly added route

                var route_save = {};
                route_save["code"] = response.data.code;
                route_save["name"] = route;
                route_save["activeflag"] = "1";
                route_save["fromStation"] = {"code": data.fromStation, "name": from, "activeFlag": "0"};
                route_save["toStation"] = {"code": data.toStation, "name": to, "activeFlag": "0"};

                routes.push(route_save);

                // Push End

                $('.er_msg').addClass('hide');
                $('#usr-org-state').show();
                $('#usr-org-state').removeClass('alert-danger');
                $('#usr-org-state').addClass('alert-success');
                $('#ur-org-loading').html('');
                $('#usr-org-state').html('Your request has been completed successfully');

                window.setTimeout(function() {
                    $('#usr-org-state').hide();
                    cancelorganization();
                    checkURL();
                    return;
                    
                    $('#am-' + data.code).find('.sp_name').html(route);
                    if ($('#chk_new').val() == 2) {

                        var li = $('li.amt-db').clone();
                        li.attr('id', "am-" + response.data.code);
                        li.find(".sp_name").html(route);//lb
                        li.find("#lb").attr('id', "lb-" + response.data.code);
                        li.find("#sta").attr('id', "sta-" + response.data.code);
                        if (data.rt_disable > 0) {
                            if (data.rt_disable == 1) {
                                li.find(".edsts").attr('onclick', "editRouteStatus('" + response.data.code + "', '" + route + "','" + data.fromStation + "','" + data.toStation + "')");//lb
                            } else {
                                li.find(".edsts").attr('onclick', "");//lb    
                            }
                        } else {
                            li.find(".edsts").hide();
                        }
                        if (data.rt_edit > 0 && data.rt_edit != '') {
                            if (data.rt_disable == 1) {
                                li.find(".edat").attr('onclick', "allRoutesDialog({\"code\":\"" + response.data.code + "\",\"name\":\"" + route + "\",\"activeFlag\":" + response.data.activeFlag + "})");
                                li.find(".edat").attr('id', "edt_rots_" + response.data.code);
                            } else {

                                li.find(".edat").attr('onclick', "");
                                li.find(".edat").attr('id', "edt_rots_" + response.data.code);
                            }
                        } else {
                            li.find(".edat").hide();
                        }
                        if (data.rt_del > 0 && data.rt_del != '') {
                            if (data.rt_del == 1) {
                                li.find(".delam").attr('onclick', "deleteRoutes('" + response.data.code + "', '" + route + "')");//lb

                            } else {
                                li.find(".delam").attr('onclick', "");
                            }
                        } else {
                            li.find(".delam").hide();
                        }
                        li.removeClass('hide amt-db');
                        $('#user_list_search').append(li);
                    }

                }, 3000);
            }

            else {
                $('#all-org-state').addClass('alert-error').removeClass('hide');
                $('#all-org-state').html(response.errorDesc);
                $('#all-org-state').show();
                $('#all-form-bttons').show();
            }
        }
    });


}
function editRouteStatus(am_code, am_name, fromcode, tocode) {
    var data = {};
    data.code = am_code;
    data.name = am_name;
    data.activeFlag = $('#sta-' + am_code).attr('data-status');
    data.fromStation = fromcode;
    data.toStation = tocode;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/status-routes",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                var chg = data.activeFlag == 1 ? 0 : 1;
                $('#sta-' + am_code).attr('data-status', chg);
                if ($('#sta-' + am_code).attr('data-status') == 1) {
                    $('#edt_rots_' + am_code).hide();
                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-check');
                    $('#lb-' + am_code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#edt_rots_' + am_code).show();
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


function deleteRoutes(am_code, am_name) {
    if (confirm('Do you want to delete this route?')) {
        var data = {};
        data.code = am_code;
        data.name = am_name

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-routes",
            data: data,
            success: function(response) {
                if (response.status == 1) {

                    $('#am-' + am_code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
                    });

                    //  Delete / Hide route from JSON

                    routes = $.grep(routes, function(e) {
                        return e.code != am_code
                    });

                    // End delete 

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
function cancelRoute() {
    $('#edit-user-organization').dialog('destroy');
    $('#edit-user-organization').hide();
}

function exportRoutes() {
    document.export_routes.action = "config/export-routes";
    document.export_routes.target = "ifrm_downloader";
    document.export_routes.submit();
    return;
}
