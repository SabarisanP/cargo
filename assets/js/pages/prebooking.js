function init_cargo_pre_booking_page_actions() {

    $('#from_phone').on('blur', function(){
        $('#from_phone').data('customerData', '');

        var data = {};
        data.mobile = $('#from_phone').val();
        if (isNull(data.mobile)) {
            return;
        }
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "prebooking/get-customer-info",
            data: data,
            success: function (response) {
               $.each(response, function(index, res){
                    $('#from_name').val(res.name);
                    $('#from_phone').data('customerData', res);
                    $('#sender_gst').val(res.gstin);
                    formatCustomerAddress(1, res.code);
               });
            }
        });
    })

    $('#to_phone').on('blur', function(){
        $('#to_phone').data('customerData', '');

        var data = {};
        data.mobile = $('#to_phone').val();
        if (isNull(data.mobile)) {
            return;
        }
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "prebooking/get-customer-info",
            data: data,
            success: function (response) {
               $.each(response, function(index, res){
                    $('#to_name').val(res.name);
                    $('#to_phone').data('customerData', res);
                    $('#receiver_gst').val(res.gstin);
                    formatCustomerAddress(2, res.code);
               });
            }
        });
    })

    masterItems = items;
    
    $('#article_row_1').find('#name').autocomplete({
        minLength: 0,
        source: masterItems,
        select: function (event, ui) {
            var $article_row = $(this).closest('tr.article_row');
            setTimeout(function () {
                select_article(ui.item, $article_row);
            });
        }
    }).focus(function () {
        $(this).autocomplete('search', '');
    });
    
    $('#article_row_1').find('#handling').closest('.input-group').tooltip({ title: '', html: true });
}

var tr_id = 1;

function select_article(item, $article_row) {
    var pos = $article_row.data('index');
    $article_row.find('#code').val(item.code);
    $article_row.find('#qty').val(1);
    $article_row.find('#price').val(item.defaultRate);
    $article_row.find('#handling').val(item.defaultHandlingRate).data('min', item.defaultHandlingRate);
    $article_row.find('#unloading').val(0);
    $article_row.find('#handling-type').html('<i class="fa fa-rupee"></i>');
    $article_row.find('#article-unit').trigger('change');

    $article_row.find('#article-desc').val('')
        .autocomplete({
            minLength: 0,
            source: item.description || []
        }).on('focus', function () {
            $(this).autocomplete('search', '');
        });

    if (vendor.role.code == 'CGCUST') {
        setVendorSettings(ven_data, pos, false);
    } else {
        var vendorData = $('#prebook-vendor').select2('data');
        setVendorSettings(vendorData, pos, false);
    }
    

    calculateAmounts();
    if ($article_row.is(':last-child')) {
        addArticleRow(false);
    }
}

function addArticleRow(autofocus = true) {
    tr_id = tr_id + 1;

    var $newrow = $('#tr_clone').clone(true);
    $newrow.attr('id', 'article_row_' + tr_id).attr('data-index', tr_id);
    $newrow.addClass('article_row').removeAttr('style');
    $('#article_rows').append($newrow);

    $newrow.find('#name').autocomplete({
        minLength: 0,
        source: masterItems,
        select: function (event, ui) {
            setTimeout(function () {
                select_article(ui.item, $newrow);
            });
        }
    }).focus(function () {
        $(this).autocomplete('search', '');
    });

    $newrow.find('#handling').closest('.input-group').tooltip({ title: '', html: true });

    if (autofocus) {
        $newrow.find('#name').focus();
    }
}

function removeArticleRow(btn) {
    $(btn).closest('tr.article_row').remove();
    calculateAmounts();
}

