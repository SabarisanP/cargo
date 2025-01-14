$(document).keydown(function (event) {
    if (event.keyCode == 192) {
        window.location.href = '#user/dashboard';
        location.reload();
    }
});

var loading_small = '<img src="' + base_url + 'assets/img/loaders/17.gif">';
var loading_big = '<img src="' + base_url + 'assets/img/loaders/19.gif">';
var loading_popup = '<img src="' + base_url + 'assets/img/loaders/17.gif">';

var timer = "";
var collaboration = '';
//var menu_permission = '';
var session_name = '';
var sesson_balance = '';

$.cookie.json = true;

(function($,c,b){$.map("click dblclick mousemove mousedown mouseup mouseover mouseout change select submit keydown keypress keyup".split(" "),function(d){a(d)});a("focusin","focus"+b);a("focusout","blur"+b);$.addOutsideEvent=a;function a(g,e){e=e||g+b;var d=$(),h=g+"."+e+"-special-event";$.event.special[e]={setup:function(){d=d.add(this);if(d.length===1){$(c).bind(h,f)}},teardown:function(){d=d.not(this);if(d.length===0){$(c).unbind(h)}},add:function(i){var j=i.handler;i.handler=function(l,k){l.target=k;j.apply(this,arguments)}}};function f(i){$(d).each(function(){var j=$(this);if(this!==i.target&&!j.has(i.target).length){j.triggerHandler(e,[i.target])}})}}})(jQuery,document,"outside");

$(function () {
    window.setTimeout(function () {
        periodicalVerifier()
    }, 600000);
    $("#s_name, #b_name").css({
        'max-height': '280px',
        'overflow' : 'auto',
        'min-width' : '233px'
    });
    
    $(document).click(function (e) {
        if ($(e.target).parent().find('[data-toggle="popover"]').length > 0) {
            $('[data-toggle="popover"]').popover('hide');
        }             
        
    });
    //  Ezee Apps icon
    $('#ez-apps').click(function(e) {
        e.stopPropagation();
        e.preventDefault();

        if($('#slidebar').hasClass('hidden')) {
            $('#slidebar').removeClass('hidden');
        } else {
            $('#slidebar').addClass('hidden');
        }
    });
        
    //  Nav notifications
    $('#ez-noti').click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        
        if($('#notification-panel').hasClass('active')) {
            $('#notification-panel').removeClass('active');
        } else {
            $('#notification-panel').addClass('active');
        }
    });
    
    $("#slidebar, #notification-panel").bind( "clickoutside", function(event){
        $(this).addClass('hidden');
    });
    
    $.scrollUp({
        animation: 'fade',
        activeOverlay: '#00FFFF',
        scrollImg: {
            active: true,
            type: 'background',
            src: '../img/top.png'
        }
    });

    if($.fn.multiselect) {
        $.extend(true, $.fn.multiselect.Constructor.prototype.defaults, {
            enableFiltering: true,
            enableCaseInsensitiveFiltering: true,
            templates: {
                filterClearBtn: ''
            }
        });
    }

    if($.fn.datepicker) {
        $.extend(true, $.fn.datepicker.defaults, {
            todayHighlight: true
        });
    }

    if ($.ui && $.ui.dialog) {
        $.ui.dialog.prototype._allowInteraction = function(e) {
            return !!$(e.target).closest('.ui-dialog, .ui-datepicker, .select2-drop').length;
        };
    }

    Inputmask.extendAliases({
        'inrcurrency': {
            alias: 'numeric',
            placeholder: '',
            prefix: '',
            groupSeparator: '',
            digits: 2,
            digitsOptional: true,
            rightAlign: false,
            allowMinus: false,
            showMaskOnHover: false,
            showMaskOnFocus: false
        },
        'allintegers': {
            alias: 'integer',
            placeholder: '',
            rightAlign: false,
            showMaskOnHover: false,
            showMaskOnFocus: false
        },
        'positiveinteger': {
            alias: 'integer',
            placeholder: '',
            rightAlign: false,
            allowMinus: false,
            showMaskOnHover: false,
            showMaskOnFocus: false
        },
        'positivedecimal': {
            alias: 'decimal',
            placeholder: '',
            digits: 2,
            digitsOptional: true,
            rightAlign: false,
            allowMinus: false,
            showMaskOnHover: false,
            showMaskOnFocus: false
        },
        'englishonly': {
            regex: '[\\u0000-\\u007F]+',
            placeholder: '',
            showMaskOnHover: false,
            showMaskOnFocus: false
        }
    });

    $(".subscription-menu").bind( "click", function(event){
        ga_track_event('Subscription : Top Menu', ns_username, '');
    });

    $(document).on('click', 'span.input-group-addon', function () {
        $(this).siblings('input').trigger('focus');
    });

    LRDetailsHotKeys();
});



function periodicalVerifier() {
    $.ajax({
        type: "POST",
        url: base_url + "user/verifier",
        data: "",
        dataType: 'json',
        success: function (result) {
            if (result.status == 0) {
                window.location.href = base_url;
            } else if (result.server_error == 1) {
                window.location.href = "user/logout";
            } else {
                //menu_permission = result.permission;
                //collaboration = result.collaboration;
                //chatUpdate(collaboration);
                session_name = result.session_name;
            }
            window.setTimeout(function () {
                periodicalVerifier()
            }, 600000);
        },
        error : function() {
           window.setTimeout(function () {
                periodicalVerifier()
            }, 30000); 
        }
    });
}

function setUserBalance(val) {
    $("#user_balance").effect("highlight", { color: '#d7af0d' }, 7000);
    $('#user_balance').html(val);
}

function chatUpdate(vl) {
    $('#scroll_chat').html('');
    if (vl.length == 0) {
        $('#scroll_chat').append("<li><a class='name_scroll'>No User Found</a></li>");
    }
    $.each(vl, function (key, vals) {
        $('#scroll_chat').append("<li class=names_" + vals.coll_id + "><a onclick=\"javascript:chatWith('" + vals.coll_id + "','" + vals.coll_users + "')\" class='name_scroll' href='javascript:;'>" + vals.coll_users + "</a></li>");
    });
}
function _isdefined(v) {
    return (typeof (v) == "undefined") ? false : true;
}

function _getAllStates(dest_ele, output_type, ele_id, selected_val, onchange) {
    var o_ele_id = (_isdefined(ele_id)) ? ele_id : '';
    var o_selected_val = (_isdefined(selected_val)) ? selected_val : '';
    var o_onchange = (_isdefined(onchange)) ? onchange : '';
    var o_dest_ele = (_isdefined(dest_ele)) ? dest_ele : '';
    var o_output_type = (_isdefined(output_type)) ? output_type : '';

    $('#' + dest_ele).html(loading_small);
    $.ajax({
        type: "POST",
        url: base_url + "utils/get-all-states",
        dataType: 'json',
        data: '',
        success: function (response) {
            if (response.status == 0) {
                _handle_error(response);
                return;
            }
            if (o_dest_ele !== '') {
                if (o_output_type === "dropdown") {
                    var dd = '<select class="form-control" id="' + o_ele_id + '" >';
                    dd += '<option value="">Select a State</option>';
                    $.each(response.data, function (i, obj) {
                        var selected = (o_selected_val === obj.code) ? ' selected=selected ' : "";
                        dd += "<option " + selected + " value = '" + obj.code + "'>" + obj.name + "</option>";
                    });
                    dd += '</select>';
                    $('#' + dest_ele).empty().html(dd);
                    if (o_onchange !== '') {
                        $('#' + dest_ele).bind('change', function () {
                            eval(o_onchange);
                        });
                    }
                    /*$("#"+o_ele_id).select2({
                     placeholder: "Select a State",
                     allowClear: true
                     }); */
                } else if (o_output_type === "json") {
                    return response;
                }
            }

        }
    });
}
function _getNamespaceStation(dest_ele, output_type, ele_id, selected_val, onchange, param) {
    var o_ele_id = (_isdefined(ele_id)) ? ele_id : '';
    var o_selected_val = (_isdefined(selected_val)) ? selected_val : '';
    var o_onchange = (_isdefined(onchange)) ? onchange : '';
    var o_dest_ele = (_isdefined(dest_ele)) ? dest_ele : '';
    var o_output_type = (_isdefined(output_type)) ? output_type : '';
    var data = (_isdefined(param)) ? param : {};

    $('#' + dest_ele).html(loading_small);
    $.ajax({
        type: "POST",
        url: base_url + "utils/get-namespace-station-point",
        dataType: 'json',
        data: data,
        success: function (response) {
            if (response.status == 0) {
                _handle_error(response);
                return;
            }
            if (o_dest_ele !== '') {
                if (o_output_type === "dropdown") {
                    var dd = '<select class="form-control" id="' + o_ele_id + '" >';
                    dd += '<option value="">Select a Station</option>';
                    $.each(response.data, function (i, obj) {
                        var selected = (o_selected_val === obj.code) ? ' selected=selected ' : "";
                        dd += "<option " + selected + " value = '" + obj.code + "'>" + obj.name + "</option>";
                    });
                    dd += '</select>';
                    $('#' + dest_ele).empty().html(dd);
                    if (o_onchange !== '') {
                        $('#' + dest_ele).bind('change', function () {
                            eval(o_onchange);
                        });
                    }
                } else if (o_output_type === "json") {
                    return response;
                }
            }

        }
    });
}


function _getStations(dest_ele, output_type, ele_id, selected_val, onchange, param) {
    var o_ele_id = (_isdefined(ele_id)) ? ele_id : '';
    var o_selected_val = (_isdefined(selected_val)) ? selected_val : '';
    var o_onchange = (_isdefined(onchange)) ? onchange : '';
    var o_dest_ele = (_isdefined(dest_ele)) ? dest_ele : '';
    var o_output_type = (_isdefined(output_type)) ? output_type : '';
    var data = (_isdefined(param)) ? param : {};

    $('#' + dest_ele).html(loading_small);
    $.ajax({
        type: "POST",
        url: base_url + "utils/get-stations",
        dataType: 'json',
        data: data,
        success: function (response) {
            if (response.status == 0) {
                _handle_error(response);
                return;
            }
            if (o_dest_ele !== '') {
                if (o_output_type === "dropdown") {
                    var dd = '<select class="form-control" id="' + o_ele_id + '" >';
                    dd += '<option value="">Select a Station</option>';
                    $.each(response.data, function (i, obj) {
                        var selected = (o_selected_val === obj.code) ? ' selected=selected ' : "";
                        dd += "<option " + selected + " value = '" + obj.code + "'>" + obj.name + "</option>";
                    });
                    dd += '</select>';
                    $('#' + dest_ele).empty().html(dd);
                    if (o_onchange !== '') {
                        $('#' + dest_ele).bind('change', function () {
                            eval(o_onchange);
                        });
                    }
                } else if (o_output_type === "json") {
                    return response;
                }
            }

        }
    });
}

function _handle_error(res) {
    if (res.status == 0) {
        if (res.errorDesc != '') {
            alert(res.errorDesc);
            //window.location.href = base_url;
        }
    }
}


function organtaionDialogUser(code, org_code, flag) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-org-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
    $('#form-org-bttons').show();
    $('#hid_org_usr_code').val('');

    $(".org_all").attr('checked', '');
    $(".org_all").removeAttr('checked');
    $(".org_all").attr('checked', false);
    $(".org_all").prop('checked', false);

    $("#org_" + org_code).attr('checked', 'checked');
    $("#org_" + org_code).attr('checked', 'checked');
    $("#org_" + org_code).prop('checked', true);
    $('#hid_org_usr_code').val(code);
    $('#hid_flg').val(flag);
    $('#hid_org_od_code').val(org_code);



    $('#edit-user-organization').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });

    $(".ui-dialog-titlebar").hide();
}

