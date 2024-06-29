function cancellation(option) {
    $('.inp_error').removeClass('inp_error');
    $('#cnl-form-action-state').html('');
    $('#cnl-form-action-state').hide();
    $('#pg-cancel-dialog').css('background', '#fff');


    $('#pg-cancel-dialog').removeClass('hide');
    $('#pg-cancel-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 800,
        modal: true,
        resizable: false
    });

    $('#form-bttons').show();

    $(".ui-dialog-titlebar").hide();
    $('#form-bttons').show();
    $('#pg-cancel-dialog,.tr_st').removeClass('hide');
    $('.tr_st :input').val('');
    $('.tr_st').find('.frm_val input').val(0);
    $('#tr_default .amt_val input').val('');
    if (_isdefined(option)) {
        $('#hid_active_Flag').val(option.activeFlag);
        $('#txt_cp_name').val(option.name);
        $('#hid_cn_code').val(option.code);
        $.each(option.policyList, function (keys, values) {

            var last = option.policyList.length - 1;
            if (values.fromValue < 1440 && values.fromValue > 60) {
                values.fromValue = Math.floor(values.fromValue / 60);
            } else if (values.fromValue >= 1440) {
                values.fromValue = Math.floor(values.fromValue / (24 * 60));
            }

            if (values.toValue < 1440 && values.toValue > 60) {
                values.toValue = Math.floor(values.toValue / 60);
                values.policyPattern = "hour";
            } else if (values.toValue >= 1440) {
                values.toValue = Math.floor(values.toValue / (24 * 60));
                values.policyPattern = "day";
            }

            if (values.fromValue == 0 && keys == 0) {

                var ftr = $('.tr_st');
                ftr.find('.frm_val input').val(values.fromValue);
                ftr.find('.frm_val input').attr('disabled', 'disabled');
                ftr.find('.to_val input').val(values.toValue);
                if (values.policyPattern == 'AM' || values.policyPattern == 'PM') {
                    ftr.find('.plc_val select').val(values.policyPattern);
                } else {
                    ftr.find('.plc_val select').val(values.policyPattern.toLowerCase());
                }

                ftr.find('.amt_val input').val(values.deductionAmount);

                if (values.percentageFlag == 1) {
                    ftr.find('.rs_val input').attr('checked');
                }
            } else if (last == keys) {
                var ltr = $('#tr_default');
                ltr.find('.frm_val input').val(values.fromValue);
                ltr.find('.frm_val input').attr('disabled', 'disabled');
                //ltr.find('.to_val input').val(values.toValue);
                if (values.policyPattern == 'AM' || values.policyPattern == 'PM') {
                    ltr.find('.plc_val select').val(values.policyPattern);
                } else {
                    ltr.find('.plc_val select').val(values.policyPattern.toLowerCase());
                }

                ltr.find('.amt_val input').val(values.deductionAmount);

                if (values.percentageFlag == 1) {
                    ltr.find('.rs_val input').attr('checked');
                }
            } else {
                $('#tr_clone').find('.su_ds').removeAttr('disabled', 'disabled');
                var tr = $('#tr_clone').clone();
                tr.find('.su_ds').removeClass('su_ds');
                tr.removeClass('hide');
                tr.attr('id', '');



                tr.find('.frm_val input').val(values.fromValue);
                tr.find('.frm_val input').attr('disabled', 'disabled');
                tr.find('.to_val input').val(values.toValue);
                if (values.policyPattern == 'AM' || values.policyPattern == 'PM') {
                    tr.find('.plc_val select').val(values.policyPattern);
                } else {
                    tr.find('.plc_val select').val(values.policyPattern.toLowerCase());
                }

                tr.find('.amt_val input').val(values.deductionAmount);

                if (values.percentageFlag == 1) {
                    tr.find('.rs_val input').attr('checked');
                } else {
                    tr.find('.rs_val input').attr('checked', false);
                    tr.find('.rs_val input').attr('checked', "");
                }


                $('#tr_default').before(tr);

            }
            onblurtxt();
            removetr();

        });

        var to = $("#tr_default").prev().find('.to_val input').val();

        $('input[name="ay_fm_val"]').val(to);
    }
    dilg.push("#pg-cancel-dialog");
}
function cancelEdit() {
    $('#pg-cancel-dialog').dialog("destroy");
    $("#tbl_list").find("tr").not("#tr_default").not("#tr_add").not(".tr_st").not("#tr_clone").remove();
    $('#pr_viw').html('<span class="">Click "Preview" button to get preview of this policy.</span>');
    $('input[name="ay_fm_val"]').val(0);
    $('#txt_cp_name,#hid_cn_code').val('');
    $('#hid_active_Flag').val(1);
    $('.su_ds').removeAttr('disabled', 'disabled');
    $('.frm_val input').attr('disabled', 'disabled');
    $('#form1').removeClass('inp_error');
    $('#pg-cancel-dialog').hide();
}