function calculateAmounts(pos) {
    var totalPayableAmount = 0;
    var totalHandlingAmount = 0;
    var totalFreightAmount = 0;
    var $articlerow = (pos) ? $('#article_row_' + pos) : $('.article_row');

    $articlerow.each(function () {
        var $article = $(this);

        var qty = $.trim($article.find('#qty').val()) || 1;
        var price = $.trim($article.find('#price').val()) || 0;
        var handling = $.trim($article.find('#handling').val()) || 0;
        var unloading = $.trim($article.find('#unloading').val()) || 0;
        var unitValue = $article.find('#article-unit-val').val();
        var unit = $article.find('#article-unit').val();

        var uomOrQty = unitValue; // UOM value or Qty
        if (isNaN(unitValue) || unit == 'NPPKG') {
            unitValue = 1;
            uomOrQty = qty;
            $article.find('#article-unit-val').val(unitValue);
        }

        var article = $article.find('#name').data('uiAutocomplete').selectedItem;

        if ((!article || article.defaultHandlingRate == 0) && Number(price) > 0 && cargoSetting.defaultLoadigCharge > 0) {
            var defaultLoadigCharge = cargoSetting.defaultLoadigCharge || 0;
            if (cargoSetting.loadingChargePercentageFlag) {
                $article.find('#handling-type').html('%');
                if (Number(handling) == 0 || defaultLoadigCharge > Number(handling)) {
                    $article.find('#handling').val(defaultLoadigCharge).data('min', defaultLoadigCharge);
                    handling = defaultLoadigCharge;
                }
                defaultLoadigCharge = (parseFloat(price) * parseFloat(handling)) / 100;
                handling = defaultLoadigCharge;
            } else {
                $article.find('#handling-type').html('<i class="fa fa-rupee"></i>');
                if (defaultLoadigCharge > Number(handling)) {
                    $article.find('#handling').val(defaultLoadigCharge).data('min', defaultLoadigCharge);
                    handling = defaultLoadigCharge;
                }
            }
        }

        var freight = parseFloat(price) * parseFloat(uomOrQty);
        var loadingCharges = Math.ceil(parseFloat(handling));
        var unloadingCharges = Math.ceil(parseFloat(unloading));
        if (menu_permission['PB-HANDLING-PER-UOMQTY'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseInt(uomOrQty));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(uomOrQty));
        } else if (menu_permission['PB-HANDLING-PER-QTY'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseInt(qty));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(qty));
        } else if (menu_permission['PB-HANDLING-PER-UOM'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseFloat(unitValue));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseFloat(unitValue));
        }

        if (cargoSetting.loadingChargeRoundOffValue > 0) {
            loadingCharges = roundDownValue(loadingCharges, cargoSetting.loadingChargeRoundOffValue);
        }
        totalHandlingAmount += loadingCharges;

        if (!article || !article.gstExemptedFlag) {
            totalFreightAmount += freight;
        }

        if (parseInt(qty) > 0) {
            totalPayableAmount += parseFloat(freight) + parseFloat(loadingCharges) + parseFloat(unloadingCharges);
        }

        $article.find('#total').val(+Number(freight).toFixed(2));
    });

    $('#total_loading_charges').val(totalHandlingAmount);

    // calculate pickup charges
    var dpc = parseFloat($('#dp_charges').val());
    if (dpc > 0) {
        totalPayableAmount += dpc;
    }

    // calculate delivery charges
    var ddc = parseFloat($('#dd_charges').val());
    if (ddc > 0) {
        totalPayableAmount += ddc;
    }

    // net amount roundoff
    if (cargoSetting.totalFreightRoundOffValue > 0) {
        var netPayableRound = roundDownValue(totalPayableAmount, cargoSetting.totalFreightRoundOffValue);
        var roundOffValue = netPayableRound - totalPayableAmount;
        $('#total_amount_roundoff').val(roundOffValue);

        totalPayableAmount = netPayableRound;
    }
}

function get_customer_code(mobile){
    var code = '';
    var p = eval('/^'+mobile+'/i');
    $.each(customersMap || [], function(key, cust) {
        if(p.test(cust.mobileNumber)) {
            code =  cust.code;
        }
    }); 
    return code;
}