function cancelorganization() {
    $('#edit-user-organization').dialog('destroy');
    $('#edit-user-organization').hide();
}
function saveUserOrganization() {
    var data = {};
    data.code = $('#hid_org_usr_code').val();
    data.organization = $("input[name='org_rad']:checked").val();

    if (!$("input[name='org_rad']:checked").val()) {
        $('#usr-org-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-org-state').html('Please  select any one of organization.');
        $('#usr-org-state').show();
        return false;
    }
    else {
        $('#usr-org-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-org-state').html('');
        $('#usr-org-state').hide();
    }


    $('#form-org-bttons').hide();
    $('#ur-org-loading').html(loading_popup);
    $('#ur-org-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-user-organization",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#ur-org-loading').html('');
                $('#ur-org-loading').hide();
                $('#usr-org-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-org-state').show();
                $('#usr-org-state').html('Your request has been completed successfully');
                if ($('#hid_flg').val() == 'usr') {
                    $.each(userlist, function (keys, values) {
                        if (values.code == data.code) {
                            userlist[keys].organization.name = $("#org_" + data.organization).attr("data-name");
                            userlist[keys].organization.code = data.organization;//values.organization.name
                        }

                        $('#usr-viw-' + data.code).trigger("click");
                    });
                } else if ($('#hid_flg').val() == 'org') {
                    var usr = $('#usr_' + data.code).clone();
                    usr.find('.btn').attr('onclick', "organtaionDialogUser('" + data.code + "','" + data.organization + "','org')");
                    var old = Number($('#usr_cnt_' + $('#hid_org_od_code').val()).html()) - 1;
                    $('#usr_cnt_' + $('#hid_org_od_code').val()).html(old);
                    var newc = Number($('#usr_cnt_' + data.organization).html()) + 1;
                    $('#usr_cnt_' + data.organization).html(newc);
                    $('#usr_' + data.code).remove();
                    $('#org_usr_' + data.organization).append(usr);

                }
                window.setTimeout(function () {
                    cancelUserOrganizationDialog();
                    cancelorganization();
                    checkURL();
                }, 3000);
            } else {
                $('#ur-org-loading').html('');
                $('#ur-org-loading').hide();
                $('#usr-org-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-org-state').html(response.errorDesc);
                $('#usr-org-state').show();
                $('#form-org-bttons').show();
            }
        }
    });
}


function groupDialogUser(code, grp_code, flag) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-grp-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
    $('#form-grp-bttons').show();
    $('#hid_grp_usr_code').val('');

    $(".grp_all").attr('checked', '');
    $(".grp_all").removeAttr('checked');
    $(".grp_all").attr('checked', false);
    $(".grp_all").prop('checked', false);


    $("#grp_" + grp_code).attr('checked', 'checked');
    $("#grp_" + grp_code).attr('checked', 'checked');
    $("#grp_" + grp_code).prop('checked', true);
    $('#hid_grp_usr_code').val(code);

    $('#hid_grp_flg').val(flag);
    $('#hid_grp_od_code').val(grp_code);


    $('#edit-user-group').dialog({
        autoOpen: true,
        height: 400,
        width: 500,
        modal: true,
        resizable: false
    });

    $(".ui-dialog-titlebar").hide();
}

function cancelgroup() {
    $('#edit-user-group').dialog('destroy');
    $('#edit-user-group').hide();
}
function saveUserGroup() {
    var data = {};
    data.code = $('#hid_grp_usr_code').val();
    data.group = $("input[name='grp_rad']:checked").val();



    if (!$("input[name='grp_rad']:checked").val()) {
        $('#usr-grp-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-grp-state').html('Please  select any one of group');
        $('#usr-grp-state').show();
        return false;
    }
    else {
        $('#usr-grp-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-grp-state').html('');
        $('#usr-grp-state').hide();
    }


    $('#form-grp-bttons').hide();
    $('#ur-grp-loading').html(loading_popup);
    $('#ur-grp-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-user-group",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#ur-grp-loading').html('');
                $('#ur-grp-loading').hide();
                $('#usr-grp-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-grp-state').show();
                $('#usr-grp-state').html('Your request has been completed successfully');
                if ($('#hid_grp_flg').val() == 'usr') {
                    $.each(userlist, function (keys, values) {
                        if (values.code == data.code) {
                            userlist[keys].group.name = $("#grp_" + data.group).attr("data-name");
                            userlist[keys].group.code = data.group;//values.organization.name
                        }

                        $('#usr-viw-' + data.code).trigger("click");
                    });

                } else if ($('#hid_grp_flg').val() == 'grp') {
                    var type = $('#hid_grp_flg').val();
                    var usr = $('#usr_' + data.code).clone();
                    usr.find('.btn').attr('onclick', "groupDialogUser('" + data.code + "','" + data.group + "','" + type + "')");
                    var old = Number($('#usr_cnt_' + $('#hid_grp_od_code').val()).html()) - 1;
                    $('#usr_cnt_' + $('#hid_grp_od_code').val()).html(old);
                    var newc = Number($('#usr_cnt_' + data.group).html()) + 1;
                    $('#usr_cnt_' + data.group).html(newc);
                    $('#usr_' + data.code).remove();
                    $('#grp_usr_' + data.group).find('.grp').append(usr);
                }
                window.setTimeout(function () {
                    cancelgroup();
                }, 3000);
            } else {
                $('#ur-grp-loading').html('');
                $('#ur-grp-loading').hide();
                $('#usr-grp-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-grp-state').html(response.errorDesc);
                $('#usr-grp-state').show();
                $('#form-grp-bttons').show();
            }
        }
    });
}



function editNamespace(code, name, pin, mode, flag) {
    $('#nsp-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#nsp-action-state').hide();
    $('#e_pin').removeClass('inp_error');
    $('#e_code').removeClass('inp_error');
    $('#e_name').removeClass('inp_error');
    $('#pro-dialog').css('background', '#fff');

    $('#amt-form-bttons').show();
    //$('#pro-dialog').show();
    $('#pro-dialog').removeClass('hidden');

    $('#pro-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 600,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();

    $('#amt-form-bttons').show();
    $('#pwd-action-state').html('');
    $('#pwd-action-state').hide();
    $('#e_code').val(code).removeAttr('disabled', 'disabled');

    if (code != '' && code != undefined)
    {
        var name_e = $('.n_' + code).html();
        var pin_e = $('.p_' + code).html();
        $('#e_name').val(name_e);
        $('#e_pin').val(pin_e);
        $('#flag').val(flag);
        $('#e_code').val(code);
        $('#e_code').val(code).attr('disabled', 'disabled');
        $('#np-code').hide();
    } else {
        $('#e_name').val('');
        $('#e_pin').val('');
        $('#flag').val('');
        $('#e_code').val('');
    }
    $('#nsp-action-state').html('');
    $('#nsp-action-state').hide();
    $('#nsp-form-bttons').show();

    //var height = $('#main_wrapper').height() + 100;
    //$(".ui-widget-overlay").css('height', height);

}

function cancelProAddEdit() {
    $('#pro-dialog').dialog("close");
    $('#pro-dialog').addClass('hidden');
    //removeArray("#pro-dialog");

}
function nameSpaceswitch(code) {
    var data = {}
    data.code = code;
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/switch-namespace",
        data: data,
        success: function (response) {
            if (response.status == 1) {


                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });


                window.setTimeout(function () {
                    window.location = "";

                }, 1000);
            }
        }
    })
}
function saveNamespace() {
    var data = {};
    data.activeFlag = 1;
    data.name = $('#e_name').val();
    data.code = $('#e_code').val();
    data.pin = $('#e_pin').val();
    $('#pwd-action-loading').html('');
    $('#pwd-action-loading').hide();

    var reg = /^[a-z]+$/;
    var err = 0;
    if ($('#e_code').val() == '') {
        $('#e_code').addClass('inp_error');
        err++;
    } else {
        $('#e_code').removeClass('inp_error');
    }

    if ($('#e_name').val() == '') {
        $('#e_name').addClass('inp_error');
        err++;
    } else {
        $('#e_name').removeClass('inp_error');
    }

    if ($('#e_pin').val() == '') {
        $('#e_pin').addClass('inp_error');
        err++;
    } else {
        $('#e_pin').removeClass('inp_error');
    }


    if (err > 0) {
        $('#nsp-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#nsp-action-state').html('Please enter the values in the field that are marked in red');
        $('#nsp-action-state').show();
        return false;
    } else {
        $('#nsp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#nsp-action-state').hide();
    }

    if (!reg.test(data.code)) {
        err++;
        $('#nsp-action-state').show();
        $('#nsp-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#nsp-action-state').html('Please enter valid code.');
        $('#e_code').addClass('inp_error');
        return false;
    } else {
        $('#e_code').removeClass('inp_error');
    }


    $('#nsp-action-loading').html(loading_popup);
    $('#nsp-action-loading').show();
    $('#nsp-form-bttons').hide();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "profile/update-namespace",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#nsp-action-loading').html('');
                $('#nsp-action-loading').hide();
                $('.n_' + data.code).html(data.name);
                $('.p_' + data.code).html(data.pin);
                if ($('#nps_' + data.code).length > 0) {
                    $('#nps_' + data.code).html(data.name);
                } else {

                    var nsp = $('#nsp-li').html();
                    nsp = $('<li>').html(nsp).clone();
                    nsp.find('a').attr('onclick', 'nameSpaceswitch("' + data.code + '")');
                    nsp.find('a').attr('id', ' id="nps_' + data.code + '"');
                    nsp.find('a').html(data.name);

                    $(nsp).insertBefore('#lst_nsp');
                }
                $('#nsp-action-state').show();
                $('#nsp-action-state').removeClass('alert-danger').removeClass('hide');
                $('#nsp-action-state').addClass('alert-success');
                $("#nsp-action-state").width(550);
                $('#nsp-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelProAddEdit();

                }, 3000);
            } else {
                $('#nsp-action-loading').html('');
                $('#nsp-action-loading').hide();
                $('#nsp-action-state').show();
                $('#nsp-action-state').addClass('alert-danger').removeClass('alert-success').removeClass('hide');
                $('#nsp-action-state').html(response.errorDesc);
                $('#nsp-form-bttons').show();
                window.setTimeout(function () {
                    $('#pwd-action-state').hide();
                    $('#amt-form-bttons').show();
                }, 3000);
            }
        }
    })
}
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

$(window).resize(function () {
    fluidDialog();
});

$(document).on("dialogopen", ".ui-dialog", function (event, ui) {
    $(".ui-dialog .ui-dialog-content").dialog("option", "fluid", true);
    $(".ui-dialog .ui-dialog-content").dialog("option", "maxWidth", 900);
    fluidDialog();
    $("#bus-type-dialog").dialog({width: 900});
    $("#pg-cancel-dialog").dialog({width: 800});
    $("#menu-dialog").dialog({width: 950});
    var wWidth = $(window).width();
    if (wWidth <= 480) {                                        // Mobile View
        $("#bus-type-dialog").dialog("option", "fluid", false);
        $("#pg-cancel-dialog").dialog("option", "fluid", false);
    } else if (wWidth >= 481 && wWidth <= 979) {                 // Tablet View
        $("#bus-type-dialog").dialog({width: 700});
        $("#pg-cancel-dialog").dialog({width: 600});
        $("#menu-dialog").dialog({width: 500});
    }

});

