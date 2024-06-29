function editOrganization(option) {

    $('#pg-organization-dialog').css('background', '#fff');
    $('#pg-organization-dialog').removeClass('hide');
    $('.short-code-warning').text('');
    $('#pg-organization-dialog').dialog({
        autoOpen: true,
        height: $(window).height() - 50,
        width: $(window).width() - 250,
        height: 670,
        width: 900,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#hub_flag').prop('checked', true);

    $('#txt_oz_name,#txt_oz_lookupCode,#txt_oz_type,#txt_oz_address1,#txt_oz_address2,#txt_oz_contact, #aid_oz_code ,#aid_oz_stationCode,#station_list,#txt_oz_shortcode,#txt_oz_pincode,#txt_oz_user,#deviation_percentage').val('');
    $('#txt_oz_transit_close_time').val('');
    //$('#station_list').select2("val","");
    if (_isdefined(option)) {

        if (option.organizationType.code == 'REG') {
            $('#branchCode').addClass('hide');
            $('#txt_oz_type').val('');
        } else {
            $('#branchCode').removeClass('hide');
            $('#txt_oz_type').val(option.organizationType.code);
        }

        $('#txt_oz_name').val(option.name);
        
        $('#txt_oz_lookupCode').val(option.lookupCode).trigger('change');
        $('#sel_oz_status').val(option.activeFlag);
        $('#aid_oz_code').val(option.code);
        $('#station_list').val(option.station.code).trigger('change');

        //$('#station_list').select2("val",option.station.code);
        $('#txt_oz_address1').val(option.address1);
        $('#txt_oz_address2').val(option.address2);
        $('#txt_oz_contact').val(option.contact);
        $('#txt_oz_pincode').val(option.pincode);
        $('#txt_oz_shortcode').val(option.shortCode != 'NA' ? option.shortCode : '');
        $('#hid_oz_lat').val(option.latitude).trigger('change');
        $('#hid_oz_lng').val(option.longitude).trigger('change');
        $('#txt_oz_user').select2('destroy');
        var opt = $(primary_user_option).find('option[data-orgcode="' + option.code + '"]')
        $('#txt_oz_user').html(opt).prepend('<option value="" selected="">Select User</option>');
        $('#txt_oz_user').select2();
        $('#txt_oz_user').val(option.user.code || '').trigger('change');

        if (option.hubFlag == 'false') {
            $('#hub_flag').prop('checked', false);
        } else {
            $('#hub_flag').prop('checked', true);
        }

        $('#deviation_percentage').val(option.deviationPercentage || 0);
        if (option.tag) {
            $('#org-tags').val(option.tag.map(i => i.code)).trigger('change');
        } else {
            $('#org-tags').val('').trigger('change');
        }
        if (option.transactionMode) {
            $('#org-transactionMode').val(option.transactionMode.map(i => i.code)).trigger('change');
        } else {
            $('#org-transactionMode').val('').trigger('change');
        }
        if (option.bookingPaymentTypeList) {
            $('#org-bookpaylist').val(option.bookingPaymentTypeList.map(i => i.code)).multiselect('refresh');
        } else {
            $('#org-bookpaylist').val('').multiselect('refresh');
        }
        if (option.deliveryPaymentTypeList) {
            $('#org-delpaylist').val(option.deliveryPaymentTypeList.map(i => i.code)).multiselect('refresh');
        } else {
            $('#org-delpaylist').val('').multiselect('refresh');
        }
        const hours = Math.floor(option.transitCloseMinutes / 60);
        const minutes = (option.transitCloseMinutes % 60);
        $('#txt_oz_transit_close_time').val(padTo2Digits(hours) + ':' + padTo2Digits(minutes));
    } else {
        $('#hid_oz_lat').val('').trigger('change');
        $('#hid_oz_lng').val('').trigger('change');    
        $('#txt_oz_user').html('<option value="" selected="">Select User</option>')
            .val('').trigger('change');
        $('#deviation_percentage').val('0');
        $('#org-tags').val([]).trigger('change');
        $('#org-transactionMode').val([]).trigger('change');
        $('#org-bookpaylist').val([]).multiselect('refresh');
        $('#org-delpaylist').val([]).multiselect('refresh');
    }
    //dilg.push("#pg-organization-dialog");
}

function padTo2Digits(num) {
    return num.toString().padStart(2, '0');
}
function saveOrganization() {
    var data = {};
    data.activeFlag = $('#sel_oz_status').val();
    data.name = $('#txt_oz_name').val();

    if($("#txt_oz_type option:selected").text()=="Regular"){
        data.organizationType  = "REG";
    }else{
        data.organizationType = "CDB";
    }

    if( $("#txt_oz_type option:selected").text()=="Regular"){
        $('#txt_oz_lookupCode').val('');
        data.lookupCode = "NA";
    }else{
        data.lookupCode = $('#txt_oz_lookupCode').val();
    }

    data.code = $('#aid_oz_code').val();
    data.address1 = $('#txt_oz_address1').val();
    data.address2 = $('#txt_oz_address2').val();
    data.contact = $('#txt_oz_contact').val();
    data.branchType = $('#org-branch-type').val();

    data.stationCode = $('#station_list').val();
    data.pincode = $('#txt_oz_pincode').val().trim();
    data.latitude = $('#hid_oz_lat').val();
    data.longitude = $('#hid_oz_lng').val();
    data.shortCode = $('#txt_oz_shortcode').val().trim().toUpperCase();
    data.hubFlag = $('#hub_flag').is(':checked');
    data.user = {};
    data.user.code = $('#txt_oz_user').val();
    data.deviationPercentage = $('#deviation_percentage').val();
    data.tag = $.map($('#org-tags').val() || [], (tag) => ({ code: tag }));
    data.transactionMode = $.map($('#org-transactionMode').val() || [], (transactionMode) => ({ code: transactionMode }));
    data.bookingPaymentTypeList = $.map($('#org-bookpaylist').val() || [], (bookingPaymentTypeList) => ({ code: bookingPaymentTypeList }));
    data.deliveryPaymentTypeList = $.map($('#org-delpaylist').val() || [], (deliveryPaymentTypeList) => ({ code: deliveryPaymentTypeList }));
    // data.transactionMode = $.map($('#org-transactionMode').val() || [], (transactionMode) => ({ code: transactionMode }));
    data.transitCloseMinutes = $('#txt_oz_transit_close_time').val();
    var err = 0;
    if(! validateStation()){
        err++;
    }
    if ($('#txt_oz_name').val() == '') {
        $('#txt_oz_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_oz_name').removeClass('inp_error');
    }

  
    if (data.lookupCode =='') {
        $('#txt_oz_lookupCode').addClass('inp_error');
        err++;
    } else {
        $('#txt_oz_lookupCode').removeClass('inp_error');
    }

    if ($('#txt_oz_address1').val() == '') {
        $('#txt_oz_address1').addClass('inp_error');
        err++;
    } else {
        $('#txt_oz_address1').removeClass('inp_error');
    }
    //    if($('#txt_oz_address2').val()==''){
    //       $('#txt_oz_address2').addClass('inp_error') ;
    //       err++;
    //    }else{
    //        $('#txt_oz_address2').val().removeClass('alert-success');
    //    }
    if ($('#txt_oz_contact').val() == '') {
        $('#txt_oz_contact').addClass('inp_error');
        err++;
    } else {
        $('#txt_oz_contact').removeClass('inp_error');
    }
    
    if ($('#station_list').val() == '') {
        $('#station_list').addClass('inp_error');
        err++;
    } else {
        $('#station_list').removeClass('inp_error');
    }
    if ($('#txt_oz_name').val() == '') {
        $('#txt_oz_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_oz_name').removeClass('inp_error');
    }
 
    if (data.lookupCode == '') {
        $('#txt_oz_lookupCode').addClass('inp_error');
        err++;
    } else {
        $('#txt_oz_lookupCode').removeClass('inp_error');
    }

    if (data.deviationPercentage == '' || data.deviationPercentage < 0  || data.deviationPercentage > 100) {
        $('#deviation_percentage').addClass('inp_error');
        err++;
    } else{
        $('#deviation_percentage').removeClass('inp_error');
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

    $('#form-bttons').hide();
    $('#org-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#org-form-action-state').html(loading_popup);
    $('#org-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-organization",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                
                window.setTimeout(function() {
                    cancelOrganization();
                    var branch_data = JSON.parse($('#branch-detail').val());
                    getbranchDetail(branch_data);
                    // checkURL();
                    // return;
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
    // removeArray("#pg-organization-dialog");
}

function saveOrganizationDocuments(code){
    fileupload.startUpload({
        referenceCode: code, 
        imageCategoryCode: 'ORGN',
        onComplete: function () {
            var branch_data = JSON.parse($('#branch-detail').val());
            getbranchDetail(branch_data);
        }
    });
}

function addOrganizationDimension(code) {
    $('#org-dimension-dialog').removeClass('hide');
    $('#org-dimension-dialog').dialog({
        autoOpen: true,
        minHeight: 400,
        width: 600,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#org_dimension_code').val(code);
    $('#org-dimension-action-state').hide();
    $('.organization_bank').removeClass('inp_error')
    $('#organization_bank').multiselect('clearSelection');
    $('#organization_length, #organization_height, #organization_breadth, #organization_bank').removeClass('inp_error').val('');

    $('#organization_bank_img').html('');
    $('#ie-fileupload .file-upload-gallery .file-upload-image').each(function () {
        var checked = $(this).data('tag') == 'QR' ? 'checked' : '';
        
        $('#organization_bank_img').append('\n\
            <label class="radio-inline">\n\
                <input type="radio" name="organization_bank_img" value="' + $(this).data('slug') + '" ' + checked + '>\n\
                <img src="' + dmsdomain + '/download/' + $(this).data('slug') + '" height="40px">\n\
            </label>');
    });
    if (!$('#ie-fileupload .file-upload-gallery .file-upload-image').length) {
        $('#organization_bank_img').html('<div class="well well-sm">No Results Found!</div>');
    }
}

function editOrganizationDimension(data) {
    $('#org-dimension-dialog').removeClass('hide');
    $('#org-dimension-dialog').dialog({
        autoOpen: true,
        minHeight: 400,
        width: 600,
        modal: true,
        closeOnEscape:true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#org-dimension-action-state').hide();
    $('#org_dimension_code').val(data.organization.code);

    $('#org-dimension-action-state').removeClass('alert-success alert-danger').html('');
    $('#organization_length, #organization_height, #organization_breadth, #organization_bank').removeClass('inp_error').val('');
    $('#organization_bank').multiselect('clearSelection');

    if(data.dimensions){
        var dimension = data.dimensions.split('|');
       
        $('#organization_breadth').val(dimension[1]);
        $('#organization_length').val(dimension[0]);
        $('#organization_height').val(dimension[2]);

        var bank_details = [];
        $.each(data.bankDetails, function( key, value ) {
            bank_details.push(value.code);
        });
        $('#organization_bank').multiselect('select', (bank_details));
    }

    $('#organization_bank_img').html('');
    $('#ie-fileupload .file-upload-gallery .file-upload-image').each(function () {
        var checked = $(this).data('tag') == 'QR' ? 'checked' : '';
        
        $('#organization_bank_img').append('\n\
            <label class="radio-inline">\n\
                <input type="radio" name="organization_bank_img" value="' + $(this).data('slug') + '" ' + checked + '>\n\
                <img src="' + dmsdomain + '/download/' + $(this).data('slug') + '" height="40px">\n\
            </label>');
    });
    if (!$('#ie-fileupload .file-upload-gallery .file-upload-image').length) {
        $('#organization_bank_img').html('<div class="well well-sm">No Files Found!</div>');
    }
}

function cancelOrganizationDimension(){
    $('#org-dimension-dialog').dialog('destroy');
    $('#org-dimension-dialog').hide();
}

function saveOrganizationDimension(){
    var data = {};

    data.code = $('#org_dimension_code').val();
    data.dimensions = $('#organization_length').val() + '|' + $('#organization_breadth').val() + '|' +$('#organization_height').val();

    data.bankDetails = [];  
    $.each($('#organization_bank').val() || [], function (i, code) {
        data.bankDetails.push({ code: code });
    });

    data.imageUrlSlug = $.trim($('[name="organization_bank_img"]:checked').val());
    data.activeFlag = 1;

    var err = 0;

    if($('#organization_length').val() == ''){
        $('#organization_length').addClass('inp_error');
        err++;
    }else {
        $('#organization_length').removeClass('inp_error');
    }

    if($('#organization_breadth').val() == ''){
        $('#organization_breadth').addClass('inp_error');
        err++;
    }else {
        $('#organization_breadth').removeClass('inp_error');
    }

    if($('#organization_height').val() == ''){
        $('#organization_height').addClass('inp_error');
        err++;
    }else {
        $('#organization_height').removeClass('inp_error');
    }

    if($('#organization_bank').length){
        if(data.bankDetails.length == 0){
            $('.organization_bank').addClass('inp_error');
            err++;
        }else {
            $('.organization_bank').removeClass('inp_error');
        }
    }

    if (err > 0) {
        $('#org-dimension-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#org-dimension-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#org-dimension-action-state').show();
        return false;
    } else {
        $('#org-dimension-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#org-dimension-action-state').hide();
    }

    $('#org-dimension-panel-btn').show();
    $('#org-dimension-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#org-dimension-action-state').html(loading_popup);
    $('#org-dimension-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-org-dimension",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#org-dimension-action-state').removeClass('alert-danger');
                $('#org-dimension-action-state').addClass('alert-success');
                $('#org-dimension-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelOrganizationDimension();
                    var branch_data = JSON.parse($('#branch-detail').val());
                    getbranchDetail(branch_data);
                    // checkURL();
                    // return;
                }, 3000);
            } else {
                $('#org-dimension-action-state').addClass('alert-danger');
                $('#org-dimension-action-state').html(response.errorDesc);
                $('#org-dimension-panel-btn').show();
            }
        }
    })
}

function addPaymentPreference(option) {

    $('#branch-pay-pref-dialog').css('background', '#fff');
    $('#branch-pay-pref-dialog').removeClass('hide');
    $('.short-code-warning').text('');
    $('#branch-pay-pref-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 500,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#pay-pref-form-bttons').show();
    $('#pay-pref-action-state').html('');
    $('#pay-pref-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    var org_code = $('#addedit_sel_station_id').val()
    $('#pay-pref-to').val([]).trigger('change');
    $('#pay-pref-from').val(org_code).attr('disabled', true);

    if (_isdefined(option)) {
        $('#pay_pref_code').val(option.code);
        if(option.toOrganizationList){
            if(option.toOrganizationList.length > 0){
                $('#pay-pref-to').val(option.toOrganizationList.map(i => i.code)).trigger('change');
            }else{
                $('#pay-pref-to').val('').trigger('change');
            }
        }else{
            $('#pay-pref-to').val([]).trigger('change');
        }
    } else {
        $('#pay-pref-to').val([]).trigger('change');
    }
}

function savePaymentPreference() {
    var data = {};

    data.code = $('#pay_pref_code').val();
    data.activeFlag = 1;

    data.fromOrganization = {};

    var fromOrganization = $('#pay-pref-from').val();
    var toOrganizationList = $.map($('#pay-pref-to').val() || [], (to) => (to));

    if(jQuery.inArray(fromOrganization, toOrganizationList) >= 0) {
        alert('From organization and to organization cannot be the same !!!')
        return;
    } else {
        data.fromOrganization.code = fromOrganization;
        data.toOrganizationList = $.map($('#pay-pref-to').val() || [], (to) => ({ code: to }));
    }

    var err = 0;
    
    if (data.toOrganizationList.length == 0) {
        $('#pay-pref-to').addClass('inp_error');
        err++;
    } else {
        $('#pay-pref-to').removeClass('inp_error');
    }

    if (err > 0) {
        $('#pay-pref-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#pay-pref-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#pay-pref-action-state').show();
        return false;
    } else {
        $('#pay-pref-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#pay-pref-action-state').hide();
    }

    $('#pay-pref-form-bttons').hide();
    $('#pay-pref-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#pay-pref-action-state').html(loading_popup);
    $('#pay-pref-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-payment-preference",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#pay-pref-action-state').removeClass('alert-danger');
                $('#pay-pref-action-state').addClass('alert-success');
                $('#pay-pref-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelPaymentPreference();
                    var branch_data = JSON.parse($('#branch-detail').val());
                    getbranchDetail(branch_data);
                    // checkURL();
                    // return;
                }, 3000);
            } else {
                $('#pay-pref-action-state').addClass('alert-danger');
                $('#pay-pref-action-state').html(response.errorDesc);
                $('#pay-pref-form-bttons').show();
            }
        }
    })
}
function cancelPaymentPreference() {
    $('#branch-pay-pref-dialog').dialog('destroy');
    $('#branch-pay-pref-dialog').hide();
}

function deletePaymentPreference(val) {
    if (confirm('Do you want to delete this Payment Preference?')) {
        var data = val;
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-payment-preference",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        var branch_data = JSON.parse($('#branch-detail').val());
                        getbranchDetail(branch_data);
                        // checkURL();
                    }, 2000);
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

function deleteOrganization(or_code, or_name) {
    if (confirm('Do you want to delete this organization?')) {
        var data = {};

        data.name = or_name;
        data.code = or_code;
        //data.stationCode = option.stationCode;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-organization",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    // $('#oz-' + response.data.code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                    //     $(this).remove()
                    // });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
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
function editStatusOrganization(option, obj) {

    var data = {};
    data.code = option.code;
    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 9;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-status-organization",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#og_edt_' + option.code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
                    $('#og_edt_' + option.code).show();
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

function getbranchDetail(org) {
    $('.li_bk').removeClass('li_bk');
    $('#branch-detail').val(JSON.stringify(org));

    var data = {};
    data.org = org;
    data.organizationcode = org.code;
    $('#branch-result').html('<div align="center">' + loading_big + '</div>');
    $('#branch-result').show();
    $.ajax({
        type: "POST",
        url: base_url + "config/get-org-usr",
        data: data,
        success: function(response) {
            $('#ns-' + data.organizationcode).addClass('li_bk');
            $('#branch-result').removeClass('hide')
            $('#branch-result').html(response).show();
            $('#stat_title').html(org.name);
            $('#newStation').val(org.name);
            $('#addedit_sel_station_id').val(org.code);
            fileupload.clearFiles();
            fileupload.loadFiles({
                referenceCode: org.code, 
                imageCategoryCode: 'ORGN'
            });
        }
    })
}

function allUserOrganizations(code) {
    $('#all_usr_org').css('background', '#fff');
    $('#all_usr_org').removeClass('hide');
    $('#all_usr_org').show();
    $('#all-form-bttons').show();
    $('#all-org-state').hide();
    $('#all_usr_org').dialog({
        autoOpen: true,
        height: 400,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#id_oz_code').val(code);
    var id = $.trim($('#alr_usr_' + code).val()).replace(',', '');
    var lis = id.split(",");
    $('input[name="usr_org_all"]').each(function() {
        if (jQuery.inArray($(this).val(), lis) > -1) {
            $(this).attr('checked', 'checked');
            $(this).attr('disabled', 'disabled');
        }
    });
}
function cancelUserOrganization() {
    $('#all_usr_org').dialog('destroy');
    $('#all_usr_org').hide();
}

function userOrganizationDialog(val) {
    $('#user-organization-dialog').css('background', '#fff');
    $('#user-organization-dialog').removeClass('hide');
    $('#user-organization-dialog').show();
    $('#user-organization-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 600,
        modal: true,
        resizable: false,
        close: cancelUserOrganizationDialog
    });
    $(".ui-dialog-titlebar").hide();
}
function cancelUserOrganizationDialog(val) {
    $('#user-organization-dialog').dialog('destroy');
    $('#user-organization-dialog').hide();
}

function saveUserOrganizatio() {
    var data = {}
    data.code = $('#id_oz_code').val();
    data.usrCode = $('input[name="usr_org_all"]').serializeArray();
    //all_user_organization
    $('#all-form-bttons').hide();
    $('#all-form-loading').html(loading_popup);
    $('#all-form-loading').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/all-user-organization",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#all-org-state').removeClass('alert-danger').removeClass('hide');
                $('#all-org-state').addClass('alert-success');
                $('#all-org-state').html('Your request has been completed successfully');
                $('#all-org-state').show();
                $('#all-form-loading').html('');
                $('#all-form-loading').hide();
                window.setTimeout(function() {
                    cancelUserOrganization();
                    cancelUserOrganizationDialog();
                    checkURL();
                    $('a[href="collapse-' + data.code + '"]').trigger('click');
                    return;
                }, 3000);

            } else {
                $('#all-form-loading').html('');
                $('#all-form-loading').hide();
                $('#all-org-state').addClass('alert-danger').removeClass('hide');
                $('#all-org-state').html(response.errorDesc);
                $('#all-org-state').show();
                $('#all-form-bttons').show();
            }
        }
    })
}

function addBranchContactsDialog(data){
    $('#add-branch-contact-dialog').css('background', '#fff');
    $('#add-branch-contact-dialog').removeClass('hide');
    $('#add-branch-contact-dialog').show();
    $('#add-branch-contact-dialog').dialog({
        autoOpen: true,
        height: 650,
        width: 900,
        modal: true,
        resizable: false,
        close: cancelBranchContactsDialog
    });
    $(".ui-dialog-titlebar").hide();
    $('#brn-con-code, #brn-con-name, #brn-con-alias, #brn-con-category, #brn-con-age, #brn-con-mob, #brn-con-alt-mob, #brn-con-qual, #brn-con-other-POB, #brn-con-address, #brn-con-remarks').val('');
    $('#brn-con-POB, #brn-con-lang').val('').trigger('change');
    $('.inp_error').removeClass('inp_error');
    $('#brn_con_action_state').removeClass('alert-danger').html('').hide();
    $('#brn-con-add-btns').show();

    if(_isdefined(data)){
        $('#brn-con-code').val(data.code);
        $('#brn-con-name').val(data.name);
        $('#brn-con-alias').val(data.aliasCode);
        $('#brn-con-category').val(data.category.code);
        $('#brn-con-age').val(data.age);
        $('#brn-con-mob').val(data.mobile);
        $('#brn-con-alt-mob').val(data.alternateMobile);

        $('#brn-con-qual').val(data.qualification);

        var pob = data.placeOfBirth.split('-');
        if(pob[0] == 'OTHERS'){
            $('#brn-con-POB').val(pob[0]).trigger('change');
            $('#brn-con-other-POB').val(pob[1]);
        }else{
            $('#brn-con-POB').val(data.placeOfBirth).trigger('change');
        }

        var lang = data.languages.split(', ');
        $('#brn-con-lang').val(lang).trigger('change');

        $('#brn-con-address').val(data.address);
        $('#brn-con-remarks').val(data.remarks);
    }
}

function cancelBranchContactsDialog(val) {
    $('#add-branch-contact-dialog').dialog('destroy');
    $('#add-branch-contact-dialog').hide();
}

function saveBranchContact() {
    var brn = JSON.parse($('#branch-detail').val());

    var data = {};

    data.code = $('#brn-con-code').val();
    data.activeFlag = 1;

    data.name = $.trim($('#brn-con-name').val());
    data.aliasCode = $.trim($('#brn-con-alias').val());

    data.organization = {};
    data.organization.code = brn.code;

    data.category = {};
    data.category.code = $('#brn-con-category').val();

    data.age = $('#brn-con-age').val();
    data.mobile = $('#brn-con-mob').val();
    data.alternateMobile = $('#brn-con-alt-mob').val();
    data.qualification = $('#brn-con-qual').val();


    var lang = $('#brn-con-lang').val();
    
    if(lang){
        data.languages = lang.join(', ');
    }else{
        data.languages = '';
    }

    if($('#brn-con-POB').val() == 'OTHERS'){
        data.placeOfBirth = 'OTHERS-'+$('#brn-con-other-POB').val();
    }else{
        data.placeOfBirth = $('#brn-con-POB').val();
    }

    data.address = $.trim($('#brn-con-address').val());
    data.remarks = $.trim($('#brn-con-remarks').val());
    
    var err = 0;
    if (data.name == '') {
        $('#brn-con-name').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-name').removeClass('inp_error');
    }

    if (data.aliasCode == '') {
        $('#brn-con-alias').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-alias').removeClass('inp_error');
    }

    if ($('#brn-con-category').val() == '') {
        $('#brn-con-category').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-category').removeClass('inp_error');
    }
    if (data.age == '' || data.age < 0) {
        $('#brn-con-age').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-age').removeClass('inp_error');
    }

    if (data.mobile == '') {
        $('#brn-con-mob').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-mob').removeClass('inp_error');
    }

    if ($('#brn-con-qual').val() == '') {
        $('#brn-con-qual').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-qual').removeClass('inp_error');
    }

    if (data.languages == '') {
        $('#brn-con-lang').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-lang').removeClass('inp_error');
    }

    if($('#brn-con-POB').val() == 'OTHERS'){
        if ($('#brn-con-other-POB').val() == '') {
            $('#brn-con-other-POB').addClass('inp_error');
            err++;
        } else {
            $('#brn-con-other-POB').removeClass('inp_error');
        }
    }else{
        if ($('#brn-con-POB').val() == '') {
            $('#brn-con-POB').addClass('inp_error');
            err++;
        } else {
            $('#brn-con-POB').removeClass('inp_error');
        }
    }

    if (data.address == '') {
        $('#brn-con-address').addClass('inp_error');
        err++;
    } else {
        $('#brn-con-address').removeClass('inp_error');
    }

    if (data.mobile.length < 10) {
        $('#brn-con-mob').addClass('inp_error');
        $('#brn_con_action_state').removeClass('alert-success').addClass('alert-danger');
        $('#brn_con_action_state').html('Mobile Number Is Too Short!!');
        $('#brn_con_action_state').show();
        return false;
    } else {
        $('#brn-con-mob').removeClass('inp_error');
        $('#brn_con_action_state').removeClass('alert-success').removeClass('alert-danger').html('').hide();
    }

    if (data.alternateMobile && data.alternateMobile.length < 10) {
        $('#brn-con-alt-mob').addClass('inp_error');
        $('#brn_con_action_state').removeClass('alert-success').addClass('alert-danger');
        $('#brn_con_action_state').html('Alternate Mobile Number Is Too Short!!');
        $('#brn_con_action_state').show();
        return false;
    } else {
        $('#brn-con-alt-mob').removeClass('inp_error');
        $('#brn_con_action_state').removeClass('alert-success').removeClass('alert-danger').html('').hide();
    }

    if (err > 0) {
        $('#brn_con_action_state').removeClass('alert-success').addClass('alert-danger');
        $('#brn_con_action_state').html('Please enter/select the values in the field that are marked in red');
        $('#brn_con_action_state').show();
        return false;
    } else {
        $('#brn_con_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#brn_con_action_state').hide();
    }

    $('#brn-con-add-btns').hide();
    $('#brn_con_action_state').removeClass('alert-danger').removeClass('alert-success');
    $('#brn_con_action_state').html(loading_popup);
    $('#brn_con_action_state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-branch-contact",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#brn_con_action_state').removeClass('alert-danger');
                $('#brn_con_action_state').addClass('alert-success');
                $('#brn_con_action_state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelBranchContactsDialog();
                    getbranchDetail(brn);
                }, 3000);
            } else {
                $('#brn_con_action_state').addClass('alert-danger');
                $('#brn_con_action_state').html(response.errorDesc);
                $('#brn-con-add-btns').show();
            }
        }
    })
}

function deleteBranchContact(brn_con) {
    if (confirm('Do you want to delete this Payment Preference?')) {
        var data = brn_con;
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-branch-contact",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        var branch_data = JSON.parse($('#branch-detail').val());
                        getbranchDetail(branch_data);
                        // checkURL();
                    }, 2000);
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