function init_contacts() {
    // Transporter
    $('#con-usr-trns').on('click', function(){
        $('#con-usr-add-btn').removeClass('none');
        $('#con-usr-add-btn').text('Add Transporter');
        $('#con-usr-add-btn').attr('onclick', 'showAddNew()');
        $('#con-usr-title').text('Transporter');
        $('#con-usr-add').addClass('none');
        $('#add-namespace, #add-bank-details, #add-expenses, #add-other-contacts, #add-branch').addClass('none');
        $('#entity-type').val('TRANS');
        $('#tags').removeClass('none');
        $('#con-usr-tab-pannel').removeClass('none');
        $('#con-usr-trns-data #cancel-view').addClass('none');
        $('#con-usr-trns-data #con-usr-table tbody tr').removeClass('none');
        $('#con-usr-trns-data #con-usr-details').addClass('none');
        $('.name, .trd-name, .gstin, .con-name, .mob, .email, .address, .acc-hld-name, .acc-num, .acc-tpe, .bnk-name, .brn, .ifsc, .upi').text('');
        $('.contact-map').css('height', '458px');

        var data = {};
        data.entityTypeCode = 'TRANS';
        $('#con-usr-trns-data').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'contact/get-all-contacts',
            data: data,
            success: function (response) {
                $('#con-usr-trns-data').html(response);
            }
        });
    });

    // Vendor
    $('#con-usr-vendor').on('click', function(){
        $('#con-usr-add-btn').removeClass('none');
        $('#con-usr-add-btn').text('Add Vendor');
        $('#con-usr-add-btn').attr('onclick', 'showAddNew()');
        $('#entity-type').val('RAC');
        $('#con-usr-title').text('Vendor');
        $('#con-usr-add').addClass('none');
        $('#add-namespace, #add-bank-details, #add-expenses, #add-other-contacts, #add-branch').addClass('none');
        $('#tags').addClass('none');
        $('#con-usr-tab-pannel').removeClass('none');
        $('#con-usr-ven-data #cancel-view').addClass('none');
        $('#con-usr-ven-data #con-usr-table tbody tr').removeClass('none');
        $('#con-usr-ven-data #con-usr-details').addClass('none');
        $('.name, .trd-name, .gstin, .con-name, .mob, .email, .address, .acc-hld-name, .acc-num, .acc-tpe, .bnk-name, .brn, .ifsc, .upi').text('');
        $('.contact-map').css('height', '400px');

        var data = {};
        data.entityTypeCode = 'RAC';
        $('#con-usr-ven-data').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'contact/get-all-contacts',
            data: data,
            success: function (response) {
                $('#con-usr-ven-data').html(response);
            }
        });
    });

    // Branch
    $('#con-usr-branch-tab').on('click', function(){
        $('#con-usr-add-btn').addClass('none');
        $('#add-namespace, #add-bank-details, #add-expenses, #add-other-contacts, #add-branch').addClass('none');
        $('#entity-type').val('BRCH');
        $('#con-usr-title').text('Branch');
        $('#con-usr-add').addClass('none');
        $('#tags').addClass('none');
        $('#con-usr-tab-pannel').removeClass('none');

        var data = {};
        data.entityTypeCode = 'BRCH';
        $('#con-usr-brn-data').html(loading_popup);

        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'contact/get-all-contacts',
            data: data,
            success: function (response) {
                $('#con-usr-brn-data').html(response);
            }
        });
    })

    // Namespace
    $('#con-usr-bnk-det').on('click', function(){
        $('#con-usr-add-btn').removeClass('none');
        $('#con-usr-add-btn').text('Add Bank Details');
        $('#con-usr-add-btn').attr('onclick', 'addBankDetails()');
        $('#con-usr-title').text('Bank Details');
        $('#con-usr-add').addClass('none');
        $('#add-namespace, #add-bank-details, #add-expenses, #add-other-contacts, #add-branch').addClass('none');
        $('#entity-type').val('NMSP');
        $('#con-usr-tab-pannel').removeClass('none');

        var data = {};
        data.entityTypeCode = 'NMSP';
        $('#con-usr-bnk-det-data').html(loading_popup);
        
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'contact/get-all-bank-details',
            data: data,
            success: function (response) {
                $('#con-usr-bnk-det-data').html(response);
            }
        });
    })

    // Expense
    $('#con-usr-expense').on('click', function(){
        $('#con-usr-add-btn').removeClass('none');
        $('#con-usr-add-btn').text('Add Expenses');
        $('#con-usr-add-btn').attr('onclick', 'addExpense()');
        $('#con-usr-title').text('Expenses');
        $('#con-usr-add').addClass('none');
        $('#add-namespace, #add-bank-details, #add-expenses, #add-other-contacts, #add-branch').addClass('none');
        $('#entity-type').val('EXP');
        $('#con-usr-tab-pannel').removeClass('none');

        var data = {};
        data.entityTypeCode = 'EXP';
        $('#con-usr-expense-data').html(loading_popup);
        
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'contact/get-all-contacts',
            data: data,
            success: function (response) {
                $('#con-usr-expense-data').html(response);
            }
        });
    })

    // Others
    $('.con-usr-others').on('click', function(){
        var title = $(this).text();
        var entityType = $(this).data('type');
        var code = $(this).data('code');

        $('#con-usr-add-btn').removeClass('none');
        $('#con-usr-add-btn').text('Add '+title);
        $('#con-usr-add-btn').attr('onclick', 'addOtherContacts()');
        $('#con-usr-title').text(title);
        $('#con-usr-add').addClass('none');
        $('#add-namespace, #add-bank-details, #add-expenses, #add-other-contacts, #add-branch').addClass('none');
        $('#entity-type').val(code);
        $('#con-usr-tab-pannel').removeClass('none');

        var data = {};
        data.entityTypeCode = code;
        data.type = 'OTHERS';
        $('#con-usr-others-data').html(loading_popup);
        
        $.ajax({
            type: 'POST',
            dataType: 'html',
            url: base_url + 'contact/get-all-contacts',
            data: data,
            success: function (response) {
                $('#con-usr-others-data').html(response);
            }
        });
    })

    if (typeof google === 'object' && typeof google.maps === 'object') {
        initContactMap();
    } else {
        jQuery.getScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initContactMap');
    }
}

