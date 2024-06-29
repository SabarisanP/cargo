function menuDialog(code) {

    $('.inp_error').removeClass('inp_error');
    $('#menu-dialog').css('background', '#fff');
    $('#menu-dialog').removeClass('hide');
    $('#menu-dialog').dialog({
        autoOpen: true,
        height: 600,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#mnu-action-state').html('');
    $('#mnu-action-state').hide();





    if (_isdefined(code)) {

        $.each(menulist, function(key, mnuval) {

            if (code == mnuval.code) {
                $('#parentmenu').val(mnuval.lookup.code);
                $('#txt_m_name').val(mnuval.name);
                $('#txt_l_name').val(mnuval.link);
                $('#menu_code').val(mnuval.code);
                $('#menu_status').val(mnuval.activeFlag);
                if (mnuval.defaultFlag == 1) {
                    $('#chk_dft_flg').attr('checked');
                }
                $.each(mnuval.eventList, function(ct, evtval) {
                    if (ct == 0) {
                        var tr = $('.def-tr');
                        tr.find('#evt_name').val(evtval.name);
                        tr.find('select').val(evtval.permissionType);
                        tr.find('#evt_key').val(evtval.operationCode);
                        tr.find('#evt_key').after("<input type='hidden' name='evt_code' value='" + evtval.code + "' />");
                        if (evtval.activeFlag == 1) {
                            tr.find('#evt_act').attr('checked');
                        } else {
                            tr.find('#evt_act').removeAttr('checked');
                        }
                    } else {
                        var tr = $('#clo').clone();
                        tr.removeClass("hide");
                        tr.removeClass("dis");
                        tr.removeAttr('id');
                        tr.find('#evt_name').val(evtval.name);
                        tr.find('select').val(evtval.permissionType);
                        tr.find('#evt_key').val(evtval.operationCode);
                        tr.find('#evt_key').after("<input type='hidden' name='evt_code' value='" + evtval.code + "' />");
                        if (evtval.activeFlag == 1) {
                            tr.find('#evt_act').attr('checked');
                        } else {
                            tr.find('input:checkbox').removeAttr('checked');
                            // tr.find('#evt_act').removeattr('checked');
                        }
                        tr.insertBefore('#clo');
                    }
                });
                removetr();
                $("#parentmenu option[value='" + mnuval.code + "']").attr("disabled", "disabled");

            }
        });
        /*$('#txt_g_name').val(option.name);
         $('#txt_g_decription').val(option.decription);
         $('#aid_g_code').val(option.code);
         $('#sel_g_status').val(option.activeFlag);*/
    }
}

function saveMenu() {
    $('#clo').find('input').attr('disabled', 'disabled');
    $('#clo').find('select').attr('disabled', 'disabled');
    var data = {}
    data.parentCode = $('#parentmenu').val();
    data.name = $('#txt_m_name').val();
    data.link = $('#txt_l_name').val();
    data.code = $('#menu_code').val();
    data.activeFlag = $('#menu_status').val(); //name="menu_status"
    data.defaultFlag = $('#chk_dft_flg:checked').val() ? 1 : 0; //evt_name evt_permis
    data.eventName = $('input[name="evt_name"]').serializeArray();
    data.eventPermission = $('select[name="evt_permis"]').serializeArray();
    data.eventKeywords = $('input[name="evt_key"]').serializeArray();
    data.eventCode = $('input[name="evt_code"]').serializeArray();
    var err = 0;
    if (data.name == '') {
        $('#txt_m_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_m_name').removeClass('inp_error');

    }
    if (data.link == '') {
        $('#txt_l_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_l_name').removeClass('inp_error');
    }

    var rowCount = $('#tbl_list tr').length;
    if (rowCount == 4) {
        
        if($("input[name='evt_name']").val()!=''){
            if($("input[name='evt_key']").val()==''){
                $("input[name='evt_key']").addClass('inp_error');
                    err++;
            }else{
                 $(this).removeClass('inp_error');
            }
            
        }
        
         if($("input[name='evt_key']").val()!=''){
            if($("input[name='evt_name']").val()==''){
                $("input[name='evt_name']").addClass('inp_error');
                    err++;
            }else{
                 $(this).removeClass('inp_error');
            }
            
        }

    } else {
        $("input[name='evt_name']").each(function() {
            var value = $(this).val();
            if ($(this).parent().parent().attr('id') != 'clo') {
                if (value == '') {
                    $(this).addClass('inp_error');
                    err++;
                } else {
                    $(this).removeClass('inp_error');
                }
            }
        });
        $("input[name='evt_permis']").each(function() {
            var value = $(this).val();
            if ($(this).parent().parent().attr('id') != 'clo') {
                if (value == '') {
                    $(this).addClass('inp_error');
                    err++;
                } else {
                    $(this).removeClass('inp_error');
                }
            }
        });
        $("input[name='evt_key']").each(function() {
            var value = $(this).val();
            if ($(this).parent().parent().attr('id') != 'clo') {
                if (value == '') {
                    $(this).addClass('inp_error');
                    err++;
                } else {
                    $(this).removeClass('inp_error');
                }
            }
        });
    }


    var cht = new Array();
    $("input[name='evt_act']").each(function() {
        if ($(this).is(":checked") == true && !$(this).hasClass('su_ds')) {
            if ($(this).val() == '')
                $(this).val(1)
            cht.push($(this).val());
        } else if (!$(this).hasClass('su_ds')) {
            cht.push(0);
        }
    });
    if (err > 0) {
        $('#mnu-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#mnu-action-state').show();
        $('#mnu-action-state').html('Please enter/select the values for the field that are marked in red');
        return false;
    }

    data.eventactiveFlag = cht;
    $('#mnu-button').hide();
    $('#mnu-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#mnu-action-state').hide();
    $('#mnu-loading').html(loading_popup);
    $('#mnu-loading').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/update-menu",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#mnu-loading').html('');
                $('#mnu-loading').hide();
                $('#mnu-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#mnu-action-state').show();
                $('#mnu-action-state').html('Your request has been completed successfully');

                $('#clo').find('input').removeAttr('disabled', 'disabled');
                $('#clo').find('select').removeAttr('disabled', 'disabled');

                window.setTimeout(function() {
                    cancelMenu();
                    checkURL();
                }, 3000);
            } else {
                $('#mnu-loading').html('');
                $('#mnu-loading').hide();
                $('#mnu-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#mnu-action-state').html(response.errorDesc);
                $('#mnu-action-state').show();
                $('#form-bttons').show();
            }
        }
    })

}
function cancelMenu() {
    $('#menu-dialog').dialog("destroy");
    $(":input").val('');
    $("#parentmenu option").removeAttr("disabled", "disabled");
    $(".def-tr").find('input[name="evt_act"]').val(1);
    $("#tbl_list").find("tr").not(".def-tr").not("#clo").not('.tr-head').not("#tr_add").remove();
    $('input[name="evt_code"]').remove();
    $('#menu_code').val('');
    $('#menu_status').val('1');
    $('#mnu-action-state').html('');
    $('#mnu-action-state').hide();
}
function addEvents() {
    $('.inp_error').removeClass('inp_error');
    var tr = $('#clo').clone();
    tr.find('input').removeAttr('disabled', 'disabled');
    tr.find('select').removeAttr('disabled', 'disabled');
    tr.removeClass("hide");
    tr.removeAttr('id');
    tr.insertBefore('#clo');

    $('#mnu-action-state').hide();
    $('#mnu-action-state').html('');
    removetr();
}