function fluidDialog() {
    var $visible = $(".ui-dialog:visible");
    $visible.each(function () {
        var $this = $(this);
        var dialog = $this.find(".ui-dialog-content").data("ui-dialog");
        if (dialog.options.fluid) {
            var wWidth = $(window).width();
            if (wWidth > (parseInt(dialog.options.maxWidth) + 50)) {
                $this.css("width", dialog.options.width + "px");
            } else {
                $this.css("width", "90%");
            }
            dialog.option("position", dialog.options.position);
        }
    });

}
function datetimeToTime(time) {
    var dateString = time.replace(/-/g, "/");
    var dt = new Date(dateString);
    var hours = dt.getHours()
    var minutes = dt.getMinutes()
    if (minutes < 10)
        minutes = "0" + minutes
    var suffix = "AM";
    if (hours >= 12) {
        suffix = "PM";
        hours = hours - 12;
    }
    if (hours == 0) {
        hours = 12;
    }
    return hours + ":" + minutes + " " + suffix;
}
function dateToDateTime(time) {

    var dateString = time.replace(/-/g, "/");
    var dt = new Date(dateString);
    var hours = dt.getHours()
    var minutes = dt.getMinutes()
    var month = dt.getMonth() + 1;
    var day = dt.getDate();

    month = month + "";

    if (month.length == 1)
    {
        month = "0" + month;
    }

    day = day + "";

    if (day.length == 1)
    {
        day = "0" + day;
    }
    if (minutes < 10)
        minutes = "0" + minutes
    var suffix = "AM";
    if (hours >= 12) {
        suffix = "PM";
        hours = hours - 12;
    }
    if (hours == 0) {
        hours = 12;
    }
    return day + "/" + month + "/" + dt.getFullYear() + " " + hours + ":" + minutes + " " + suffix;
}
function isValidEmailAddress(pmEmail) {
    if (!pmEmail)
        return false;
    pmEmail = $.trim(pmEmail);
    pmEmail = pmEmail.replace(/\r\n|\r|\n/g, '');

    if (isRegExpSupport()) {
        var vPattern = "^[A-Za-z0-9](([_\\.\\-]?[a-zA-Z0-9_]+)*)@([A-Za-z0-9]+)(([\\_.\\-]?[a-zA-Z0-9]+)*)\\.([A-Za-z]{2,})$";
        var vRegExp = new RegExp(vPattern);
        return (vRegExp.test(pmEmail));
    } else {
        if (pmEmail.indexOf('@') == -1 || pmEmail.indexOf('.') == -1 || pmEmail.indexOf(' ') != -1)
            return false;
        else {
            var vSplit = pmEmail.split("@");
            if (vSplit.length > 2)
                return false;
            else {
                var vDomain = vSplit[1].split('.');
                var vLength = vDomain.length;
                for (var vLoop = 0; vLoop < vLength; vLoop++)
                    if (vDomain[vLoop].length <= 0)
                        return false;
                return true;
            }
        }
    }
}
function isValidPhonenumber(number) {
    //var filter = /^[0-9+]{10,13}$/;
    var filter = /^\d{10}$/;
    if (filter.test(number)) {
        return true;
    }
    else {
        return false;
    }
}
function isValidGstNumber(number) {
    //var filter = /^[0-9+]{10,13}$/;
    var filter = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
    if (filter.test(number)) {
        return true;
    }
    else {
        return false;
    }
}
function isRegExpSupport() {
    /* Function will check whether the regular expression supported by the browser */
    if (window.RegExp) {
        var vTempStr = "a";
        var vTempReg = new RegExp(vTempStr);
        return (vTempReg.test(vTempStr));
    }
    return false;
}
function uniqueArray(arr) {
    var r = [];
    o:for (var i = 0, n = arr.length; i < n; i++) {
        for (var x = i + 1; x < n; x++) {
            if (arr[x] == arr[i])
                continue o;
        }
        r[r.length] = arr[i];
    }
    return r;
}


function isNull(a) {
    if (typeof a == "undefined") {
        return true;
    } else {
        if (a == null || a == "" || a == "NA") {
            return true;
        } else {
            return false;
        }
    }
}
function isNotNull(a) {
    return !isNull(a);
}
function setCookie(c_name, value, expiredays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + expiredays);
    document.cookie = c_name + "=" + escape(value)
            + ((expiredays == null) ? "" : "; expires=" + exdate.toGMTString()) + ";path=/";
    document.cookie = c_name + "=" + escape(value)
            + ((expiredays == null) ? "" : "; expires=" + exdate.toGMTString()) + ";path=/ezeebus";
}
function getCookie(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=");
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1)
                c_end = document.cookie.length;
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return "";
}

function dateToDateTime(time, type) {
    if(time=="" || time === undefined ) return '';
    
    var dateString = time.replace(/-/g, "/");
    var dt = new Date(dateString);
    var hours = dt.getHours()
    var minutes = dt.getMinutes()
    var month = dt.getMonth() + 1;
    var day = dt.getDate();

    month = month + "";

    if (month.length == 1) {
        month = "0" + month;
    }
    day = day + "";
    if (day.length == 1) {
        day = "0" + day;
    }
    if (minutes < 10)
        minutes = "0" + minutes
    var suffix = "AM";
    if (hours >= 12) {
        suffix = "PM";
        hours = hours - 12;
    }
    if (hours == 0) {
        hours = 12;
    }
    if (type == 1)
        return day + "/" + month + "/" + dt.getFullYear();
    else if (type == 2)
        return hours + ":" + minutes + " " + suffix;
    else if (type == 3)
        return day + "/" + month + "/" + dt.getFullYear() + ' : ' + hours + ":" + minutes + " " + suffix;
}


function editTicket(pnr) {
    $('#edt-tck-dialog').css('background', '#fff');
    $('#edt-tck-dialog').removeClass('hide');
    $('#edt-tck-dialog').dialog({
        autoOpen: true,
        height: 620,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#edt-tck-dialog').html(loading_small);
    var data = {};
    data.ticketpnrcode = pnr;
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "ticket/get-ticket-details",
        data: data,
        success: function (response) {
            if (response != '') {
                $('#edt-tck-dialog').html(response);
            }
        }
    })

}

function cancelEditTck() {
    $('#edt-tck-dialog').dialog('destroy');
    $('#edt-tck-dialog').hide();
}

function editPassengerMobile(mobile, seatcode) {
    $('.mob_save').show();
    $('#seat_code').val('');
    $('#o_mobile').val('');
    $('#n_mobile').val('');
    $('#mob-action-state').html('');
    $('#mob-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-mob-dialog').css('background', '#fff');
    $('#edt-tck-mob-dialog').removeClass('hide');
    $('#edt-tck-mob-dialog').dialog({
        autoOpen: true,
        height: 220,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#seat_code').val(seatcode);
    $('#o_mobile,#n_mobile').val(mobile);

}

function editMobileNumber() {

    var data = {};
    data.oldMobileNumber = $('#o_mobile').val();
    data.newMobileNumber = $('#n_mobile').val();
    data.ticketCode = $('#seat_code').val();

    if ($('#mob_noti').bootstrapSwitch('state')) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    var err = 0;
    if (data.newMobileNumber == '') {
        $('#n_mobile').addClass('inp_error');
        err++;
    } else {
        $('#n_mobile').removeClass('inp_error');
    }
    if (err > 0) {

        $('#mob-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#mob-action-state').html('Please enter mobile number.');
        $('#mob-action-state').show();
        return false;
    } else {
        $('#mob-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#mob-action-state').html('');
        $('#mob-action-state').hide();
    }
    $('#mob-action-state').show();
    $('.mob_save').hide();
    $('#mob-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-passenger-mobile",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#mob-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#mob-action-state').html('Mobile number updated successfully. SMS notification sent to the passenger.'); 
                } else {
                    $('#mob-action-state').html('Mobile number updated successfully');                    
                }
                window.setTimeout(function () {
                    cancelMobileNumber();
                    editTicket(data.ticketCode);
                }, 4000);
            } else {
                $('#board-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#board-action-state').html(response.errorDesc);
                $('.mob_save').show();
            }
        }
    })

}

function passengerNameDialog(seat, pnr, name) {
    $('.name_save').show();
    $('#seat_code').val('');
    $('#pass_name').val('');
    $('#pnr_name').val('');
    $('#name-action-state').html('');
    $('#name-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-name-dialog').css('background', '#fff');
    $('#edt-tck-name-dialog').removeClass('hide');
    $('#edt-tck-name-dialog').dialog({
        autoOpen: true,
        height: 220,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#seat_code').val(seat);
    $('#pnr_name').val(pnr);
    $('#pass_name').val(name);

}

function editPassengerName() {

    var data = {};
    data.newName = $('#pass_name').val();
    data.seatCode = $('#seat_code').val();
    data.ticketCode = $('#pnr_name').val();

    if ($('#noti_name').bootstrapSwitch('state')) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    var err = 0;
    if (data.newName == '') {
        $('#pass_name').addClass('inp_error');
        err++;
    } else {
        $('#pass_name').removeClass('inp_error');
    }
    if (err > 0) {

        $('#name-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#name-action-state').html('Please enter passenger name.');
        $('#name-action-state').show();
        return false;
    } else {
        $('#name-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#name-action-state').html('');
        $('#name-action-state').hide();
    }
    $('#name-action-state').show();
    $('.name_save').hide();
    $('#name-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-passenger-details",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#name-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#name-action-state').html('Passenger name updated successfully. SMS notification sent to the passenger.');
                } else {
                    $('#name-action-state').html('Passenger name updated successfully');               
                }
                window.setTimeout(function () {
                    cancelPassengerName();
                    editTicket(data.ticketCode);
                }, 4000);
            } else {
                $('#board-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#board-action-state').html(response.errorDesc);
                $('.name_save').show();
            }
        }
    })

}

function passengerGenderDialog(seat, pnr, gender) {
    $('.gender_save').show();
    $("input:radio").attr("checked", false);
    $('#seat_code').val('');
    $('#pnr_code').val('');
    $('#gender-action-state').html('');
    $('#gender-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-gender-dialog').css('background', '#fff');
    $('#edt-tck-gender-dialog').removeClass('hide');
    $('#edt-tck-gender-dialog').dialog({
        autoOpen: true,
        height: 220,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#seat_code').val(seat);
    $('#pnr_name').val(pnr);
    $('input[name="pass_gender"][value="' + gender + '"]').prop('checked', true);
}

function editPassengerGender() {

    var data = {};
    data.newGender = $('input[name=pass_gender]:checked').val();
    data.seatCode = $('#seat_code').val();
    data.ticketCode = $('#pnr_name').val();

    if ($('#noti_gen').bootstrapSwitch('state')) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    var err = 0;
    if (data.newGender == '') {
        $('#pass_gender').addClass('inp_error');
        err++;
    } else {
        $('#pass_gender').removeClass('inp_error');
    }
    if (err > 0) {

        $('#gender-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#gender-action-state').html('Please select gender.');
        $('#gender-action-state').show();
        return false;
    } else {
        $('#gender-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#gender-action-state').html('');
        $('#gender-action-state').hide();
    }
    $('.gender_save').hide();
    $('#gender-action-state').show();
    $('#gender-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-passenger-details",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#gender-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#gender-action-state').html('Passenger gender updated successfully. SMS notification sent to the passenger.');                    
                } else {
                    $('#mob-action-state').html('Passenger gender updated successfully');                    
                }
                window.setTimeout(function () {
                    cancelPassengerGender();
                    editTicket(data.ticketCode);
                }, 4000);
            } else {
                $('#board-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#board-action-state').html(response.errorDesc);
                $('.gender_save').show();
            }
        }
    })

}

function passengerAgeDialog(seat, pnr, age) {
    $('.age_save').show();
    $('#seat_code').val('');
    $('#pnr_code').val('');
    $('#age-action-state').html('');
    $('#age-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-age-dialog').css('background', '#fff');
    $('#edt-tck-age-dialog').removeClass('hide');
    $('#edt-tck-age-dialog').dialog({
        autoOpen: true,
        height: 220,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#seat_code').val(seat);
    $('#pnr_name').val(pnr);
    $('#pass_age').val(age);
}

function editPassengerAge() {

    var data = {};
    data.newAge = $('#pass_age').val();
    data.seatCode = $('#seat_code').val();
    data.ticketCode = $('#pnr_name').val();

    if ($('#noti_age').bootstrapSwitch('state')) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    var err = 0;
    if (data.newAge == '') {
        $('#pass_age').addClass('inp_error');
        err++;
    } else {
        $('#pass_age').removeClass('inp_error');
    }
    if (err > 0) {

        $('#age-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#age-action-state').html('Please enter passenger age.');
        $('#age-action-state').show();
        return false;
    } else {
        $('#age-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#age-action-state').html('');
        $('#age-action-state').hide();
    }
    $('.age_save').hide();
    $('#age-action-state').show();
    $('#age-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-passenger-details",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#age-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#age-action-state').html('Passenger age updated successfully. SMS notification sent to the passenger.');                  
                } else {
                    $('#age-action-state').html('Passenger age updated successfully');                
                }
                window.setTimeout(function () {
                    cancelPassengerAge();
                    editTicket(data.ticketCode);
                }, 4000);
            }  else {
                $('#board-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#board-action-state').html(response.errorDesc);
                $('.age_save').show();
            }
        }
    })

}


function passengerBoardDialog(trip, stage, pnr, addrCode, fromCode, toCode, travelDate) {

    $('.board_save').show();
    $('#seat_code').val('');
    $('#pnr_code').val('');
    $('#board-action-state').html('');
    $('#board-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-board-dialog').css('background', '#fff');
    $('#edt-tck-board-dialog').removeClass('hide');
    $('#edt-tck-board-dialog').dialog({
        autoOpen: true,
        height: 340,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#trip_code').val(trip);
    $('#pnr_name').val(pnr);
    $('#stage_code').val(stage);
    ele = $('#tkn_edt');
    brd = $(ele).attr('data-pointname')+', '+$(ele).attr('data-address')+', '+$(ele).attr('data-landmark');
    $('#brd').html(brd);

    var data = {};
    data.tripCode = trip;
    data.stageCode = stage;
    data.fromCode = fromCode;
    data.toCode = toCode;
    data.travelDate = travelDate;
    $('#point').html(loading_small);
    $('#end').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/get-boarding-info",
        data: data,
        success: function (response) {
            $('#point').html(response.boardingPoint);
            $('#addr').html(response.address);
            $('#board').val(addrCode);
            $('#old_board').val(addrCode);
            getAddress();
        }
    })

}