function view(get_data) {
    if($('#transporter').hasClass('active')){
        if($('#con-usr-trns-data #con-usr-details').hasClass('none')){

            $('#con-usr-trns-data #cancel-view').removeClass('none');
            $('#con-usr-trns-data #con-usr-table tbody tr').not('#con-usr-'+get_data.code+', #basic-dtl').addClass('none');
            $('#con-usr-trns-data #con-usr-table tbody #con-usr-'+get_data.code+'').css('background-color', '#eee');
            $('#con-usr-trns-data #con-usr-details').removeClass('none');
            $('.own-tpe').removeClass('none');

            $('#con-usr-trns-data .name').text(get_data.name);
            $('#con-usr-trns-data .trd-name').text(get_data.tradeName);
            $('#con-usr-trns-data .gstin').text(get_data.gstin);
            $('#con-usr-trns-data .con-name').text(get_data.contactName);
            $('#con-usr-trns-data .mob').text(get_data.mobile);
            $('#con-usr-trns-data .email').text(get_data.email);
            $('#con-usr-trns-data .address').text(get_data.contactAddress.address);

            var tags = '';
            $.each(get_data.tag, function(key, val){
                tags += val.name;
            })
            $('#con-usr-trns-data .own').text(tags);
            
            var data = {};
            data.entityType = get_data.contactCategory.code;
            data.referenceCode = get_data.code

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'contact/get-bank-details',
                data: data,
                success: function (response) {
                    if(response.status == 1){
                        var res = response.data[0];
                        $('#con-usr-trns-data .acc-hld-name').text(res.name);
                        $('#con-usr-trns-data .acc-num').text(res.accountNumber);
                        $('#con-usr-trns-data .acc-tpe').text(res.accountType.name);
                        $('#con-usr-trns-data .bnk-name').text(res.bankName);
                        $('#con-usr-trns-data .brn').text(res.branchLocation);
                        $('#con-usr-trns-data .ifsc').text(res.ifscCode);
                        $('#con-usr-trns-data .upi').text(res.upiId);
                    }
                }
            });

        }else{
            $('#con-usr-trns-data #cancel-view').addClass('none');
            $('#con-usr-trns-data #con-usr-table tbody tr').removeClass('none');
            $('#con-usr-trns-data #con-usr-details').addClass('none');
            $('#con-usr-trns-data #con-usr-table tbody #con-usr-'+get_data.code+'').css('background-color', '#fff');
            $('.name, .trd-name, .gstin, .con-name, .mob, .email, .address, .acc-hld-name, .acc-num, .acc-tpe, .bnk-name, .brn, .ifsc, .upi').text('');
        }
    }else if($('#vendor').hasClass('active')){
        if($('#con-usr-ven-data #con-usr-details').hasClass('none')){
            
            $('#con-usr-ven-data #cancel-view').removeClass('none');
            $('#con-usr-ven-data #con-usr-table tbody tr').not('#con-usr-'+get_data.code+', #basic-dtl').addClass('none');
            $('#con-usr-ven-data #con-usr-details').removeClass('none');
            $('.own-tpe').addClass('none');
            $('#con-usr-ven-data #con-usr-table #con-usr-'+get_data.code+'').css('background-color', '#eee');

            $('#con-usr-ven-data .name').text(get_data.name);
            $('#con-usr-ven-data .trd-name').text(get_data.tradeName);
            $('#con-usr-ven-data .gstin').text(get_data.gstin);
            $('#con-usr-ven-data .con-name').text(get_data.contactName);
            $('#con-usr-ven-data .mob').text(get_data.mobile);
            $('#con-usr-ven-data .email').text(get_data.email);
            $('#con-usr-ven-data .address').text(get_data.contactAddress.address);
            
            var data = {};
            data.entityType = get_data.contactCategory.code;
            data.referenceCode = get_data.code

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'contact/get-bank-details',
                data: data,
                success: function (response) {
                    if(response.status == 1){
                        var res = response.data[0];
                        $('#con-usr-ven-data .acc-hld-name').text(res.name);
                        $('#con-usr-ven-data .acc-num').text(res.accountNumber);
                        $('#con-usr-ven-data .acc-tpe').text(res.accountType.name);
                        $('#con-usr-ven-data .bnk-name').text(res.bankName);
                        $('#con-usr-ven-data .brn').text(res.branchLocation);
                        $('#con-usr-ven-data .ifsc').text(res.ifscCode);
                        $('#con-usr-ven-data .upi').text(res.upiId);
                    }
                }
            });

        }else{
            $('#con-usr-ven-data #cancel-view').addClass('none');
            $('#con-usr-ven-data #con-usr-table tbody tr').removeClass('none');
            $('#con-usr-ven-data #con-usr-details').addClass('none');
            $('#con-usr-ven-data #con-usr-table #con-usr-'+get_data.code+'').css('background-color', '#fff');
            $('.name, .trd-name, .gstin, .con-name, .mob, .email, .address, .acc-hld-name, .acc-num, .acc-tpe, .bnk-name, .brn, .ifsc, .upi').text('');
        }
    }
}

