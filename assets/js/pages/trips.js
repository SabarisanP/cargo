function editTripHead(option) {
    $('.inp_error').removeClass('inp_error');
    $('#trip-head-action').hide();
    $('#trip-head-dialog').css('background', '#fff');
    $('#trip-head-buttons,#trip-head-dialog').show();
    $('#trip-head-dialog').removeClass('hide');

    $('#trip-head-dialog').dialog({
        autoOpen: true,
        width: 650,
        maxWidth: 650,
        height: 400,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    $('#tph-name,#tph-description,#tph-code').val('');
    $('#trip_head_tags, #trip_head_mandatory_fields').val(['']).multiselect('refresh');
    $('#trip_head_mandatory_fields').closest('.form-group').addClass('hide');
    $('#trp-cr-dr').attr("checked", "checked");
    $('.bsn_switch').bootstrapSwitch('state', true);
    $('.bsn_switch').addClass('switch-on');
    $('#trip-head-action').hide();
    if (_isdefined(option)) {
        $.each(triphead, function(k, sval) {
            if (option == sval.code) {
                if (sval.creditDebitFlag == "Dr") {
                    $('#trp-cr-dr').removeAttr("checked");
                    $('#trp-cr-dr').prop("checked", "");
                    $('.bsn_switch').bootstrapSwitch('state', false);
                    $('.bsn_switch').removeClass('switch-on');
                }
                $('#tph-name').val(sval.name);
                $('#tph-description').val(sval.description);
                $('#tph-code').val(sval.code);
                $('#t_mode').val(sval.transactionMode.code);

                var tags = $.map(sval.tag || [], function(obj) {
                    return obj;
                });
                if (tags.length > 0) {
                    $('#trip_head_tags').val(tags).multiselect('refresh');
                }

                if ($.inArray('BRN', tags) != -1) {
                    $('#trip_head_mandatory_fields').closest('.form-group').removeClass('hide');
                    $('#trip_head_mandatory_fields').val((sval.additionalAttributes || '').split(',')).multiselect('refresh');
                }
            }

        });
    }

}
function closeTripHead() {
    $('#trip-head-dialog').dialog('destroy');
    $('#trip-head-dialog').hide();
}

function saveTripHead() {
    var data = {};
    data.name = $('#tph-name').val();
    data.description = $('#tph-description').val();

    data.code = $('#tph-code').val();
    data.creditDebitFlag = $('#trp-cr-dr:checked').val() ? 1 : 0;
    var cd = '';
    if (data.creditDebitFlag == 1) {
        data.creditDebitFlag = "Cr";
        cd = "Credit";
    } else {
        data.creditDebitFlag = "Dr";
        cd = "Debit";
    }
    data.transactionMode = {}
    data.transactionMode.code = $('#t_mode').val();

    data.tag = $('#trip_head_tags').val();

    if ($.inArray('BRN', data.tag) != -1) {
        data.additionalAttributes = $('#trip_head_mandatory_fields').val();
    }

    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').html('');
    var err = 0;
    if (data.name == '') {
        $('#tph-name').addClass('inp_error');
        err++;
    }
    // if (data.description == '') {
    //     $('#tph-description').addClass('inp_error');
    //     err++;
    // }
    if (data.transactionMode.code == '') {
        $('#t_mode').addClass('inp_error');
        err++;
    }

    if (err > 0) {

        $('#trip-head-action').html('<div class="alert alert-danger">Please enter the values in the field that are marked in red</div>');
        $('#trip-head-action').show();
        return false;
    }

    $('#trip-head-buttons').hide();
    $('#trip-head-action').html(loading_popup).show();


    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "trips/update-trips-head",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#trip-head-action').html('<div class="alert alert-success">Your request has been completed successfully</div>');

                window.setTimeout(function() {
                    closeTripHead();
                    location.reload();
                }, 2500);
                return

                if (data.code != '') {
                    triphead = $.grep(triphead, function(e) {
                        return e.code != data.code
                    });
                    $('#trp-' + data.code).find('.trp_name').html(data.name);
                    $('#trp-' + data.code).find(".trp_cr_dr_flag").html(cd);
                    var trip_head = {};
                    trip_head["code"] = data.code;
                    trip_head["name"] = data.name;
                    trip_head["creditDebitFlag"] = data.creditDebitFlag;
                    trip_head["description"] = data.description;
                    trip_head["activeflag"] = "1";

                    triphead.push(trip_head);

                } else {

                    var li = $('#template-trip-head-list').html();
                    li = $('<div>').html(li).clone();
                    li.find("li").attr('id', "trp-" + response.data.code);
                    li.find(".trp_name").html(data.name);//lb
                    li.find("#lb").attr('id', "trp-lb-" + response.data.code);
                    li.find("#trp-stu").attr('id', "trp-stu-" + response.data.code);
                    li.find(".trp_cr_dr_flag").html(cd);
                    if (menu_permission['TP-DS'] > 0) {
                        if (menu_permission['TP-DS'] == 1) {
                            li.find(".edsts").attr('onclick', "editTripHeadStatus('" + response.data.code + "', '" + response.data.name + "')");//lb
                        } else {
                            li.find(".edsts").attr('onclick', "");//lb
                        }
                    }
                    else {
                        li.find(".edsts").hide();
                    }
                    if (menu_permission['TP-ED'] > 0) {
                        if (menu_permission['TP-ED'] == 1) {
                            li.find(".edat").attr('onclick', "editTripHead('" + response.data.code + "')");
                            li.find(".edat").attr('id', "tph_edt_" + response.data.code);
                        } else {
                            li.find(".edat").attr('onclick', "");
                            li.find(".edat").attr('id', "tph_edt_" + response.data.code);
                        }
                    }
                    else {
                        li.find(".edat").hide();
                    }
                    if (menu_permission['TP-ED'] > 0) {
                        if (menu_permission['TP-ED'] == 1) {
                            li.find(".delam").attr('onclick', "deleteTripHead('" + response.data.code + "')");//lb
                        } else {
                            li.find(".delam").attr('onclick', "");//lb
                        }
                    }
                    else {
                        li.find(".delam").hide();//lb
                    }
                    $('#trip_list_search').append(li.html());
                }
                var trip_head = {};
                trip_head["code"] = response.data.code;
                trip_head["name"] = data.name;
                trip_head["creditDebitFlag"] = data.creditDebitFlag;
                trip_head["description"] = data.description;
                trip_head["activeflag"] = "1";

                triphead.push(trip_head);
                window.setTimeout(function() {
                    $('#trip-head-action').html('');
                    closeTripHead();
                }, 3000);
            } else {
                $('#trip-head-action').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                $('#trip-head-buttons').show();
                window.setTimeout(function() {
                    $('#trip-head-action').html('');

                }, 3000);
            }
        }
    })
}