function getAddress() {
    $('.add_shw').hide();
    var code = $('#board').val();
    $('#addr_' + code).show();
}

function editPassengerBoard() {

    var data = {};
    data.oldBoardingPointCode = $('#old_board').val();
    data.newBoardingPointCode = $('#board').val();
    data.ticketCode = $('#pnr_name').val();

    if ($('#noti_brd').bootstrapSwitch('state') == true) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    var err = 0;
    if (data.newBoardingPointCode == '') {
        $('#board').addClass('inp_error');
        err++;
    } else {
        $('#board').removeClass('inp_error');
    }
    if (err > 0) {

        $('#board-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#board-action-state').html('Please select boarding point.');
        $('#board-action-state').show();
        return false;
    } else {
        $('#board-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#board-action-state').html('');
        $('#board-action-state').hide();
    }
    $('.board_save').hide();
    $('#board-action-state').show();
    $('#board-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-boarding-point",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#board-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#board-action-state').html('Boarding point updated successfully. SMS notification sent to the passenger.');                   
                } else {
                    $('#board-action-state').html('Boarding point updated successfully');               
                }
                window.setTimeout(function () {
                    cancelPassengerBoard();
                    editTicket(data.ticketCode);
                }, 4000);
            } else {
                $('#board-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#board-action-state').html(response.errorDesc);
                $('.board_save').show();
            }
        }
    })

}

function passengerDroppingDialog(trip, stage, pnr, addrCode, fromCode, toCode, travelDate) {

    $('.drop_save').show();
    $('#seat_code').val('');
    $('#pnr_code').val('');
    $('#drop-action-state').html('');
    $('#drop-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-drop-dialog').css('background', '#fff');
    $('#edt-tck-drop-dialog').removeClass('hide');
    $('#edt-tck-drop-dialog').dialog({
        autoOpen: true,
        height: 340,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#trip_code').val(trip);
    $('#pnr_name').val(pnr);
    $('#stage_code').val(stage);
    ele = $('#tkn_drop');
    drop = $(ele).attr('data-pointname')+', '+$(ele).attr('data-address')+', '+$(ele).attr('data-landmark');
    $('#drop').html(drop);

    var data = {};
    data.tripCode = trip;
    data.stageCode = stage;
    data.fromCode = fromCode;
    data.toCode = toCode;
    data.travelDate = travelDate;
    $('#dpoint').html(loading_small);
    $('#end').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/get-dropping-info",
        data: data,
        success: function (response) {
            $('#dpoint').html(response.droppingPoint);
            $('#dropaddr').html(response.address);
            $('#sdrop').val(addrCode);
            $('#old_drop').val(addrCode);
            getDropAddress();
        }
    })

}

function getDropAddress() {
    $('.add_shw').hide();
    var code = $('#sdrop').val();
    $('#daddr_' + code).show();
}

function editPassengerDropping() {

    var data = {};
    data.oldDroppingPointCode = $('#old_drop').val();
    data.newDroppingPointCode = $('#sdrop').val();
    data.ticketCode = $('#pnr_name').val();

    if ($('#noti_drop').bootstrapSwitch('state') == true) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    var err = 0;
    if (data.newBoardingPointCode == '') {
        $('#sdrop').addClass('inp_error');
        err++;
    } else {
        $('#sdrop').removeClass('inp_error');
    }
    if (err > 0) {
        $('#drop-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#drop-action-state').html('Please select dropping point.');
        $('#drop-action-state').show();
        return false;
    } else {
        $('#drop-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#drop-action-state').html('');
        $('#drop-action-state').hide();
    }
    $('.drop_save').hide();
    $('#drop-action-state').show();
    $('#drop-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-dropping-point",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#drop-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#drop-action-state').html('Dropping point updated successfully. SMS notification sent to the passenger.');                   
                } else {
                    $('#drop-action-state').html('Dropping point updated successfully');               
                }
                window.setTimeout(function () {
                    cancelPassengerDropping();
                    editTicket(data.ticketCode);
                }, 4000);
            } else {
                $('#drop-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#drop-action-state').html(response.errorDesc);
                $('.drop_save').show();
            }
        }
    })

}


var seatStatusDetails = new Array();
var tripDate = new Array();
var fromStation = new Array();
var toStation = new Array();
function passengerSeatDialog(trip, stage, pnr, fromCode, toCode, travelDate) {
    $('.seat_save').show();
    $('#seat_code').val('');
    $('#pnr_code').val('');
    $('#seat-action-state').html('');
    $('#seat-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    $('#edt-tck-seat-dialog').css('background', '#fff');
    $('#edt-tck-seat-dialog').removeClass('hide');
    $('#edt-tck-seat-dialog').dialog({
        autoOpen: true,
        height: 680,
        width: 900,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#trip_code').val(trip);
    $('#pnr_name').val(pnr);
    $('#stage_code').val(stage);
    $('#sch-workspace-content').html(loading_small);
    $('.new_seat').html(loading_small);
    //$('#sel').html(seat);
    var data = {};
    data.tripCode = trip;
    data.stageCode = stage;
    data.fromCode = fromCode;
    data.toCode = toCode;
    data.travelDate = travelDate;
    //$('#point').html(loading_small);
    //$('#end').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/get-seat-info",
        data: data,
        success: function (res) {
            if(res.status==0) {
                $('#sch-workspace-content').html('<div class="alert alert-danger">Problem in loading bus layout. Please try again.</div>');
                $('#seat').html('');
            } else {                
                $('.new_seat').html(res.available);
                seatStatusDetails[1] = res.busseatlayer;
                renderBusMap(res, 1);
                //$('#seat_old').val(seatcode);
            }
        }
    })

}

function editPassengerSeat() {
    $('#edt-tck-seat-dialog .inp_error').removeClass('inp_error');
    
    var err = 0;
    var data = {};
    data.ticketCode = $('#pnr_name').val();
    
    data.seatCodes = [];
    data.oldSeatNames = [];
    data.newSeatCodes = {};
    $('#edt-tck-seat-dialog .new_seat').each(function() {
        var newSeatCode = $(this).find('#bs_seat').val();
        if(newSeatCode != '') {
            var oldSeatCode = $(this).data('oldseatcode');
            data.seatCodes.push(oldSeatCode + '-' + newSeatCode);
            data.oldSeatNames.push($(this).data('oldseatname'));
            if(data.newSeatCodes[newSeatCode]) {
                $(this).find('#bs_seat').addClass('inp_error');
                $('#seat-action-state').html('Seat already selected');
                err++;
            } else {
                data.newSeatCodes[newSeatCode] = newSeatCode;
            }
        }
    });
    data.seatCodes = data.seatCodes.join(',');

    if ($('#noti_seat').bootstrapSwitch('state') == true) {
        data.notificationFlag = 1;
    } else {
        data.notificationFlag = 0;
    }

    if (data.oldSeatNames.length == 0) {
        $('#edt-tck-seat-dialog .new_seat #bs_seat').addClass('inp_error');
        $('#seat-action-state').html('Please select atleast one seat name.');
        err++;
    }
    
    if (err > 0) {

        $('#seat-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#seat-action-state').show();
        return false;
    } else {
        $('#seat-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#seat-action-state').html('');
        $('#seat-action-state').hide();
    }
    
    if(!confirm('Do you want to change seats for seat ' + data.oldSeatNames.join(', '))) {
        return;
    }
    
    $('.seat_save').hide();
    $('#seat-action-state').show();
    $('#seat-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "ticket/edit-seat-name",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#seat-action-state').removeClass('alert-danger').addClass('alert-success');
                if(data.notificationFlag == 1) {
                    $('#seat-action-state').html('Seat name updated successfully. SMS notification sent to the passenger');
                } else {
                    $('#seat-action-state').html('Seat name updated successfully');              
                }                
                window.setTimeout(function () {
                    cancelPassengerSeat();
                    editTicket(data.ticketCode);
            }, 4000);
            } else {
                $('#seat-action-state').addClass('alert-danger').removeClass('alert-success');
                $('#seat-action-state').html(response.errorDesc);
                $('.seat_save').show();

            }
        }
    })

}

function renderBusMap(bus, id) {

    var html = '';
    var upst;
    var lwst;
    var busmap = $('#template-busmap-listedit').html();
    busmap = $('<div>').html(busmap).clone();
    var result = busSeatForEdit(bus.lrowmax, bus.lcolmax, bus.lrowmin, bus.lcolmin, bus.seatStatus, bus.seatDetails, 1, id);
    html = result[0];

    if (result[1] != '') {
        lwst = result[1];
    }

    busmap.find('.lower').html(html);
    busmap.find('.frm-sta').html("&nbsp;" + bus.busmap.fromStation.name);
    busmap.find('.to-sta').html("&nbsp;" + bus.busmap.toStation.name);
    busmap.find('.trp-date').html("&nbsp;" + dateToDateTime(bus.busmap.fromStation.dateTime));
    tripDate[id] = bus.busmap.fromStation.dateTime;
    fromStation[id] = bus.busmap.fromStation.code;
    toStation[id] = bus.busmap.toStation.code;
    if (bus.urowmax != '' && bus.urowmax != undefined && bus.ucolmax != '' && bus.ucolmax != undefined) {
        var result = busSeatForEdit(bus.urowmax, bus.ucolmax, bus.urowmin, bus.ucolmin, bus.seatStatus, bus.seatDetails, 2, id);
        html = result[0];
        if (result[1] != '') {
            upst = result[1];
        }
        busmap.find('.upper').html(html);
        busmap.find('.upper-layer').removeClass('hide');
        busmap.find('.seat-map-selayer').removeClass('hide');
    }

    $("#sch-workspace-content").html(busmap.html());
    if (lwst != '') {
        $("#sch-workspace-content").find(lwst).show();
    }
    if (upst != '') {
        $("#sch-workspace-content").find(upst).show();
    }


}

