
function addCriteria(i) {    
   $('#disc-criteria').css('background', '#fff'); 
   $('#disc-criteria').css('overflow-x', 'hidden');
   $('#disc-criteria').show();
   $('#disc-criteria').dialog({
        autoOpen: true,
        height: screen.height - 500,
        width: screen.width - 300,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    resetCriteriaForm();
    if( _isdefined(i) ) {
        editCriteria(i);
    }
}

function resetCriteriaForm() {
    $('.inp_error').removeClass('inp_error');
    $('#hid-critria-id').val('');
    $('#coup-code').val('');
    $('#disc_value').val('');
    $('#disc_type').val(1);
    $('#date_cop').val('');

    $('#exp-weekdays').find('.btn').addClass('active');
    $('#exp-weekdays').find('input').prop('checked', true);
    
    $('#maxDiscountAmount').val('');
    $('#minFreightAmount').val('');
    
    $('#discount_branch').val(['']).multiselect('refresh');
    $('#paymentTypes').val(['']).multiselect('refresh');

    $('#cop-form-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#cop-form-action-state, #cop-form-buttons').show();
}

function editCriteria(i) {
    var dis = discount_list[i];

    $('#hid-critria-id').val(dis.code);
    $('#coup-code').val(dis.discountCoupon.code);
    $('#disc_value').val(dis.value);

    if (dis.percentageFlag == true) {
        $('#disc_type').val(1);
    } else {
        $('#disc_type').val(0);
    }
    
    $('#date_cop').val(dis.activeFrom+' | '+dis.activeTo);

    var res = dis.dayOfWeek.split("");
    $("input[name='discount-weekdays']").each(function (i) {
        if (res[i] == 0) {
            $(this).prop("checked", false);
            $(this).parent().removeClass('active');
        }
    });
    
    $('#maxDiscountAmount').val(dis.maxDiscountAmount);
    $('#minFreightAmount').val(dis.minFreightAmount);
    
    var organizations = $.map(dis.organizations || [], function (obj) {
        return obj.code;
    });
    
    if(organizations.length) {
    $('#discount_branch').val(organizations).multiselect('refresh');
    } else {
       $('#discount_branch').val(['']).multiselect('refresh'); 
    }

    var paymentTypes = $.map(dis.paymentTypes || [], function (obj) {
        return obj.code;
    });
    
    if(paymentTypes.length) {
    $('#paymentTypes').val(paymentTypes).multiselect('refresh');
    } else {
       $('#paymentTypes').val(['']).multiselect('refresh'); 
    }

    $('.nav-coupon a[href="#add_criteria"]').tab('show');
}

function saveDiscount() {
    var data = {};
    data.critriaId =  $('#hid-critria-id').val();
    data.percentageFlag = $('#disc_type').val();
    data.maxDiscountAmount = $.trim( $('#maxDiscountAmount').val() );
    data.minFreightAmount =  $.trim( $('#minFreightAmount').val() );
    data.comm_value =  $.trim( $('#disc_value').val() );
    
    var dateDisc =  $.trim( $('#date_cop').val() );
    var date = dateDisc.split('|');
    data.activeFrom = $.trim(date[0]);
    data.activeTo = $.trim(date[1]);
    
    data.dayOfWeek = $("input[name='discount-weekdays']").map(function () {
        return +$(this).is(':checked');
    }).get();

    data.paymentTypes = $.map($('#paymentTypes').val() || [], function(val) {
        return {code:val};
    });
    
    data.organizations = $.map($('#discount_branch').val() || [], function(val) {
        return {code:val};
    });

    data.coupon_code = $('#coup-code').val();

    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if ($('#coup-code').val() == '' || $('#coup-code').val() == null) {
        $('#coup-code').addClass('inp_error');
        err++;
    }
    
    if ($('#disc_value').val() == '') {
        $('#disc_value').addClass('inp_error');
        err++;
    }

    if ($('#date_cop').val() == '') {
        $('#date_cop').addClass('inp_error');
        err++;
    }
    
    if ($('#discount_branch').val() == null) {
        $('.discount_branch').addClass('inp_error');
        err++;
    }

    if ($('#maxDiscountAmount').val() == '') {
        $('#maxDiscountAmount').addClass('inp_error');
        err++;
    }

    if ($('#minFreightAmount').val() == '') {
        $('#minFreightAmount').addClass('inp_error');
        err++;
    }

    if ($('#paymentTypes').val() == null) {
        $('.paymentTypes').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#cop-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#cop-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#cop-form-action-state').show();
        return false;
    } else {
        $('#cop-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#cop-form-action-state').hide();
    }

    $('#cop-form-buttons').hide();
    $('#cop-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#cop-form-action-state').html(loading_popup);
    $('#cop-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-discount-criteria",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#cop-form-bttons').hide();
                $('#cop-form-action-state').removeClass('alert-danger');
                $('#cop-form-action-state').addClass('alert-success');
                $('#cop-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                   cancelDiscount();
                   $('#disc-coup-code').val(data.coupon_code);
                   getdiscountreport();
                }, 3000);
            } else {
                $('#cop-form-action-state').addClass('alert-danger');
                $('#cop-form-action-state').html(response.errorDesc);
                $('#cop-form-buttons').show();
            }
        }
    })
}