function get_customer(mobile){
    var res = {};
    var p = eval('/^'+mobile+'/i');
    $.each(customersMap || [], function(key, cust) {
        if(p.test(cust.mobileNumber)) {
            res =  cust;
        }
    }); 
    return res;
}

function savePreBooking(showpreview = 0) {
    var err = 0;
    var data = {};  

    var lrLoadType = $('[name="lr-load-type"]:checked').val();
    data.from_phone = $.trim( $('#from_phone').val() );
    data.from_name = $.trim( $('#from_name').val() );
    data.door_pickup = +$('#door-pickup').is(':checked');
    data.sender_gst = $.trim( $('#sender_gst').val() );

    var fromCustomer = $('#from_phone').data('customerData');
    if (isNotNull(fromCustomer)) {
        data.from_customer = fromCustomer.code;
        data.from_customer_name = fromCustomer.name;

        if (hasChanged(data.from_name, fromCustomer.name) || hasChanged(data.sender_gst, fromCustomer.gstin)) {
            data.update_from_customer = 1;
        }
    }

    if (lrLoadType == 'RGL') {
        var fromOrganization = $('#from_branch').select2('data');
        if (isNotNull(fromOrganization)) {
            data.from_branch = fromOrganization.code;
            data.from_station = fromOrganization.station && fromOrganization.station.code;
        }
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var fromStation = $('#from_branch').select2('data');
        if (isNotNull(fromStation)) {
            data.from_branch = 'NA';
            data.from_station = fromStation && fromStation.code;
            data.from_station_name = fromStation && fromStation.name;
        }
    }
    
    data.to_phone = $.trim( $('#to_phone').val() );
    data.to_name = $.trim( $('#to_name').val() );
    data.door_delivery = +$('#door-delivery').is(':checked');
    data.receiver_gst = $.trim( $('#receiver_gst').val());
    
    var toCustomer = $('#to_phone').data('customerData');
    if (isNotNull(toCustomer)) {
        data.to_customer = toCustomer.code;
        data.to_customer_name = toCustomer.name;

        if (hasChanged(data.to_name, toCustomer.name) || hasChanged(data.receiver_gst, toCustomer.gstin)) {
            data.update_to_customer = 1;
        }
    }


    if (lrLoadType == 'RGL') {
        var toOrganization = $('#to_branch').select2('data');
        if (isNotNull(toOrganization)) {
            data.to_branch = toOrganization.code;
            data.to_station = toOrganization.station && toOrganization.station.code;
        }
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var toStation = $('#to_branch').select2('data');
        if (isNotNull(toStation)) {
            data.to_branch = 'NA';
            data.to_station = toStation && toStation.code;
            data.to_station_name = toStation && toStation.name;
        }
    }
        
    data.pay_mode = 'INP';  
    
    data.dp_charges = $.trim( $('#dp_charges').val() );
    data.dd_charges = $.trim( $('#dd_charges').val() );
    
    data.handover_at = $.trim( $('#handover_at').val() );
    data.inv_number = $.trim( $('#inv_numbers').val() );
    data.inv_amount = $.trim( $('#inv_amount').val() );
    data.inv_date = $.trim( $('#inv_date').val() );

    if (vendor.role.code == 'CGCUST') {
        data.vendor_usercode = ven_data.code;
        data.vendor_username = ven_data.companyName;
    } else {
        var vendor_user = $('#prebook-vendor').select2('data');
        if (isNotNull(vendor_user)) { 
            data.vendor_usercode = vendor_user.code;
            data.vendor_username = vendor_user.companyName;
        }
    }
    
    data.remarks = $('#booking-remarks').val().trim();
    
    data.cargoAddonsDetails = [];
    
    if((cargoSetting.showCustomerAddressFlag || $('#door-pickup').is(':checked')) && $('.pick1:checked').data('code') != 'other'){
        data.from_cus_addr_code = $('.pick1:checked').data('code');
    }else if ($('.pick1:checked').data('code') == 'other'){
       data.fr_address = $('#fr_address').val();
       data.fr_landmark = $('#fr_landmark').val();
       data.fr_pincode =  $('#fr_pincode').val();
       data.fr_station=  $('#fr_addr_station').val();
    }
    
    if($('.pick1:checked').data('code') != 'other' &&  $('.pick1:checked').data('code')){
        data.pick_addr_selected = '1';
    }
    
    if($('.pick2:checked').data('code') != 'other' &&  $('.pick2:checked').data('code')){
        data.dlvry_addr_selected = '1';
    }
    
    if((cargoSetting.showCustomerAddressFlag ||$('#door-delivery').is(':checked')) && $('.pick2:checked').data('code') != 'other'){
        data.to_cus_addr_code = $('.pick2:checked').data('code');
    }else if ($('.pick2:checked').data('code') == 'other'){
       data.to_address = $('#to_address').val();
       data.to_landmark = $('#to_landmark').val();
       data.to_pincode =  $('#to_pincode').val();
       data.to_station=  $('#to_addr_station').val();
    }
    
    if(data.to_address && cargoSetting.showCustomerAddressFlag){ //address entered or modified when address flag is enable
        data.dlvry_cus_address = '1';
    }
    
    if(data.fr_address && cargoSetting.showCustomerAddressFlag){ //address entered or modified when address flag is enable
        data.pickup_cus_address = '1';
    }
    
    var ewbill = $.trim($('#eway_bill').val());
    if(ewbill != '') {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'EWBL' },
            value: ewbill
        });
    }

    var fromOrgData = $('#from_branch').select2('data') || {};
    
    var articles = [];
    var totalHandlingAmount = 0;
    var totalUnloadHandlingAmount = 0;
    var totalAmount = 0;
    $('.article_row').each(function() { 
        
        if( Number( $(this).find('#qty').val() ) >0 ) {
            var article = {};
            article.activeFlag = 1;
            article.cargoItem = {};
            article.cargoItem.code = $(this).find('#code').val() || '';
            article.cargoItem.name = $(this).find('#name').val();
            article.fare = $.trim( $(this).find('#price').val()) || 0;
            article.itemCount =  $.trim( $(this).find('#qty').val()) | 0;
            article.loadingChargeAmount =  $.trim( $(this).find('#handling').val()) || 0;
            article.unloadingChargeAmount =  $.trim( $(this).find('#unloading').val()) || 0;
            article.unit = {};
            article.unit.code = $(this).find('#article-unit').val();
            article.unitValue = $(this).find('#article-unit-val').val();  
            article.actualUnitValue = $(this).find('#actual-weight').val();

            var description = $(this).find('#article-desc').val();
            if (article.unit.code == 'VOL') {
                description += ' ' + $(this).find('#article-unit-volumetric').val();
            }
            article.cargoItem.description = [ description ];

            var articleData = $(this).find('#name').data('uiAutocomplete').selectedItem;

            if (fromOrgData.deviationPercentage > 0 && article.cargoItem.code == '') {
                $('#booking-action-state').html('Adding new Article not allowed for the selected From Branch');
                $(this).find('#article-name').focus();
                err++;
                return false;
            }

            if (!$.trim($(this).find('#name').val())) {
                $('#booking-action-state').html('Please enter valid article');
                $(this).find('#name').focus();
                err++;
                return false;
            }
            if (!$.trim($(this).find('#article-desc').val())) {
                $('#booking-action-state').html('Please enter valid description');
                $(this).find('#article-desc').focus();
                err++;
                return false;
            }

            let uomOrQty = article.unitValue; // UOM value or Qty
            if (isNaN(article.unitValue) || article.unit.code == 'NPPKG') {
                article.unitValue = 1;
                uomOrQty = article.itemCount;
            }

            let freight = parseFloat(article.fare) * parseFloat(uomOrQty);

            if ((!articleData || articleData.defaultHandlingRate == 0) && Number(article.fare) > 0 && cargoSetting.defaultLoadigCharge > 0) {
                var defaultLoadigCharge = cargoSetting.defaultLoadigCharge || 0;
                if (cargoSetting.loadingChargePercentageFlag) {
                    if (Number(article.loadingChargeAmount) == 0 || defaultLoadigCharge > Number(article.loadingChargeAmount)) {
                        article.loadingChargeAmount = defaultLoadigCharge;
                    }
                    defaultLoadigCharge = (parseFloat(article.fare) * parseFloat(article.loadingChargeAmount)) / 100;
                    article.loadingChargeAmount = defaultLoadigCharge;
                } else {
                    if (defaultLoadigCharge > Number(article.loadingChargeAmount)) {
                        article.loadingChargeAmount = defaultLoadigCharge;
                    }
                }
            }

            if (Math.ceil(article.loadingChargeAmount) > freight) {
                $('#booking-action-state').html('L. Charges must be less than freight amount');
                $(this).find('#handling').focus();
                err++;
                return false;
            }

            if (menu_permission['PB-HANDLING-PER-UOMQTY'] == 1) {
                article.loadingChargeAmount = Math.ceil(parseFloat(article.loadingChargeAmount) * parseFloat(uomOrQty));
                article.unloadingChargeAmount = Math.ceil(parseFloat(article.unloadingChargeAmount) * parseFloat(uomOrQty));
            } else if (menu_permission['PB-HANDLING-PER-QTY'] == 1) {
                article.loadingChargeAmount = Math.ceil(parseFloat(article.loadingChargeAmount) * parseInt(article.itemCount));
                article.unloadingChargeAmount = Math.ceil(parseFloat(article.unloadingChargeAmount) * parseInt(article.itemCount));
            } else if (menu_permission['PB-HANDLING-PER-UOM'] == 1) {
                article.loadingChargeAmount = Math.ceil(parseFloat(article.loadingChargeAmount) * parseFloat(article.unitValue));
                article.unloadingChargeAmount = Math.ceil(parseFloat(article.unloadingChargeAmount) * parseFloat(article.unitValue));
            }
                
            // if (cargoSetting.loadingChargeRoundOffValue > 0) {
            //     article.loadingChargeAmount = roundDownValue(article.loadingChargeAmount, cargoSetting.loadingChargeRoundOffValue);
            // }

            totalHandlingAmount += parseFloat(article.loadingChargeAmount);
            totalUnloadHandlingAmount += parseFloat(article.unloadingChargeAmount);
            totalAmount += parseFloat(article.fare);
            article.loadingChargeAmount = Math.ceil(article.loadingChargeAmount);
            articles.push(article);
        }
    });
    data.cargo_items = articles;
    data.totalHandlingAmount = totalHandlingAmount;
    data.totalUnloadHandlingAmount = totalUnloadHandlingAmount;
    data.totalAmount = totalAmount;
    
    data.additionalAttribute = {};
    data.additionalAttribute.LOAD_TYPE = lrLoadType;
    data.lrLoadType = lrLoadType;

    $('#booking-action-state').show();
    
    if (err) {
        return;
    }
    
    if(!$('#from_branch').val()) {
        if($('#door-pickup').prop('checked') == true || $('#door-delivery').prop('checked') == true){
            $('#booking-action-state').html('Please select from station');
        }else{
            $('#booking-action-state').html('Please select from branch');
        }
        return;
    } else if(!$('#to_branch').val()) {
        if($('#door-pickup').prop('checked') == true || $('#door-delivery').prop('checked') == true){
            $('#booking-action-state').html('Please select to station');
        }else{
            $('#booking-action-state').html('Please select to branch');
        }
        return;
    } else if ($('#prebook-vendor').val() == "") {
        $('#booking-action-state').html('Please select a vendor');
        $('#prebook-vendor').focus();
        return;
    } else if ($('#handover_at').val() == '') {
        $('#booking-action-state').html('Please Enter a Valid Handover Date');
        $('#handover_at').focus();
        return;
    }else if(data.from_phone=="") {
        $('#booking-action-state').html('Please enter sender mobile');
        $('#from_phone').focus();
        return;
    } else if(!isValidPhonenumber(data.from_phone)) {
        $('#booking-action-state').html('Please enter valid sender mobile');
        $('#from_phone').focus();
        return;        
    }else if(data.from_name=="") {
        $('#booking-action-state').html('Please enter sender name');
        $('#from_name').focus();
        return;        
    } else if(data.to_phone=="") {
        $('#booking-action-state').html('Please enter recipient mobile');
        $('#to_phone').focus();
        return;
    } else if(!isValidPhonenumber(data.to_phone)) {
        $('#booking-action-state').html('Please enter valid recipient mobile');
        $('#to_phone').focus();
        return;        
    } else if(data.to_name=="") {
        $('#booking-action-state').html('Please enter recipient name');
        $('#to_name').focus();
        return;        
    } else if(data.cargo_items.length<=0) {
        $('#booking-action-state').html('Please add atleast one article');
        return;
    }
    
    if(!$('.from-address-components').hasClass('hide')){
        if ($('#fr_address').val() == '') {
            $('#booking-action-state').html('Please select Pickup Address');
            $('#fr_address').focus();
            return;
        }
        if ($('#fr_addr_station').val() == '') {
            $('#booking-action-state').html('Please select Pickup Address City');
            $('#fr_addr_station').focus();
            return;
        }
        if ($('#fr_landmark').val() == '') {
            $('#booking-action-state').html('Please select Pickup Address Landmark');
            $('#fr_landmark').focus();
            return;
        }
        if ($('#fr_pincode').val() == '') {
            $('#booking-action-state').html('Please select Pickup Address pincode');
            $('#fr_pincode').focus();
            return;
        }
    }
    
    if(!$('.to-address-components').hasClass('hide')){
        if ($('#to_address').val() == '') {
            $('#booking-action-state').html('Please select Delivery Address');
            $('#to_address').focus();
            return;
        }
        if ($('#to_addr_station').val() == '') {
            $('#booking-action-state').html('Please select Delivery Address City');
            $('#to_addr_station').focus();
            return;
        }
        if ($('#to_landmark').val() == '') {
            $('#booking-action-state').html('Please select Delivery Address Landmark');
            $('#to_landmark').focus();
            return;
        }
        if ($('#to_pincode').val() == '') {
            $('#booking-action-state').html('Please select Delivery Address pincode');
            $('#to_pincode').focus();
            return;
        }
    }
    if(cargoSetting.mandateInvoiceAmountFlag || data.inv_number !="") {
        if(data.inv_number=="") {
            $('#booking-action-state').html('Please enter invoice number');
            $('#inv_numbers').focus();
            return;        
        } else if(data.inv_amount=="") {
            $('#booking-action-state').html('Please enter invoice amount');
            $('#inv_amount').focus();
            return;        
        } else if( isNaN(data.inv_amount)) {
            $('#booking-action-state').html('Please enter valid invoice amount');
            $('#inv_amount').focus();
            return;        
        } else if(data.inv_date=="") {
            $('#booking-action-state').html('Please enter invoice date');
            $('#inv_date').focus();
            return;        
        }
    }

    if(data.sender_gst != '' && !isValidGstNumber(data.sender_gst)) {
        $('#booking-action-state').html('Please enter a valid GSTIN');
        $('#sender_gst').focus();
        return;        
    } 
    if(data.receiver_gst != '' && !isValidGstNumber(data.receiver_gst)) {
        $('#booking-action-state').html('Please enter a valid GSTIN');
        $('#receiver_gst').focus();
        return;        
    }

    if (showpreview == 1) {
        $('#booking-action-state').hide();
        show_booking_preview(data);
        return;
    }

    $('#booking-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#booking-action-state').html(loading_popup);
    $('#booking-action-state').show();

    $('#confirm-booking-btn').attr('disabled', true);
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "prebooking/save-pre-booking",
        data: data,
        success: function (response) {
            $('#confirm-booking-btn').attr('disabled', false);
            if (response.status == 1) {
                $('#booking-action-state').removeClass('alert-danger');
                $('#booking-action-state').addClass('alert-success');
                $('#booking-action-state').html('Your request has been completed successfully');
                getPreBookingDetails(response.data.code, {
                    params: {onBooked: 1}
                });

                if ($('#remember-booking').is(':checked')) {
                    toggleToBranch();
                    $('#to_phone, #to_name').val('');
                    setTimeout(function () {
                        $('#booking-action-state').hide();
                    }, 1000);
                } else {
                    setTimeout(checkURL, 3000);
                }
            } else {
                $('#booking-action-state').addClass('alert-danger');
                $('#booking-action-state').html(response.errorDesc || 'Unknown Exception');
                $('#booking-form-bttons').show();
            }
        }
    })
}

