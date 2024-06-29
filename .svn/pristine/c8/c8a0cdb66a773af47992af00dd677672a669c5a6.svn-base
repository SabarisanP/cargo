function saveGatewayProvider(option) {

    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger').hide();
    $('.edt_hide').show();

    var heig = 350;

    $('#btn-save').attr("onclick", "saveProvider()");
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
        var new_name = $('#am-' + option.code).find('.sp_name a').html();
        var Sname_c = $('#am-' + option.code).find('.sp_name1').html();
        var cid = option.code;
        $('#name').val(new_name);
        $('#service').val(Sname_c);
        $('#hid_provider_code').val(cid);

    }


    $(".ui-dialog-titlebar").hide();
}
function saveGatewayPartner(code, name, payment, providercode, offerTerms, offerNotes) {

    var heig = 500;
    var widt = 860;
    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state1').removeClass('alert-success').removeClass('alert-danger').hide();
    $('.edt_hide').show();
    $('#btn-save').attr("onclick", "saveParter()");
    $('.edt_hide').show();
    $('#form-buttonss').show();
    $('[id=name]').val('');
    $('[id=terms_row]').hide();


    var data = _.find(commission, function (o) {
        return o.code === code;
    });
//            console.log(data.offerTerms);

    $('#partner-dialog').dialog({
        autoOpen: true,
        height: heig,
        width: widt,
        modal: true,
        resizable: false
    });
    if (code) {
        $('#part_name').val(name);
        $('#part_mode').val(payment);
        $('#partner_code').val(code);
        $('#pro_code').val(providercode);
        $('#ofr_note').val(offerNotes);

        var offerTerms = data.offerTerms;
        

        for (let i = 0; i < offerTerms.length; i++) {
            add_row(offerTerms[i]);
        }

    } else {
        $('#part_name').val('');
        $('#part_mode').val('');
        $('#partner_code').val('');
        $('#pro_code').val('');
        $('#ofr_note').val('');
        for (let i = 0; i <5; i++) {
            init_terms_rows();
        }
        
        
    }

    $(".ui-dialog-titlebar").hide();
    $(".ui-dialog-titlebar").hide();
}

function init_terms_rows() {
    var row_tmplate = $('#template-row').html();
    var html = $(row_tmplate).clone();
    $('#terms > tbody > tr:last').before(html);

}

function add_row(term) {

    var row_tmplate = $('#template-row').html();
    var html = $(row_tmplate).clone();

//    $(html).find('#code').val(r.code);
    if (term == "[object Object]") {
        $(html).find('#name').val('');
    } else {
        $(html).find('#name').val(term);
    }

    $('#terms > tbody > tr:last').before(html);

}



function savePartner() {

    var data = {};
    var termData = [];
    // data.activeFlag = $('#usr_status').val();
    data.pro_code = $('#partner').val();
    data.part_name = $('#part_name').val();
    data.api_pro_code = $('#pro_code').val();
    data.part_mode = $('#part_mode').val();
    data.code = $('#partner_code').val();
    data.offerNotes = $('#ofr_note').val();
    data.activeFlag = 1;


    $('#terms > tbody > tr').each(function () {
//        if ($.trim($(this).find('#name').val()) != "") {
            var term = $.trim($(this).find('#name').val());
//            term.name = $.trim( $(this).find('#name').val() );
            termData.push(term);
//        }
    });
//     $('#terms > tbody > tr').each( function() {
//         var name = $(this).find('#name').val()
//          if($.trim(name) != "") {
//              data.terms = $.map(name || [], function (val) {
//                return { code: val };
//            });
//          }
//      });


    var param = {};
    data.terms = termData;
    console.log(param.terms);

    var err = 0;
    if ($('#part_name').val() == '') {
        $('#part_name').addClass('inp_error');
        err++;
    } else {
        $('#part_name').removeClass('inp_error');
    }
    if ($('#part_mode').val() == '') {
        $('#part_mode').addClass('inp_error');
        err++;
    } else {
        $('#part_mode').removeClass('inp_error');
    }

    if ($('#pro_code').val() == '') {
        $('#pro_code').addClass('inp_error');
        err++;
    } else {
        $('#pro_code').removeClass('inp_error');
    }

    var Exp = /^[0-9a-zA-Z]+$/;



    if (err > 0) {
        $('#usr-action-state1').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state1').html('Please enter/select the values in the field that are marked in red');
        $('#usr-action-state1').show();
        return false;
    } else {
        $('#usr-action-state1').removeClass('alert-success').removeClass('alert-danger');
        $('#usr-action-state1').html('');
        $('#usr-action-state1').hide();
    }

    if (!data.api_pro_code.match(Exp))
    {
        $('#api_pro_code').addClass('inp_error');
        $('#usr-action-state1').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state1').html('Please enter valid API provider code');
        $('#usr-action-state1').show();
        return false;
    } else {

    }

    $('#form-buttonss').hide();
    $('#ur-form-loading').html(loading_popup);
    $('#ur-form-loading').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/add-gateway-partner",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#ur-form-loading').hide();
                $('#ur-form-loading').html('');
                $('#usr-action-state1').removeClass('alert-danger').addClass('alert-success');
                $('#usr-action-state1').show();
                $('#usr-action-state1').html('Your request has been completed successfully');
                window.setTimeout(function () {

                    cancelPartner();
                    $('#pro-viw-' + data.pro_code).trigger("click");
                }, 3000);

            } else {

                $('#ur-form-loading').html('');
                $('#ur-form-loading').hide();
                $('#usr-action-state1').removeClass('alert-success').addClass('alert-danger');
                $('#usr-action-state1').html(response.errorDesc);
                $('#usr-action-state1').show();
                $('#form-buttonss').show();
            }
        }
    });
}