function cancelView() {
    if($('#transporter').hasClass('active')){
        $('#con-usr-trns-data #cancel-view').addClass('none');
        $('#con-usr-trns-data #con-usr-table tbody tr').removeClass('none');
        $('#con-usr-trns-data #con-usr-details').addClass('none');
        $('#con-usr-trns-data #con-usr-table tbody tr').css('background-color', '#fff');
        $('.name, .trd-name, .gstin, .con-name, .mob, .email, .address, .acc-hld-name, .acc-num, .acc-tpe, .bnk-name, .brn, .ifsc, .upi').text('');
    }else if($('#vendor').hasClass('active')){
        $('#con-usr-ven-data #cancel-view').addClass('none');
        $('#con-usr-ven-data #con-usr-table tbody tr').removeClass('none');
        $('#con-usr-ven-data #con-usr-details').addClass('none');
        $('#con-usr-ven-data #con-usr-table tbody tr').css('background-color', '#fff');
        $('.name, .trd-name, .gstin, .con-name, .mob, .email, .address, .acc-hld-name, .acc-num, .acc-tpe, .bnk-name, .brn, .ifsc, .upi').text('');
    }
}

function showAddNew(usr) {
    event && event.stopPropagation();

    $('#con-usr-tab-pannel').addClass('none');
    $('#add-branch').addClass('none');
    $('#add-namespace, #add-bank-details').addClass('none');
    $('#con-usr-add').removeClass('none');

    $('.inp_error').removeClass('inp_error');

    if (_isdefined(usr)) {
        $('#hid-con-usr-code').val(usr.code);
        $('#con-usr-name').val(usr.name);
        $('#con-usr-tradename').val(usr.tradeName);
        $('#con-usr-gstin').val(usr.gstin);
        $('#con-usr-contact').val(usr.contactName);

        $('#con-usr-mob').val(usr.mobile);
        $('#con-usr-email').val(usr.email);
        
        $('#con-usr-tags').val(usr.tag.map(i => i.code)).trigger('change');

        $('#hid-con-usr-address-code').val(usr.contactAddress.code);
        $('#con-usr-latitude').val(usr.contactAddress.latitude).trigger('change');
        $('#con-usr-longitude').val(usr.contactAddress.longitude).trigger('change');
        $('#con-usr-address').val(usr.contactAddress.address);
        $('[name="con-usr-taglist"][value="' + usr.tagList[0] + '"]').prop('checked', true).trigger('change');

        //bank details
        var data = {};
        data.entityType = usr.contactCategory.code;
        data.referenceCode = usr.code

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'contact/get-bank-details',
            data: data,
            success: function (response) {
                if(response.status == 1){
                    var res = response.data[0];
                    $('#hid-con-usr-bank-code').val(res.code);
                    $('#con-usr-acc-name').val(res.name);
                    $('#con-usr-acc-no').val(res.accountNumber);
                    $('#con-usr-ifc').val(res.ifscCode);
                    $('#con-usr-bank-name').val(res.bankName);
                    $('#con-usr-branch').val(res.branchLocation);
                    $('#con-usr-acc-type').val(res.accountType.code).trigger('change');
                    $('#con-usr-upi').val(res.upiId);
                }
            }
        });
    } else {
        $('#hid-con-usr-code').val('');
        $('#con-usr-name').val('');
        $('#con-usr-tradename').val('');
        $('#con-usr-gstin').val('');
        $('#con-usr-contact').val('');

        $('#con-usr-mob').val('');
        $('#con-usr-email').val('');

        $('#hid-con-usr-address-code').val('');
        $('#con-usr-latitude').val('').trigger('change');
        $('#con-usr-longitude').val('').trigger('change');
        $('#con-usr-address').val('');
        $('[name="con-usr-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');

        //bank details
        $('#con-usr-acc-name').val('');
        $('#con-usr-acc-no').val('');
        $('#con-usr-ifc').val('');
        $('#con-usr-bank-name').val('');
        $('#con-usr-branch').val('');
        $('#con-usr-acc-type').val('').trigger('change');
        $('#con-usr-upi').val('');
    }
}

