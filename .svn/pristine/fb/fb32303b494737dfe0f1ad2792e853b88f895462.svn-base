$(document).ready(function() {
    $('input#list_search').quicksearch('#user_list_search #usr_scroll > li');
});

function addStationPointDialog(code, spcode) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-sp-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
    $('#form-sp-bttons').show();
    
    $('#hid_urs_sp_code').val(code);
    $('#hid_sp_code').val(spcode);
    
    $("#user_stations, #user_stations_point ,#brdg_comm ").val('');
    $('#user_group').multiselect('deselectAll', false);
    $('#user_group').multiselect('refresh');

    $('#edit-user-stationpoint').dialog({
        autoOpen: true,
        height: 650,
        width: 500,
        modal: true,
        resizable: false
    });

    $(".ui-dialog-titlebar").hide();
}

function addTdsDialog(code, tdscode) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-tds-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
    $('#form-tds-bttons').show();
    
    $('#hid_urs_tds_code').val(code);
    $('#hid_tds_code').val(tdscode);

    $('#edit-user-tds').dialog({
        autoOpen: true,
        height: 550,
        width: 500,
        modal: true,
        resizable: false
    });
    
    $('#usr_tds_date').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '-0D',
        endDate: '+12m',
        changeMonth: true,
    })

    $(".ui-dialog-titlebar").hide();
}

function cancelUserTdsDialog() {
    $('#edit-user-tds').dialog('destroy');
    $('#edit-user-tds').hide();
}

function saveUserTds() {
    var data = {}
    data.tdsvalue = $('#usr_tds_value').val();
    data.effectivedate = $('#usr_tds_date').val();    
    data.pan = $('#usr_tds_pan').val();
    
    data.code = $('#hid_tds_code').val();
    data.userCode = $('#hid_urs_tds_code').val();

    $("#usr_tds_value, #usr_tds_date, #usr_tds_pan").removeClass('inp_error');
    $('#usr-tds-state').html('');
    $('#usr-tds-state').hide();
    
    var err = 0;
    if (Number(data.tdsvalue) <=0 ) {
        $("#usr_tds_value").addClass('inp_error');
        err++;
    } else if (isNaN(data.tdsvalue)) {
        $("#usr_tds_value").addClass('inp_error');
        err++;
    }
    
    if (data.effectivedate == '') {
        $("#usr_tds_date").addClass('inp_error');
        err++;
    }
    
    if (data.pan == '') {
        $('#usr_tds_pan').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#ur-tds-loading').html('');
        $('#ur-tds-loading').hide();
        $('#usr-tds-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-tds-state').html('Please enter the values in the field that are marked in red');
        $('#usr-tds-state').show();
        return false;
    }
    
    $('#form-tds-bttons').hide();
    $('#ur-tds-loading').html(loading_popup);
    $('#ur-tds-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/save-user-tds",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-tds-loading').html('');
                $('#ur-tds-loading').hide();
                $('#usr-tds-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-tds-state').show();
                $('#usr-tds-state').html('Your request has been completed successfully');
                
                window.setTimeout(function() {
                    cancelUserTdsDialog();                    
                    loadUserTds(data.userCode);
                }, 3000);                
            } else {
                $('#ur-tds-loading').html('');
                $('#ur-tds-loading').hide();
                $('#usr-tds-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-tds-state').show();
                $('#usr-tds-state').html(response.errorDesc);
            }
        }
    });
}

function deleteUserTds(usercode) {
    var data = {};
    data.options = g_usertds[0];
    if(confirm('Do you want to delete this TDS deduction?')) {                
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-user-tds",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    loadUserTds(usercode);
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
        });
    }    
}


var g_usertds = '';
function loadUserTds(usercode) {    
    $('.tds').html(loading_small);
    var data = {}
    data.userCode = usercode;
    var htmlsp = '';
    var c = 1;
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/user-tds",
        data: data,
        success: function(response) {
            if (response.status = 1 && response.data != undefined) {
                g_usertds = response.data;
                cvalues = response.data; 
                if( _isdefined(cvalues.tdsTaxValue) ) {
                    htmlsp += "<tr>";
                    htmlsp += "<td>"+dateToDateTime(cvalues.fromDate,1)+"</td>";
                    htmlsp += "<td>"+cvalues.tdsTaxValue+" %</td>";
                    htmlsp += "<td>"+cvalues.panCardCode+"</td>";                    
                    htmlsp += "</td><td>\n\
                                <a class='btn btn-default btn-xs'  title='delete' onclick=\"deleteUserTds('"+usercode+"')\">\
                                    <i class='fa fa-trash'></i>\n\
                                </a></td>";
                    htmlsp += "</tr>";
                    
                    c++;
                    $('.tds').html(htmlsp);
                } else {
                    $('.tds').html('<tr><td colspan="4">No TDS configured</td></tr>');
                }               
            } else {
               $('.tds').html('<tr><td colspan="4">No TDS configured</td></tr>');
            }
            $('.addtds').attr("onclick", "addTdsDialog('" + usercode + "')");
        }
    });
}