function deleteTripHead(code, el) {
    if (confirm('Do you want to delete this Trip Head?')) {
        var data = {};
        data.code = code;
        data.activeFlag = 2;
        data.transactionMode = {}
        data.transactionMode.code = $(el).data('transmode');
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "trips/update-staus-trip-head",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#trp-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
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
function init_Trip_Page() {
    $('.bsn_switch').bootstrapSwitch('size', 'mini');
}
function editTripHeadStatus(code, el) {
    var data = _.find(triphead, i => i.code == code);
    data.activeFlag = $('#trp-stu-' + code).attr('data-status');
    if (data.activeFlag == "1") {
        data.activeFlag = 9;
    }
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "trips/update-staus-trip-head",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                var chg = data.activeFlag == 9 ? 0 : 1;
                $('#trp-stu-' + code).attr('data-status', chg);
                if ($('#trp-stu-' + code).attr('data-status') == 1) {
                    $('#tph_edt_' + code).hide();
                    $('#trp-stu-' + code).removeClass('fa-times').addClass('fa-check');
                    $('#trp-lb-' + code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#tph_edt_' + code).show();
                    $('#trp-stu-' + code).removeClass('fa-times').addClass('fa-times');
                    $('#trp-lb-' + code).removeClass('label-danger').addClass('label-success').html('Active');

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