function cancelAddNew() {
    $('#con-usr-tab-pannel').removeClass('none');
    $('#con-usr-add').addClass('none');
}

// Branch
function addBranch(code) {
    event && event.stopPropagation();

    $('#con-usr-tab-pannel').addClass('none');
    $('#con-usr-add, #add-namespace, #add-bank-details, #add-expenses').addClass('none');
    $('#add-branch').removeClass('none');

    $('.inp_error').removeClass('inp_error');
    $('#hid-branch-code, #branch-name, #branch-contact-name').val('');
    $('[name="branch-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');

    if (_isdefined(code)) {
        var data = _.find(contactData, i => i.code == code);
        $('#hid-branch-code').val(data.code);
        $('#branch-name').val(data.name);
        $('#branch-contact-name').val(data.contactName);
        $('[name="branch-taglist"][value="' + data.tagList[0] + '"]').prop('checked', true).trigger('change');
    }
}

function cancelBranchDialog() {
    $('#con-usr-tab-pannel').removeClass('none');
    $('#add-branch').addClass('none');
}

function saveBranch() {
    event && event.stopPropagation();

    var code = $('#hid-branch-code').val();
    if (!code) {
        return;
    }

    var branch = _.find(contactData, i => i.code == code);

    var data = {};
    data.activeFlag = branch.activeFlag;
    data.code = branch.code;
    data.name = branch.name;
    data.contactName = branch.contactName;
    data.tradeName = branch.tradeName;
    data.gstin = branch.gstin;
    data.tag = branch.tag;
    data.mobile = branch.mobile;
    data.email = branch.email;

    data.contactCategory = {};
    data.contactCategory.code = branch.contactCategory.code;

    data.contactAddress = {};
    data.contactAddress.code = branch.contactAddress.code;
    data.contactAddress.address = branch.contactAddress.address;
    data.contactAddress.latitude = branch.contactAddress.latitude;
    data.contactAddress.longitude = branch.contactAddress.longitude;

    data.tagList = [];
    var tagList = $('input[name=branch-taglist]:checked').val();
    if (isNotNull(tagList)) {
        data.tagList.push(tagList)
    }
    
    var loading_overlay = iosOverlay({
        text: 'Loading',
        icon: 'fa fa-spinner fa-spin'
    });

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: 'contact/update-contact-expense',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: 'fa fa-check',
                    text: 'Success!'
                });
            } else {
                loading_overlay.update({
                    icon: 'fa fa-times',
                    text: 'Sorry!'
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
                checkURL();
            }, 2000);
        }
    });
}

// Namespace
function editNamespace(code) {
    event && event.stopPropagation();

    $('#con-usr-tab-pannel').addClass('none');
    $('#con-usr-add, #add-branch, #add-namespace, #add-bank-details, #add-expenses').addClass('none');
    $('#add-namespace').removeClass('none');

    $('.inp_error').removeClass('inp_error');
    $('#hid-namespace-code, #namespace-name, #namespace-contact-name').val('');
    $('[name="namespace-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');

    if (_isdefined(code)) {
        var data = _.find(namespaceData, i => i.code == code);
        $('#hid-namespace-code').val(data.code);
        $('[name="namespace-taglist"][value="' + data.tagList[0] + '"]').prop('checked', true).trigger('change');
    }
}

function cancelNamespaceDialog() {
    $('#con-usr-tab-pannel').removeClass('none');
    $('#add-namespace').addClass('none');
}