var g_userstationpoints = '';
function loadUserStationPoints(stcode) {
    $('.staionpoints').html(loading_small);
    var data = {}
    data.userCode = stcode;
    var htmlsp = '';
    var c = 1;
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/user-stationpoints",
        data: data,
        success: function(response) {
            if (response.status = 1 && response.data != undefined) {
                g_userstationpoints = response.data;
                $.each(response.data, function(keys1, cvalues) {
                    htmlsp += "<tr>";                    
                    htmlsp += "<td>"+cvalues.station.name+"</td>";
                    htmlsp += "<td>"+cvalues.name+"</td>";
                    htmlsp += "<td>"+cvalues.boardingCommission+"</td><td>";
                    $.each(cvalues.userGroupList, function(k,v) {
                        htmlsp += v.name + '<br/>';
                    });
                    htmlsp += "</td><td>\n\
                                <a class='btn btn-default btn-xs'  title='delete' onclick=\"deleteUserStationPoint('"+stcode+"', '" + cvalues.code + "')\">\
                                    <i class='fa fa-times'></i>\n\
                                </a></td>";
                    htmlsp += "</tr>";
                    
                    c++;
                });
                $('.staionpoints').html(htmlsp);
            } else {
               $('.staionpoints').html('<tr><td colspan="4">No boarding points assinged</td></tr>');
            }
            
             
        }
    });
}

function cancelUserStationpointDialog() {
    $('#edit-user-stationpoint').dialog('destroy');
    $('#edit-user-stationpoint').hide();
}

function deleteUserStationPoint(usrcode, code) {
    var data = {};
    
    if(confirm('Do you want to delete this station point?')) {
        $.each(g_userstationpoints, function(keys, values) {
            if (values.code == code) {
                data.station = values.station.code;
                data.stationpoint = values.code;
                data.userCode = usrcode,
                data.boardingCommission = values.boardingCommission;
                data.userGroupList = values.userGroupList;
            }
        });
        
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-user-stationpoints",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    //$('#usr-viw-' + usrcode).trigger("click");
                    loadUserStationPoints(usrcode);
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
        });
    }
    
    
    
}

function saveUserStationpoint() {
    var data = {}
    data.station = $('#user_stations').val();
    data.stationpoint = $('#user_stations_point').val();
    data.userCode = $('#hid_urs_sp_code').val();
    data.code = $('#hid_sp_code').val();
    data.boardingCommission = $('#brdg_comm').val();
    data.userGroupList = $('#user_group').val();

    $("#user_stations, #user_stations_point").removeClass('inp_error');
    $('#usr-sp-state').html('');
    $('#usr-sp-state').hide();
    
    var err = 0;
    if (data.station == '') {
        $("#user_stations").addClass('inp_error');
        err++;
    }
    
    if (data.stationpoint == '') {
        $("#user_stations_point").addClass('inp_error');
        err++;
    }
    
    if (data.boardingCommission !='' && data.userGroupList == null) {
        $('.user_group').addClass('inp_error');
        err++;
    }

    if(data.boardingCommission == ''){
        data.boardingCommission = 0;
    }

    if (err > 0) {
        $('#ur-sp-loading').html('');
        $('#ur-sp-loading').hide();
        $('#usr-sp-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-sp-state').html('Please enter the values in the field that are marked in red');
        $('#usr-sp-state').show();
        return false;
    }
    
    $('#form-sp-bttons').hide();
    $('#ur-sp-loading').html(loading_popup);
    $('#ur-sp-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/save-user-stationpoints",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-sp-loading').html('');
                $('#ur-sp-loading').hide();
                $('#usr-sp-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-sp-state').show();
                $('#usr-sp-state').html('Your request has been completed successfully');
                
                window.setTimeout(function() {
                    cancelUserStationpointDialog();
                    //$('#usr-viw-' + data.userCode).trigger("click");
                    loadUserStationPoints(data.userCode);
                }, 3000);                
            } else {
                $('#ur-sp-loading').html('');
                $('#ur-sp-loading').hide();
                $('#usr-sp-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-sp-state').show();
                $('#usr-sp-state').html(response.errorDesc);
            }
        }
    });
}

function loadUserStationPointsByStation(code) {
    $('#user_stations_point').html('<option value="">Please wait...</option>');
    var data = {}
    data.station_code = code;
    var htmlsp = '';
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/get-stationpoint-by-station-user",
        data: data,
        success: function(response) {
            if (response.status = 1 && response.data != undefined) {
                htmlsp += "<option value=''>Select a station point</option>";
                $.each(response.data, function(keys1, cvalues) {
                    htmlsp += "<option value='"+cvalues.code+"'>"+cvalues.name+"</option>";
                });
            }          
            $('#user_stations_point').html(htmlsp); 
        }
    });
}