function cancelDiscount() {    
    $('#disc-criteria').dialog('destroy');
    $('#disc-criteria').hide();
}

$('#add-cate').click(function () {
    $('#cate').addClass('active');
    $('#disc-cate').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "config/discount-category",
        success: function (response) {
            $('#disc-cate').html(response);

        }
    })
});
$('#disc-coupon').click(function () {
    $('#disc_coupon').addClass('active');
    $('#disc-coupons').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "config/coupon",
        success: function (response) {
            $('#disc-coupons').html(response);
            html = '<option value="">Select a coupon</option>';
            $.each(coupon_list, function(key, data) {
                html += '<option value="'+data.code+'">' + data.coupon + '</option>';
            });
            
            $('#disc-coup-code, #coup-code').html(html);            
        }
    });
});
$('#view-coup').click(function () {
    alert('sd');
    $('#viw_coupons').addClass('active');
    $('#coupon-list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "config/get-discount-coupon",
        success: function (response) {
            $('#coupon-list').html(response);
        }
    })
});
function addCategory(option) {
    $('#category-dialog').css('background', '#fff');
    $('#category-dialog').removeClass('hide');
    $('#category-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 570,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#cat-form-bttons').show();
    $('#cat-form-action-state').html('');
    $('#cat-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    if (_isdefined(option)) {
        $('#code').val(option.code);
        $('#name').val(option.name);
        $('#desc').val(option.description);
    } else {
        $('#code').val('');
        $('#name').val('');
        $('#desc').val('');
    }
}

function cancelDiscountCategory() {
    $('#category-dialog').dialog('destroy');
    $('#category-dialog').hide();
}


function saveDiscountCategory() {
    var data = {};

    data.name = $('#name').val();
    data.description = $('#desc').val();
    data.code = $('#code').val();

    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }

    if ($('#desc').val() == '') {
        $('#desc').addClass('inp_error');
        err++;
    } else {
        $('#desc').removeClass('inp_error');
    }

    if (err > 0) {
        $('#cat-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#cat-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#cat-form-action-state').show();
        return false;
    } else {
        $('#cat-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#cat-form-action-state').hide();
    }

    $('#cat-form-bttons').hide();
    $('#cat-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#cat-form-action-state').html(loading_popup);
    $('#cat-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-discount-category",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#cat-form-bttons').hide();
                $('#cat-form-action-state').removeClass('alert-danger');
                $('#cat-form-action-state').addClass('alert-success');
                $('#cat-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelDiscountCategory();
                    $('#add-cate').trigger('click');
                    // checkURL();
                    return;
                }, 3000);
            } else {
                $('#cat-form-action-state').addClass('alert-error');
                $('#cat-form-action-state').html(response.errorDesc);
                $('#cat-form-bttons').show();
            }
        }
    })
}