function saveProvider() {

    var data = {};

    data.name = $('#name').val();
    data.serviceName = $('#service').val();
    data.code = $('#hid_provider_code').val();
    data.pg_pr_disable = menu_permission['PG-PROVI-DISABLE'];
    data.pg_pr_edit = menu_permission['PG-PROVI-EDIT'];
    data.pg_pr_del = menu_permission['PG-PROVI-DELETE'];

    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }
    if ($('#service').val() == '') {
        $('#service').addClass('inp_error');
        err++;
    } else {
        $('#service').removeClass('inp_error');
    }

    var Exp = /^[0-9a-zA-Z]+$/;



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

    if (!data.serviceName.match(Exp))
    {
        $('#service').addClass('inp_error');
        $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usr-action-state').html('Please enter valid servicename');
        $('#usr-action-state').show();
        return false;
    } else {

    }

    $('#form-buttons').hide();
    $('#ur-form-loadings').html(loading_popup);
    $('#ur-form-loadings').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/add-gateway-provider",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('.er_msg').addClass('hide');
                $('#ur-form-loadings').hide();
                $('#ur-form-loadings').html('');
                $('#usr-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-action-state').show();
                $('#form-buttons').hide();

                $('#am-' + data.code).find('.sp_name a').html(data.name);
                $('#am-' + data.code).find('.sp_name1').html(data.serviceName);
                $('#service').val(data.serviceName);
                $('#usr-action-state').html('Your request has been completed successfully');


                if (data.code == '') {

                    var li = $('.amt-db').clone();

                    li.attr('id', "am-" + response.data.code);
                    li.find(".sp_name a").html(response.data.name);//lb
                    li.find(".sp_name1").html(response.data.serviceName);
                    li.find(".sp_name a").attr("id", "pro-viw-" + response.data.code);
                    li.find(".sp_name a").attr("onclick", "providerView('" + response.data.code + "')");
                    li.find("#lb").attr('id', "lb-" + response.data.code);
                    li.find("#sta").attr('id', "sta-" + response.data.code);
                    if (data.pg_pr_disable > 0) {
                        if (data.pg_pr_disable == 1) {
                            li.find(".edsts").attr('onclick', "editProviderStatus('" + response.data.code + "', '" + response.data.name + "')");//lb
                        } else {
                            li.find(".edsts").attr('onclick', "");//l
                        }
                    } else {
                        li.find(".edsts").hide();
                    }


                    if (data.pg_pr_edit > 0) {
                        if (data.pg_pr_edit == 1) {
                            li.find(".edat").attr('onclick', "saveGatewayProvider({\"code\":\"" + response.data.code + "\",\"name\":\"" + response.data.name + "\",\"activeFlag\":" + response.data.activeFlag + ",\"serviceName\":\"" + response.data.serviceName + "\",})");
                            li.find(".edat").attr('id', "edt_pro_" + response.data.code);
                        } else {
                            li.find(".edat").attr('onclick', "");//l
                            li.find(".edat").attr('id', "edt_pro_" + response.data.code);
                        }
                    } else {
                        li.find(".edat").hide();
                    }

                    if (data.pg_pr_del > 0) {
                        if (data.pg_pr_del == 1) {
                            li.find(".delam").attr('onclick', "deleteProvider('" + response.data.code + "', '" + response.data.name + "')");//lb
                        } else {
                            li.find(".delam").attr('onclick', "");//l 
                        }
                    } else {
                        li.find(".delam").hide();
                    }

                    li.removeClass('hide amt-db');
                    $('#user_list_search').append(li);
                }

                window.setTimeout(function () {
                    cancelProvider();
                }, 3000);

            } else {
                $('#ur-form-loadings').html('');
                $('#ur-form-loadings').hide();
                $('#usr-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-action-state').html(response.errorDesc);
                $('#usr-action-state').show();
                $('#form-buttons').show();
            }
        }
    });
}
function cancelProvider() {
    $('#provider-dialog').dialog('destroy');
    $('#provider-dialog').hide();
}
function cancelPartner() {
    $('#partner-dialog').dialog('destroy');
    $('#partner-dialog').hide();
}
function editProviderStatus(am_code, am_name) {
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
        url: base_url + "config/status-provider",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                var chg = data.activeFlag == 1 ? 0 : 1;
                $('#sta-' + am_code).attr('data-status', chg);
                if ($('#sta-' + am_code).attr('data-status') == 1) {
                    $('#edt_pro_' + am_code).hide();
                    $('#sta-' + am_code).removeClass('fa-times').addClass('fa-check');
                    $('#lb-' + am_code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#edt_pro_' + am_code).show();
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
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 2000);
        }
    })
}