function show_booking_preview(data) {
    if(!data) return;
    
    if(!$('#dia-cargo-preview').length) {
        $('<div id="dia-cargo-preview" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-cargo-preview').removeClass('hide');
    $('#dia-cargo-preview').dialog({
        autoOpen: true,
        height: 650,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-cargo-preview').html(loading_small);  

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "prebooking/cargo-pre-booking-preview",
        data: data,
        success: function (res) {
           $('#dia-cargo-preview').html(res);
        }
    })
}

function closeCargoPreviewDialog() {
    $('#dia-cargo-preview').dialog('destroy');
    $('#dia-cargo-preview').hide();
    $('#dia-cargo-preview').html('');
}

//  From booking page
function formatCustomerAddress(type, code) {
    var pkpflag = type == 1 && $('#door-pickup').is(':checked');
    var drpflag = type == 2 && $('#door-delivery').is(':checked');
    if(cargoSetting.showCustomerAddressFlag && (pkpflag || drpflag)){
        var data = {};
        data.usrCode = code;
        address = $.getJSON( base_url + "prebooking/get-customer-address", data, function( res ) {
            setAddress(type ,res)
        });
    }
}

function setAddress(type, res = []) {
    var html = '';
    $('.row-address-dropdown-' + type).removeClass('hide');

    $.each(res || [], function (key, value) {
        var address = _.filter([value.address1, value.address2, value.landmark, value.station.name, value.pincode]);

        html += '<li><label>';
        html += '<input type="radio" name="addr-rb-' + type + '" class="pick' + type + '" data-code="' + value.code + '">';
        html += '<span>&nbsp;';
        html += address.join(', ');
        html += '</span>';
        html += '</label></li>';
    });
    html += '<li><label>';
    html += '<input type="radio" name="addr-rb-' + type + '" class="pick' + type + '" data-code ="other"> Other';
    html += '</label></li>';

    $('.address-dropdown-' + type).html(html);

    $('.pick' + type).on('change', function () {
        openAddressComponents(type);
        setTimeout(function() {
            $('.address-dropdown-' + type).siblings('[data-toggle="dropdown"]').dropdown('toggle').focus();
        }, 1000);
    });

    if (!res.length) {
        $('.pick' + type + '[data-code ="other"]').prop('checked', true);
    }
    openAddressComponents(type);
}

function openAddressComponents(code) {
    if ($('.pick' + code + ':checked').data('code') == 'other') {
        if (code == 1) {
            $('.from-address-components').removeClass('hide');

            var from = $('#from_branch').select2('data');
            $('#fr_addr_station').val(from && from.station.code);
        } else if (code == 2) {
            $('.to-address-components').removeClass('hide');

            var to = $('#to_branch').select2('data');
            $('#to_addr_station').val(to && to.station.code);
        }
    } else {
        if (code == 1) {
            $('.from-address-components').addClass('hide');
        } else if (code == 2) {
            $('.to-address-components').addClass('hide');
        }
    }
}

function setupDoorPickup() {
    $('#pickup-charge-panel').addClass('hide');
    if ($('#door-pickup').is(':checked')) {
        $('#pickup-charge-panel').removeClass('hide');
        if (cargoSetting.showCustomerAddressFlag) {
            $('.row-address-dropdown-1').removeClass('hide');
            var customer = $('#from_phone').data('customerData');
            if (customer && customer.code) {
                formatCustomerAddress(1, customer.code);
            } else {
                setAddress(1)
            }
        }
    } else {
        $('.row-address-dropdown-1').addClass('hide');
        $('.pick1').prop('checked', false);
        openAddressComponents(1);
    }
    $('#dp_charges').val(0);
}

function setupDoorDelivery() {
    $('#delivery-charge-panel').addClass('hide');
    if ($('#door-delivery').is(':checked')) {
        $('#delivery-charge-panel').removeClass('hide');
        if (cargoSetting.showCustomerAddressFlag) {
            $('.row-address-dropdown-2').removeClass('hide');
            var customer = $('#to_phone').data('customerData');
            if (customer && customer.code) {
                formatCustomerAddress(2, code);
            } else {
                setAddress(2);
            }
        }
        var minvalue = $('#dd_charges').data('minvalue');
        $('#dd_charges').val(minvalue || 0);
    } else {
        $('.row-address-dropdown-2').addClass('hide');
        $('.pick2').prop('checked', false);
        openAddressComponents(2);
        $('#dd_charges').val(0);
    }
}


function prefillBooking(data) {
    if (!data) return;

    $('#lr-prebooking-code:hidden').val(data.code);

    if($('#door-pickup').prop('checked') == true || $('#door-delivery').prop('checked') == true){
        $('#from_branch').val(data.fromStation.code).trigger('change');
    }else{
        $('#from_branch').val(data.fromOrganization.code).trigger('change');
    }

    toggleToBranch();
    $('#door-pickup').prop('checked', data.pickupType && data.pickupType.code == 'PUDO').trigger('change');

    if($('#door-pickup').prop('checked') == true || $('#door-delivery').prop('checked') == true){
        $('#to_branch').val(data.toStation.code).trigger('change');
    }else{
        $('#to_branch').val(data.toOrganization.code).trigger('change');
    }

    $('#door-delivery').prop('checked', data.deliveryType && data.deliveryType.code == 'DYDO').trigger('change');

    $('#from_phone').val(data.fromCustomer.mobileNumber);
    $('#from_name').val(data.fromCustomer.name);
    $('#to_phone').val(data.toCustomer.mobileNumber);
    $('#to_name').val(data.toCustomer.name);

    $('[name="pay_type_radio"][value="' + data.paymentType.code + '"]').prop('checked', true).trigger('change');

    resetArticles();
    $.each(data.itemDetails || [], function (i, item) {
        var $article = $('.article_row:last');

        $article.find('#code').val(item.cargoItem.code || '');
        $article.find('#name').val(item.cargoItem.name).autocomplete('close');
        $article.find('#article-desc').val(item.cargoItem.description[0]);
        $article.find('#qty').val(item.itemCount);
        addArticleRow();
    });
    $('.article_row:last').find('#name').autocomplete('close');

    $('#sender_gst').val(data.fromCustomerGST);
    $('#receiver_gst').val(data.toCustomerGST);
    $('#inv_amount').val(data.invoiceAmount);
    $('#inv_date').val(moment(data.invoiceDate).format('DD-MM-YYYY')).trigger('change');
    $('#inv_numbers').val(data.invoiceNumber);

    $.each(data.cargoAddonsDetails || [], function (i, addon) {
        if (addon.addonsType.code == 'EWBL') {
            $('#eway_bill').val(addon.value);
        }
    });

    $('#booking-remarks').val(data.remarks);
}

function hasChanged(newData = '', oldData = '') {
    if (isNull(newData)) {
        return false;
    }

    return newData.trim().toLowerCase() != oldData.trim().toLowerCase();
}
