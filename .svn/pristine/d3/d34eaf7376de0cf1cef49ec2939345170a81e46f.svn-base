function menuPermissionDialog(code) {
	$('#per-table-list-grp').hide();
    $('#per-table-list-usr').hide();
   
}
function searchGroup(code) {
    $('.per-list-form-control').hide();
    $('#per-table-list-usr').hide();
    $('#per-table-list-grp').show();
    $('#tc-back-per').removeClass('hidden');
}

function searchUser(code) {
    $('.per-list-form-control').hide();
    $('#per-table-list-grp').hide();
    $('#per-table-list-usr').show();
    $('#user_list_search').show();
    $('#tc-back-per').removeClass('hidden');
}

function backToSelectRole() {
    $('.per-list-form-control').show();	
    $('#per-table-list-grp').hide();
    $('#per-table-list-usr').hide();
    $('#tc-back-per').addClass('hidden');
}

function menuPermissionDialog(role, code) {
    getPermissions(role, code);
    $('#code').val(code);

}

function savePermission(mnu_id, flag, role, evt) {
    var data = {};
    data.menu = mnu_id;
    data.role = role;
    data.activeFlag = flag;
    data.event = evt;
    data.code = $('#code').val();
    var loading_overlay = iosOverlay({
        text: "Updating...",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/update-menu-permissions",
        data: data,
        success: function (response) {
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
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 1000);
        }
    });
}

function menuLoadPermission(menu, submenu) {
    var html = "<tr>";
    $.each(menu, function (k, vals) {
        var pid = "";
        if (vals['level'] == 2) {
            var cls = "pd_2";
        }
        html += "<td class='" + cls + "'>";
        if (vals['lookup'] != null) {
            if (vals['level'] == 2 && vals['lookup']['code'] != '' && vals['lookup']['code'] != undefined) {
                html += "<table>";
            }
            if (vals['lookup']['code'] != '' && vals['lookup']['code'] != undefined) {
                pid = vals['lookup']['code'];
            } else {
                pid = '';
            }
        }
        if (vals['name'] != null) {
            if (vals['enabledFlag'] == 1) {
                html += "<label class='checkbox-inline'>\n\
                        <input type='checkbox' checked='checked' name='menu' value='" + vals['code'] + "' id='mnu_" + vals['code'] + "' data-parent='" + pid + "' />\n\
                        &nbsp;" + vals['name'] + "</label>\n\
                        <div class='clear_fix_both'></div>";
            } else {
                html += "<label class='checkbox-inline'>\n\
                        <input type='checkbox' name='menu' value='" + vals['code'] + "' id='mnu_" + vals['code'] + "' data-parent='" + pid + "' />\n\
                        &nbsp;" + vals['name'] + "</label>\n\
                        <div class='clear_fix_both'></div>";
            }
        }
        if (vals['eventList'] != '' && vals['eventList'] != null && vals['eventList'].length > 0) {
            html += "<td class='pd_2 pd_per wd_763'>";
            $.each(vals['eventList'], function (ek, evals) {
                if (vals['level'] != 1 && evals['name'] != '') {
                    if (evals['enabledFlag'] == 1) {
                        html += "<div class='pull-left pd_per li-tp lt_41'><label class='checkbox-inline'><input type='checkbox' checked='checked' name='evnt' id='evt_" + evals['code'] + "' class='" + vals['code'] + "' data-parent='" + vals['code'] + "' value='" + evals['code'] + "' />&nbsp;" + evals['name'] + "</label></div>"
                    } else {
                        html += "<div class='pull-left pd_per li-tp lt_41'><label class='checkbox-inline'><input type='checkbox' name='evnt' id='evt_" + evals['code'] + "' class='" + vals['code'] + "' data-parent='" + vals['code'] + "' value='" + evals['code'] + "' />&nbsp;" + evals['name'] + "</label></div>"
                    }
                }
            })
            html += "</td>";
        }
        if ($.isArray(submenu[vals['code']])) {
            html += menuLoadPermission(submenu[vals['code']], submenu);
        }
        if (vals['lookup'] != null) {
            if (vals['level'] == 2 && vals['lookup']['code'] != '' && vals['lookup']['code'] != undefined) {
                html += "</table>";
            }
        }
        html += "</td>";
        html += "</tr>";
    });
    html += "</tr>";
    return html;
}

function cancelMenuPermission() {
    $('#permission-dialog').dialog('destroy');
    $('#permission-dialog').hide();
}

function getPermissions(opt, code) {
    $('#menu-permissions').html('');
    var data = {};
    data.role = opt;
    if (code != '') {
        data.code = code;
    }
    $('#menu-permissions').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "menu/get-menu-permissions",
        data: data,
        success: function (response) {
            if (response) {
                var html = menuLoadPermission(response.parent, response.submenu);
                $('#menu-permissions').html(html);
                $("input[name=menu]").click(function () {
                    if ($(this).is(":checked")) {
                        savePermission($(this).val(), 1, data.role);
                    } else {
                        savePermission($(this).val(), 0, data.role);
                    }
                });
                $("input[name=evnt]").click(function () {
                    var evt = '';
                    var cls = $(this).data('parent');
                    $("input:checkbox[class=" + cls + "]").each(function () {
                        if ($(this).is(":checked") == true) {
                            evt += $(this).val() + ',';
                        }
                    });
                    var evt = evt.replace(/(^,)|(,$)/g, "");
                    savePermission(cls, 1, data.role, evt);
                });
                $('.load_success').html('');
            }
        }
    });
}