function saveNamespace() {
    event && event.stopPropagation();

    var code = $('#hid-namespace-code').val();
    if (!code) {
        return;
    }

    var namespace = _.find(namespaceData, i => i.code == code);

    var data = {};
    data.activeFlag = namespace.activeFlag;
    data.code = namespace.code;
    data.name = namespace.name;
    data.contactName = namespace.contactName;
    data.tradeName = namespace.tradeName;
    data.gstin = namespace.gstin;
    data.tag = namespace.tag;
    data.mobile = namespace.mobile;
    data.email = namespace.email;

    data.contactCategory = {};
    data.contactCategory.code = namespace.contactCategory.code;

    data.contactAddress = {};
    data.contactAddress.code = namespace.contactAddress.code;
    data.contactAddress.address = namespace.contactAddress.address;
    data.contactAddress.latitude = namespace.contactAddress.latitude;
    data.contactAddress.longitude = namespace.contactAddress.longitude;

    data.tagList = [];
    var tagList = $('input[name=namespace-taglist]:checked').val();
    if (isNotNull(tagList)) {
        data.tagList.push(tagList)
    }
    
    var loading_overlay = iosOverlay({
        text: 'Loading',
        icon: 'fa fa-spinner fa-spin'
    });

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: 'contact/update-contact-expense',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: 'fa fa-check',
                    text: 'Success!'
                });
            } else {
                loading_overlay.update({
                    icon: 'fa fa-times',
                    text: 'Sorry!'
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
                checkURL();
            }, 2000);
        }
    });
}

function addBankDetails(bnk){
    event && event.stopPropagation();

    $('#con-usr-tab-pannel').addClass('none');
    $('#con-usr-add, #add-branch, #add-namespace').addClass('none');
    $('#add-bank-details').removeClass('none');

    $('.inp_error').removeClass('inp_error');

    if (_isdefined(bnk)) {
        
        $('#hid-bank-detail-code').val(bnk.code);
        $('#add-bnk-acc-name').val(bnk.name);
        $('#add-bnk-acc-no').val(bnk.accountNumber);
        $('#add-bnk-ifc').val(bnk.ifscCode);
        $('#add-bnk-bank-name').val(bnk.bankName);
        $('#add-bnk-branch').val(bnk.branchLocation);
        $('#add-bnk-acc-type').val(bnk.accountType.code);
        $('#add-bnk-upi').val(bnk.upiId);
    } else {
        $('#hid-bank-detail-code').val('');
        $('#add-bnk-acc-name').val('');
        $('#add-bnk-acc-no').val('');
        $('#add-bnk-ifc').val('');
        $('#add-bnk-bank-name').val('');
        $('#add-bnk-branch').val('');
        $('#add-bnk-acc-type').val('').trigger('change');
        $('#add-bnk-upiadd-bnk-upi').val('');
    }
}

function cancelAddBankDetail() {
    $('#con-usr-tab-pannel').removeClass('none');
    $('#add-bank-details').addClass('none');
}

// Expense
function addExpense(code) {
    event && event.stopPropagation();

    $('#con-usr-tab-pannel').addClass('none');
    $('#con-usr-add, #add-branch, #add-namespace, #add-bank-details').addClass('none');
    $('#add-expenses').removeClass('none');

    $('.inp_error').removeClass('inp_error');
    $('#hid-expense-code, #expense-name, #expense-contact-name').val('');
    $('[name="expense-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');

    if (_isdefined(code)) {
        var data = _.find(contactData, i => i.code == code);
        $('#hid-expense-code').val(data.code);
        $('#expense-name').val(data.name);
        $('#expense-contact-name').val(data.contactName);
        $('[name="expense-taglist"][value="' + data.tagList[0] + '"]').prop('checked', true).trigger('change');
    }
}

function cancelExpenseDialog() {
    $('#con-usr-tab-pannel').removeClass('none');
    $('#add-expenses').addClass('none');
}