function deleteProvider(am_code, am_name, am_service) {
    if (confirm('Do you want to delete this gateway provider?')) {
        var data = {};
        data.code = am_code;
        data.name = am_name;
        data.serviceName = am_service;
        /* $('#action-status').html(loading_popup);
         $('#action-status').show();*/
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-provider",
            data: data,
            success: function (response) {
                if (response.status == 1) {

                    $('#am-' + am_code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
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
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}

var commission = {};
function providerView(code) {

    $('#usr-viw-rslt').html('<div align="left">' + loading_big + '</div>');
    $('.li_bk').removeClass('li_bk');
    $.each(userlist, function (keys, values) {

        if (values.code == code) {

            $('#partner').val(code);
            $('#am').find('.pro_name').html(values.name);

            var usr_com = $('#user_commission_view').html();


            usr_com = $('<div>').html(usr_com).clone();

            var usr = $('#user_detail_view').html();
            usr = $('<div>').html(usr).clone();
            usr.find('.viw_name').text(values.name);
            usr.find('.edt').attr("onclick", "saveDialogUser('" + code + "')");
            usr.find('.edt_stu').attr("onclick", "editUserStatus('" + code + "',this)");

            $('#usr-viw-rslt').html(usr).append(usr_com);
            $('#usr-' + code).addClass('li_bk');

        }

    });

    $.each(userlist, function (keys, values) {
        if (values.code == code) {

            commission = {};
            var data = {}

            var html = "";
            data.usrCode = code;
            data.pg_gp_disable = $('#pg_gp_disable').val();
            data.pg_gp_edit = $('#pg_gp_edit').val();
            data.pg_gp_del = $('#pg_gp_del').val();
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/get-gateway-partners",
                data: data,
                async: true,
                success: function (response) {

                    if (response.status = 1 && response.data != undefined) {
                        commission = response.data;
                        var a = 1;
                        $.each(response.data, function (keys1, cvalues) {
                            if (cvalues.gatewayProvider.code == code) {

                                html += "<tr id='ams_" + cvalues.code + "'>";
                                html += "<td>" + a + "</td>";
                                html += "<td>" + cvalues.name + "</td>";
                                html += "<td>" + cvalues.paymentMode.name + "</td>";
                                html += "<td>" + cvalues.gatewayProvider.name + "</td>";
                                if (cvalues.activeFlag == 1) {
                                    html += "<td><span class='label label-success' id='lb-'" + cvalues.activeFlag + "'>Active</span> </td>";
                                } else {
                                    html += "<td><span class='label label-danger' id='lb-'" + cvalues.activeFlag + "'>Disabled</span> </td>";
                                }
                                html += "<td>\n\
                                    <div class='btn-group'>";
                                if (cvalues.activeFlag == 1) {
                                    if (data.pg_gp_disable > 0) {
                                        if (data.pg_gp_disable != 2) {
                                            html += "<a class='btn btn-default btn-xs' data-status='0'  onclick=\"partner_status('" + cvalues.code + "','" + code + "','" + cvalues.name + "','" + cvalues.paymentMode.code + "','" + cvalues.apiProviderCode + "',this)\">\n\
                                                    <i class='fa fa-times'></i>\n\
                                                </a>";
                                        } else {
                                            html += "<a class='btn btn-default btn-xs' data-status='0'>\n\
                                                    <i class='fa fa-times'></i>\n\
                                                </a>";
                                        }

                                    }
                                    if (data.pg_gp_edit > 0) {
                                        if (data.pg_gp_edit != 2) {
                                            html += "<a class='btn btn-default btn-xs' id='edt_id'  onclick=\"saveGatewayPartner('" + cvalues.code + "','" + cvalues.name + "','" + cvalues.paymentMode.code + "','" + cvalues.apiProviderCode + "','" + cvalues.offerTerms + "','" + cvalues.offerNotes + "')\"><i class='fa fa-pencil igreen'></i></a>";
                                        } else {
                                            html += "<a class='btn btn-default btn-xs' id='edt_id'><i class='fa fa-pencil igreen'></i></a>";
                                        }
                                    }
                                    if (data.pg_gp_del > 0) {
                                        if (data.pg_gp_del > 0) {

                                            html += "<a class='btn btn-default btn-xs'  onclick=\"DelGatewayPartner('" + cvalues.code + "','" + cvalues.name + "','" + cvalues.paymentMode.code + "','" + cvalues.apiProviderCode + "')\"><i class='fa fa-trash-o ired'></i></a>";
                                        } else {
                                            html += "<a class='btn btn-default btn-xs'><i class='fa fa-trash-o ired'></i></a>";

                                        }
                                    }
                                } else {
                                    html += "<a class='btn btn-default btn-xs' data-status='1'  onclick=\"partner_status('" + cvalues.code + "','" + code + "','" + cvalues.name + "','" + cvalues.paymentMode.code + "','" + cvalues.apiProviderCode + "',this)\">\n\
                                                    <i class='fa fa-check'></i>\n\
                                                </a>";
                                    html += "<a class='btn btn-default btn-xs'  onclick=\"DelGatewayPartner('" + cvalues.code + "','" + cvalues.name + "','" + cvalues.paymentMode.code + "','" + cvalues.apiProviderCode + "','" + code + "')\"><i class='fa fa-trash-o ired'></i></a>";

                                }


                                html += "</div>\n\
                                    </td>";
                                html += "<td><a href='javascript:;' data-toggle='popover' class='has_popover' data-trigger='hover' data-placement='left'  data-content='"+cvalues.offerTerms+"'><i class='fa fa-info-circle'></i></a></td></tr>";
                                a++;

                            }

                        });
                        if (html == '') {

                            var emhtml = "<tr><td colspan='6'>No Partner details found!</td></tr>";
                            usr_com.find('.body_table').append(emhtml);
                        } else {
                            usr_com.find('.body_table').append(html);
                        }
                    }

                }
            });
            $('#partner').val(code);
            $('#am').find('.pro_name').html(values.name);

            var usr_com = $('#user_commission_view').html();
            usr_com = $('<div>').html(usr_com).clone();

            var usr = $('#user_detail_view').html();
            usr = $('<div>').html(usr).clone();
            usr.find('.viw_name').text(values.name);
            usr.find('.edt').attr("onclick", "saveDialogUser('" + code + "')");
            usr.find('.edt_stu').attr("onclick", "editUserStatus('" + code + "',this)");

            $('#usr-viw-rslt').html(usr).append(usr_com);
            $('#am-' + code).addClass('li_bk');

        }

    });


}

function partner_status(code, codegate, name, payment, providercode, obj) {
    
    var data = _.find(commission, function (o) {
        return o.code === code;
    });
     data.code = code;
    data.part_name = name;
    data.pro_code = codegate;
    data.part_mode = payment;

    data.activeFlag = $(obj).attr('data-status');

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-gateway-partner",
        data: data,
        success: function (response) {
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
            $('#pro-viw-' + data.pro_code).trigger("click");
            window.setTimeout(function () {

                loading_overlay.hide();
            }, 2000);
        }
    })

}


function DelGatewayPartner(codegate, code, name, payment, providercode, obj) {
    if (confirm('Do you want to delete this gateway partner?')) {
        //var data = {}
        var data = _.find(commission, function (o) {
        return o.code === codegate;
    });
    console.log(data);
        data.code = codegate;
        data.part_name = name;
        
        data.pro_code = codegate;
        data.part_mode = payment;
       
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/edit-gateway-partner",
            data: data,
            success: function(response) {
                if (response.status == 1) {

                    $('#ams_' + codegate).animate({opacity: '0'}, 2000, function() {
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

                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}