function busSeatForEdit(row, col, rowmin, colmin, seatstatus, seatDetails, lay, id) {
    var s = '';
    var htm = '';
    var seatStatusList = {
        "AM": "Available male",
        "AF": "Available female",
        "AL": "Available for all",
        "BO": "Booked",
        "BM": "Booked for Male",
        "BF": "Booked for Female",
        "AY": "Allocated for You",
        "AO": "Allocated to ",
        "UK": "Un Known,yet identified",
        "TBL": "Blocked",
        "PBL": "Phone Booking",
        "BL": "Blocked Seat to"
    };
    var seatStatusClass = {
        "AM": "seat-available-gents",
        "AF": "seat-available-ladies",
        "AL": "",
        "BO": "seat-booked",
        "BM": "seat-booked-gents",
        "BF": "seat-booked-ladies",
        "AY": "seat-available-you",
        "AO": "seat-available-other",
        "UK": "seat-booked-blocked",
        "TBL": "seat-booked-blocked",
        "PBL": "seat-phone-blocked",
        "BL": "seat-booked-blocked"
    };
    var rowSeatFoundCount = {};
    for (var i = rowmin; i <= row; i++) {
        for (var j = colmin; j <= col; j++) {
            var set = lay + "" + i + "" + j;
            if (rowSeatFoundCount[i] != undefined) {
                rowSeatFoundCount[i] = rowSeatFoundCount[i] + 1;
            } else {
                rowSeatFoundCount[i] = 1;
            }
        }
    }
    var axialFound = false;
    for (var i = rowmin; i <= row; i++) {
        var sleeperSeatFound = false;
        for (var j = colmin; j <= col; j++) {
            var set = lay + "" + i + "" + j;
            var seatclass = '';
            var BusSeatTypeclass = ' seat-lay-search ';

            var c = '';
            var sn = ''

            if (seatstatus[set] != undefined) {

                var dataPop =  "";

                if (seatstatus[set]['code'] != undefined && seatstatus[set]['status'] != undefined) {
                    if (htm != '')
                        htm += ',';

                    if (htm.indexOf(seatstatus[set]['code']) == -1)
                        htm = seatstatus[set]['status']['code']
                    if (seatstatus[set]['status']['code'] != 'BO' && seatstatus[set]['status']['code'] != 'BL' && seatstatus[set]['status']['code'] != 'AO' && seatstatus[set]['status']['code'] != 'TBL' && seatstatus[set]['status']['code'] != 'BF' && seatstatus[set]['status']['code'] != 'BM' && seatstatus[set]['status']['code'] != 'PBL' && seatstatus[set]['status']['code'] != undefined) {
                        seatclass += seatstatus[set]['code'] + ' seat-select-visibility ' + seatStatusClass[seatstatus[set]['status']['code']];
                    } else {
                        seatclass += seatStatusClass[seatstatus[set]['status']['code']];
                    }
                    c = ' data-code = "' + seatstatus[set]['code'] + '"';
                    if (seatstatus[set]['status']['code'] == 'AO' || seatstatus[set]['status']['code'] == 'BL') {
                        var temp = '';
                        if (seatstatus[set]['userName'] != undefined) {
                            temp += '&nbsp;' + seatstatus[set]['userName'] + "(u)"; //userName
                        }
                        if (seatstatus[set]['groupName'] != undefined) {
                            if (temp != '')
                                temp += ',';
                            temp += '&nbsp;' + seatstatus[set]['groupName'] + "(g)";
                        }
                        if (temp != '') {
                            dataPop += temp;
                        }
                    }
                    sn = seatDetails[seatstatus[set]['code']]['seatName'];
                    if (seatstatus[set]['status']['code'] == 'BO' || seatstatus[set]['status']['code'] == 'PBL') {
                        $.each(seatStatusDetails[id], function (t, tik) {
                            if (seatstatus[set]['code'] == tik.code && tik.ticketCode != '' && tik.ticketCode != undefined) {
                                if (tik.seatGendarStatus != undefined) {
                                    if (tik.seatGendarStatus.code == "M" && tik.seatGendarStatus.code != undefined) {
                                        seatclass += ' seat-booked-gents ';
                                    } else if (tik.seatGendarStatus.code == "F" && tik.seatGendarStatus.code != undefined) {
                                        seatclass += ' seat-booked-ladies ';
                                    }
                                }
                            }
                        });
                    }
                }
                dataPop += "";
                if (seatstatus[set]['status'] != '' && seatstatus[set]['status'] != undefined && seatstatus[set]['status'] == 1 && seatstatus[set] != undefined) {
                    seatclass += ' seat-booked ' + seatStatusClass[seatstatus[set]['status']['code']];
                }
                if (seatstatus[set]['seatType'] != '' && seatstatus[set]['seatType'] != undefined && seatstatus[set]['seatType'] == "Sleeper") {
                    BusSeatTypeclass = ' sleeper-lay-search ';
                    sleeperSeatFound = true;
                } else {
                    sleeperSeatFound = false;
                }

            } else if (rowSeatFoundCount[i] != undefined && rowSeatFoundCount[i] > 0 && !sleeperSeatFound) {// && seatstatus[previousSeatPos]['seatType'] != '' && seatstatus[previousSeatPos]['seatType'] != undefined && seatstatus[previousSeatPos]['seatType'] == "Sleeper" ){
                sn = '&nbsp;';
                dataPop = '';
            } else if (rowSeatFoundCount[i] == 0 && !axialFound) {
                sn = '&nbsp;';
                axialFound = true;
                dataPop = '';
            }

            if (sn != '') {
                s += '<div class="p_tool  seat-lay-out ' + BusSeatTypeclass + seatclass + '" ' + c + ' data-toggle="popover" data-container="body" data-placement="left" data-trigger="hover" data-content="' + dataPop + '">' + sn + '</div>';
            }
        }
        s += '<div class="clear_fix_both"></div>';
    }
    return [s, htm];
}


function ga_track_event(c,a,l){
    ga('send', {hitType: 'event', eventCategory: c, eventAction: a, eventLabel: ns_name });
}

function cancelMobileNumber() {
    $('#edt-tck-mob-dialog').dialog('destroy');
    $('#edt-tck-mob-dialog').hide();
}

function cancelPassengerName() {
    $('#edt-tck-name-dialog').dialog('destroy');
    $('#edt-tck-name-dialog').hide();
}

function cancelPassengerGender() {
    $('#edt-tck-gender-dialog').dialog('destroy');
    $('#edt-tck-gender-dialog').hide();
}

function cancelPassengerAge() {
    $('#edt-tck-age-dialog').dialog('destroy');
    $('#edt-tck-age-dialog').hide();
}

function cancelPassengerBoard() {
    $('#edt-tck-board-dialog').dialog('destroy');
    $('#edt-tck-board-dialog').hide();
}

function cancelPassengerDropping() {
    $('#edt-tck-drop-dialog').dialog('destroy');
    $('#edt-tck-drop-dialog').hide();
}


function cancelPassengerSeat() {
    $('#edt-tck-seat-dialog').dialog('destroy');
    $('#edt-tck-seat-dialog').hide();
}

function PrintTck(code, print) {
    if( !_isdefined(print) ) print = 0; 
    var url = base_url + "search/print-sheet?print="+print+"&pnrCode=" + code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1050, height=650");
}

function PrintMiniTck(code) {
    var url = base_url + "search/print-mini-sheet?pnrCode=" + code;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
}