function initContactMap() {
    var location = new google.maps.LatLng(13.0827, 80.2707);

    var map = new google.maps.Map(document.getElementById('map_canvas'), {
        zoom: 12,
        center: location,
        streetViewControl: false,
        gestureHandling: 'greedy',
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    var marker = new google.maps.Marker({
        position: location,
        map: map,
        draggable: true
    });

    var getLatLng = function (e) {
        if ($('#con-usr-latitude').val().trim() && $('#con-usr-longitude').val().trim()) {
            location = new google.maps.LatLng($('#con-usr-latitude').val(), $('#con-usr-longitude').val());
            map.setZoom(18);
        } else {
            location = new google.maps.LatLng(13.0827, 80.2707);
            map.setZoom(12);
        }
        marker.setPosition(location);
        map.panTo(location);
    };

    var setLatLng = function (e) {
        $('#con-usr-latitude').val(e.latLng.lat());
        $('#con-usr-longitude').val(e.latLng.lng());
    };

    google.maps.event.addListener(marker, 'dragend', setLatLng);

    google.maps.event.addListener(map, 'click', function (e) {
        marker.setPosition(e.latLng);
        map.setZoom(18);
        map.panTo(e.latLng);
        setLatLng(e);
    });

    $('#con-usr-latitude, #con-usr-longitude').on('change', getLatLng);
}

function saveContacts() {
    var data = {}, err = 0;

    data.activeFlag = 1;
    data.code = $.trim($('#hid-con-usr-code').val());
    data.name = $.trim($('#con-usr-name').val());
    data.tradeName = $.trim($('#con-usr-tradename').val());
    data.gstin = $.trim($('#con-usr-gstin').val());
    data.referenceCode = 'NA';
    data.contactName = $.trim($('#con-usr-contact').val());

    data.entityType = {};
    data.entityType.code = $('#entity-type').val();

    if($('#entity-type').val() == 'TRANS'){
        data.tag = [];
        var tags = {};
        tags.code = $('#con-usr-tags').val()
        data.tag.push(tags);
    }

    data.tagList = [];
    var tagList = $('input[name=con-usr-taglist]:checked').val();
    if (isNotNull(tagList)) {
        data.tagList.push(tagList)
    }

    data.mobile = $.trim($('#con-usr-mob').val());
    data.email = $.trim($('#con-usr-email').val());

    data.contactAddress = {};
    data.contactAddress.code = $('#hid-con-usr-address-code').val();
    data.contactAddress.latitude = $.trim($('#con-usr-latitude').val());
    data.contactAddress.longitude = $.trim($('#con-usr-longitude').val());
    data.contactAddress.address = $.trim($('#con-usr-address').val());
    data.contactAddress.activeFlag = 1;

    //bank details
    data.bank_code = $.trim($('#hid-con-usr-bank-code').val());
    data.bank_name = $.trim($('#con-usr-acc-name').val());
    data.accountNumber = $.trim($('#con-usr-acc-no').val());

    data.accountType = {};
    data.accountType.code = $('#con-usr-acc-type').val();

    data.bank_entityType = {};
    data.bank_entityType.code = $('#entity-type').val();

    data.bankName = $.trim($('#con-usr-bank-name').val());
    data.branchLocation = $.trim($('#con-usr-branch').val());
    data.ifscCode = $.trim($('#con-usr-ifc').val());
    data.upiId = $.trim($('#con-usr-upi').val());
    data.bank_activeFlag = 1;

    $('.inp_error').removeClass('inp_error');

    if (data.name == '') {
        $('#con-usr-name').addClass('inp_error');
        err++;
    }
    if (data.mobile.length != 10 || isNaN(data.mobile)) {
        $('#con-usr-mob').addClass('inp_error');
        err++;
    }
    if (data.tradeName == '') {
        $('#con-usr-tradename').addClass('inp_error');
        err++;
    }
    if (data.gstin == '') {
        $('#con-usr-gstin').addClass('inp_error');
        err++;
    }
    if (data.contactName == '') {
        $('#con-usr-contact').addClass('inp_error');
        err++;
    }
    if (data.email == '') {
        $('#con-usr-email').addClass('inp_error');
        err++;
    }
    if (data.address == '') {
        $('#con-usr-address').addClass('inp_error');
        err++;
    }
    
    //bank details

    if (data.bank_name == '') {
        $('#con-usr-acc-name').addClass('inp_error');
        err++;
    }
    if (data.accountNumber == '') {
        $('#con-usr-acc-no').addClass('inp_error');
        err++;
    }
    if ($('#con-usr-acc-type').val() == '') {
        $('#con-usr-acc-type').addClass('inp_error');
        err++;
    }
    if (data.bankName == '') {
        $('#con-usr-bank-name').addClass('inp_error');
        err++;
    }
    if (data.branchLocation == '') {
        $('#con-usr-branch').addClass('inp_error');
        err++;
    }
    if (data.ifscCode == '') {
        $('#con-usr-ifc').addClass('inp_error');
        err++;
    }
    if (data.upiId == '') {
        $('#con-usr-upi').addClass('inp_error');
        err++;
    }
    if (err > 0) {
        $('#con-usr-state').removeClass('alert-success').addClass('alert-danger');
        $('#con-usr-state').html('Please enter/select the values in the field that are marked in red');
        $('#con-usr-state').show();
        return false;
    } else {
        $('#con-usr-state').removeClass('alert-success').removeClass('alert-danger');
        $('#con-usr-state').hide();
    }

    $('#con-usr-state').removeClass('alert-danger').removeClass('alert-success');
    $('#con-usr-state').html(loading_popup);
    $('#con-usr-state').show();

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'contact/update-contact-users',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#con-usr-state').removeClass('alert-danger');
                $('#con-usr-state').addClass('alert-success');
                $('#con-usr-state').html('Your request has been completed successfully');
                setTimeout(function () {
                    checkURL();
                }, 3000);
            } else {
                $('#con-usr-state').addClass('alert-danger');
                $('#con-usr-state').html(response.errorDesc);
            }
        }
    });
}