var commission = {};
function userView(code) {
    $('#usr-viw-rslt').html('<div align="left">' + loading_big + '</div>');
    $('.li_bk').removeClass('li_bk');

    $.each(userlist, function(keys, values) {
        if (values.code == code) {
            var usr_com = $('#user_commission_view').html();
            usr_com = $('<div>').html(usr_com).clone();
            commission = {};
            var data = {}
            var html = "";
            var html_ct = '';
            var html_cancom = '';
            var html_bkg_cargo = '';
            var html_dlv_cargo = '';
            data.usrCode = code;
            data.disable = $('#comm_dis').val();
            data.edit = $('#comm_edit').val();
            data.delete = $('#comm_del').val();
            
            loadUserStationPoints(code);
            loadUserTds(code);
            
            usr_com.find('.com').html(loading_small);
            usr_com.find('.ctr').html(loading_small);
            usr_com.find('.cargo').html(loading_small);
            usr_com.find('.cancom').html(loading_small);
            
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/user-commission",
                data: data,
                async: true,
                success: function(response) {
                    if (response.status = 1 && response.data != undefined) {
                        commission = response.data;
                        var ks = 1;
                        var ky = 1;
                        var kc = 1;
                        var kd = 1;
                        $.each(response.data, function(keys1, cvalues) {
                            if(cvalues.commissionType == 'BO')   {
                                html += "<tr>";

                                html += "<td>" + cvalues.creditLimit + "</td>";
                                html += "<td>" + dateToDateTime(cvalues.createdDateTime,3) + "</td>";
                                if (cvalues.valueType.code == "PER") {
                                    html += "<td>" + cvalues.value + " %</td>";
                                } else {
                                    html += "<td>Rs. " + cvalues.value + "</td>";
                                }
                                html += "<td>" + cvalues.serviceTax + " %</td>";
                                html += "<td>\n\
                                        <div class='btn-group'>";
                                if (cvalues.activeFlag == 1) {
                                    if (data.disable > 0) {
                                        if (data.disable == 1) {
                                            html += "<a class='btn btn-default btn-xs'  title='Disable' data-status='0' data-from='" + cvalues.activeFrom + "' data-to='" + cvalues.activeTo + "' onclick=\"cms_status('" + code + "','" + cvalues.code + "',this)\">\n\
                                                        <i class='fa fa-times'></i>\n\
                                                    </a>";
                                        }
                                    }
                                    if (data.edit>0) {
                                        if (data.edit == 1) {
                                            html += "<a class='btn btn-default btn-xs' title='Edit' onclick=\"commissionDialog('" + code + "','" + cvalues.code + "')\"><i class='fa fa-pencil igreen'></i></a>";

                                        }
                                    }
                                } else {
                                    //html += "<a class='btn btn-default btn-xs' data-status='1' data-from='" + cvalues.activeFrom + "' data-to='" + cvalues.activeTo + "' onclick=\"cms_status('" + code + "','" + cvalues.code + "',this)\">\n\
                                    //                    <i class='fa fa-check'></i>\n\
                                    //                </a>";
                                    html += " - ";
                                }
                                html += "</div></td>";
                                html += "</tr>";
                            }
                            if(cvalues.commissionType == 'BO'){
                                ks++;   
                            }
                        
                            // cancel charges share                     
                            if(cvalues.commissionType == 'CA')   {
                                html_ct += "<tr>";

                                html_ct += "<td>" + dateToDateTime(cvalues.createdDateTime,3) + "</td>";
                                if (cvalues.valueType.code == 'PER') {
                                    html_ct += "<td>" + cvalues.value + " %</td>";
                                } else {
                                    html_ct += "<td>Rs. " + cvalues.value + "</td>";
                                }
                                html_ct += "<td>" + cvalues.serviceTax + " %</td>";
                                html_ct += "<td>\n\
                                        <div class='btn-group'>";
                                if (cvalues.activeFlag == 1) {
                                    if (data.disable > 0) {
                                        if (data.disable == 1) {
                                            html_ct += "<a class='btn btn-default btn-xs'  title='Disable' data-status='0' data-from='" + cvalues.activeFrom + "' data-to='" + cvalues.activeTo + "' onclick=\"ctr_status('" + code + "','" + cvalues.code + "',this)\">\n\
                                                        <i class='fa fa-times'></i>\n\
                                                    </a>";
                                        }
                                    }
                                    if (data.edit>0) {
                                        if (data.edit == 1) {
                                            html_ct += "<a class='btn btn-default btn-xs' title='Edit' onclick=\"cancellationDialog('" + code + "','" + cvalues.code + "')\"><i class='fa fa-pencil igreen'></i></a>";

                                        }
                                    }
                                } else {
                                    html_ct += " - ";
                                }
                                html_ct += "</div>\n\
                                        </td>";
                                html_ct += "</tr>";
                                if(cvalues.commissionType == 'CA'){
                                 ky++;
                                }
                            }
                            
                            // cancellation                       
                            if(cvalues.commissionType == 'CCA')   {
                                html_cancom += "<tr>";

                                html_cancom += "<td>" + dateToDateTime(cvalues.createdDateTime,3) + "</td>";
                                if (cvalues.valueType.code == 'PER') {
                                    html_cancom += "<td>" + cvalues.value + " %</td>";
                                } else {
                                    html_cancom += "<td>Rs. " + cvalues.value + "</td>";
                                }
                                html_cancom += "<td>" + cvalues.serviceTax + " %</td>";
                                html_cancom += "<td>\n\
                                        <div class='btn-group'>";
                                if (cvalues.activeFlag == 1) {
                                    if (data.disable > 0) {
                                        if (data.disable == 1) {
                                            html_cancom += "<a class='btn btn-default btn-xs'  title='Disable' data-status='0' data-from='" + cvalues.activeFrom + "' data-to='" + cvalues.activeTo + "' onclick=\"cancom_status('" + code + "','" + cvalues.code + "',this)\">\n\
                                                        <i class='fa fa-times'></i>\n\
                                                    </a>";
                                        }
                                    }
                                    if (data.edit>0) {
                                        if (data.edit == 1) {
                                            html_cancom += "<a class='btn btn-default btn-xs' title='Edit' onclick=\"addCancomDialog('" + code + "','" + cvalues.code + "')\"><i class='fa fa-pencil igreen'></i></a>";

                                        }
                                    }
                                } else {
                                    html_cancom += " - ";
                                }
                                html_cancom += "</div>\n\
                                        </td>";
                                html_cancom += "</tr>";                                
                            }
                         
                        });
                        
                        if (html == '') {
                           var emhtml = "<tr><td colspan='6'>No Commission details found!.</td></tr>";
                            usr_com.find('.com').html(emhtml);
                        } else {
                            usr_com.find('.com').html(html);
                        }
                        
                        if (html_ct == '') {
                            var emhtml_ct = "<tr><td colspan='6'>No Cancel share details found!.</td></tr>";
                            usr_com.find('.ctr').html(emhtml_ct);
                        } else {
                            usr_com.find('.ctr').html(html_ct);
                        }
                        
                        if (html_cancom == '') {
                            var emhtml_cancom = "<tr><td colspan='6'>No Cancellation Commission found!.</td></tr>";
                            usr_com.find('.cancom').html(emhtml_cancom);
                        } else {
                            usr_com.find('.cancom').html(html_cancom);
                        }
                        
                        $('.addcancom').attr("onclick", "addCancomDialog('" + code + "')");
                    }
                }
            });
            var usr = $('#user_detail_view').html();
            usr = $('<div>').html(usr).clone();
            usr.find('.viw_name').text(values.name);
            usr.find('.usr_code').text(values.code);
            usr.find('.usr_name').text(values.username);
            usr.find('.email').text(values.email);
            usr.find('.org_name').text(values.organization.name);
            usr.find('.grp_name').text(values.group.name);
            usr.find('.type_name').text(values.paymentType.name);
            usr.find('.mob_no').text(values.mobile);
            usr.find('.tags').html(values.userTags.map(function(obj) {
                return '<span class="label label-default">' + allusertags[obj.code] + '</span>';
            }).join('&nbsp;'));
            usr.find('.edt').attr("onclick", "saveDialogUser('" + code + "')");
            usr.find('.edt_stu').attr("onclick", "editUserStatus('" + code + "',this)");
            if (values.activeFlag == 1) {
                usr.find('.edt_stu').find("i").removeClass("fa-check").addClass('fa-times');
                usr.find('.edt_stu').attr('data-status', values.activeFlag);
            } else if (values.activeFlag == 0) {
                usr.find('.edt').hide();
                usr.find('.edt_stu').find("i").removeClass("fa-times").addClass('fa-check');
                usr.find('.edt_stu').attr('data-status', values.activeFlag);
            }
            usr.find('.del').attr("onclick", "deleteUser('" + code + "')");//
            usr.find('.grp').attr("onclick", "groupDialogUser('" + code + "','" + values.group.code + "','usr')");
            usr.find('.org').attr("onclick", "organtaionDialogUser('" + code + "','" + values.organization.code + "','usr')");
            usr.find('.rspa').attr("onclick", "resetDialogUser('" + code + "')");
            usr.find('.urcms').attr("onclick", "commissionDialog('" + code + "')");
            usr.find('.urctr').attr("onclick", "cancellationDialog('" + code + "')");
            usr.find('.usersp').attr("onclick", "addStationPointDialog('" + code + "')");         
            
            usr.find('.switchuser').attr("onclick", "switchToUser('" + code + "')");
            $('#usr-viw-rslt').html(usr).append(usr_com);
            $('#usr-' + code).addClass('li_bk');
        }

    });
}

