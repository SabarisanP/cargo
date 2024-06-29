function editSchedules(option) {

    $('#pg-organization-dialog').css('background', '#fff');
    $('#pg-organization-dialog').removeClass('hide');
    $('#pg-organization-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    if (_isdefined(option)) {

        var fromDate = option.fromDate.split(" ").slice(0, 1).join(" ");
        var toDate = option.toDate.split(" ").slice(0, 1).join(" ");
        $('#gateway').val(option.gatewayPartner.code);
        $('#sel_oz_status').val(option.activeFlag);
        $('#name').val(option.name);
        $('#fdate').val(fromDate);
        $('#tdate').val(toDate);
        $('#group').val(option.group.code);
        $('#code_edit').val(option.code);
        $('#device').val(option.deviceMedium);


        $('#service_charges').val(option.serviceCharge);
        $('#sch-precedence').val(option.precedence);
        $('#pgs_txn_type').val(option.transactionType.code);
        if (option.deviceMedium.length) {
            $('#device').val(option.deviceMedium).multiselect('refresh');

        } else {
            $('#device').val('').multiselect('refresh');
        }



    } else {
        // alert('no');
        $('#gateway').val('');
        $('#name').val('');
        $('#device').val('').multiselect('refresh');
        $('#fdate').val('');
        $('#tdate').val('');
        $('#group').val('');
        $('#code_edit').val('');

        $('#service_charges').val('');
        $('#sch-precedence').val(0);
        $('#pgs_txn_type').val('');
    }

}
function saveSchedule() {
    var data = {};

    data.activeFlag = $('#sel_oz_status').val();
    data.name = $('#name').val();
    data.gatewayPartner = $('#gateway').val();
    data.group = $('#group').val();
    data.fromDate = $('#fdate').val();
    data.toDate = $('#tdate').val();
    data.code = $('#code_edit').val();

    data.serviceCharge = $('#service_charges').val();
    data.txnType = $('#pgs_txn_type').val();
    data.precedence = $('#sch-precedence').val();

    var err = 0;
    if ($('#gateway').val() == '') {
        $('#gateway').addClass('inp_error');
        err++;
    } else {
        $('#gateway').removeClass('inp_error');
    }

    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }
    if ($('#device').val() == null) {
        $('.deviceMedium').addClass('inp_error');
        err++;
    } else {
        data.deviceMedium = $.map($('#device').val() || [], function (val) {
            return val;
            console.log($('#device').val());
        });
    }
    if ($('#group').val() == '') {
        $('#group').addClass('inp_error');
        err++;
    } else {
        $('#group').removeClass('inp_error');
    }
    if ($('#fdate').val() == '') {
        $('#fdate').addClass('inp_error');
        err++;
    } else {
        $('#fdate').removeClass('inp_error');
    }
    if ($('#tdate').val() == '') {
        $('#tdate').addClass('inp_error');
        err++;
    } else {
        $('#tdate').removeClass('inp_error');
    }

    if ($('#tdate').val() == '') {
        $('#tdate').addClass('inp_error');
        err++;
    } else {
        $('#tdate').removeClass('inp_error');
    }

    if ($('#service_charges').val() == '') {
        $('#service_charges').addClass('inp_error');
        err++;
    } else {
        $('#service_charges').removeClass('inp_error');
    }

    if ($('#pgs_txn_type').val() == '') {
        $('#pgs_txn_type').addClass('inp_error');
        err++;
    } else {
        $('#pgs_txn_type').removeClass('inp_error');
    }
    
    if ($('#sch-precedence').val() == '') {
        $('#sch-precedence').addClass('inp_error');
        err++;
    } else {
        $('#sch-precedence').removeClass('inp_error');
    }

    if (err > 0) {
        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#org-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#org-form-action-state').show();
        return false;
    } else {
        $('#org-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#org-form-action-state').hide();
    }

    // Date validation

    var str = $('#fdate').val();
    str = str.replace(/-/g, '/');
    var dt = new Date(str);
    str = $('#tdate').val();
    str = str.replace(/-/g, '/')
    var selec = new Date(str);

    if (dt > selec) {
        $('#tdate').addClass('inp_error');
        $('#org-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#org-form-action-state').html('To date should be greater than from date.');
        $('#org-form-action-state').show();
        return false;
    } else {
        $('#tdate').removeClass('inp_error');
        $('#org-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#org-form-action-state').hide();
    }

    // Date validation ends

    $('#form-bttons').hide();
    $('#org-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#org-form-action-state').html(loading_popup);
    $('#org-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-payment-schedules",
        data: data,
        success: function (response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelOrganization();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#org-form-action-state').addClass('alert-danger');
                $('#org-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}
function cancelOrganization() {
    $('#pg-organization-dialog').dialog('destroy');
    $('#pg-organization-dialog').hide();

}


function deleteSchedules(option) {
    if (confirm('Do you want to delete this schedule?')) {
        var data = {};

        data.activeFlag = 2;

        data.name = option.name;
        data.deviceMedium = option.deviceMedium;
        data.deviceMedium = $.map(option.deviceMedium || [], function (val) {
            return val;
        });
        //alert(data.deviceMedium);
        data.gatewayPartner = option.gatewayPartner.code;
        data.group = option.group.code;
        data.fromDate = option.fromDate;
        data.toDate = option.toDate;
        data.code = option.code;
        data.serviceCharge = option.serviceCharge;
        data.txnType = option.transactionType.code;
        data.precedence = option.precedence;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-payment-schedules",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#oz-' + response.data.code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove()
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
function editStatusSchedules(option, obj) {

    var data = {};


    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;

    data.name = option.name;
    data.deviceMedium = option.deviceMedium;
    //alert(data.deviceMedium);
    data.gatewayPartner = option.gatewayPartner.code;
    data.group = option.group.code;
    data.fromDate = option.fromDate;
    data.toDate = option.toDate;
    data.code = option.code;

    data.serviceCharge = option.serviceCharge;
    data.txnType = option.transactionType.code;
    data.precedence = option.precedence;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-payment-schedules",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#edt_sch_' + option.code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $('#edt_sch_' + option.code).show();
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