function deleteContact(code, flag = 2) {
    event && event.stopPropagation();

    var data = code;
    data.activeFlag = flag;

    if (flag == 2 && !confirm('Do you want to delete this entry?')) {
        return;
    }

    var loading_overlay = iosOverlay({
        text: 'Loading',
        icon: 'fa fa-spinner fa-spin'
    });

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: 'contact/update-contact-users',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: 'fa fa-check',
                    text: 'Success!'
                });
            } else {
                loading_overlay.update({
                    icon: 'fa fa-times',
                    text: 'Sorry!'
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
                checkURL();
            }, 2000);
        }
    });
}

function saveBankDetails() {
    var data = {}, err = 0;

    data.activeFlag = 1;
    data.code = $.trim($('#hid-bank-detail-code').val());
    data.name = $.trim($('#add-bnk-acc-name').val());
    data.accountNumber = $.trim($('#add-bnk-acc-no').val());

    data.accountType = {};
    data.accountType.code = $('#add-bnk-acc-type').val();

    data.entityType = {};
    data.entityType.code ='NMSP';

    data.bankName = $.trim($('#add-bnk-bank-name').val());
    data.branchLocation = $.trim($('#add-bnk-branch').val());
    data.ifscCode = $.trim($('#add-bnk-ifc').val());
    data.upiId = $.trim($('#add-bnk-upi').val());

    $('.inp_error').removeClass('inp_error');
    //bank details

    if (data.name == '') {
        $('#add-bnk-acc-name').addClass('inp_error');
        err++;
    }
    if (data.accountNumber == '') {
        $('#add-bnk-acc-no').addClass('inp_error');
        err++;
    }
    if ($('#add-bnk-acc-type').val() == '') {
        $('#add-bnk-acc-type').addClass('inp_error');
        err++;
    }
    if (data.bankName == '') {
        $('#add-bnk-bank-name').addClass('inp_error');
        err++;
    }
    if (data.branchLocation == '') {
        $('#add-bnk-branch').addClass('inp_error');
        err++;
    }
    if (data.ifscCode == '') {
        $('#add-bnk-ifc').addClass('inp_error');
        err++;
    }
    if (data.upiId == '') {
        $('#add-bnk-upi').addClass('inp_error');
        err++;
    }
    if (err > 0) {
        $('#add-bank-detail-state').removeClass('alert-success').addClass('alert-danger');
        $('#add-bank-detail-state').html('Please enter/select the values in the field that are marked in red');
        $('#add-bank-detail-state').show();
        return false;
    } else {
        $('#add-bank-detail-state').removeClass('alert-success').removeClass('alert-danger');
        $('#add-bank-detail-state').hide();
    }

    $('#add-bank-detail-state').removeClass('alert-danger').removeClass('alert-success');
    $('#add-bank-detail-state').html(loading_popup);
    $('#add-bank-detail-state').show();

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'contact/update-bank-details',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#add-bank-detail-state').removeClass('alert-danger');
                $('#add-bank-detail-state').addClass('alert-success');
                $('#add-bank-detail-state').html('Your request has been completed successfully');
                setTimeout(function () {
                    checkURL();
                }, 3000);
            } else {
                $('#add-bank-detail-state').addClass('alert-danger');
                $('#add-bank-detail-state').html(response.errorDesc);
            }
        }
    });
}

function deleteBankDetails(code, flag = 2) {
    event && event.stopPropagation();

    var data = code;
    data.activeFlag = flag;

    if (flag == 2 && !confirm('Do you want to delete this Account?')) {
        return;
    }

    var loading_overlay = iosOverlay({
        text: 'Loading',
        icon: 'fa fa-spinner fa-spin'
    });

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: 'contact/update-bank-details',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: 'fa fa-check',
                    text: 'Success!'
                });
            } else {
                loading_overlay.update({
                    icon: 'fa fa-times',
                    text: 'Sorry!'
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
                checkURL();
            }, 2000);
        }
    });
}

function saveExpense() {
    var data = {}, err = 0;

    data.activeFlag = 1;
    data.code = $.trim($('#hid-expense-code').val());
    data.name = $.trim($('#expense-name').val());
    data.contactName = $.trim($('#expense-contact-name').val());

    data.tagList = [];
    var tagList = $('input[name=expense-taglist]:checked').val();
    if (isNotNull(tagList)) {
        data.tagList.push(tagList)
    }
    
    data.contactCategory = {};
    data.contactCategory.code ='EXP';
    
    $('.inp_error').removeClass('inp_error');

    if (data.name == '') {
        $('#expense-name').addClass('inp_error');
        err++;
    }
    
    if (data.contactName == '') {
        $('#expense-contact-name').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#add-expense-state').removeClass('alert-success').addClass('alert-danger');
        $('#add-expense-state').html('Please enter/select the values in the field that are marked in red');
        $('#add-expense-state').show();
        return false;
    } else {
        $('#add-expense-state').removeClass('alert-success').removeClass('alert-danger');
        $('#add-expense-state').hide();
    }

    $('#add-expense-state').removeClass('alert-danger').removeClass('alert-success');
    $('#add-expense-state').html(loading_popup);
    $('#add-expense-state').show();

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'contact/update-contact-expense',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#add-expense-state').removeClass('alert-danger');
                $('#add-expense-state').addClass('alert-success');
                $('#add-expense-state').html('Your request has been completed successfully');
                setTimeout(function () {
                    checkURL();
                }, 3000);
            } else {
                $('#add-expense-state').addClass('alert-danger');
                $('#add-expense-state').html(response.errorDesc);
            }
        }
    });
}