function saveDialogUser(code) {
     $('#form-buttons').show();
    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger').hide();
    $('#user_availablity_state').removeClass('alert').removeClass('alert-success').removeClass('alert-danger');
    $('#user_availablity_state').html('');
    $('.edt_hide').show();
    $('#btn-user-save').removeClass('hide');

    var heig = 650;
    $('#txt_name,#txt_lname,#txt_email,#txt_mobile,#grp_list,#org_list,#hid_usr_code,#txt_usr_name').val('');
    $('#btn-user-save').attr("onclick", "saveUser('"+code+"')");
    $('.edt_hide').show();
    if (_isdefined(code)) {
        $.each(userlist, function(keys, values) {
            if (values.code == code) {
                $('#txt_name').val(values.name);
                $('#txt_lname').val(values.lastname);
                $('#txt_email').val(values.email);
                $('#txt_mobile').val(values.mobile);
                $('#pay_mode').val(values.paymentType.code);
                $('#hid_usr_code').val(code);
                $('#usr_statu').val(values.activeFlag);
                $('#txt_usr_name').val(values.username);
                $('#usr_tags').val(values.userTags.map(function(obj) {
                    return obj.code;
                })).trigger('change');
                $('.edt_hide').hide();
                $('#grp_list').val('');
                $('#org_list').val('');
                $('#btn-save').attr("onclick", "saveUser('" + code + "')");
            }
        });
        heig = 590;
    } else {
        $('#pay_mode').val('');
        $('#usr_tags').val(null).trigger('change');
        $('#btn-user-save').addClass('hide');
        heig = 590;
    }

    $('#user-dialog').dialog({
        autoOpen: true,
        height: heig,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
}


function saveUser(code) {

    var data = {};
    data.activeFlag = $('#usr_status').val();
    data.name = $.trim( $('#txt_name').val() );
    data.code = $('#hid_usr_code').val();
    data.lastname = $.trim( $('#txt_lname').val() );
    data.email = $.trim( $('#txt_email').val() );
    data.group = $('#grp_list').val();
    data.username = $.trim( $('#txt_usr_name').val() );
    data.organization = $('#org_list').val();
    data.mobile = $.trim( $('#txt_mobile').val() );
    data.pay_mode = $('#pay_mode').val();
    data.mode = $("#pay_mode option:selected").text();
    data.userTags = $.map($('#usr_tags').val() || [], function(val) {
	return { code: val };
    });
    var err = 0;
    if ($('#txt_name').val() == '') {
        $('#txt_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_name').removeClass('inp_error');
    }
    if ($('#txt_lname').val() == '') {
        $('#txt_lname').addClass('inp_error');
        err++;
    } else {
        $('#txt_lname').removeClass('inp_error');
    }

    if ($('#txt_usr_name').val() == '' && (code == '' || code == undefined)) {
        $('#txt_usr_name').addClass('inp_error');
        err++;
    } else if(data.username.length<6) {
        $('#txt_usr_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_usr_name').removeClass('inp_error');
    }
    
    
    
    if ($('#txt_email').val() == '') {
        $('#txt_email').addClass('inp_error');
        err++;
    } else {
        $('#txt_email').removeClass('inp_error');
    }
    if ($('#grp_list').val() == '' && (code == '' || code == undefined)) {
        $('#grp_list').addClass('inp_error');
        err++;
    } else {
        $('#grp_list').removeClass('inp_error');
    }
    if ($('#org_list').val() == '' && (code == '' || code == undefined)) {
        $('#org_list').addClass('inp_error');
        err++;
    } else {
        $('#org_list').removeClass('inp_error');
    }
    if ($('#txt_mobile').val() == '') {
        $('#txt_mobile').addClass('inp_error');
        err++;
    } else {
        $('#txt_mobile').removeClass('inp_error');
    }
    if ($('#pay_mode').val() == '') {
        $('#pay_mode').addClass('inp_error');
        err++;
    } else {
        $('#pay_mode').removeClass('inp_error');
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
    var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    if (!filter.test(data.email) && (code == '' || code == undefined)) {
        $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state').html('Please enter valid email.');
        $('#usr-action-state').show();
        $('#txt_email').addClass('inp_error');
        return false;
    } else {
        $('#txt_email').removeClass('inp_error');
        $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state').html('');
        $('#usr-action-state').hide();
    }
    if (isNaN(data.mobile))
    {
        $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state').html('Please enter valid mobile number');
        $('#usr-action-state').show();
        return false;
    } else {
        $('#txt_mobile').removeClass('inp_error');
        $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state').html('');
        $('#usr-action-state').hide();
    }
    $('#form-bttons').hide();
    $('#ur-form-loading').html(loading_popup);
    $('#ur-form-loading').show();
    $('#form-buttons').hide();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/add-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-form-loading').html('');
                $('#ur-form-loading').hide();
                $('#usr-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-action-state').show();
                $('#usr-action-state').html('Your request has been completed successfully');
                if (code == undefined || code == '') {
                    response.data.organization.name = $('#org_list').find(":selected").text();
                    response.data.group.name = $('#grp_list').find(":selected").text();
                    userlist.push(response.data);

                    var usr = $('#user_list_view').html();
                    usr = $('<div>').html(usr).clone();
                    usr.find('a').html(data.name);//id="usr-viw-{$row->code}" //onclick="userView('{$row->code}')"
                    usr.find('a').attr("id", "usr-viw-" + response.data.code);
                    usr.find('a').attr("onclick", "userView('" + response.data.code + "')");

                    $('#usr_scroll').append(usr);
                    window.setTimeout(function() {
                        cancelUser();
                        //checkURL();

                    }, 3000);
                } else if (code != '') {
                    $.each(userlist, function(keys, values) {
                        if (values.code == code) {
                            userlist[keys].name = data.name;
                            userlist[keys].lastname = data.lastname;
                            userlist[keys].email = data.email;
                            userlist[keys].mobile = data.mobile;
                            userlist[keys].paymentType.name = data.mode;
                            userlist[keys].paymentType.code = data.pay_mode;
                            userlist[keys].userTags = data.userTags;
                        }
                    });
                    $('#usr-viw-' + code).html(data.name);
                    $('#usr-viw-' + code).trigger("click");
                    window.setTimeout(function() {
                        cancelUser();
                    }, 3000);

                }

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
function cancelUser() {
    $('#user-dialog').dialog('destroy');
    $('#user-dialog').hide();
}
function editUserStatus(code, obj) {
    var user = userlist.find(function(e) {
        return e.code == code;
    });
    var data = {};
    data.code = code;
    data.username = user.username;
    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-status-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('.edt').hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    //var usr = $('#user_detail_view').html();
                    $('.edt').show();
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

function deleteUser(code) {
    if (confirm('Do you want to delete this user?')) {        
        var user = userlist.find(function(e) {
            return e.code == code;
        });
        var data = {};
        data.code = code;
        data.username = user.username;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-user",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#usr-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#usr-viw-rslt').html('<div class="p_t_100"><div class="well well-large "> Click any of the user name to view more details.</div></div>');
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


function resetDialogUser(code) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-rps-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
    $('#form-rps-bttons').show();
    $('#hid_code').val(code);
    $("#txt_nw_pass,#txt_cnf_pass").val('');

    $('#edit-user-rps').dialog({
        autoOpen: true,
        height: 300,
        width: 600,
        modal: true,
        resizable: false
    });

    $(".ui-dialog-titlebar").hide();
}
function cancelResetDialog() {
    $('#edit-user-rps').dialog('destroy');
    $('#edit-user-rps').hide();
}
function restPassword() {
    var data = {};
    data.code = $('#hid_code').val();
    data.password = $("#txt_nw_pass").val();
    var err = 0;

    if ($("#txt_nw_pass").val() == '') {
        $("#txt_nw_pass").addClass('inp_error');
        err++;
    } else {
        $("#txt_nw_pass").removeClass('inp_error');
    }

    if ($("#txt_cnf_pass").val() == '') {
        $("#txt_cnf_pass").addClass('inp_error');
        err++;
    } else {
        $("#txt_cnf_pass").removeClass('inp_error');
    }

    if (err > 0) {
        //
        $('#ur-rps-loading').html('');
        $('#ur-rps-loading').hide();
        $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-rps-state').html('Please enter the values in the field that are marked in red');
        $('#usr-rps-state').show();
        return false;
    }
    if (data.password.length < 6) {
        $("#txt_nw_pass").addClass('inp_error');
        $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-rps-state').html('Password should be minimum 6 charactors.');
        $('#usr-rps-state').show();
        return false;

    } else {
        $("#txt_nw_pass").removeClass('inp_error');
        $('#usr-rps-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-rps-state').html('');
        $('#usr-rps-state').hide();
    }
    if ($("#txt_nw_pass").val() != $("#txt_cnf_pass").val()) {
        $('#ur-rps-loading').html('');
        $('#ur-rps-loading').hide();
        $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
        $('#txt_cnf_pass').addClass('inp_error');
        $('#usr-rps-state').show();
        $('#usr-rps-state').html('Please enter the same password as above.');
        return false;
    } else {
        $('#usr-rps-state').removeClass('alert-success').removeClass('alert-danger');
        $('#txt_cnf_pass').removeClass('inp_error');
        $('#usr-rps-state').html('');
        $('#usr-rps-state').hide();
    }
    $('#form-rps-bttons').hide();
    $('#ur-rps-loading').html(loading_popup);
    $('#ur-rps-loading').show();


    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-user-password",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-rps-loading').html('');
                $('#ur-rps-loading').hide();
                $('#usr-rps-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-rps-state').show();
                $('#usr-rps-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelResetDialog();
                }, 3000);
            } else {
                $('#ur-rps-loading').html('');
                $('#ur-rps-loading').hide();
                $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-rps-state').html(response.errorDesc);
                $('#usr-rps-state').show();
                $('#form-rps-bttons').show();
            }
        }
    });
}
function commissionDialog(code, com_code) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-cms-state').removeClass('alert-success').removeClass('alert-danger').hide();


    $('#txt_cl,#dpStart,#dpEnd,#txt_vlu').val('');

    $("#txt_pt").attr('checked', 'checked');
    //$("#txt_pt").removeAttr('checked');
    $("#txt_pt").attr('checked', true);
    $("#txt_pt").prop('checked', true);

    $('#form-cms-bttons,#edit-user-cms,#hid_cms_code').show();
    $('#usr_comm_type').val('PER');

    $('#edit-user-cms').dialog({
        autoOpen: true,
        height: 450,
        width: 450,
        modal: true,
        resizable: false
    });

    if (_isdefined(code) || _isdefined(com_code)) {
        $.each(commission, function(k, vls) {
            if (com_code == vls.code) {
                $('#dpStart').val(vls.activeFrom);
                $('#dpEnd').val(vls.activeTo);
                $('#txt_cl').val(vls.creditLimit);
                $('#txt_vlu').val(vls.value);
                $('#usr_comm_type').val(vls.valueType.code);
                $('#txt_bogst').val(vls.serviceTax);
                $('#hid_cms_code').val(com_code);
                $('#hid_cms_status').val(vls.activeFlag);
                //
            }
        });
        $('#hid_urs_cms_code').val(code);
    }
    $(".ui-dialog-titlebar").hide();
}