function deleteCategory(code) {
    if (confirm('Do you want to delete this discount category ?')) {
        var data = {}
        data.code = code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-discount-category",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        $('#add-cate').trigger('click');
                        //checkURL();
                        //return;
                    }, 2000);
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

// Coupon Discount



function addCoupon(option) {
    $('#coupon-dialog').css('background', '#fff');
    $('#coupon-dialog').removeClass('hide');
    $('#coupon-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 570,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#cop-form-bttons').show();
    $('#cop-form-action-state').html('');
    $('#cop-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    if (_isdefined(option)) {
        $('#cop-code').val(option.code);
        $('#cop-name').val(option.coupon);
        $('#cop-desc').val(option.desription);
        $('#cop-category').val(option.discountCategory.code);
    } else {
        $('#cop-code').val('');
        $('#cop-name').val('');
        $('#cop-desc').val('');
        $('#cop-category').val('');
    }
}

function cancelDiscountCoupon() {
    $('#coupon-dialog').dialog('destroy');
    $('#coupon-dialog').hide();
}


function saveDiscountCoupon() {
    var data = {};

    data.name = $('#cop-name').val();
    data.description = $('#cop-desc').val();
    data.code = $('#cop-code').val();
    data.category = $('#cop-category').val();

    var err = 0;
    $('.inp_error').removeClass('inp_error');

    if ($('#cop-name').val() == '') {
        $('#cop-name').addClass('inp_error');
        err++;
    }

    if ($('#cop-desc').val() == '') {
        $('#cop-desc').addClass('inp_error');
        err++;
    }

    if ($('#cop-category').val() == '') {
        $('#cop-category').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#cops-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#cops-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#cops-form-action-state').show();
        return false;
    } else {
        $('#cops-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#cops-form-action-state').hide();
    }

    $('#cops-form-bttons').hide();
    $('#cops-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#cops-form-action-state').html(loading_popup);
    $('#cops-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-discount-coupon",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#cops-form-bttons').hide();
                $('#cops-form-action-state').removeClass('alert-danger');
                $('#cops-form-action-state').addClass('alert-success');
                $('#cops-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelDiscountCoupon();
                    $('#disc-coupon').trigger('click');
                    // checkURL();
                    // return;
                }, 3000);
            } else {
                $('#cops-form-action-state').addClass('alert-error');
                $('#cops-form-action-state').html(response.errorDesc);
                $('#cops-form-bttons').show();
            }
        }
    })
}

function deleteCoupon(code) {
    if (confirm('Do you want to delete this discount coupon ?')) {
        var data = {}
        data.code = code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-discount-coupon",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        //checkURL();
                        //return;
                        $('#disc-coupon').trigger('click');
                    }, 2000);
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

function getdiscountreport() {
    $('#disc-coupon-rpt-list').html('');
    var data = {};
    data.coupon_code = $('#disc-coup-code').val();
    var err = 0;
    if ($('#disc-coup-code').val() == '' || $('#disc-coup-code').val() == null) {
        $('#disc-coup-code').addClass('inp_error');
        err++;
    } else {
        $('#disc-coup-code').removeClass('inp_error');
    }


    if (err > 0) {
        $('#coup-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#coup-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#coup-form-action-state').show();
        return false;
    } else {
        $('#coup-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#coup-form-action-state').html('');
        $('#coup-form-action-state').hide();
    }

    var html = "";
    $('#disc-coup-code').removeClass('inp_error');
    $('#disc-coupon-rpt-list-container').removeClass('hidden');
    $('#disc-coupon-rpt-list').html(loading_popup);


    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "config/get-discount-coupon-filter",
        data: data,
        success: function (response) {
            $('#disc-coupon-rpt-list').html(response);
        }
    })
}