function saveCancel() {
    $('#txt_cp_name').removeClass('inp_error');


    if ($('#txt_cp_name').val() == '') {
        $('#txt_cp_name').addClass('inp_error');
        $('#cnl-form-action-state').show();
        $('#cnl-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#cnl-form-action-state').html('Please enter the cancellation policy name.');
        return false;
    }

    var data = {}
    $('.su_ds').attr('disabled', 'disabled');
    data.name = $('#txt_cp_name').val();
    data.percentageFlag = $('input[name="chk_amt"]').serializeArray();
    data.policyPattern = $('select[name="ps_tye"]').serializeArray();
    data.deductionAmount = $('input[name="amt_val"]').serializeArray();
    data.toValue = $('input[name="to_val"]').serializeArray();

    var cht = new Array();
    $("input[name='chk_amt']").each(function () {
        if ($(this).is(":checked") == true && !$(this).hasClass('su_ds')) {
            if ($(this).val() == '')
                $(this).val(1)
            cht.push($(this).val());
        } else if (!$(this).hasClass('su_ds')) {
            cht.push(0);
        }
    });
    data.percentageFlag = cht;
    data.activeFlag = $('#hid_active_Flag').val();//hid_active_Flag

    data.at_fromValue = $('input[name="ay_fm_val"]').val();
    data.code = $('#hid_cn_code').val();
    data.at_toValue = 0;
    data.at_pp = $('input[name="ay_ps_tye"]').val();
    data.at_amt = $('input[name="ay_amt_val"]').val();
    data.at_amt_tp = $('input[name="ay_chk_amt"]').is(":checked") == true ? 1 : 0;
    var disabled = $('input[name="fm_val"]').removeAttr('disabled');
    $('.su_ds').attr('disabled', 'disabled');
    data.fromValue = $('input[name="fm_val"]').serializeArray();
    disabled.attr('disabled', 'disabled');

    $('#cnl-form-action-state').html(loading_popup);
    $('#cnl-form-action-state').show();
    $('#form-bttons').hide();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-cancellation",
        data: data,
        success: function (response) {

            if (response.status == 1) {
                $('#cnl-form-action-state').show();
                $('#cnl-form-action-state').removeClass('alert-danger');
                $('#cnl-form-action-state').addClass('alert-success');
                $('#cnl-form-action-state').html('Your request has been completed successfully');

                $('.su_ds').removeAttr('disabled', 'disabled');
                $('.frm_val input').attr('disabled', 'disabled');
                if ($('#min-' + response.data.code).html() == undefined) {
                    var jsn = {};
                    jsn['policyList'] = new Array();
                    var ar = $('#min-dm').clone();
                    ar.removeClass('hide');
                    ar.attr('id', 'min-' + response.data.code);
                    ar.find('.ac_but').attr('href', '#collapse-' + response.data.code); //ac_bo
                    ar.find('.ac_but').html($('#txt_cp_name').val());
                    ar.find('.ac_bo').attr('id', 'collapse-' + response.data.code);
                    var ht = '';
                    $.each(data.policyPattern, function (keys, values) {
                        var amt = " Rs";

                        if (data.fromValue[keys].value != '' && data.toValue[keys].value != '' && data.deductionAmount[keys].value != '') {
                            var rs = convertion(data.policyPattern[keys].value, data.fromValue[keys].value, data.toValue[keys].value);
                            var jsr = {};
                            jsr.fromValue = rs.f;
                            jsr.toValue = rs.t;
                            jsr.deductionAmount = data.deductionAmount[keys].value;
                            jsr.policyPattern = rs.p;
                            jsr.percentageFlag = data.percentageFlag[keys].value;
                            jsn['policyList'].push(jsr);
                            if (cht[keys] == 1)
                                amt = '%';
                            if (data.deductionAmount[keys].value == '-1') {
                                data.deductionAmount[keys].value = "No";
                                amt = '';
                                ht += "<li> Between " + data.fromValue[keys].value + " " + data.policyPattern[keys].value + " - " + data.toValue[keys].value + " " + data.policyPattern[keys].value + " " + data.deductionAmount[keys].value + " " + amt + " Cancellation </li>";
                            }
                            else {
                                ht += "<li> Between " + data.fromValue[keys].value + " " + data.policyPattern[keys].value + " - " + data.toValue[keys].value + " " + data.policyPattern[keys].value + " " + data.deductionAmount[keys].value + " " + amt + " Deduction </li>";

                            }
                        }
                    });
                    var rs = convertion($('input[name="ay_ps_tye"]').val(), $('input[name="ay_fm_val"]').val(), $('input[name="ay_to_val"]').val());
                    var jsr = {};
                    var amt = ' Rs', amut;
                    jsr.fromValue = rs.f;
                    jsr.toValue = rs.f;
                    jsr.deductionAmount = $('input[name="ay_amt_val"]').val();
                    jsr.policyPattern = rs.p;
                    jsr.percentageFlag = data.at_amt_tp;

                    if (data.at_amt_tp == 1)
                        amt = '%';
                    amut = $('input[name="ay_amt_val"]').val();
                    if ($('input[name="ay_amt_val"]').val() == '-1') {
                        amut = "No";
                        amt = '';
                        ht += "<li> Between " + $('input[name="ay_fm_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " - " + $('input[name="ay_to_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " " + amut + " " + amt + " Cancellation </li>";
                    }
                    else {
                        ht += "<li> Between " + $('input[name="ay_fm_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " - " + $('input[name="ay_to_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " " + amut + " " + amt + " Deduction </li>";

                    }
                    jsn['policyList'].push(jsr);

                    jsn.name = $('#txt_cp_name').val();
                    jsn.code = response.data.code;
                    jsn.activeFlag = $('#hid_active_Flag').val();
                    var json = JSON.stringify(jsn);
                    ar.find('.list-unstyled').html(ht);
                    ar.find('.edat').attr('onclick', 'cancellation(' + json + ')');
                    ar.find('.del').attr('onclick', 'delete_cancellations("' + response.data.code + '","' + $('#txt_cp_name').val() + '")');
                    ar.find('.est').attr('onclick', 'editStatus_cancellations("' + response.data.code + '","' + $('#txt_cp_name').val() + '")');
                    $('#accordion').append(ar); //
                    if ($('#accordion > .panel-info').not('.hide').html() != '') {
                        $('.well').hide();
                    }
                    window.setTimeout(function () {
                        $('#cnl-form-action-state').html('');
                        $('#cnl-form-action-state').hide();
                        cancelEdit();
                        checkURL();
                        return;
                    }, 3000);

                } else {

                    var jsn = {};
                    jsn['policyList'] = new Array();
                    var ar = $('#min-' + response.data.code);
                    ar.find('.ac_but').html($('#txt_cp_name').val());

                    var ht = '';
                    $.each(data.policyPattern, function (keys, values) {
                        var amt = " Rs";

                        if (data.fromValue[keys].value != '' && data.toValue[keys].value != '' && data.deductionAmount[keys].value != '') {
                            var rs = convertion(data.policyPattern[keys].value, data.fromValue[keys].value, data.toValue[keys].value);
                            var jsr = {};
                            jsr.fromValue = rs.f;
                            jsr.toValue = rs.t;
                            jsr.deductionAmount = data.deductionAmount[keys].value;
                            jsr.policyPattern = rs.p;
                            jsr.percentageFlag = data.percentageFlag[keys].value;
                            jsn['policyList'].push(jsr);
                            if (cht[keys] == 1)
                                amt = '%';
                            if (data.deductionAmount[keys].value == '-1') {
                                data.deductionAmount[keys].value = "No";
                                amt = '';
                                ht += "<li> Between " + data.fromValue[keys].value + " " + data.policyPattern[keys].value + " - " + data.toValue[keys].value + " " + data.policyPattern[keys].value + " " + data.deductionAmount[keys].value + " " + amt + " cancellation </li>";
                            }
                            else {
                                ht += "<li> Between " + data.fromValue[keys].value + " " + data.policyPattern[keys].value + " - " + data.toValue[keys].value + " " + data.policyPattern[keys].value + " " + data.deductionAmount[keys].value + " " + amt + " Deduction </li>";

                            }
                        }
                    });
                    var rs = convertion($('input[name="ay_ps_tye"]').val(), $('input[name="ay_fm_val"]').val(), $('input[name="ay_to_val"]').val());
                    var jsr = {};
                    var amt = ' Rs', amut;
                    jsr.fromValue = rs.f;
                    jsr.toValue = rs.f;
                    jsr.deductionAmount = $('input[name="ay_amt_val"]').val();
                    jsr.policyPattern = rs.p;
                    jsr.percentageFlag = data.at_amt_tp;

                    if (data.at_amt_tp == 1)
                        amt = ' %';
                    amut = $('input[name="ay_amt_val"]').val();
                    if ($('input[name="ay_amt_val"]').val() == '-1') {
                        amut = "No";
                        amt = '';

                        ht += "<li> Between " + $('input[name="ay_fm_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " - " + $('input[name="ay_to_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " " + amut + " " + amt + " Cancellation </li>";
                    }
                    else {
                        ht += "<li> Between " + $('input[name="ay_fm_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " - " + $('input[name="ay_to_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " " + amut + " " + amt + " Deduction </li>";

                    }
                    jsn['policyList'].push(jsr);

                    jsn.name = $('#txt_cp_name').val();
                    jsn.activeFlag = $('#hid_active_Flag').val();
                    jsn.code = response.data.code;
                    var json = JSON.stringify(jsn);
                    ar.find('.list-unstyled').html(ht);
                    ar.find('.edat').attr('onclick', 'cancellation(' + json + ')');
                    ar.find('.del').attr('onclick', 'delete_cancellations("' + response.data.code + '","' + $('#txt_cp_name').val() + '")');
                    ar.find('.est').attr('onclick', 'editStatus_cancellations("' + response.data.code + '","' + $('#txt_cp_name').val() + '")');
                    window.setTimeout(function () {
                        $('#cnl-form-action-state').html('');
                        $('#cnl-form-action-state').hide();
                        cancelEdit();
                    }, 3000);
                }
            } else {
                $('#tr_clone').find('.su_ds').removeAttr('disabled', 'disabled');
                $('#tr_clone').find('.frm_val input').attr('disabled', 'disabled');
                $('#cnl-form-action-state').show();
                $('#cnl-form-action-state').addClass('alert-error');
                $('#cnl-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
                window.setTimeout(function () {
                    $('#cnl-form-action-state').html('');
                    $('#cnl-form-action-state').hide();

                }, 3000);
            }

        }
    });
}
function convertion(policyPattern, fromValue, tovalue) {
    if (policyPattern == 'day') {
        tovalue = tovalue * (24 * 60);
        fromValue = fromValue * (24 * 60);
        policyPattern = 'min';
    } else if (policyPattern == 'hour') {
        tovalue = tovalue * 60;
        fromValue = fromValue * 60;
        policyPattern = 'min';
    } else {
        tovalue = tovalue;
        fromValue = fromValue;
        policyPattern = policyPattern;
    }

    return {
        p: policyPattern,
        f: fromValue,
        t: tovalue
    };
}
function delete_cancellations(cn_code, cn_name) {
    if (confirm('Do you want to delete this cancellations policy?')) {
        var data = {};
        data.cn_code = cn_code;
        data.cn_name = cn_name

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-cancellations",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#min-' + cn_code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
                        if ($('#accordion > .panel-info').not('.hide').html() == undefined) {
                            $('.well').show();
                        }
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
function editStatus_cancellations(cn_code, cn_name, obj) {

    var data = {};
    data.cn_code = cn_code;
    data.cn_name = cn_name;
    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-status-cancellations",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#cl_edt_' + cn_code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $('#cl_edt_' + cn_code).show();
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
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 2000);
        }
    })

}
function preview() {

    $('#tr_clone').find('.su_ds').attr('disabled', 'disabled');
    var name = $('#txt_cp_name').val();
    var policyPattern = $('select[name="ps_tye"]').serializeArray();
    var deductionAmount = $('input[name="amt_val"]').serializeArray();
    var toValue = $('input[name="to_val"]').serializeArray();

    var disabled = $('input[name="fm_val"]').removeAttr('disabled');
    $('#tr_clone').find('.frm_val input').attr('disabled', 'disabled');
    var fromValue = $('input[name="fm_val"]').serializeArray();
    disabled.attr('disabled', 'disabled');
    $('#tr_clone').find('.su_ds').removeAttr('disabled', 'disabled');
    $('#tr_clone').find('.frm_val input').attr('disabled', 'disabled');
    var ht = "";

    var cht = new Array();
    $("input[name='chk_amt']").each(function () {
        if ($(this).is(":checked") == true && !$(this).hasClass('su_ds')) {
            if ($(this).val() == '')
                $(this).val(1)
            cht.push($(this).val());
        } else if (!$(this).hasClass('su_ds')) {
            cht.push(0);
        }
    });

    $.each(policyPattern, function (keys, values) {
        var amt = " Rs";
        if (ht != '')
            ht += "<br>";
        if (fromValue[keys].value != '' && toValue[keys].value != '' && deductionAmount[keys].value != '') {
            if (cht[keys] == 1)
                amt = '%';
            if (deductionAmount[keys].value == '-1') {
                deductionAmount[keys].value = "No";
                amt = '';            
            if (keys > 0) {
                var key = keys - 1;
                ht += "Between " + fromValue[keys].value + " " + policyPattern[key].value + " - " + toValue[keys].value + " " + policyPattern[keys].value + " " + deductionAmount[keys].value + " " + amt + " Cancellation";
            }
            else {
                ht += "Between " + fromValue[keys].value + " " + policyPattern[keys].value + " - " + toValue[keys].value + " " + policyPattern[keys].value + " " + deductionAmount[keys].value + " " + amt + " Cancellation";

            }}else{
              if (keys > 0) {
                var key = keys - 1;
                ht += "Between " + fromValue[keys].value + " " + policyPattern[key].value + " - " + toValue[keys].value + " " + policyPattern[keys].value + " " + deductionAmount[keys].value + " " + amt + " Deduction";
            }
            else {
                ht += "Between " + fromValue[keys].value + " " + policyPattern[keys].value + " - " + toValue[keys].value + " " + policyPattern[keys].value + " " + deductionAmount[keys].value + " " + amt + " Deduction";

            }
            }
        }
    });
    if ($('input[name="ay_amt_val"]').val() != '') {
        var amt = 'Rs', amut;
        var at_amt_tp = $('input[name="ay_chk_amt"]').is(":checked") == true ? 1 : 0
        if (at_amt_tp == 1)
            amt = ' %';
        amut = $('input[name="ay_amt_val"]').val();
        if ($('input[name="ay_amt_val"]').val() == '-1') {
            amut = "No";
            amt = '';
            ht += "<br/> Between " + $('input[name="ay_fm_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " - " + $('input[name="ay_to_val"]').val() + amut + " " + amt + " " + " Cancellation ";
        }
        else {
            ht += "<br/> Between " + $('input[name="ay_fm_val"]').val() + " " + $('input[name="ay_ps_tye"]').val() + " - " + $('input[name="ay_to_val"]').val() + amut + " " + amt + " " + " Deduction ";

        }
    }
    $('#pr_viw').css('margin', '10px auto auto 20px').html(ht);
}
$(document).ready(function () {
    removetr();
    onblurtxt();
});

$('#tr_add_btn').click(function (e) {

    var dataArray = $('select[name="ps_tye"]').serializeArray(),
            len = dataArray.length,
            dataObj = {};

    for (i = 0; i < len - 1; i++) {
        dataObj[dataArray[i].name] = dataArray[i].value;

    }


    if ($("#tr_default").prev().find('.to_val input').val() != '' && $("#tr_default").prev().find('.amt_val input').val() != '') {

        $('#tr_clone').find('.su_ds').removeAttr('disabled', 'disabled');
        $('#tr_clone').find('.frm_val input').attr('disabled', 'disabled');
        $('#tr_clone').find('.plc_val select').val(dataObj['ps_tye']);
        var tr = $('#tr_clone').clone();

        tr.find('select').each(function (index, item) {
            $(item).val(dataObj['ps_tye']);

        });

        tr.find('.su_ds').removeClass('su_ds');
        tr.removeClass('hide');
        tr.attr('id', '');
        var to = '';
        if ($("#tr_default").prev().find('.to_val input').val() != '' && $("#tr_default").prev().find('.to_val input').val() != undefined) {
            to = $("#tr_default").prev().find('.to_val input').val();
        } else {
            to = 0;
        }
        tr.find('.frm_val input').val(to);
        $('#tr_default').before(tr);
        removetr();
        onblurtxt();
    } else {
        alert("Please fill the empty");
        return false;
    }

});
function removetr() {
    $('.tr_remove').on('click', function () {
        $(this).closest('tr').remove();
    });
}
function onblurtxt() {
    $('#tr_default').prev().find('.to_val input').blur(function () {
        var fm = $("#tr_default").prev().find('.frm_val input').val();
        var to = $("#tr_default").prev().find('.to_val input').val();
        if (fm > to) {
            $("#tr_default").prev().find('.to_val input').addClass('inp_error');
        } else {
            $("#tr_default").prev().find('.to_val input').removeClass('inp_error');
        }
        $('input[name="ay_fm_val"]').val(to);
    });
    $('#tr_default').prev().find('.to_val input').keyup(function () {
        var fm = $("#tr_default").prev().find('.frm_val input').val();
        var to = $("#tr_default").prev().find('.to_val input').val();
        if (fm > to) {
            $('input[name="ay_fm_val"]').val(0);
        }
        $('input[name="ay_fm_val"]').val(to);

    });
    $('#tr_default').prev().find('.plc_val select').change(function () {
        $('input[name="ay_ps_tye"]').val($(this).val());
    });
}
$('#tbl_list').on('input', '[name="to_val"]', function () {
    $(this).closest('tr').next().find('[name="fm_val"]').val(+this.value || 0);
});
    