function cancellationDialog(code, com_code) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-ctr-state').removeClass('alert-success').removeClass('alert-danger').hide();


    $('#dpStart,#dpEnd,#txt_ctr_vlu, #txt_agsgst').val('');
    $('#txt_ctr_comm_type').val('PER');

    $('#form-ctr-bttons,#edit-user-ctr,#hid_ctr_code').show();

    $('#edit-user-ctr').dialog({
        autoOpen: true,
        height: 400,
        width: 450,
        modal: true,
        resizable: false
    });

    if (_isdefined(code) || _isdefined(com_code)) {
        $.each(commission, function(k, vls) {
            if (com_code == vls.code) {
                $('#dpStart').val(vls.activeFrom);
                $('#dpEnd').val(vls.activeTo);
                $('#txt_ctr').val(0);
                $('#txt_ctr_vlu').val(vls.value);                
                $('#txt_ctr_comm_type').val(vls.valueType.code);
                $('#txt_agsgst').val(vls.serviceTax); 
                $('#hid_ctr_code').val(com_code);
                $('#hid_ctr_status').val(vls.activeFlag);
                //
            }
        });
        $('#hid_urs_ctr_code').val(code);
    }
    $(".ui-dialog-titlebar").hide();
}

function addCancomDialog(code, cancom_code) {
    $('.inp_error').removeClass('inp_error');
    $('#usr-cancom-state').removeClass('alert-success').removeClass('alert-danger').hide();


    $('#dpStart,#dpEnd,#txt_cancom_vlu, #txt_acancom_gst').val('');
    $('#txt_cancom_comm_type').val('PER');

    $('#form-cancom-bttons,#edit-user-cancom,#hid_cancom_code').show();

    $('#edit-user-cancom').dialog({
        autoOpen: true,
        height: 400,
        width: 450,
        modal: true,
        resizable: false
    });

    if (_isdefined(code) || _isdefined(cancom_code)) {
        $.each(commission, function(k, vls) {
            if (cancom_code == vls.code) {
                $('#dpStart').val(vls.activeFrom);
                $('#dpEnd').val(vls.activeTo);
                $('#txt_cancam').val(0);
                $('#txt_cancom_vlu').val(vls.value);                
                $('#txt_cancam_comm_type').val(vls.valueType.code);
                $('#txt_acancom_gst').val(vls.serviceTax);   
                $('#hid_cancam_code').val(cancom_code);
                $('#hid_cancam_status').val(vls.activeFlag);
                //
            }
        });
        $('#hid_urs_cancom_code').val(code);
    }
    $(".ui-dialog-titlebar").hide();
}