function getTicketHistory(pnr) {
    if(pnr=="") return;
    
    if( !$('#dia-ticket-histroy').length ) {             
        $('<div id="dia-ticket-histroy" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-ticket-histroy').removeClass('hide');
    $('#dia-ticket-histroy').dialog({
        autoOpen: true,
        height: 550,
        width: 700,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-ticket-histroy').html(loading_small);  
    
    var data = {};
    data.ticketCode = pnr;    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "ticket/get-ticket-history",
        data: data,
        success: function (res) {
           $('#dia-ticket-histroy').html(res); 
           $('#dia-ticket-histroy').find('a').focus();
        }
    })
}
function closeTicketHistoryDialog() {
    $('#dia-ticket-histroy').dialog('destroy');
    $('#dia-ticket-histroy').hide();
    $('#dia-ticket-histroy').html('');
}

function getCargoDetails(cargoCode, options = {}) {
    if(cargoCode=="") return;
    
    if( !$('#dia-cargo-details').length ) {             
        $('<div id="dia-cargo-details" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-cargo-details').removeClass('hide');
    $('#dia-cargo-details').dialog({
        autoOpen: true,
        height: 650,
        width: Math.min(1100, $(window).width() - 50),
        modal: true,
        closeOnEscape:true,
        resizable: false,
        open: function () {
            if ($.ui && $.ui.dialog && !$.ui.dialog.prototype._allowInteractionRemapped && $(this).closest(".ui-dialog").length) {
                if ($.ui.dialog.prototype._allowInteraction) {
                    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
                    $.ui.dialog.prototype._allowInteraction = function (e) {
                        if ($(e.target).closest('.select2-drop').length) return true;
                        return ui_dialog_interaction.apply(this, arguments);
                    };
                    $.ui.dialog.prototype._allowInteractionRemapped = true;
                }
            }
        },
        _allowInteraction: function (event) {
            return !!$(event.target).is(".select2-input") || this._super(event);
        }
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-cargo-details').html(loading_small);  
    
    var data = $.extend({}, options.params);
    data.cargoCode = $.trim(cargoCode).toUpperCase();    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/cargo-details",
        data: data,
        success: function (res) {
           $('#dia-cargo-details').html(res);
           $('#dia-cargo-details').find('a').focus();
        }
    })
}

function getPreBookingDetails(lrcode, options = {}) {
    if(lrcode=="") return;
    
    if( !$('#dia-cargo-details').length ) {             
        $('<div id="dia-cargo-details" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-cargo-details').removeClass('hide');
    $('#dia-cargo-details').dialog({
        autoOpen: true,
        height: 650,
        width: Math.min(1100, $(window).width() - 50),
        modal: true,
        closeOnEscape:true,
        resizable: false,
        open: function () {
            if ($.ui && $.ui.dialog && !$.ui.dialog.prototype._allowInteractionRemapped && $(this).closest(".ui-dialog").length) {
                if ($.ui.dialog.prototype._allowInteraction) {
                    var ui_dialog_interaction = $.ui.dialog.prototype._allowInteraction;
                    $.ui.dialog.prototype._allowInteraction = function (e) {
                        if ($(e.target).closest('.select2-drop').length) return true;
                        return ui_dialog_interaction.apply(this, arguments);
                    };
                    $.ui.dialog.prototype._allowInteractionRemapped = true;
                }
            }
        },
        _allowInteraction: function (event) {
            return !!$(event.target).is(".select2-input") || this._super(event);
        }
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-cargo-details').html(loading_small);  
    
    var data = $.extend({}, options.params);
    data.lrcode = $.trim(lrcode).toUpperCase();    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "prebooking/cargo-pre-booking-details",
        data: data,
        success: function (res) {
           $('#dia-cargo-details').html(res);
           $('#dia-cargo-details').find('a').focus();
        }
    })
}
function closeCargoDetailsDialog() {
    // $('#dia-cargo-details').dialog('destroy');
    // $('#dia-cargo-details').hide();
    // $('#dia-cargo-details').html('');
    $('#dia-cargo-details').dialog('destroy').remove();
}

function printCargoReceipt(code, type) {
    var url = base_url + "cargo/print-cargo-summary?code="+code+'&type='+type;
    if( !epPrintUrlHtml(url, '3 Inch') ) {
        var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=288, height=550");
    }
}

function printCargoInvoice(code) {
    var param = $.param({
        code: code
    })
    var url = base_url + "cargo/print-cargo-invoice?" + param;
    var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=960, height=550");
}

function getCargoHistory(cargoCode) {
    if(cargoCode=="") return;
    
    if( !$('#dia-cargo-history').length ) {             
        $('<div id="dia-cargo-history" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-cargo-history').removeClass('hide');
    $('#dia-cargo-history').dialog({
        autoOpen: true,
        height: 550,
        width: 800,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-cargo-history').html(loading_small);  
    
    var data = {};
    data.cargoCode = cargoCode;    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/cargo-history",
        data: data,
        success: function (res) {
           $('#dia-cargo-history').html(res);
           $('#dia-cargo-history').find('a').focus();
        }
    });
    ga_track_event('LR History', 'View LR History', '');
}

function getTransitHistory(transitCode, aliasCode, filterType = 'NA') {
    if(transitCode=="") return;
    
    if( !$('#dia-transit-history').length ) {             
        $('<div id="dia-transit-history" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-transit-history').removeClass('hide');
    $('#dia-transit-history').dialog({
        autoOpen: true,
        height: 550,
        width: 800,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-transit-history').html(loading_small);  
    
    var data = {};
    data.transitCode = transitCode;  
    data.aliasCode = aliasCode;
    data.filterType = filterType;
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/transit-history",
        data: data,
        success: function (res) {
           $('#dia-transit-history').html(res);
           $('#dia-transit-history').find('a').focus();
        }
    })
}

function exportSchedule(id){
    
    if(id=="") return;
    
    $('.schd_rows').removeClass('last-active');
    $('#sch-' + id).addClass('last-active');
    
    if( !$('#dia-sch-export').length ) {             
        $('<div id="dia-sch-export" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-sch-export').removeClass('hide');
    $('#dia-sch-export').dialog({
        autoOpen: true,
        height: 350,
        width: 800,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-sch-export').html(loading_small); 
    
    var data = {};
    data.code = id;    
    $.ajax({
        type: "GET",
        dataType: 'html',
        url: base_url + "schedules/export-schedule",
        data: data,
        success: function (response) {
          $('#dia-sch-export').html(response);  
        }
    })
}

function closeCargoHistoryDialog() {
    $('#dia-cargo-history').dialog('destroy');
    $('#dia-cargo-history').hide();
    $('#dia-cargo-history').html('');
}

function closeCargoTransitHistoryDialog() {
    $('#dia-transit-history').dialog('destroy');
    $('#dia-transit-history').hide();
    $('#dia-transit-history').html('');
}

function interchangeStationsHome() {
    var stcode = $('#from-station').val();
    var tocode = $('#to-station').val();
    if(stcode == "" || tocode == "") {
        return;
    }
    $('#from-station').val(tocode);
    $('#from-station').select2('val', tocode);    
    
    toStationLoadingHome();
    
    $('#to-station').val(stcode);
    $('#to-station').select2('val', stcode);
    
    return;   
}

function toStationLoadingHome() {
    var stcode = $('#from-station').val();
    var html = '<option value=""></option>';
    $('#to-station').val('');
    $('#to-station').select2('val', '');
    
    var to_codes = eval(routes1[stcode]);
    var html="<option selected='selected' value=''>Select Destination</option>";
    $(to_codes).each(function() {
        html+="<option value="+this.code+">"+this.name+"</option>";
    });
    $('#to-station').html(html);
    return;    
}

function getCurrentDate(){
    var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1;
    var curr_year = d.getFullYear();
    if (curr_month < 10) {
        curr_month = '0' + curr_month;
    }
    if (curr_date < 10) {
        curr_date = '0' + curr_date;
    }
    var date_format = curr_year + '-' + curr_month + '-' + curr_date;   
    return date_format;
}

function openPrintTicket(pnr){
    
}

function getScheduleAdvanceBookingGraph(code, scheduleName = '') {
    $('.schd_rows').removeClass('last-active');
    $('#sch-' + code).addClass('last-active');
    $('#sch-adv-book-graph').css('background', '#fff');
    $('#sch-adv-book-graph').removeClass('hide');
    $('#sch-adv-book-graph').show();
    $('#sch-adv-book-graph').dialog({
        autoOpen: true,
        height: 500,
        width: $(window).width() - 100,
        modal: true,
        resizable: false
    });
    $('.ui-dialog-titlebar').hide();
    $('#sch-adv-book-graph-loader').html('<div class="text-center p_t_100">' + loading_big + '<div>');
    $('#adv-booking-trends-heading').html('');

    var data = {};
    data.schedule_code = code;
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'report/schedule-advance-booking-graph',
        data: data,
        success: function (res) {
            $('#adv-booking-trends-heading').html('Advance Booking and Fare Trends : ' + scheduleName);

            if (res.status === 0) {
                return;
            }

            var data = _.reduce(res.data, function (result, value) {
                var maxFare = _.max(_.map(value.stageList, function (stage) {
                    return _.max(_.map(stage.stageFare, function (o) {
                        return o.fare;
                    }));
                }));
                var date = moment(value.travelDate, 'YYYY-MM-DD').format('ddd D MMM');
                result[date] = {};
                result[date].occupancy = value.bookedSeatCount;
                result[date].maxfare = _.max([result[date].maxfare, maxFare]);
                result[date].stageList = value.stageList;
                if(!result[date].occupancy && !result[date].maxfare) {
                    delete result[date];
                }
                return result;
            }, {});
            
            drawBookingTrends(data);
        }
    });
}

function drawBookingTrends(data) {
    $('#sch-adv-book-graph-loader').highcharts({
        title: {text: ''},
        subtitle: {text: ''},
        xAxis: [{
                title: {
                    text: 'Travel Date',
                    style: {fontWeight: 'bold'}
                },
                categories: _.keys(data),
                crosshair: false
            }],
        yAxis: [{
                title: {
                    text: 'Fare',
                    style: {fontWeight: 'bold'}
                },
                opposite: true                

            }, {
                gridLineWidth: 0,
                title: {
                    text: 'No. of Seats Booked',
                    style: {fontWeight: 'bold'}
                },
            }],
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true,
                    formatter: function () {
                        if (this.y !== 0) {
                            return this.y;
                        }
                    }
                },
                legend: {enabled: true}
            },
            spline: {
                dataLabels: {
                    enabled: true,
                    formatter: function () {
                        if (this.y !== 0) {
                            return this.y;
                        }
                    }
                },
                legend: {enabled: true}
            }
        },
        tooltip: {
            shared: false,
            useHTML: true,
            percentageDecimals: 1,
            crosshairs: false,
            formatter: function () {
                if (this.series.index === 0) {
                    return '<b>' + this.x + '</b><table><tr><td style="color: ' + this.color + '">No. of Seats Booked</td><td style="text-align: right"><b>&nbsp;' + this.y + ' seats</b></td></tr></table>';
                } else if (this.series.index === 1) {
                    return '<b>' + this.x + '</b><div  style="border-top: 1px solid #b8b8b8;margin: 4px 0px;"></div>' + drawFareTable(data[this.x]);
                }
            }
        },
        credits: {enabled: false},
        legend: {enabled: true},
        exporting: {enabled: false},
        colors: ["#FF6040", "#A05030", "#D0B090", "#6600FF", "#64E572", "#FF9655", "#FFF263", "#6AF9C4"],
        series: [{
                name: 'No. of Seats Booked',
                type: 'column',
                yAxis: 1,
                data: _.map(data, function (o) {
                    return o.occupancy;
                })

            }, {
                name: 'Fare',
                type: 'spline',
                stickyTracking: false,
                data: _.map(data, function (o) {
                    return o.maxfare;
                })
            }]
    });
}

function drawFareTable(data) {
    var head = $.map(data.stageList[0].stageFare, function(o) {
                   return '<th>&emsp;' + o.seatName + '</th>';
               }).join('');
    
    var body = $.map(data.stageList, function(stage) {
        var fares =  $.map(stage.stageFare, function(o) {
                        return '<td align="right">' + o.fare + '</td>';
                     }).join('');
                     
        return '<tr><td>' + stage.fromStation.name + '-' + stage.toStation.name + '</td>' + fares + '</tr>';
    }).join('');
    
    return '<table><tr><th>Route</th>' + head + '</tr>' + body + '</table>';
}

function closeAdvBookPopup() {
    $('#sch-adv-book-graph').dialog('destroy');
    $('#sch-adv-book-graph').addClass('hide');
}

function printTktWindow(nscode, pnr, type, print='', download=''){
    if(download != 1) { 
        $('#print-tkt-dialog').css('background', '#fff');
        $('#print-tkt-dialog').removeClass('hide');
    
        $('#print-tkt-dialog').dialog({
            autoOpen: true,
            height: 700,
            width: 1100,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
    }
    if(type == undefined){
        type = 'ticket';
    }
    $('#print-tkt-iframe > iframe').attr('src',$('#print-tkt-iframe > iframe').attr('url')+'?nscode='+nscode+'&pnr='+pnr+'&type='+type+'&print='+print+'&download='+download);
}

function closePrintTktWindow(){
    $('#print-tkt-iframe > iframe').attr('src','');
    $('#print-tkt-dialog').dialog('close');
}

function namespaceFilter(element , event){
    var value = $(element).val();
    $("#s_name .nasp-item > a").each(function() {
        if ($(this).text().search(new RegExp(value, "i")) > -1) {
            $(this).parent('li').show();
        } else {
            $(this).parent('li').hide();
        }
    });
}

function stopProp(event){
    event.stopPropagation();
}

function focusSearch(event){
    namespaceFilter('','');
    setTimeout(function(){
        $('#nasp-input').val('').focus();
    });
}

function toggleNsSelction(e) {
    var $allLinks = $('#s_name > .nasp-item');
    var $visibleLinks = $allLinks.filter(':visible');
    var $activeLink = $visibleLinks.filter('.active');

    if (e.which === 40) {
        $allLinks.removeClass('active');
        $activeLink = $activeLink.nextAll(':visible:first').addClass('active');
        if ($activeLink.length === 0) {
            $activeLink = $visibleLinks.first().addClass('active');
        }
        e.preventDefault();
    } else if (e.which === 38) {
        $allLinks.removeClass('active');
        $activeLink = $activeLink.prevAll(':visible:first').addClass('active');
        if ($activeLink.length === 0) {
            $activeLink = $visibleLinks.last().addClass('active');
        }
        e.preventDefault();
    } else if (e.which === 13) {
        $activeLink.find('a:first').trigger('click');
    }

    if ($activeLink.get(0)) {
        $activeLink.get(0).scrollIntoView({behavior: 'instant', block: 'center'});
    }
}

function switchBackToUser(){
    var data = {};
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/switch-to-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                window.setTimeout(function() {
                    loading_overlay.hide();
                    window.location.reload(true);
                }, 2000);
            } else {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        }
    });
}

function sendUserOTP() {
    var loading_overlay = iosOverlay({
        text: "Sending...",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "user/send-user-otp",
        data: {},
        success: function(response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "OTP Sent"
                });
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            } else {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        }
    });
}

function isValidGstin(str){
    var filter = new RegExp('^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    if (filter.test(str)) {
        return true;
    } else {
        return false;
    }
}

function customerGstDialog(pnr) {
    $('.inp_error').removeClass('inp_error');
    $('#cust-gst-action-state').removeClass('alert-success alert-danger').addClass('hide');
    $('#cust-gst-pnr').val(pnr);
    $('#cust-gstin').val('');
    $('#cust-gsttrade').val('');
    
    $('#cust-gst-update-btn').html(loading_small).show();
    
    var data = {};
    data.ticketCode = pnr;
    
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'ticket/get-customer-gst-details',
        data: data,
        success: function (res) {
            $('#cust-gst-update-btn').html('').hide();
            if(res.status == 1) {
                $('#cust-gst-details-txt').html(res.data.tradeName + '<br/>' + res.data.gstin).show();
            } else if(res.errorCode == 207){
                $('#update-cust-gst-dialog').css('background', '#fff');
                $('#update-cust-gst-dialog').removeClass('hide');
                $('#update-cust-gst-dialog').dialog({
                    autoOpen: true,
                    height: 430,
                    width: 550,
                    modal: true,
                    resizable: false
                });
                $('.ui-dialog-titlebar').hide();
            } 
        }
    });
    
}

function cancelCustomerGst() {
    $('#update-cust-gst-dialog').dialog('destroy');
    $('#update-cust-gst-dialog').hide();
}

function saveCustomerGst() {    
    var data = {}, err = 0;
    data.ticketCode = $('#cust-gst-pnr').val();
    data.gstin = $.trim( $('#cust-gstin').val() );
    data.email = $.trim( $('#cust-gstemail').val() );
    data.tradeName = $.trim( $('#cust-gsttrade').val() );
    
    $('.inp_error').removeClass('inp_error');
    if (!isValidGstin(data.gstin)) {
        $('#cust-gstin').addClass('inp_error');
        err++;
    } 
    if (data.tradeName == '') {
        $('#cust-gsttrade').addClass('inp_error');
        err++;
    } 
    if (data.email != "" && !isValidEmailAddress(data.email)) {
        $('#cust-gstemail').addClass('inp_error');
        $('#cust-gst-action-state').removeClass('hide alert-success').addClass('alert-danger');
        $('#cust-gst-action-state').html('Invalid Email Address');
        return false;
    } 
    
    if (err > 0) {
        $('#cust-gst-action-state').removeClass('hide alert-success').addClass('alert-danger');
        $('#cust-gst-action-state').html('Please enter/select the values in the field that are marked in red');
        return false;
    }
    
    $('#cust-gst-action-state').removeClass('hide alert-danger alert-success');            
    $('#cust-gst-action-state').html(loading_small);  
    
    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'ticket/update-customer-gst-details',
        data: data,
        success: function (res) {
            if(res.status == 1) {
                $('#cust-gst-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#cust-gst-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelCustomerGst();
                    customerGstDialog(data.ticketCode);
                }, 3000);
            } else {
                $('#cust-gst-action-state').addClass('alert-danger');
                $('#cust-gst-action-state').html(res.errorDesc);
            }
        }
    });
}

function scanQRCode(selector) {
    if (!selector) return;

    var applySearchResult = function (result) {
        if ($(selector).is(':input')) {
            var enterKey = $.Event('keypress', { keyCode: 13, which: 13 });
            $(selector).val(result).trigger(enterKey);
        } else {
            $(selector).text(result);
        }
    };

    $(document).one('custom:qr-scanned', function(e, data) {
        var result = $.trim(data.result);

        if (result.split('/').length > 2) {
            var data = {};
            data.slug = result;

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/get-slug-details',
                data: data,
                success: function (res) {
                    if (res.status == 1) {
                        applySearchResult(res.data.lr);
                    }
                }
            });
        } else {
            applySearchResult(result);
        }
    });

    if ($('#qr-scan-details').length) {
        startQRScanner();
        showScanQRDialog();
        return;
    }

    $('<div id="qr-scan-details" class="hide dialog-content-page"></div>').appendTo('body');
    $('#qr-scan-details').removeClass('hide').html(loading_small);
    showScanQRDialog();

    var data = {};
    $.ajax({
        type: 'POST',
        dataType: 'html',
        url: base_url + 'cargo/scan-qr-code',
        data: data,
        success: function (res) {
            $('#qr-scan-details').html(res);
            startQRScanner();
        }
    });
}