function removetr() {
    $('.tr_remove').on('click', function() {
        $(this).closest('tr').remove();
    });
}
function deleteMenu(code) {
    if (confirm('Do you want to delete this menu?')) {
        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "menu/delete-menu",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#mnu_' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
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
function editStatusMenu(code, obj) {

    var data = {};
    data.code = code;
    data.activeFlag = $(obj).attr('data-status') == 1 || $(obj).attr('data-status') == 9 ? 0 : 9;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/edit-status-menu",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
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
function privilegeDialog(opt) {
    //privilege-dialog

    $('.inp_error').removeClass('inp_error');
    $('#privilege-dialog').css('background', '#fff');
    $('#privilege-dialog').removeClass('hide');
    $('#privilege-dialog').show();
    $('#privilege-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#privilege-action-state').html('');
    $('#privilege-action-state').hide();
    $('role_name').val('');

    $('#menu-privilege-drop,#menu-privilege').html('');
    var html = '', option;
    if (opt == 'NS') {

        $('#privilege-loading').html(loading_small);
        $('#privilege-loading').show();

        html = menuLoad(parentmenulist, submenulist, eventList);
        $('#role_name').val(opt);
        $('#menu-privilege').html(html);
        checkboxCheck(opt);
    }
    if (opt == 'GR') {
        //menu-privilege-drop  
        $('#role_name').val(opt);
        option = optionLoad(groupsoption);
        $('#menu-privilege-drop ').html(option);
    }
    if (opt == 'UR') {
        $('#role_name').val(opt);
        option = optionLoad(usersoption);
        $('#menu-privilege-drop ').html(option);
    }


    //  savePrivilege();
}
function checkboxCheck(opt, code) {

    var data = {}
    data.role = opt;

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/get-privilege",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                if (data.role == 'NS') {



                    $.each(response.data, function(key, vals) {
                        if (vals.activeFlag == 1) {
                            $('#mnu_' + vals.code).attr('checked', 'checked');
                            $.each(vals.eventList, function(key1, vals1) {
                                $('#evt_' + vals1.code).attr('checked', 'checked');
                            });

                        }
                    });
                }
                else if (data.role == 'GR') {

                    $.each(response.data, function(key, vals) {
                        if (vals.activeFlag == 1) {
                            if (vals.group.code == code) {
                                $('#mnu_' + vals.code).attr('checked', 'checked');
                                $.each(vals.eventList, function(key1, vals1) {
                                    $('#evt_' + vals1.code).attr('checked', 'checked');
                                });
                            }
                        }
                    });

                }

                else if (data.role == 'UR') {

                    $.each(response.data, function(key, vals) {
                        if (vals.activeFlag == 1) {
                            if (vals.user.code == code) {
                                $('#mnu_' + vals.code).attr('checked', 'checked');
                                $.each(vals.eventList, function(key1, vals1) {
                                    $('#evt_' + vals1.code).attr('checked', 'checked');
                                });
                            }
                        }
                    });

                }


                $('#privilege-loading').html();
                $('#privilege-loading').hide();
            } else {
                $('#privilege-loading').html();
                $('#privilege-loading').hide();
            }
        }
    });
}
function optionLoad(options) {
    var html = "<select id='select-drop' class='form-control' onchange='loadMenus()'>";
    html += "<option value=''>--Select--</option>";

    $.each(options, function(key, vals) {
        html += "<option value='" + vals.code + "'";
        if ($('#role_name').val() == 'UR') {
            html += "data-group ='" + vals.group.code + "'";
        }
        html += ">" + vals.name + "</option>";
    });
    html += "</select>";
    return html;
}
function loadMenus() {
    var data = {}
    data.role = $('#role_name').val();
    data.code = $('#select-drop').val();
    if (data.role == 'UR') {
        data.group = $('#select-drop').find(":selected").attr('data-group');
    }
    $('#privilege-loading').html(loading_small);
    $('#privilege-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/get-namespace-privilege",
        data: data,
        success: function(response) {
            if (response.status == 1) {

                if (data.role == "UR") {

                    $('#menu-privilege').html(loading_small);
                    var html = menuLoad(parentmenulistGroup, submenulistGroup);
                    $('#menu-privilege').html(html);
                    checkboxCheck(data.role, data.code);
                    checkboxCheck('GR', data.group);
                    $('#privilege-loading').hide();

                } else if (data.role = "GR") {

                    $('#menu-privilege').html(loading_small);
                    var html = menuLoad(parentmenulistGroup, submenulistGroup);
                    $('#menu-privilege').html(html);
                    checkboxCheck(data.role, data.code);
                    $('#privilege-loading').hide();

                }
                //  savePrivilege();
                $('#privilege-loading').html();
                $('#privilege-loading').hide();
            } else {
                $('#privilege-loading').html();
                $('#privilege-loading').hide();
            }
        }
    });
}
function menuLoad(menu, submenu) {
    //menu-privilege
    var html = "<tr>";
    $.each(menu, function(k, vals) {
        var pid = "";

        if (vals['level'] == 2) {
            var cls = "pd_2";
        }

        html += "<td class='" + cls + "'>";

        if (vals['level'] == 2 && vals['lookup']['code'] != '' && vals['lookup']['code'] != undefined) {

            html += "<table>";

        }

        if (vals['lookup']['code'] != '' && vals['lookup']['code'] != undefined) {

            pid = vals['lookup']['code'];

        } else {
            pid = '';
        }

        html += "<label class='checkbox-inline'>\n\
            <input type='checkbox' name='menu' value='" + vals['code'] + "' id='mnu_" + vals['code'] + "' data-parent='" + pid + "' />\n\
            &nbsp;" + vals['name'] + "</label>\n\
            <div class='clear_fix_both'></div>";



        if (vals['eventList']) {
            html += "<td class='pd_2 pd_10 wd_598'>";
            $.each(vals['eventList'], function(ek, evals) {
                html += "<div class='pull-left pd_10 li-tp lt_41'><label class='checkbox-inline'><input type='checkbox' name='evnt' id='evt_" + evals['code'] + "' class='eve_code' data-parent='" + vals['code'] + "' value='" + evals['code'] + "' />&nbsp;" + evals['name'] + "</label></div>"

            })

            html += "</td>";
        }

        if ($.isArray(submenu[vals['code']])) {
            html += menuLoad(submenu[vals['code']], submenu);
        }
        if (vals['level'] == 2 && vals['lookup']['code'] != '' && vals['lookup']['code'] != undefined) {

            html += "</table>";

        }
        html += "</td>";
        html += "</tr>";
    });
    html += "</tr>";
    return html;
}
function cancelprivilege() {
    $('#privilege-dialog').dialog("destroy");
    $('#privilege-dialog').hide();
}
function savePrivilege() {

    var data = {}

    var evt, menu, test, m_evt, exceptionFlag;

    data.event = new Array();
    data.menucode = new Array();




    $('input:checked').each(function() {

        if ($(this).attr('name') == 'evnt') {
            evt = $(this).val();
            data.event.push(evt);
            menu = $(this).attr('data-parent');
            data.menucode.push(menu);

        } else {
            evt = '';
            menu = $(this).val();
        }
    });

    $("input[name='menu']:checked").each(function() {
        test = $(this).val();
        data.menucode.push(test);

    });

    if ($('input:checkbox').is(":checked") == true) {
        data.exceptionFlag = 1;
        data.activeFlag = 1;
    } else {
        data.exceptionFlag = 0;
        data.activeFlag = 1;
    }
    data.role = $('#role_name').val();
    if (data.role == 'GR') {
        data.groupcode = $('#select-drop').val();
    } else if (data.role == 'UR') {
        data.usercode = $('#select-drop').val();
    }

    $('#privilege-loading').html(loading_small);
    $('#privilege-loading').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/update-privilege",
        data: data,
        success: function(response) {

            if (response.status == 1) {

                $('#privilege-loading').html(loading_small);
                $('#privilege-loading').hide();
                window.setTimeout(function() {
                    cancelprivilege();
                    checkURL();
                    return;
                }, 3000);

            }

            else {
                $('#privilege-loading').html(loading_small);
                $('#privilege-loading').hide();
            }

        }
    });
    //alert($(this)
}
$(document).ready(function() {
    $("#menu-privilege").on('change', "input[type=checkbox]", function() {
        if ($(this).is(":checked") == true) {
            if (($(this).attr('name') == 'evnt')) {
                var evt = $(this).val();
                var menu = $(this).attr('data-parent');
                $('#mnu_' + menu).attr('checked', 'checked');
            }
        }
    });
    removetr();
});