function cancelCommissionDialog() {
    $('#edit-user-cms').dialog('destroy');
    $('#edit-user-cms').hide();
}


function cancelCancellationDialog() {
    $('#edit-user-ctr').dialog('destroy');
    $('#edit-user-ctr').hide();
}

function cancelCancellationCommissionDialog() {
    $('#edit-user-cancom').dialog('destroy');
    $('#edit-user-cancom').hide();
}

function saveCommission() {
    var data = {}
    data.creditlimit = $('#txt_cl').val();
    //data.activeFrom = $('#dpStart').val();
    //data.activeTo = $('#dpEnd').val();
    data.value = $('#txt_vlu').val();
    data.gst = $('#txt_bogst').val();
    data.userCode = $('#hid_urs_cms_code').val();
    data.code = $('#hid_cms_code').val();
    data.activeFlag = $('#hid_cms_status').val();
    data.percentageFlag = $('#usr_comm_type').val();


    var err = 0;
    if (data.creditlimit == '') {
        $("#txt_cl").addClass('inp_error');
        err++;
    } else {
        $("#txt_cl").removeClass('inp_error');
    }
    /*if (data.activeFrom == '') {
        $("#dpStart").addClass('inp_error');
        err++;
    } else {
        $("#dpStart").removeClass('inp_error');
    }
    if (data.activeTo == '') {
        $("#dpEnd").addClass('inp_error');
        err++;
    } else {
        $("#dpEnd").removeClass('inp_error');
    }*/

    if (data.value == '') {
        $("#txt_vlu").addClass('inp_error');
        err++;
    } else {
        $("#txt_vlu").removeClass('inp_error');
    }
    
    if (data.gst == '') {
        $("#txt_bogst").addClass('inp_error');
        err++;
    } else {
        $("#txt_bogst").removeClass('inp_error');
    }

    if (err > 0) {
        $('#ur-cms-loading').html('');
        $('#ur-cms-loading').hide();
        $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-cms-state').html('Please enter the values in the field that are marked in red');
        $('#usr-cms-state').show();
        return false;
    }
    $('#form-cms-bttons').hide();
    $('#ur-cms-loading').html(loading_popup);
    $('#ur-cms-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/commission-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-cms-state').show();
                $('#usr-cms-state').html('Your request has been completed successfully');

                window.setTimeout(function() {
                    cancelCommissionDialog();
                    clearDate();
                    $('#usr-viw-' + data.userCode).trigger("click");
                }, 3000);
            } else if (response.status == 3) {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cms-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-cms-state').show();
                $('#form-cms-bttons').show();
            } else if (response.status == 4) {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cms-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-cms-state').show();
                $('#form-cms-bttons').show();
            } else {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cms-state').html(response.errorDesc);
                $('#usr-cms-state').show();
                $('#form-cms-bttons').show();
            }
        }
    });
}