function showScanQRDialog() {
    $('#qr-scan-details').dialog({
        autoOpen: true,
        height: 460,
        width: 650,
        modal: true,
        closeOnEscape: true,
        resizable: false
    });
}

function hideScanQRDialog() {
    $('#qr-scan-details').dialog('destroy').hide();
}

function showRecentBookings() {
    if (!$('#recent-bookings').length) {
        $('<div id="recent-bookings" class="hide dialog-content-page"></div>').appendTo('body');
    }

    $('#recent-bookings').removeClass('hide');
    $('#recent-bookings').dialog({
        autoOpen: true,
        height: $(window).height() - 200,
        width: $(window).width() - 250,
        modal: true,
        closeOnEscape: true,
        resizable: false
    });
    $('#recent-bookings').html(loading_small);

    $.ajax({
        type: 'GET',
        dataType: 'html',
        url: base_url + 'cargo/recent-bookings',
        success: function (response) {
            $('#recent-bookings').html(response);
        }
    });
}

function LRDetailsHotKeys() {
    const OPTIONS = {
        element: document.querySelector('#dia-cargo-details'),
    }

    hotkeys('alt+p', OPTIONS, function() {
        $('#print-button').trigger('click');
    });

    hotkeys('alt+shift+p', OPTIONS, function() {
        $('#print-preferences-button').trigger('click');
    });
}

function userBranchFilter(element , event){
    var value = $(element).val();
    $("#b_name .brch-item > a").each(function() {
        if ($(this).text().search(new RegExp(value, "i")) > -1) {
            $(this).parent('li').show();
        } else {
            $(this).parent('li').hide();
        }
    });
}

function focusSearchBranch(event){
    userBranchFilter('','');
    setTimeout(function(){
        $('#brch-input').val('').focus();
    });
}

function toggleBranchSelction(e) {
    var $allLinks = $('#b_name > .brch-item');
    var $visibleLinks = $allLinks.filter(':visible');
    var $activeLink = $visibleLinks.filter('.active');

    if (e.which === 40) {
        $allLinks.removeClass('active');
        $activeLink = $activeLink.nextAll(':visible:first').addClass('active');
        if ($activeLink.length === 0) {
            $activeLink = $visibleLinks.first().addClass('active');
        }
        e.preventDefault();
    } else if (e.which === 38) {
        $allLinks.removeClass('active');
        $activeLink = $activeLink.prevAll(':visible:first').addClass('active');
        if ($activeLink.length === 0) {
            $activeLink = $visibleLinks.last().addClass('active');
        }
        e.preventDefault();
    } else if (e.which === 13) {
        $activeLink.find('a:first').trigger('click');
    }

    if ($activeLink.get(0)) {
        $activeLink.get(0).scrollIntoView({behavior: 'instant', block: 'center'});
    }
}

function userBranchSwitch(code) {
    var data = {}
    data.code = code;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "user/switch-branch",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });

                window.setTimeout(function () {
                    window.location = "";
                }, 1000);
            }
        }
    })
}

function roundUpValue(value, offset) {
    return Math.ceil(value / offset) * offset;
}

function roundDownValue(value, offset) {
    return Math.floor(value / offset) * offset;
}

function roundUpOrDownValue(value, offset) {
    if (offset > 0) {
        return roundUpValue(value, Math.abs(offset));
    }
    if (offset < 0) {
        return roundDownValue(value, Math.abs(offset));
    }
    return value;
}

function showLRdetails(userCode, filterType, fromDate, toDate) {
    if (!$('#user-lrdetails-dialog').length) {
        $('<div id="user-lrdetails-dialog"  class="dialog-content-page" style="display: none;"></div>').appendTo('body');
    }

    $('#user-lrdetails-dialog').html(loading_small);

    $('#user-lrdetails-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    var data = {};
    data.userCode = userCode;
    data.fromDate = fromDate;
    data.toDate = toDate;
    data.filterType = filterType;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "branch/user-lrdetails-list",
        data: data,
        success: function (response) {
            $('#user-lrdetails-dialog').html(response);
        }
    });
}

function showRevertLRdetails(userCode, filterType, fromDate, toDate) {
    if (!$('#user-lrdetails-dialog').length) {
        $('<div id="user-lrdetails-dialog"  class="dialog-content-page" style="display: none;"></div>').appendTo('body');
    }

    $('#user-lrdetails-dialog').html(loading_small);

    $('#user-lrdetails-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    var data = {};
    data.userCode = userCode;
    data.fromDate = fromDate;
    data.toDate = toDate;
    data.filterType = filterType;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "branch/user-revert-lrdetails-list",
        data: data,
        success: function (response) {
            $('#user-lrdetails-dialog').html(response);
        }
    });
}

function showIEdetails(organizationCode, filterType, fromDate, toDate, receiptCode) {
    if (!$('#user-lrdetails-dialog').length) {
        $('<div id="user-lrdetails-dialog"  class="dialog-content-page" style="display: none;"></div>').appendTo('body');
    }

    $('#user-lrdetails-dialog').html(loading_small);

    $('#user-lrdetails-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 150,
        width: $(window).width() - 200,
        modal: true,
        resizable: false
    });

    var data = {};
    data.organizationCode = organizationCode;
    data.fromDate = fromDate;
    data.toDate = toDate;
    data.transactionType = filterType;
    data.organizationReceiptCode = receiptCode;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "branch/branch-iedetails-list",
        data: data,
        success: function (response) {
            $('#user-lrdetails-dialog').html(response);
        }
    });
}

function closeLRdetails() {
    $('#user-lrdetails-dialog').dialog('destroy');
    $('#user-lrdetails-dialog').hide();
}

function INRFormat(num) {
    return Number(num).toLocaleString('en-IN', { maximumFractionDigits: 2, minimumFractionDigits: 2 });
}

function cleanString(string = '') {
    return string.replace(/[^\w\s]/gi, '').toUpperCase();
}

function proofDocumentGallery(lrcode){
    proofupload.clearFiles();
    $('.proof-gallery-document').html('');
    $('.file-upload-gallery').html('');

    $('#proof-gallery-dialog').dialog({
        autoOpen: true,
        height: 460,
        width: 650,
        modal: true,
        closeOnEscape: true,
        resizable: false
    });

    var data = {};
    data.cargoCode = lrcode
    data.imageCategoryCode = 'LRPROOF';

    $('#tab_pob .file-upload-gallery').html(loading_popup);
    $('#proof-gallery-alert')
        .removeClass('alert-success alert-danger alert-info hide')
        .addClass('hide').html('');

    $.ajax({
        type: 'POST',
        url: base_url + 'config/get-image-details',
        data: data,
        dataType: 'json',
        success: function(response) {
            $('#tab_pob .file-upload-gallery').html('');
            if (response.status == 1) {
                $.each(response.data || [], function(i, proof) {
                    var category = (proof.documentCategory.code || '').toLowerCase();
                    var $tab = $('#tab_' + category);
                    var gallerynode = $tab.find('.file-upload-gallery').html('');

                    $tab.find('.proof-gallery-document').html(proof.documentType.name + ' : ' + proof.documentNumber +'  ' + 'Mobile Number : ' + proof.mobileNumber);
                    $.each(proof.files || [], function(i, file) {
                        proofupload.renderfile(file, gallerynode);
                    });
                    $tab.find('.fileremove').addClass('hide');
                    proofupload.initGallery($tab);
                });

                $('#tab_pob, #tab_pod').find('.file-upload-gallery:empty').html('<div class="well" style="grid-column: 1 / -1;">No files found</div>');
                $('#proof-gallery-alert').html('').addClass('hide');
            } else {
                $('#proof-gallery-alert')
                    .html(response.errorDesc)
                    .addClass('alert-danger');
            }
            getWebcamUploadedFiles(data.cargoCode);
        }
    });
}

function getWebcamUploadedFiles(code) {
    var data = {};
    data.cargoCode = code;
    data.imageCategoryCode = 'LRPROOF';

    $('#tab_pob .file-webcam-upload-gallery').html(loading_popup);
    $('#proof-gallery-alert')
        .removeClass('alert-success alert-danger alert-info hide')
        .addClass('hide').html('');

    $.ajax({
        type: 'POST',
        url: base_url + 'config/get-webcam-uploaded-files',
        data: data,
        dataType: 'json',
        success: function(response) {
            $('#tab_pob .file-webcam-upload-gallery').html('');
            if (response.status == 1) {
                $.each(response.data || [], function(i, proof) {
                    var category = (proof.documentCategory.code || '').toLowerCase();
                    var $tab = $('#tab_' + category);
                    
                    $tab.find('.webcam-proof-gallery-document').html(proof.documentType.name + ' : ' + proof.documentNumber +'  ' + 'Mobile Number : ' + proof.mobileNumber);
                    var images = "";                                                         
                    $.each(proof.files || [], function(i, file) {
                        images += '<img src="'+file.imageUrlSlug+'">';
                    });
                    $tab.find('.file-webcam-upload-gallery').html(images);
                    $tab.find('.fileremove').addClass('hide');
                });

                $('#tab_pob, #tab_pod').find('.file-webcam-upload-gallery:empty').html('<div class="well" style="grid-column: 1 / -1;">No files found</div>');
                $('#proof-gallery-alert').html('').addClass('hide');
            } else {
                $('#proof-gallery-alert')
                    .html(response.errorDesc)
                    .addClass('alert-danger');
            }
        }
    });
}

function hideProofGallery() {
    $('#proof-gallery-dialog').dialog('destroy');
    $('#proof-gallery-dialog').hide();
}

function showInvoicePdfDialog(code) {
    $('#cargo-invoice-iframe').html('');
    $('#cargo-invoice-pdf-dialog').css('background', '#fff');
    $('#cargo-invoice-pdf-dialog').removeClass('hide');
    $('#cargo-invoice-pdf-dialog').dialog({
        autoOpen: true,
        height: 700,
        width: 1100,
        modal: true,
        resizable: false,
        closeOnEscape: false
    });
    $('.ui-dialog-titlebar').hide();

    var $iframe = $('<iframe />');
    $iframe.attr('src', base_url + 'cargo/invoice-partial-transactions?paymentCode=' + code);
    $iframe.attr('class', 'iframe-fullwidth iframe-loading-bg');
    $('#cargo-invoice-iframe').html($iframe);
}

function closeInvoicePdfDialog() {
    $('#cargo-invoice-iframe').html('');
    $('#cargo-invoice-pdf-dialog').dialog('destroy');
    $('#cargo-invoice-pdf-dialog').hide();
}

function vendorInfoTooltip(vendorCode, tooltipEl, options) {
    if (isNull(vendorCode)) {
        $(tooltipEl).popover('destroy').prop('disabled', true);
        return;
    }

    var defaultOptions = {
        container: '#main_page_content',
        html: true,
        trigger: 'hover',
    };
    var tooltipOptions = $.extend(defaultOptions, options);

    tooltipOptions.content = loading_popup;

    $(tooltipEl).popover('destroy')
        .popover(tooltipOptions)
        .on('show.bs.popover', function () {
            var data = {};
            data.vendorCode = vendorCode;

            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'widget-cargo/vendor-details',
                data: data,
                success: function (response) {
                    tooltipOptions.content = response;
                    $(tooltipEl).popover('destroy').popover(tooltipOptions);
                    if ($(tooltipEl).is(':focus, :hover')) {
                        $(tooltipEl).popover('show');
                    }
                }
            });
        });
}

function quickAddNewVehicle() {
    $('#quick-vehicle-action-state').removeClass('alert alert-danger alert-success').html('').hide();
    $('#quick-add-vehicle-dialog .inp_error').removeClass('inp_error');
    $('#quick_vehicle_regno').val('');
    $('#quick_vehicle_type').val('');
    $('#quick_vehicle_own_type').val('OWN');
    $('#quick-vehicle-buttons').show();
    
    $('#quick-add-vehicle-dialog').css('background', '#fff');
    $('#quick-add-vehicle-dialog').removeClass('hide');
    $('#quick-add-vehicle-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 500,
        modal: true,
        resizable: false,
        closeOnEscape: false
    });

    var dialog = $('#quick-add-vehicle-dialog').data('uiDialog');
    dialog.uiDialog.on('input', '#quick_vehicle_regno', function() {
        this.value = this.value.replace(/[^a-zA-Z\d\s:]/, '').toUpperCase();
    });
}