function deleteExpense(code) {
    event && event.stopPropagation();

    var data = _.find(contactData, i => i.code == code);
    data.activeFlag = 2;

    if (!confirm('Do you want to delete this entry?')) {
        return;
    }

    var loading_overlay = iosOverlay({
        text: 'Loading',
        icon: 'fa fa-spinner fa-spin'
    });

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: 'contact/update-contact-expense',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: 'fa fa-check',
                    text: 'Success!'
                });
            } else {
                loading_overlay.update({
                    icon: 'fa fa-times',
                    text: 'Sorry!'
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
                checkURL();
            }, 2000);
        }
    });
}

function addOtherContacts(code) {
    event && event.stopPropagation();

    $('#con-usr-tab-pannel').addClass('none');
    $('#con-usr-add, #add-branch, #add-namespace, #add-bank-details, #add-expenses').addClass('none');
    $('#add-other-contacts').removeClass('none');
    

    $('.inp_error').removeClass('inp_error');
    $('#hid-other-contact-code, #other-contact-name, #other-contact-contact-name').val('');
    $('[name="other-taglist"][value="CREDIT"]').prop('checked', true).trigger('change');

    if (_isdefined(code)) {
        var data = _.find(contactData, i => i.code == code);
        $('#hid-other-contact-code').val(data.code);
        $('#other-contact-name').val(data.name);
        $('#other-contact-contact-name').val(data.contactName);
        $('[name="other-taglist"][value="' + data.tagList[0] + '"]').prop('checked', true).trigger('change');
    }
}

function cancelOtherContacts() {
    $('#con-usr-tab-pannel').removeClass('none');
    $('#add-other-contacts').addClass('none');
}

function saveOtherContacts() {
    var data = {}, err = 0;

    data.activeFlag = 1;
    data.code = $.trim($('#hid-other-contact-code').val());
    data.name = $.trim($('#other-contact-name').val());
    data.contactName = $.trim($('#other-contact-contact-name').val());
    
    data.tagList = [];
    var tagList = $('input[name=other-taglist]:checked').val();
    if (isNotNull(tagList)) {
        data.tagList.push(tagList)
    }

    data.contactCategory = {};
    data.contactCategory.code = $('#entity-type').val();
    
    $('.inp_error').removeClass('inp_error');

    if (data.name == '') {
        $('#expense-name').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#add-other-contact-state').removeClass('alert-success').addClass('alert-danger');
        $('#add-other-contact-state').html('Please enter/select the values in the field that are marked in red');
        $('#add-other-contact-state').show();
        return false;
    } else {
        $('#add-other-contact-state').removeClass('alert-success').removeClass('alert-danger');
        $('#add-other-contact-state').hide();
    }

    $('#add-other-contact-state').removeClass('alert-danger').removeClass('alert-success');
    $('#add-other-contact-state').html(loading_popup);
    $('#add-other-contact-state').show();

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: base_url + 'contact/update-contact-expense',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#add-other-contact-state').removeClass('alert-danger');
                $('#add-other-contact-state').addClass('alert-success');
                $('#add-other-contact-state').html('Your request has been completed successfully');
                setTimeout(function () {
                    checkURL();
                }, 3000);
            } else {
                $('#add-other-contact-state').addClass('alert-danger');
                $('#add-other-contact-state').html(response.errorDesc);
            }
        }
    });
}

function deleteOtherContacts(code) {
    event && event.stopPropagation();

    var data = _.find(contactData, i => i.code == code);
    data.activeFlag = 2;

    if (!confirm('Do you want to delete this entry?')) {
        return;
    }

    var loading_overlay = iosOverlay({
        text: 'Loading',
        icon: 'fa fa-spinner fa-spin'
    });

    $.ajax({
        type: 'POST',
        dataType: 'json',
        url: 'contact/update-contact-expense',
        data: data,
        success: function (response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: 'fa fa-check',
                    text: 'Success!'
                });
            } else {
                loading_overlay.update({
                    icon: 'fa fa-times',
                    text: 'Sorry!'
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
                checkURL();
            }, 2000);
        }
    });
}