function saveCancellation() {
    var data = {}
    data.creditlimit = 0;
    data.value = $('#txt_ctr_vlu').val();
    data.gst = $('#txt_agsgst').val();
    data.userCode = $('#hid_urs_ctr_code').val();
    data.code = $('#hid_ctr_code').val();
    data.activeFlag = $('#hid_ctr_status').val();
    data.percentageFlag = $('#txt_ctr_comm_type').val();
    data.act = 'CT';

    var err = 0;
//    if (data.creditlimit == '') {
//        $("#txt_ctr").addClass('inp_error');
//        err++;
//    } else {
//        $("#txt_ctr").removeClass('inp_error');
//    }
    if (data.value == '') {
        $("#txt_ctr_vlu").addClass('inp_error');
        err++;
    } else {
        $("#txt_ctr_vlu").removeClass('inp_error');
    }
    
    if (data.gst == '') {
        $("#txt_agsgst").addClass('inp_error');
        err++;
    } else {
        $("#txt_agsgst").removeClass('inp_error');
    }

    if (err > 0) {
        $('#ur-ctr-loading').html('');
        $('#ur-ctr-loading').hide();
        $('#usr-ctr-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-ctr-state').html('Please enter the values in the field that are marked in red');
        $('#usr-ctr-state').show();
        return false;
    }
    $('#form-ctr-bttons').hide();
    $('#ur-ctr-loading').html(loading_popup);
    $('#ur-ctr-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/commission-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-ctr-loading').html('');
                $('#ur-ctr-loading').hide();
                $('#usr-ctr-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-ctr-state').show();
                $('#usr-ctr-state').html('Your request has been completed successfully');

                window.setTimeout(function() {
                    cancelCancellationDialog();
                    clearDate();
                    $('#usr-viw-' + data.userCode).trigger("click");
                }, 3000);
            } else if (response.status == 3) {
                $('#ur-ctr-loading').html('');
                $('#ur-ctr-loading').hide();
                $('#usr-ctr-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-ctr-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-ctr-state').show();
                $('#form-ctr-bttons').show();
            } else if (response.status == 4) {
                $('#ur-ctr-loading').html('');
                $('#ur-ctr-loading').hide();
                $('#usr-ctr-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-ctr-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-ctr-state').show();
                $('#form-ctr-bttons').show();
            } else {
                $('#ur-ctr-loading').html('');
                $('#ur-ctr-loading').hide();
                $('#usr-ctr-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-ctr-state').html(response.errorDesc);
                $('#usr-ctr-state').show();
                $('#form-ctr-bttons').show();
            }
        }
    });
}