function closeQuickAddVehicle() {
    $('#quick-add-vehicle-dialog').dialog('destroy');
    $('#quick-add-vehicle-dialog').hide();
}

function saveQuickAddVehicle() {
    var data = {}, err = 0;
    data.activeFlag = 1;
    data.registationNumber = $.trim($('#quick_vehicle_regno').val());
    data.vehicleType = {};
    data.vehicleType.code = $('#quick_vehicle_type').val();
    data.ownershipType = {};
    data.ownershipType.code = $('#quick_vehicle_own_type').val();

    var err = 0;
    $('#quick-add-vehicle-dialog .inp_error').removeClass('inp_error');
    if (data.registationNumber == '') {
        $('#quick_vehicle_regno').addClass('inp_error');
        err++;
    }
    if (data.vehicleType.code == '') {
        $('#quick_vehicle_type').addClass('inp_error');
        err++;
    }
    if (data.ownershipType.code == '') {
        $('#quick_vehicle_own_type').addClass('inp_error');
        err++;
    }

    if (err) {
        $('#quick-vehicle-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#quick-vehicle-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    $('#quick-vehicle-buttons').hide();
    $('#quick-vehicle-action-state').removeClass('alert alert-danger alert-success').html(loading_popup).show();
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/quick-add-vehicle",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#quick-vehicle-action-state').addClass('alert alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    closeQuickAddVehicle();
                    checkURL();
                }, 1500);
            } else {
                $('#quick-vehicle-action-state').addClass('alert alert-danger').html(response.errorDesc);
                $('#quick-vehicle-buttons').show();
            }
        }
    })
}

function showStartTransitDialog(params, onCloseCallback = () => {}) {
    $('#start-transit-dialog').removeClass('hide');
    $('#start-transit-dialog').dialog({
        autoOpen: true,
        width: 800,
        height: 600,
        modal: true,
        closeOnEscape: true,
        resizable: false,
        beforeClose: onCloseCallback,
        close: function () {
            $('#start-transit-dialog').dialog('destroy');
            $('#start-transit-dialog').hide();
        }
    });

    $('#start-transit-panel').html(loading_small);

    var data = {};
    data.vehicleCode = params.vehicleCode;
    data.transitCode = params.transitCode;
    data.transitFromOrganizationCode = params.fromOrganizationCode;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/start-transit-odometer",
        data: data,
        success: function (response) {
            $('#start-transit-panel').html(response);
        }
    });
}

function hideStartTransitDialog(event) {
    $('#start-transit-dialog').dialog('close', event);
}

function startTransitTrip() {
    $('.inp_error').removeClass('inp_error');
    var data = {}, err = 0;

    data.action = 'DEPARTURE';
    data.transitCode = $('#start-transit-transitcode:hidden').val();
    data.transitCargo = {};
    data.transitCargo.code = $('#start-transit-transitcode:hidden').val();
    data.fromOrganization = {};
    data.fromOrganization.code = $('#start-transit-organization:hidden').val();
    data.startOdometer = Number($('#start-transit-odo').val());
    data.departureAt = moment().format('YYYY-MM-DD HH:mm:ss');
    data.fromOrganizationContact = {};
    data.fromOrganizationContact.code = $('#start-transit-supervisor').val();

    if (isNaN(data.startOdometer) || data.startOdometer <= 0) {
        $('#start-transit-odo').addClass('inp_error');
        err++;
    }
    var lastOdometer = $('#start-transit-last-odometer').data('odometer');
    if (lastOdometer > 0 && data.startOdometer < lastOdometer) {
        $('#start-transit-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#start-transit-action-state').html('Entered odometer value should be greater than last odometer value');
        return;
    }

    var namespace = $('#namespace_code').val();
    var vehicleOwnershipType = $('#emptyload_vehicle_owntype').val();
    if (isNull(startTransitOdoDetails) || (startTransitOdoDetails && (startTransitOdoDetails.startOdometer == 0))) {
        // fuel expense
        data.fuelExpenseCode = '';
        data.activeFlag = 1;
        data.fuelDate = moment().format('YYYY-MM-DD');
        data.vehicle = {};
        data.vehicle.code = $('#start-transit-vehicle').val();
        data.vendorContact = {};
        data.vendorContact.code = $('#start-transit-fuel-vendor').val();
        data.litres = Number($('#start-transit-fuel-litres').val());
        data.pricePerLitre = Number($('#start-transit-fuel-rate').val());
        data.totalAmount = data.litres * data.pricePerLitre;
        data.billNumber = $.trim($('#start-transit-fuel-coupon').val());

        // hiring amount and advance amount
        data.ogpl = [];

        if ((namespace == 'seenutransports' && vehicleOwnershipType == "HIRE") || namespace != 'seenutransports') {
            var hire = {};
            hire.code = '';
            hire.activeFlag = 1;
            hire.amount = Number($('#start-transit-hire-amount').val());
            hire.remarks = '';
            hire.user = {};
            hire.user.code = $('#start-transit-user:hidden').val();
            hire.transitCargo = {};
            hire.transitCargo.code = $('#start-transit-transitcode:hidden').val();
            hire.cashbookType = {};
            hire.cashbookType.code = 'HIRING';

            if (Number(hire.amount) > 0) {
                data.ogpl.push(hire);
            }
        }

        var advance = {};
        advance.code = '';
        advance.activeFlag = 1;
        advance.amount = Number($('#start-transit-advance-amount').val());
        advance.remarks = '';
        advance.user = {};
        advance.user.code = $('#start-transit-user:hidden').val();
        advance.transitCargo = {};
        advance.transitCargo.code = $('#start-transit-transitcode:hidden').val();;
        advance.transactionMode = {};
        advance.transactionMode.code = $('#start-transit-adv-paymode').val();
        advance.cashbookType = {};
        advance.cashbookType.code = 'ADVANCE';
        advance.paymentByContact = {};
        advance.paymentByContact.code = $('#start-transit-adv-payby').val();

        if (Number(advance.amount) > 0) {
            data.ogpl.push(advance);
        }

        // hire amount and advance amount
        if ((namespace == 'seenutransports' && vehicleOwnershipType == "HIRE" && isNotNull(hire) && hire.amount != '') || (namespace != 'seenutransports' && isNotNull(hire) && hire.amount != '') || advance.amount != '' || advance.transactionMode.code != '' || advance.paymentByContact.code != '') {
            if (isNotNull(hire) && hire.amount == '') {
                $('#start-transit-hire-amount').addClass('inp_error');
                err++;
            }
            if (advance.amount == '') {
                $('#start-transit-advance-amount').addClass('inp_error');
                err++;
            }
            if (advance.transactionMode.code == '') {
                $('#start-transit-adv-paymode').addClass('inp_error');
                err++;
            }
            if (advance.paymentByContact.code == '') {
                $('#start-transit-adv-payby').addClass('inp_error');
                err++;
            }
        }

        // fuel expense
        if (data.vendorContact.code != '' || data.litres != '' || data.pricePerLitre != '' || data.billNumber != '') {
            if (data.vendorContact.code == '') {
                $('#start-transit-fuel-vendor').addClass('inp_error');
                err++;
            }
            if (data.litres == '') {
                $('#start-transit-fuel-litres').addClass('inp_error');
                err++;
            }
            if (data.pricePerLitre == '') {
                $('#start-transit-fuel-rate').addClass('inp_error');
                err++;
            }
            if (data.billNumber == '') {
                $('#start-transit-fuel-coupon').addClass('inp_error');
                err++;
            }
        }
    }

    if (err) {
        $('#start-transit-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#start-transit-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    $('#start-transit-panel-btn').hide();
    $('#start-transit-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-start-odometer",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#start-transit-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideStartTransitDialog($.Event('startTripSuccess', { data: { success: 1 } }));
                }, 3000);
            } else {
                $('#start-transit-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#start-transit-panel-btn').show();
            }
        }
    });
}

function showEndTripDialog(params, onCloseCallback = () => {}) {
    $('#end-transit-dialog').removeClass('hide');
    $('#end-transit-dialog').dialog({
        autoOpen: true,
        width: 550,
        height: 350,
        modal: true,
        closeOnEscape: true,
        resizable: false,
        beforeClose: onCloseCallback,
        close: function () {
            $('#end-transit-dialog').dialog('destroy');
            $('#end-transit-dialog').hide();
        }
    });

    $('#end-transit-panel').html(loading_small);

    var data = {};
    data.vehicleCode = params.vehicleCode;
    data.transitCode = params.transitCode;
    data.transitToOrganizationCode = params.toOrganizationCode;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/end-transit-odometer",
        data: data,
        success: function (response) {
            $('#end-transit-panel').html(response);
        }
    });
}
function showEndTripDialogV2(params) {
    $('#end-transit-dialog').removeClass('hide');
    $('#end-transit-dialog').dialog({
        autoOpen: true,
        width: 550,
        height: 350,
        modal: true,
        closeOnEscape: true,
        resizable: false,
        close: function () {
            $('#end-transit-dialog').dialog('destroy');
            $('#end-transit-dialog').hide();
        }
    });

    $('#end-transit-panel').html(loading_small);

    var data = {};
    data.vehicleCode = params.vehicleCode;
    data.transitCode = params.transitCode;
    data.transitToOrganizationCode = params.toOrganizationCode;

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/end-transit-odometer",
        data: data,
        success: function (response) {
            
            $('#end-transit-panel').html(response);
        }
    });
}

function hideEndTransitDialog(event) {
    $('#end-transit-dialog').dialog('close', event);
}

function endTransitTrip() {
    var data = {}, err = 0;
    data.action = 'ARRIVAL';
    data.transitCode = $('#end-transit-transitcode:hidden').val();
    data.transitCargo = {};
    data.transitCargo.code = $('#end-transit-transitcode:hidden').val();
    data.toOrganization = {};
    data.toOrganization.code = $('#end-transit-organization:hidden').val();
    data.endOdometer = Number($('#end-transit-odo').val());
    data.arrivalAt = moment().format('YYYY-MM-DD HH:mm:ss');
    data.toOrganizationContact = {};
    data.toOrganizationContact.code = $('#end-transit-supervisor').val();

    $('.inp_error').removeClass('inp_error');
    if (isNaN(data.endOdometer) || data.endOdometer < 0) {
        $('#end-transit-odo').addClass('inp_error');
        err++;
    }
    var lastOdometer = $('#end-transit-last-odometer').data('odometer');
    if (lastOdometer > 0 && data.endOdometer < lastOdometer) {
        $('#end-transit-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#end-transit-action-state').html('Entered odometer value should be greater than last odometer value');
        return;
    }
    if (err) {
        $('#end-transit-action-state').removeClass('alert-success hide').addClass('alert alert-danger').show();
        $('#end-transit-action-state').html('Please enter/select the values in the field that are marked in red');
        return;
    }
    $('#end-transit-panel-btn').hide();
    $('#end-transit-action-state').removeClass('alert').removeClass('alert-danger').removeClass('alert-success').html(loading_popup);

    // saveEmptyUnload(code);

    $.ajax({
        type: "POST",
        url: base_url +"cargo/empty-load-accept",
        data: data,
        success: function (response) {
            response = JSON.parse(response);
           if (response.status == 1) {
            alert('succuss');
                $('#end-transit-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
                window.setTimeout(function () {
                    hideEndTransitDialog($.Event('endTripSuccess', { data: { success: 1 } }));
                }, 3000);
            } else {
                $('#end-transit-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
                $('#end-transit-panel-btn').show();
            }
        }
    });
    // $.ajax({
    //     type: "POST",
    //     dataType: 'json',
    //     url: base_url + "cargo/update-end-odometer",
    //     data: data,
    //     success: function (response) {
    //         if (response.status == 1) {
    //             $('#end-transit-action-state').addClass('alert').addClass('alert-success').html('Your request processed successfully');
    //             window.setTimeout(function () {
    //                 hideEndTransitDialog($.Event('endTripSuccess', { data: { success: 1 } }));
    //             }, 3000);
    //         } else {
    //             $('#end-transit-action-state').addClass('alert').addClass('alert-danger').html(response.errorDesc);
    //             $('#end-transit-panel-btn').show();
    //         }
    //     }
    // })
}
function btnBlock(element){
    $(element).attr('disabled',true);
    setInterval(() => {
        $(element).attr("disabled", false);
    },2000);
    
}