function saveCancellationCommission() {
    var data = {}
    data.creditlimit = 0;
    data.value = $('#txt_cancom_vlu').val();
    data.gst = $('#txt_acancom_gst').val();
    data.userCode = $('#hid_urs_cancom_code').val();
    data.code = $('#hid_cancom_code').val();
    data.activeFlag = $('#hid_cancom_status').val();
    data.percentageFlag = $('#txt_cancom_comm_type').val();
    data.act = 'CCA';

    var err = 0;

    if (data.value == '') {
        $("#txt_cancom_vlu").addClass('inp_error');
        err++;
    } else {
        $("#txt_cancom_vlu").removeClass('inp_error');
    }
    
    if (data.gst == '') {
        $("#txt_acancom_gst").addClass('inp_error');
        err++;
    } else {
        $("#txt_acancom_gst").removeClass('inp_error');
    }

    if (err > 0) {
        $('#ur-cancom-loading').html('');
        $('#ur-cancom-loading').hide();
        $('#usr-cancom-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-cancom-state').html('Please enter the values in the field that are marked in red');
        $('#usr-cancom-state').show();
        return false;
    }
    $('#form-cancom-bttons').hide();
    $('#ur-cancom-loading').html(loading_popup);
    $('#ur-cancom-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/commission-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-cancom-loading').html('');
                $('#ur-cancom-loading').hide();
                $('#usr-cancom-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-cancom-state').show();
                $('#usr-cancom-state').html('Your request has been completed successfully');

                window.setTimeout(function() {
                    cancelCancellationCommissionDialog();
                    clearDate();
                    $('#usr-viw-' + data.userCode).trigger("click");
                }, 3000);
            } else if (response.status == 3) {
                $('#ur-cancom-loading').html('');
                $('#ur-cancom-loading').hide();
                $('#usr-cancom-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cancom-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-cancom-state').show();
                $('#form-cancom-bttons').show();
            } else if (response.status == 4) {
                $('#ur-cancom-loading').html('');
                $('#ur-cancom-loading').hide();
                $('#usr-cancom-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cancom-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-cancom-state').show();
                $('#form-cancom-bttons').show();
            } else {
                $('#ur-cancom-loading').html('');
                $('#ur-cancom-loading').hide();
                $('#usr-cancom-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cancom-state').html(response.errorDesc);
                $('#usr-cancom-state').show();
                $('#form-cancom-bttons').show();
            }
        }
    });
}

function cms_status(code, cms_code, obj) {
    var data = {}
    data.userCode = code;
    data.code = cms_code;
    data.activeFlag = $(obj).attr('data-status');
    //data.activeFrom = $(obj).attr('data-from');
    //data.activeTo = $(obj).attr('data-to');
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-cms-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                if (data.activeFlag == 0) {
                    $(obj).attr('data-status', 1);
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $(obj).attr('data-status', 0);
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
            $('#usr-viw-' + code).trigger("click");
            window.setTimeout(function() {

                loading_overlay.hide();
            }, 2000);
        }
    })

}

function ctr_status(code, cms_code, obj) {
    var data = {}
    data.userCode = code;
    data.code = cms_code;
    data.activeFlag = $(obj).attr('data-status');
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-ctr-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                if (data.activeFlag == 0) {
                    $(obj).attr('data-status', 1);
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $(obj).attr('data-status', 0);
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
            $('#usr-viw-' + code).trigger("click");
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);
        }
    })

}
function cancom_status(code, cms_code, obj) {
    var data = {}
    data.userCode = code;
    data.code = cms_code;
    data.activeFlag = $(obj).attr('data-status');
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-cancom-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                if (data.activeFlag == 0) {
                    $(obj).attr('data-status', 1);
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $(obj).attr('data-status', 0);
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
            $('#usr-viw-' + code).trigger("click");
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);
        }
    })

}

function cargo_status(code, cms_code, act, obj) {
    var data = {}
    data.userCode = code;
    data.code = cms_code;
    data.activeFlag = $(obj).attr('data-status');
    data.act = act;
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-cargo-user",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                if (data.activeFlag == 0) {
                    $(obj).attr('data-status', 1);
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $(obj).attr('data-status', 0);
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
            $('#usr-viw-' + code).trigger("click");
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);
        }
    })

}


function clearDate() {

    $('#dpStart').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd'
    }).on('changeDate', function(e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#dpEnd').datepicker('setStartDate', e.date);
        $("#dpEnd").datepicker("setEndDate", end)
    });
    $('#dpEnd').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
    }).on('changeDate', function(e) {
        $('#dpStart').datepicker('setEndDate', e.date)
    });
}

function checkUsernameAvailablity(ele) {
    var n = $.trim( $(ele).val() );
    var unameexp = new RegExp('^[a-z0-9]+$');

    var data = {};
    data.username = n;
    
    $('#user_availablity_state').removeClass('alert').removeClass('alert-success').removeClass('alert-danger');
     
    if(data.username.length<6) {
        $('#user_availablity_state').addClass('alert').addClass('alert-danger').html('Username must be atleast 6 letters');
        $('#btn-user-save').addClass('hide');
        return;
    } else if(!unameexp.test(data.username)) {
        $('#user_availablity_state').addClass('alert').addClass('alert-danger').html('Username not valid. Only characters a-z and 0-9 are acceptable.');
        $('#btn-user-save').addClass('hide');
        return;
    }
     
   
    $('#user_availablity_state').html(loading_popup+' checking availablity');
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/user-availablity",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#user_availablity_state').addClass('alert').addClass('alert-success').html('Username available to use');
                $('#btn-user-save').removeClass('hide');
            } else {
                $('#user_availablity_state').addClass('alert').addClass('alert-danger').html('Sorry! Username already taken');
                $('#btn-user-save').addClass('hide');
            }
        }
    });
}

function exportUserExcel(){
    document.trans_form.action = "config/export-user-excel";
    document.trans_form.target = "irm_downloader";
    document.trans_form.submit();
    return;
}

$(".numeric").bind("keypress", function (e) {
    var keyCode = e.which ? e.which : e.keyCode
    var ret = ((keyCode >= 48 && keyCode <= 57) || keyCode == 8);
    return ret;
});
$(".numeric").bind("paste", function (e) {
    return false;
});
$(".numeric").bind("drop", function (e) {
    return false;
});

function switchToUser(code){
    var data = {};
    data.userCode = code;
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