function init_cargo_booking_page_actions() {
    const customerBhTokenizer = Bloodhound.tokenizers.obj.whitespace('mobileNumber', 'name', 'gstin', 'companyName');
    const CUSTOMERSBH = new Bloodhound({
        datumTokenizer: function (d) {
            let tokens = customerBhTokenizer(d), result = [];
            for (let token of tokens) {
                for (let i = 0; i < token.length; i++) {
                    result.push(token.substr(i, token.length));
                }
            }
            return result;
        },
        queryTokenizer: Bloodhound.tokenizers.ngram,
        sufficient: 8,
        indexRemote: true,
        initialize: false,
        identify: function (obj) {
            return obj.code;
        },
        prefetch: {
            url: base_url + 'cargo/suggest-station-customers',
            cacheKey: 'station_customers',
            thumbprint: ns + ':' + userStationCode + ':v6',
            transform: function (response) {
                if (response.status != 1 || !response.data || response.data.length == 0) return;
                return response.data;
            },
            prepare: function (settings) {
                settings.type = 'POST';
                settings.data = {};
                settings.data.stations = [userStationCode];

                return settings;
            }
        },
        remote: {
            url: base_url + 'cargo/suggest-station-customers',
            prepare: function (query, settings) {
                var defaultBranch = { station: { code: '' } };
                var frombranch = $('#from_branch').select2('data') || defaultBranch;
                var tobranch = $('#to_branch').select2('data') || defaultBranch;
 
                settings.type = 'POST';
                settings.data = {};
                settings.data.query = query.toUpperCase();
                settings.data.stations = [frombranch.station.code, tobranch.station.code];

                return settings;
            },
            transport: function (options, onSuccess, onError) {
                if (!options.data.stations.length || (!isValidPhonenumber(options.data.query) && !isValidGstin(options.data.query) && options.data.query.replace(/ /g, '').length > 7)) {
                    onError('Request Cancelled');
                    return;
                }

                $.ajax(options)
                    .done(function(data, textStatus, request) { onSuccess(data); })
                    .fail(function(request, textStatus, errorThrown) { onError(errorThrown); });
            },
            transform: function (response) {
                if (response.status != 1) return;
                return response.data;
            }
        },
    });

    Object.assign(CUSTOMERSBH.index, {
        serialize: function() {
            return {
                datums: btoa(JSON.stringify(this.datums)),
                trie: this.trie
            }
        },
        bootstrap: function(a) {
            this.datums = JSON.parse(atob(a.datums)),
            this.trie = a.trie
        }
    });

    CUSTOMERSBH.initialize();

    $('#from_phone, #to_phone').on('input', function(e) {
        // CUSTOMERSBH.sufficient = Math.ceil((10 - this.value.length) / 2);
        $(this).data('customerData', null);
    }).on('blur', function(e) {
        let $this = $(this);
        if ($.trim(e.target.value).length < 10 || $this.data('customerData')) {
            return;
        }

        var matches = CUSTOMERSBH.index.search($.trim(e.target.value));
        $.each(matches || [], function (i, match) {
            $this.data('customerData', match);
        });
    });
    var _deepSearched = {};

    const ttOptions = {
        highlight: true,
    };
    const ttTemplates = {
        notFound: function(data) {
            var enableDeepSearch = false;
            if (['SENDER_MOBILE', 'RECEIVER_MOBILE'].includes(data.dataset) && isValidPhonenumber(data.query)) {
                enableDeepSearch = true;
            } else if (['SENDER_NAME', 'RECEIVER_NAME'].includes(data.dataset) && data.query.length > 3 && !isValidPhonenumber(data.query) && !isValidGstNumber(data.query)) {
                enableDeepSearch = true;
            } else if (['SENDER_GST', 'RECEIVER_GST'].includes(data.dataset) && isValidGstNumber(data.query)) {
                enableDeepSearch = true;
            }

            var $tpl = $('<div class="empty-message">&ensp;No matches found.</div>');
            if (enableDeepSearch && !_deepSearched[data.query]) {
                $tpl.append('&emsp;<a href="javascript:;" class="tt-deep-search" data-query="' + data.query + '"><i class="fa fa-search"></i> Advanced Find</a>');
            }

            return $tpl;
        },
        suggestion: function(data) {
            var company = '', role = '';
            if (data.role == 'RAC') {
                role += '<span class="small pull-right"><span class="label label-success" title="Registered Account Customer">RAC</span></span>';
            } else if (data.role == 'CMPY') {
                company += '<small title="Company Name">' + data.companyName + '</small><br/>';
                role += '<span class="small pull-right"><span class="label label-success" title="Company">CMPY</span></span>';
            }

            if (cargoSetting.custom.skipCustomerMobile) {
                return `<div><b class="text-break">${data.name}</b>${role}<br/>${company}<span class="text-muted"><small>${data.gstin}</small></span></div>`;
            }

            return `<div><b class="text-break">${data.name}</b>${role}<br/>${company}<span class="text-muted"><small>${data.mobileNumber}</small><small class="pull-right">${data.gstin}</small></span></div>`;
        }
    };

    $('#from_phone').typeahead(ttOptions, {
        name: 'SENDER_MOBILE',
        displayKey: 'mobileNumber',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectFromCustomer(d);
    }).on('blur', function () {
        formatCustomerAddress(1, this.value);
    });

    $('#from_name').typeahead(ttOptions, {
        name: 'SENDER_NAME',
        displayKey: 'name',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectFromCustomer(d);
    });

    $('#sender_gst').typeahead(ttOptions, {
        name: 'SENDER_GST',
        displayKey: 'gstin',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectFromCustomer(d);
    });

    $('#sender-company-name').typeahead(ttOptions, {
        name: 'SENDER_COMPANY',
        displayKey: 'companyName',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectFromCustomer(d);
    });

    $('#to_phone').typeahead(ttOptions, {
        name: 'RECEIVER_MOBILE',
        displayKey: 'mobileNumber',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectToCustomer(d);
    }).on('blur', function () {
        formatCustomerAddress(2, this.value);
    });

    $('#to_name').typeahead(ttOptions, {
        name: 'RECEIVER_NAME',
        displayKey: 'name',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectToCustomer(d);
    });

    $('#receiver_gst').typeahead(ttOptions, {
        name: 'RECEIVER_GST',
        displayKey: 'gstin',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectToCustomer(d);
    });

    $('#receiver-company-name').typeahead(ttOptions, {
        name: 'RECEIVER_COMPANY',
        displayKey: 'companyName',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        selectToCustomer(d);
    });

    $('#from_phone, #from_name, #to_phone, #to_name, #sender_gst, #receiver_gst, #sender-company-name, #receiver-company-name').on('typeahead:asyncrequest', function () {
        $(this).addClass('tt-loading').removeClass('tt-loading', 4000);
    }).on('focus blur typeahead:asynccancel typeahead:asyncreceive', function () {
        $(this).removeClass('tt-loading');
    });

    $('.twitter-typeahead').on('click', '.tt-deep-search', function (e) {
        var $ttinput = $(e.delegateTarget).find('input.tt-input');
        var query = $.trim($(this).data('query'));
        if (query.length < 3) {
            return;
        }

        var data = {};
        if (isValidPhonenumber(query)) {
            data.mobileNumber = query;
        } else if (isValidGstNumber(query)) {
            data.gstin = query;
        } else {
            data.customerName = query;
        }

        var loading_overlay = iosOverlay({
            text: 'Finding...',
            icon: 'fa fa-spinner fa-spin'
        });
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-customers-by-reference',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    _deepSearched[query] = 1;
                    CUSTOMERSBH.add(response.data);
                    $ttinput.typeahead('val', '  ').trigger('keypress').typeahead('val', query);

                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success!'
                    });
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Sorry!'
                    });
                }
                setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    });

    var driverName = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        local: drivers || [],
    });
    driverName.initialize();

    $('.selectpicker').selectpicker();
    
    $('#bkg-driver-name').typeahead(null, {
        name: 'DriverName',
        displayKey: 'name',
        source: driverName.ttAdapter(),
        templates: {
            empty: [
                '<div class="empty-message">',
                ' unable to find',
                '</div>'
            ].join('\n'),
            suggestion: Handlebars.compile('<p>{{name}} - {{mobileNumber}}</p>')

        }
    }).on('typeahead:selected', function (e, d, n) {
        $('#bkg-driver-mobile').val(d.mobileNumber);
        $('#bkg-driver-name').typeahead('val', d.name);
    });

    masterItems = items;

    $('#article_row_1').find('#name').autocomplete({
        minLength: 0,
        source: masterItems,
        select: function (event, ui) {
            var $article_row = $(this).closest('tr.article_row');
            setTimeout(function () {
                select_article(ui.item, $article_row);
            });
        },
        change: function(event, ui) {
            var $article_row = $(this).closest('.article_row');
            if (!ui.item && !cargoSetting.allowNewArticle) {
                notice('new article is not allowed');
                $(this).val(''); 
                $(this).data('selectedIndex',"");
                $article_row.find('#article-desc').val('');
                $article_row.find('#code').val("");
                $article_row.find('.iqty').val(1);
                $article_row.find('.irate').val(0);
                $article_row.find('.iunit').val('NPPKG');
                $article_row.find('.iunitval').val(1);
                $article_row.find('.ilcharge').val(0);
                $article_row.find('.iucharge').val(0);
                $article_row.find('.itotal').val(0);

            }
        }
    }).focus(function () {
        $(this).autocomplete('search', '');
    });
    
    $('#article_row_1').find('#handling').closest('.input-group').tooltip({ title: '', html: true });

    if (cargoSetting.mandateAddressOnBookingFlag) {
        setAddress(1);
        setAddress(2);
    }

    if (cargoSetting.mandateInvoiceAmountFlag) {
        addInvoiceRow();
    }

    if (referenceLRDetails && referenceLRDetails.code) {
        prefillLRData(referenceLRDetails, true);
    }
}

function selectFromCustomer(customer) {
    if (!customer) return;

    $('#from_phone').data('customerData', customer);
    $('#from_phone').typeahead('val', customer.mobileNumber).trigger('change');
    $('#from_name').typeahead('val', customer.name);
    $('#sender_gst').typeahead('val', customer.gstin).trigger('blur');
    $('#from_email').val(customer.email);

    if (customer.role == 'CMPY') {
        $('#sender-gst-type [name="sender-gst-type"][value=CMPY]').prop('checked', true).trigger('change');
        $('#sender-company-name').typeahead('val', customer.companyName);
    } else {
        $('#sender-gst-type [name="sender-gst-type"][value="INDL"]').prop('checked', true).trigger('change');
        $('#sender-company-name').typeahead('val', '');
    }
    formatCustomerAddress(1, customer.mobileNumber);
}

function selectToCustomer(customer) {
    if (!customer) return;

    $('#to_phone').data('customerData', customer);
    $('#to_phone').typeahead('val', customer.mobileNumber).trigger('change');
    $('#to_name').typeahead('val', customer.name);
    $('#receiver_gst').typeahead('val', customer.gstin).trigger('blur');
    $('#to_email').val(customer.email);

    if (customer.role == 'CMPY') {
        $('#receiver-gst-type [name="receiver-gst-type"][value="CMPY"]').prop('checked', true).trigger('change');
        $('#receiver-company-name').typeahead('val', customer.companyName);
    } else {
        $('#receiver-gst-type [name="receiver-gst-type"][value="INDL"]').prop('checked', true).trigger('change');
        $('#receiver-company-name').typeahead('val', '');
    }
    formatCustomerAddress(2, customer.mobileNumber);
}

var tr_id = 1;

function select_article(item, $article_row) {
    var pos = $article_row.data('index');
    $article_row.find('#code').val(item.code);
    $article_row.find('#qty').val(1);
    $article_row.find('#price').val($('.fs-addon-checkbox[value="FR"]').is(':checked') ? 0 : item.defaultRate);
    if ($('.fs-addon-checkbox[value="LC"]').is(':checked')) {
        $article_row.find('#handling').val(0).data('min', 0);
    } else {
        $article_row.find('#handling').val(item.defaultHandlingRate).data('min', item.defaultHandlingRate);
    }
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

    if (ns == 'rajeshcargo' || ns == 'rajeshexpress') {
        var pt = getPaymentType();
        if (item.defaultHandlingRate == 0 && (pt == 'PAD' || pt == 'TOP')) {
            setPaytypeSettings(pos, false);
        } else if (pt == 'INP') {
            setVendorSettings(pos, false);
        }
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
        },
        change: function(event, ui) {
            var $article_row = $(this).closest('.article_row');
            if (!ui.item && !cargoSetting.allowNewArticle) {
                notice('new article is not allowed');
                $(this).val(''); 
                $(this).data('selectedIndex',"");
                $article_row.find('#article-desc').val('');
                $article_row.find('#code').val("");
                $article_row.find('.iqty').val(1);
                $article_row.find('.irate').val(0);
                $article_row.find('.iunit').val('NPPKG');
                $article_row.find('.iunitval').val(1);
                $article_row.find('.ilcharge').val(0);
                $article_row.find('.iucharge').val(0);
                $article_row.find('.itotal').val(0);
                setTimeout(function () {
                    select_article([], $newrow);
                });
            }else{
                setTimeout(function () {
                    select_article(ui.item, $newrow);
                });
            }
        }
    }).focus(function () {
        $(this).autocomplete('search', '');
    });

    $newrow.find('#handling').closest('.input-group').tooltip({ title: '', html: true });

    if (autofocus) {
        $newrow.find('#name').focus();
    }
    getAllInputs();
}

function removeArticleRow(btn) {
    var rows = $('#article_rows .article_row').length;
    if(rows > 1) {
        $(btn).closest('tr.article_row').remove();
    }
    calculateAmounts();
}

function calculateAmounts(pos) {
    connectionCharges();
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

        if ((!article || article.defaultHandlingRate == 0) && Number(price) > 0 && cargoSetting.defaultLoadigCharge > 0 && !$('.fs-addon-checkbox[value="LC"]').is(':checked')) {
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
        if (menu_permission['HANDLING-PER-UOMQTY'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseInt(uomOrQty));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(uomOrQty));
        } else if (menu_permission['HANDLING-PER-QTY'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseInt(qty));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseInt(qty));
        } else if (menu_permission['HANDLING-PER-UOM'] == 1) {
            loadingCharges = Math.ceil(parseFloat(handling) * parseFloat(unitValue));
            unloadingCharges = Math.ceil(parseFloat(unloading) * parseFloat(unitValue));
        }

        if (cargoSetting.loadingChargeRoundOffValue != 0) {
            loadingCharges = roundUpOrDownValue(loadingCharges, cargoSetting.loadingChargeRoundOffValue);
        }
        totalHandlingAmount += loadingCharges;

        if (!article || !article.gstExemptedFlag) {
            totalFreightAmount += freight;
        }

        if (parseInt(qty) > 0) {
            totalPayableAmount += parseFloat(freight) + parseFloat(loadingCharges) + parseFloat(unloadingCharges);
        }

        var hcTooltip = $article.find('#handling').closest('.input-group').data('bs.tooltip');
        if (hcTooltip && hcTooltip.options) {
            $article.find('#handling').closest('.input-group').data('bs.tooltip').options.title = '<i class="fa fa-rupee"></i> ' + loadingCharges;
        }

        $article.find('#total').val(+Number(freight).toFixed(2));
    });

    $('#total_loading_charges').val(totalHandlingAmount);

    // calculate pickup charges
    var dpc = parseFloat($('#dp_charges').val());
    if (dpc > 0 && !$('.fs-addon-checkbox[value="DP"]').is(':checked')) {
        totalPayableAmount += dpc;
    }

    // calculate delivery charges
    var ddc = parseFloat($('#dd_charges').val());
    if (ddc > 0 && !$('.fs-addon-checkbox[value="DD"]').is(':checked')) {
        totalPayableAmount += ddc;
    }

    // calculate service charges
    var sc = parseFloat($('#service_charges').val());
    if (sc > 0 && !$('.fs-addon-checkbox[value="OC"]').is(':checked')) {
        totalPayableAmount += sc;
    }

    // calculate hamali charges
    var hc = parseFloat($('#hamali_charges').val());
    if (hc > 0 && !$('.fs-addon-checkbox[value="HC"]').is(':checked')) {
        totalPayableAmount += hc;
    }

    // calculate pass charges
    var pc = parseFloat($('#pass_charges').val());
    if (pc > 0) {
        totalPayableAmount += pc;
    }

    // calculate docket charges
    var dc = parseFloat($('#docket_charges').val());
    if (dc > 0 && !$('.fs-addon-checkbox[value="DC"]').is(':checked')) {
        totalPayableAmount += dc;
    }

    // calculate pod charges
    var podc = $("#pod_charges_enable").is(':checked') ? parseFloat($('#pod_charges').val()) : 0
    if (podc > 0) {
        totalPayableAmount += podc;
    }

    // calculate insurance charges
    var insuranceCharges = parseFloat($('#insurance_charges').val());
    if (insuranceCharges > 0) {
        totalPayableAmount += insuranceCharges;
    }

    // calculate adjustment amount
    var adjustmentAmount = Number($('#adjustment_amount').val());
    if (!isNaN(adjustmentAmount) && adjustmentAmount != 0) {
        totalPayableAmount += adjustmentAmount;
    }

    // calculate machine handling amount
    var machineHandlingCharges = Number($('#machine_handling_charges').val());
    if (machineHandlingCharges > 0 && !$('.fs-addon-checkbox[value="MC"]').is(':checked')) {
        totalPayableAmount += machineHandlingCharges;
    }
    
    // calculate FOV
    var invoiceAmount = 0;
    $('#invoice-list .invoice-row').each(function () {
        invoiceAmount += Number($.trim($(this).find('.inv_amount').val()));
    });

    let fovPercentage = Number($('#fov_percent').val());
    var fovCharge = Number($('#fov_charge').val()) || 0;
    if (fovPercentage > 0) {
        let fov_charge = Math.round(parseFloat(invoiceAmount) * fovPercentage / 100);
        $('#fov_charge').val(fov_charge);
        fovCharge = fov_charge;
    }
    totalPayableAmount += fovCharge;

 
        var serviceTaxRoundOff = false;
        var computeGST = cargoSetting.lrGstTaxComputeType == 'FRT' ? totalFreightAmount : totalPayableAmount
        if (computeGST > cargoSetting.minServiceTax && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
            if(serviceTaxRoundOff){
                var st = Math.ceil(parseFloat(computeGST) * cargoSetting.serviceTaxPercentage / 100);
              
            }else{
                var st = computeGST * cargoSetting.serviceTaxPercentage / 100;
                st  = parseFloat(st).toFixed(2); 
                
            }
           
            if (st > 0) {
                $('#service_tax').val(st);
                st = computeGST * cargoSetting.serviceTaxPercentage / 100;
                // if (cargoSetting.lrGstTaxComputeType == 'FRT') {
                    if(gstModal == 'EXGST'){
                      totalPayableAmount = parseFloat(totalPayableAmount) + st;
                    }
                // }
            }
            $('#include-gst').bootstrapSwitch('state', true, true);
        } else {
            
            $('#include-gst').bootstrapSwitch('state', false, true);
             //remove GST values in all iputs
             $('#service_tax').val(0);

        }

        // net amount round off
        $('.round-of-visible').attr("data-original-title", "There is no Rounded Amount yet");
        if (cargoSetting.totalFreightRoundOffValue != 0) {
            var netPayableRound = roundUpOrDownValue(totalPayableAmount, cargoSetting.totalFreightRoundOffValue);
            var roundOffValue = netPayableRound - totalPayableAmount;
            $('#total_amount_roundoff').val(roundOffValue);
            $('.round-of-visible').attr("data-original-title", "Rounded Amount is : "+roundOffValue+"");
            totalPayableAmount = netPayableRound;
        }

        if($('#include-gst').data('includegst') != false){
            if(gstModal == "INGST"){
                if (cargoSetting.lrGstTaxComputeType == 'FRT') {
                    // var incGST = calcIncGST(totalFreightAmount,totalFreightAmount, cargoSetting.serviceTaxPercentage);
                    var incGST = calcIncGST(totalFreightAmount, cargoSetting.serviceTaxPercentage);
                } else {
                    // var incGST = calcIncGST(totalPayableAmount,totalFreightAmount, cargoSetting.serviceTaxPercentage);
                    var incGST = calcIncGST(totalPayableAmount,cargoSetting.serviceTaxPercentage);
                }
                $('#service_tax').val(incGST.inclusiveGST);
                $('.pre_gst').html(`Pre-GST Amt: <span style="font-weight:700;">${incGST.preGSTAmount}</span>`);
            }
        }else{
            $('.pre_gst').html("");
            $('#service_tax').val(0);
        }
        
    

    // calculate TDS
    let tdsPercentage = parseFloat($('#tds_tax_percent').val());
    if (tdsPercentage > 0) {
        let tdsTax = Math.round(parseFloat(totalPayableAmount) * tdsPercentage / 100);
        $('#tds_tax').val(tdsTax);
    }

    $('#total_amount').val(totalPayableAmount);
    // if (cargoSetting.userAccountModel.code != 'TXRT' && menu_permission['ALW-PART-PAYMENT'] != 1) {
        $('#amount-main').val(totalPayableAmount);
    // }
    setNowPayAmount();
}
//hepler
function calcIncGST(amount, gstRate) {
    var inclusiveGST = amount - (amount / (1 + (gstRate / 100)));
    var inclusiveGST =Math.floor(inclusiveGST * 100) / 100; 
    var preGSTAmount = amount - inclusiveGST;
    return {
        inclusiveGST: inclusiveGST.toFixed(2), 
        preGSTAmount: preGSTAmount.toFixed(2)
    };
}
function makeIncGST(value){
    if(value == 0){
        return value;
    }
    if(cargoSetting.lrGstTaxComputeType != 'NET'){
        return value;
    }
    if(gstModal != "INGST"){
        return value;
    }
    var allValues = calcIncGST(value,cargoSetting.serviceTaxPercentage);
    return allValues.preGSTAmount;
}
//helper

function addInvoiceRow() {
    var totalInvocie = $('#invoice-list .invoice-row').length;
    if (totalInvocie > 4) {
        return;
    }

    var $tpl = $('#invoice-row-tpl .invoice-row').clone();
    $('#invoice-list').prepend($tpl);

    $tpl.find('[data-mask]').each(function () {
        $(this).inputmask({ alias: $(this).data('mask') });
    });

    $tpl.find('.inv_date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        startDate: '-1d',
        endDate:'0d'
    });

    $('#invoice-table-panel').removeClass('hide');
    getAllInputs();
    return $tpl;
}

function removeInvoiceRow(btn) {
    $(btn).closest('.invoice-row').remove();
    calculateAmounts();
    if (!$('#invoice-list .invoice-row').length) {
        addInvoiceRow();
    }
}

function setNowPayAmount() {
    var paymentType = getPaymentType();
    var nowPaying = 0;
    var tdsTax = 0;
    if (paymentType == 'PAD') {
        nowPaying = Number($('#total_amount').val()) || 0;
        tdsTax = Number($('#tds_tax').val()) || 0;
    }
    $('#total_paying_amount').val(nowPaying - tdsTax);
    if (cargoSetting.userAccountModel.code == 'TXRT' && menu_permission['ALW-PART-PAYMENT'] == 1) {
        $('#amount-main').val(nowPaying - tdsTax);
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

function saveBooking(showpreview = 0) {
    $('.inp_error').removeClass('inp_error');
    $('#booking-action-state').removeClass('alert-success').addClass('alert-danger');

    var lrLoadType = $('[name="lr-load-type"]:checked').val();

    var data = {};  
    data.from_phone = $.trim( $('#from_phone').val() );
    data.from_name = $.trim( $('#from_name').val() );
    data.from_email = $.trim( $('#from_email').val() );
    data.door_pickup = +$('#door-pickup').is(':checked');
    data.sender_gst = $.trim( $('#sender_gst').val() ).toUpperCase();
    data.sender_company = $.trim( $('#sender-company-name').val() );

    var fromCustomer = $('#from_phone').data('customerData');
    if (fromCustomer) {
        data.from_customer = fromCustomer.code;
        data.from_customer_name = fromCustomer.name;
        data.from_customer_email = fromCustomer.email;

        if (hasChanged(data.from_name, fromCustomer.name) || hasChanged(data.from_email, fromCustomer.email)|| hasChanged(data.sender_gst, fromCustomer.gstin) || isNotNull(data.sender_company)) {
            data.update_from_customer = 1;
        }
    }

    if (lrLoadType == 'RGL') {
        var fromOrganization = $('#from_branch').select2('data');
        if (fromOrganization && fromOrganization.station) {
            data.from_branch = fromOrganization.code;
            data.from_station = fromOrganization.station.code;
        }
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var fromStation = $('#from_station').select2('data');
        if (fromStation) {
            data.from_branch = 'NA';
            data.from_station = fromStation.code;
        }
    }
    
    data.to_phone = $.trim( $('#to_phone').val() );
    data.to_name = $.trim( $('#to_name').val() );
    data.to_email = $.trim( $('#to_email').val() );
    data.door_delivery_type = $('#ddtype-btn-group [name="dd-type"]:checked').val();
    data.receiver_gst = $.trim( $('#receiver_gst').val() ).toUpperCase();
    data.receiver_company = $.trim( $('#receiver-company-name').val() );
    
    var toCustomer = $('#to_phone').data('customerData');
    if (toCustomer) {
        data.to_customer = toCustomer.code;
        data.to_customer_name = toCustomer.name;
        data.to_customer_email = toCustomer.email;

        if (hasChanged(data.to_name, toCustomer.name) || hasChanged(data.to_email, toCustomer.email) || hasChanged(data.receiver_gst, toCustomer.gstin) || isNotNull(data.receiver_company)) {
            data.update_to_customer = 1;
        }
    }

    if (lrLoadType == 'RGL') {
        var toOrganization = $('#to_branch').select2('data');
        if (toOrganization && toOrganization.station) {
            data.to_branch = toOrganization.code;
            data.to_station = toOrganization.station.code;
        }
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var toStation = $('#to_station').select2('data');
        if (toStation) {
            data.to_branch = 'NA';
            data.to_station = toStation.code;
        }
    }

    data.pay_mode = getPaymentType();  
    data.net_pay = $('#total_amount').val();
    data.now_pay = $('#total_paying_amount').val();
    
    if (data.door_pickup) {
        data.dp_charges = $.trim( $('#dp_charges').val() );
    }
    if (data.door_delivery_type) {
        data.dd_charges = $.trim( $('#dd_charges').val() );
    }
    
    data.service_charges = $.trim( $('#service_charges').val() );
    data.service_tax = $.trim( $('#service_tax').val() );
    data.hamaliCharge = $.trim( $('#hamali_charges').val() );
    data.passCharge = $.trim( $('#pass_charges').val() );
    data.docketCharge = $.trim( $('#docket_charges').val() );

    data.on_behalf_user = $('#cb-on-behalf-user').val();
    data.vendor_user = $('#vendor_users').val();
    if (data.vendor_user) {
        data.vendor_user_name = $('#vendor_users :selected').text();
    }

    data.cargoTransactionList = [];

    data.additionalAttribute = {};
    data.additionalAttribute.registerNumber = $('#bkg-vehicle').val();
    data.additionalAttribute.driverName = $('#bkg-driver-name').val();
    data.additionalAttribute.driverMobile = $('#bkg-driver-mobile').val();
    data.additionalAttribute.fromCustomerGstType = $('#sender-gst-type [name="sender-gst-type"]:checked').val();
    data.additionalAttribute.toCustomerGstType = $('#receiver-gst-type [name="receiver-gst-type"]:checked').val();
    data.additionalAttribute.CARGO_PRE_BOOK_CODE = $('#lr-prebooking-code:hidden').val();
    data.additionalAttribute.LOAD_TYPE = $.trim( $('[name="lr-load-type"]:checked').val() );
    data.additionalAttribute.SHIPMENT_TYPE = $.trim( $('[name="lr-shipment-type"]:checked').val() );
    data.additionalAttribute.SEQUENCE_TYPE = $.trim( $('[name="lr-no-type"]:checked').val() );

    var lrReferenceCode = $.trim( $('#lr-reference-code').val() );
    if (isNotNull(lrReferenceCode)) {
        data.additionalAttribute.REFERENCE_CARGO_CODE = lrReferenceCode;
    }
    var privateMark = $.trim( $('#bkg-private-mark').val() );
    if (isNotNull(privateMark)) {
        data.additionalAttribute.PRIVATE_MARK_NUMBER = privateMark;
    }

    if ($('#from_sms_cb, #to_sms_cb').length) {
        var senderBookingSMS = +$('#from_sms_cb').is(':checked');
        var receiverBookingSMS = +$('#to_sms_cb').is(':checked');

        data.additionalAttribute.BOOKING_SMS_NOTIFICATION_FLAG = [senderBookingSMS, receiverBookingSMS].join('');
    }

    var tdsTax = Number($('#tds_tax').val()) || 0;
    if (data.pay_mode == 'PAD') {
        data.additionalAttribute.transactionModeCode = $('#transaction-mode-main').val();
        // Main
        if ($('#amount-main').val() > 0 || data.now_pay > 0) {
            var cargoTransaction = {};
            if (menu_permission['SHOW-MULTI-PAY-MODE'] == 1) {
                cargoTransaction.transactionAmount = $('#amount-main').val();
            } else {
                cargoTransaction.transactionAmount = data.now_pay;
            }
            cargoTransaction.transactionMode = {};
            cargoTransaction.transactionMode.code = $('#transaction-mode-main').val();
            cargoTransaction.customerTdsTaxAmount = tdsTax;
    
            if (Number(data.now_pay) > Number(data.net_pay)) {
                $('#booking-action-state').html('Now paying amount must be less than net amount').show();
                $('#total_paying_amount').addClass('inp_error').focus();
                return;
            }
    
            if (Number(cargoTransaction.transactionAmount) <= 0 && cargoSetting.userAccountModel.code == 'TXRT' && menu_permission['ALW-PART-PAYMENT'] == 1) {
                $('#booking-action-state').html('Please enter a valid now paying amount').show();
                $('#amount-main').addClass('inp_error').focus();
                return;
            }
    
            if (cargoTransaction.customerTdsTaxAmount > totalFreightAmount) {
                $('#booking-action-state').html('TDS amount must be less than total freight amount').show();
                $('#tds_tax').addClass('inp_error').focus();
                return;
            }
    
            if (cargoTransaction.transactionMode.code == 'UPI') {
                cargoTransaction.bankDetails = {};
                cargoTransaction.bankDetails.code = $('#upi-orgbank-main').val();
                cargoTransaction.additionalAttribute = {};
                cargoTransaction.additionalAttribute.UPI_ID = $.trim($('#upi-id-main').val());
                cargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#upi-details-main').val());
                
                if (isNull(cargoTransaction.bankDetails.code)) {
                    $('#booking-action-state').html('Please select Organization Bank').show();
                    $('#upi-orgbank-main').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(cargoTransaction.additionalAttribute.UPI_ID)) {
                    $('#booking-action-state').html('Please enter a valid UPI ID').show();
                    $('#upi-id-main').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(cargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#booking-action-state').html('Please enter a valid UPI Ref. #').show();
                    $('#upi-details-main').addClass('inp_error').focus();
                    return;
                }
            } else if (cargoTransaction.transactionMode.code == 'NBK') {
                cargoTransaction.bankDetails = {};
                cargoTransaction.bankDetails.code = $('#netbanking-orgbank-main').val();
                cargoTransaction.additionalAttribute = {};
                cargoTransaction.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#netbanking-accholder-main').val());
                cargoTransaction.additionalAttribute.BANK_NAME = $.trim($('#netbanking-bankname-main').val());
                cargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#netbanking-details-main').val());
                
                if (isNull(cargoTransaction.bankDetails.code)) {
                    $('#booking-action-state').html('Please select Organization Bank').show();
                    $('#netbanking-orgbank-main').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(cargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#booking-action-state').html('Please enter a valid Netbanking / Bank Transfer Ref. #').show();
                    $('#netbanking-details-main').addClass('inp_error').focus();
                    return;
                }
            } else if (cargoTransaction.transactionMode.code == 'CHEQUE') {
                var chequeDetails = {};
                chequeDetails.organization = {};
                chequeDetails.organization.code = userOrganizationCode;
                chequeDetails.bankDetails = $.trim($('#cheque-bankname-main').val());
                chequeDetails.payerDetails = $.trim($('#cheque-payer-main').val());
                chequeDetails.chequeDate = moment($('#cheque-date-main').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                chequeDetails.chequeNo = $.trim($('#cheque-no-main').val());
                chequeDetails.bankCity = $.trim($('#cheque-bankcity-main').val());
                chequeDetails.chequeStatus = {};
                chequeDetails.chequeStatus.code = 'NEW';
                chequeDetails.remarks = $.trim($('#cheque-remarks-main').val());
    
                if (isNull(chequeDetails.payerDetails)) {
                    $('#booking-action-state').html('Please enter valid payer details').show();
                    $('#cheque-payer-main').addClass('inp_error').focus();
                    return;
                }
                if (isNull(chequeDetails.chequeNo)) {
                    $('#booking-action-state').html('Please enter valid cheque no').show();
                    $('#cheque-no-main').addClass('inp_error').focus();
                    return;
                }
                // if (!moment($('#cheque-date').val(), 'DD-MM-YYYY').isValid()) {
                //     $('#booking-action-state').html('Please enter valid cheque date').show();
                //     $('#cheque-date-main').addClass('inp_error').focus();
                //     return;
                // }
                if (isNull(chequeDetails.bankCity)) {
                    $('#booking-action-state').html('Please enter valid bank city').show();
                    $('#cheque-bankcity-main').addClass('inp_error').focus();
                    return;
                }
                if (isNull(chequeDetails.bankDetails)) {
                    $('#booking-action-state').html('Please enter valid Organization Bank').show();
                    $('#cheque-bankname-main').addClass('inp_error').focus();
                    return;
                }
                cargoTransaction.chequeDetails = chequeDetails;
            }
    
            data.cargoTransactionList.push(cargoTransaction);
        }

        // Sub
        if (menu_permission['SHOW-MULTI-PAY-MODE'] == 1 && $('#amount-sub').val() > 0) {
            var cargoTransaction = {};
            cargoTransaction.transactionAmount = $('#amount-sub').val();
            cargoTransaction.transactionMode = {};
            cargoTransaction.transactionMode.code = $('#transaction-mode-sub').val();
    
            if (Number(data.now_pay) > Number(data.net_pay)) {
                $('#booking-action-state').html('Now paying amount must be less than net amount').show();
                $('#total_paying_amount').addClass('inp_error').focus();
                return;
            }
    
            if (Number(cargoTransaction.transactionAmount) <= 0 && cargoSetting.userAccountModel.code == 'TXRT' && menu_permission['ALW-PART-PAYMENT'] == 1) {
                $('#booking-action-state').html('Please enter a valid now paying amount').show();
                $('#amount-sub').addClass('inp_error').focus();
                return;
            }
    
            if (cargoTransaction.transactionMode.code == 'UPI') {
                cargoTransaction.bankDetails = {};
                cargoTransaction.bankDetails.code = $('#upi-orgbank-sub').val();
                cargoTransaction.additionalAttribute = {};
                cargoTransaction.additionalAttribute.UPI_ID = $.trim($('#upi-id-sub').val());
                cargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#upi-details-sub').val());
                
                if (isNull(cargoTransaction.bankDetails.code)) {
                    $('#booking-action-state').html('Please select Organization Bank').show();
                    $('#upi-orgbank-sub').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(cargoTransaction.additionalAttribute.UPI_ID)) {
                    $('#booking-action-state').html('Please enter a valid UPI ID').show();
                    $('#upi-id-sub').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(cargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#booking-action-state').html('Please enter a valid UPI Ref. #').show();
                    $('#upi-details-sub').addClass('inp_error').focus();
                    return;
                }
            } else if (cargoTransaction.transactionMode.code == 'NBK') {
                cargoTransaction.bankDetails = {};
                cargoTransaction.bankDetails.code = $('#netbanking-orgbank-sub').val();
                cargoTransaction.additionalAttribute = {};
                cargoTransaction.additionalAttribute.ACC_HOLDER_NAME = $.trim($('#netbanking-accholder-sub').val());
                cargoTransaction.additionalAttribute.BANK_NAME = $.trim($('#netbanking-bankname-sub').val());
                cargoTransaction.additionalAttribute.REFERENCE_DETAILS = $.trim($('#netbanking-details-sub').val());
                
                if (isNull(cargoTransaction.bankDetails.code)) {
                    $('#booking-action-state').html('Please select Organization Bank').show();
                    $('#netbanking-orgbank-sub').addClass('inp_error').focus();
                    return;
                }
    
                if (isNull(cargoTransaction.additionalAttribute.REFERENCE_DETAILS)) {
                    $('#booking-action-state').html('Please enter a valid Netbanking / Bank Transfer Ref. #').show();
                    $('#netbanking-details-sub').addClass('inp_error').focus();
                    return;
                }
            } else if (cargoTransaction.transactionMode.code == 'CHEQUE') {
                var chequeDetails = {};
                chequeDetails.organization = {};
                chequeDetails.organization.code = userOrganizationCode;
                chequeDetails.bankDetails = $.trim($('#cheque-bankname-sub').val());
                chequeDetails.payerDetails = $.trim($('#cheque-payer-sub').val());
                chequeDetails.chequeDate = moment($('#cheque-date-sub').val(), 'DD-MM-YYYY').format('YYYY-MM-DD');
                chequeDetails.chequeNo = $.trim($('#cheque-no-sub').val());
                chequeDetails.bankCity = $.trim($('#cheque-bankcity-sub').val());
                chequeDetails.chequeStatus = {};
                chequeDetails.chequeStatus.code = 'NEW';
                chequeDetails.remarks = $.trim($('#cheque-remarks-sub').val());
    
                if (isNull(chequeDetails.payerDetails)) {
                    $('#booking-action-state').html('Please enter valid payer details').show();
                    $('#cheque-payer-sub').addClass('inp_error').focus();
                    return;
                }
                if (isNull(chequeDetails.chequeNo)) {
                    $('#booking-action-state').html('Please enter valid cheque no').show();
                    $('#cheque-no-sub').addClass('inp_error').focus();
                    return;
                }
                if (!moment($('#cheque-date').val(), 'DD-MM-YYYY').isValid()) {
                    $('#booking-action-state').html('Please enter valid cheque date').show();
                    $('#cheque-date-sub').addClass('inp_error').focus();
                    return;
                }
                if (isNull(chequeDetails.bankCity)) {
                    $('#booking-action-state').html('Please enter valid bank city').show();
                    $('#cheque-bankcity-sub').addClass('inp_error').focus();
                    return;
                }
                if (isNull(chequeDetails.bankDetails)) {
                    $('#booking-action-state').html('Please enter valid Organization Bank').show();
                    $('#cheque-bankname-sub').addClass('inp_error').focus();
                    return;
                }
                cargoTransaction.chequeDetails = chequeDetails;
            }
    
            data.cargoTransactionList.push(cargoTransaction);
        }
    }

    if ($('#manual-lr-cb').is(':checked')) {
        data.additionalAttribute.CARGO_POSTFIX_CODE = $.trim( $('#manual-lr-no').val() );

        if (!data.additionalAttribute.CARGO_POSTFIX_CODE || isNaN(data.additionalAttribute.CARGO_POSTFIX_CODE)) {
            $('#booking-action-state').html('Please enter Manual LR number').show();
            $('#manual-lr-no').addClass('inp_error').focus();
            return;
        }
    }

    if (data.additionalAttribute.fromCustomerGstType == 'CMPY') {
        if (!isValidGstNumber(data.sender_gst)) {
            $('#booking-action-state').html('Please enter a valid GSTIN').show();
            $('#sender_gst').addClass('inp_error').focus();
            return;
        }
        if (isNull(data.sender_company)) {
            $('#booking-action-state').html('Please enter a valid Company Name').show();
            $('#sender-company-name').addClass('inp_error').focus();
            return;
        }
    }
    if (data.additionalAttribute.toCustomerGstType == 'CMPY') {
        if (!isValidGstNumber(data.receiver_gst)) {
            $('#booking-action-state').html('Please enter a valid GSTIN').show();
            $('#receiver_gst').addClass('inp_error').focus();
            return;
        }
        if (isNull(data.receiver_company)) {
            $('#booking-action-state').html('Please enter a valid Company Name').show();
            $('#receiver-company-name').addClass('inp_error').focus();
            return;
        }
    }

    data.remarks = [];

    var remarks = {};
    remarks.code = '';
    remarks.name = $('#booking-remarks').val().trim();
    remarks.cargoStatusCode = 'CB';
    data.remarks.push(remarks);

    if ((cargoSetting.showCustomerAddressFlag || $('#door-pickup').is(':checked')) && $('.pick1:checked').data('code') != 'other') {
        data.dp_address_code = $('.pick1:checked').data('code');
    } else if ($('.pick1:checked').data('code') == 'other') {
        data.dp_address = $('#fr_address').val();
        data.dp_landmark = $('#fr_landmark').val();
        data.dp_pincode = $('#fr_pincode').val();
        data.dp_station = $('#fr_addr_station').val();
    }

    if ($('.pick1:checked').data('code') != 'other' && $('.pick1:checked').data('code')) {
        data.dp_address_selected = '1';
    }

    if ($('.pick2:checked').data('code') != 'other' && $('.pick2:checked').data('code')) {
        data.dd_address_selected = '1';
    }

    if ((cargoSetting.showCustomerAddressFlag || $('#ddtype-btn-group [name="dd-type"]').is(':checked')) && $('.pick2:checked').data('code') != 'other') {
        data.dd_address_code = $('.pick2:checked').data('code');
    } else if ($('.pick2:checked').data('code') == 'other') {
        data.dd_address = $('#to_address').val();
        data.dd_landmark = $('#to_landmark').val();
        data.dd_pincode = $('#to_pincode').val();
        data.dd_station = $('#to_addr_station').val();
    }

    if (data.dp_address && cargoSetting.showCustomerAddressFlag) { //address entered or modified when address flag is enable
        data.dp_address_available = '1';
    }

    if (data.dd_address && cargoSetting.showCustomerAddressFlag) { //address entered or modified when address flag is enable
        data.dd_address_available = '1';
    }

    if (isNotNull($('#from-address-code-hidden').val())) {
        data.dp_address_code = $('#from-address-code-hidden').val();
        data.dp_address_selected = '1';
    }

    var fromOrgData = $('#from_branch').select2('data') || {};

    data.cargoAddonsDetails = [];

    var err = 0;
    var articles = [];
    var totalFreightAmount = 0;
    var totalhandalingGstAmount = 0;

    var  serviceTaxCount = 0;

    $('.article_row').each(function() { 
        //$(this).find('#code').val()!="" && 
        if( Number( $(this).find('#qty').val() ) >0 ) {
            var article = {};
            article.activeFlag = 1;
            article.cargoItem = {};
            article.cargoItem.code = $(this).find('#code').val() || ''; 
            article.cargoItem.name = $(this).find('#name').val();
            article.fare = $.trim( $(this).find('#price').val()) || 0;
            article.itemCount =  $.trim( $(this).find('#qty').val()) | 0;
            article.handlingChargeAmount =  $.trim( $(this).find('#handling').val()) || 0;
            totalhandalingGstAmount += Number(article.handlingChargeAmount);
            article.unloadingChargeAmount =  $.trim( $(this).find('#unloading').val()) || 0;
            article.unit = {};
            article.unit.code = $(this).find('#article-unit').val();
            article.unitValue = $(this).find('#article-unit-val').val();  
            article.actualUnitValue = $(this).find('#actual-weight').val();
            article.serviceTax = 0;

            var description = $(this).find('#article-desc').val();
            if (article.unit.code == 'VOL') {
                description += ' ' + $(this).find('#article-unit-volumetric').val();
            }
            article.cargoItem.description = [ description ];

            var articleData = $(this).find('#name').data('uiAutocomplete').selectedItem;
           

            if (fromOrgData.deviationPercentage > 0 && article.cargoItem.code == '') {
                if(!cargoSetting.allowNewArticle){
                    $('#booking-action-state').html('Adding new Article not allowed for the selected From Branch');
                    $(this).find('#article-name').focus();
                    err++;
                    return false;
                }
                
            }

            if (!$.trim($(this).find('#name').val())) {
                $('#booking-action-state').html('Please enter valid article');
                $(this).find('#name').focus();
                err++;
                return false;
            }
            if (!menu_permission['HIDE-DESCRIPTION']) {
                if (!$.trim($(this).find('#article-desc').val())) {
                    $('#booking-action-state').html('Please enter valid description');
                    $(this).find('#article-desc').focus();
                    err++;
                    return false;
                }
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
                    if (Number(article.handlingChargeAmount) == 0 || defaultLoadigCharge > Number(article.handlingChargeAmount)) {
                        article.handlingChargeAmount = defaultLoadigCharge;
                    }
                    defaultLoadigCharge = (parseFloat(article.fare) * parseFloat(article.handlingChargeAmount)) / 100;
                    article.handlingChargeAmount = defaultLoadigCharge;
                } else {
                    if (defaultLoadigCharge > Number(article.handlingChargeAmount)) {
                        article.handlingChargeAmount = defaultLoadigCharge;
                    }
                }
            }

            if (!$('.fs-addon-checkbox[value="FR"]').is(':checked') && Math.ceil(article.handlingChargeAmount) > freight) {
                $('#booking-action-state').html('L. Charges must be less than freight amount');
                $(this).find('#handling').focus();
                err++;
                return false;
            }

            if (menu_permission['HANDLING-PER-UOMQTY'] == 1) {
                article.handlingChargeAmount = Math.ceil(parseFloat(article.handlingChargeAmount) * parseFloat(uomOrQty));
                article.unloadingChargeAmount = Math.ceil(parseFloat(article.unloadingChargeAmount) * parseFloat(uomOrQty));
            } else if (menu_permission['HANDLING-PER-QTY'] == 1) {
                article.handlingChargeAmount = Math.ceil(parseFloat(article.handlingChargeAmount) * parseInt(article.itemCount));
                article.unloadingChargeAmount = Math.ceil(parseFloat(article.unloadingChargeAmount) * parseInt(article.itemCount));
            } else if (menu_permission['HANDLING-PER-UOM'] == 1) {
                article.handlingChargeAmount = Math.ceil(parseFloat(article.handlingChargeAmount) * parseFloat(article.unitValue));
                article.unloadingChargeAmount = Math.ceil(parseFloat(article.unloadingChargeAmount) * parseFloat(article.unitValue));
            }
                
            if (cargoSetting.loadingChargeRoundOffValue != 0) {
                article.handlingChargeAmount = roundUpOrDownValue(article.handlingChargeAmount, cargoSetting.loadingChargeRoundOffValue);
            }

            article.handlingChargeAmount = Math.ceil(article.handlingChargeAmount);

            if ($('.fs-addon-checkbox[value="LC"]').is(':checked')) {
                article.handlingChargeAmount = 0;
            }
            //need to work with inclusive gst
            if (data.service_tax > 0 && (!articleData || !articleData.gstExemptedFlag)) {
                var st = parseFloat(article.fare) * cargoSetting.serviceTaxPercentage / 100;
                article.serviceTax = st;
            }

            articles.push(article);
            totalFreightAmount += freight;
        }
    });

    data.cargo_items = articles;

    if (cargoSetting.minFreightAmount > 0 && totalFreightAmount < cargoSetting.minFreightAmount) {
        $('#booking-action-state').html('Total Freight Amount must be greater than ' + cargoSetting.minFreightAmount).show();
        return;
    }

    if (err) {
        $('#booking-action-state').show();
        return;
    }

    var podc = $("#pod_charges_enable").is(':checked') ? parseFloat($('#pod_charges').val()) : 0;
    if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
        if(addIncludeGST == "OTHER_CHARGES"){
            podc = makeIncGST(podc)           
        }
   }
    if (podc > 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'PODCH' },
            value: podc
        });
    }

    $('#shipping-btn-group :checked').map(function () {
        data.cargoAddonsDetails.push({
            addonsType: { code: $(this).val() },
            value: "0.00" 
        });
        return $(this).val();
    }).get();

    // var ewbill = $.trim($('#eway_bill').val());
    // if (ewbill != '') {
    //     data.cargoAddonsDetails.push({
    //         addonsType: { code: 'EWBL' },
    //         value: ewbill
    //     });
    // }

   
    var roundoff = Number($('#total_amount_roundoff').val());
    if (!isNaN(roundoff) && roundoff !== 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'RNDF' },
            value: Number(roundoff).toFixed(2)
        });
    }

    var insuranceCharges = Number($('#insurance_charges').val());
    if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
        if(addIncludeGST == "OTHER_CHARGES"){
            insuranceCharges = makeIncGST(insuranceCharges);
        }
    }
    if (insuranceCharges > 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'INSUR' },
            value: insuranceCharges
        });
    }

    var adjustmentAmount = Number($('#adjustment_amount').val());
    if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
        if(addIncludeGST == "OTHER_CHARGES"){
            adjustmentAmount = makeIncGST(adjustmentAmount);
        }
    }
    if (!isNaN(adjustmentAmount) && adjustmentAmount != 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'ADJSMT' },
            value: adjustmentAmount
        });
    }

    var machineHandlingCharges = Number($('#machine_handling_charges').val());
    if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
        if(addIncludeGST == "OTHER_CHARGES"){
            machineHandlingCharges = makeIncGST(machineHandlingCharges);
        }
    }
    if (machineHandlingCharges > 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'MCNHCHBL' },
            value: machineHandlingCharges
        });
    }
    var connectingChargers = Number($('#connectingChargeValue').val());
    if(connectingChargers>0){
         data.cargoAddonsDetails.push({
            addonsType: { code: 'CNCTCH'},
            value: connectingChargers
        });
    }

    var freeServiceAddon = $('.fs-addon-checkbox:checked').map((i, cb) => cb.value).get();
    if (freeServiceAddon.length) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'FRECR' },
            value: freeServiceAddon.join(',')
        });
    }

    var fovCharges = Number($('#fov_charge').val());
    if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
        if(addIncludeGST == "OTHER_CHARGES"){
            fovCharges = makeIncGST(fovCharges);
        }
    }
    if (fovCharges > 0) {
        data.cargoAddonsDetails.push({
            addonsType: { code: 'FOVCH' },
            value: fovCharges
        });
    }
    
    $('#invoice-list .invoice-row').each(function () {
        var invoice = {};

        invoice.addonsType = {};
        invoice.addonsType.code = 'EWBL';

        var invoiceNumber = $.trim($(this).find('.inv_number').val());
        var invoiceAmount = $.trim($(this).find('.inv_amount').val());
        if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
            if(addIncludeGST == "OTHER_CHARGES"){
                invoiceAmount = makeIncGST(invoiceAmount);
            }
        }

        var invoice_date = $(this).find('.inv_date').val();
        var invoiceDate =moment(invoice_date, 'DD-MM-YYYY').format('YYYY-MM-DD');
        invoice.value = invoiceAmount+'|'+invoiceNumber+'|'+invoiceDate;

        invoice.referenceCode = $.trim($(this).find('.e_way_bill_number').val());
   console.log(invoice);
        if (cargoSetting.mandateInvoiceAmountFlag || invoiceNumber != '') {
            if (invoiceNumber == '') {
                $('#booking-action-state').html('Please enter invoice number');
                $(this).find('.inv_number').focus();
                err++;
                return false;
            } else if (invoiceAmount == '') {
                $('#booking-action-state').html('Please enter invoice amount');
                $(this).find('.inv_amount').focus();
                err++;
                return false;
            } else if (isNaN(invoiceAmount)) {
                $('#booking-action-state').html('Please enter valid invoice amount');
                $(this).find('.inv_amount').focus();
                err++;
                return false;
            } else if ($(this).find('.inv_date').val() == '') {
                $('#booking-action-state').html('Please enter invoice date');
                $(this).find('.inv_date').focus();
                err++;
                return false;
            }
         
            data.cargoAddonsDetails.push(invoice);
        }
    });

    $('#booking-action-state').show();
    
    if (err) {
        return;
    }
    
    if (lrLoadType == 'RGL') {
        if (!data.from_branch) {
            $('#booking-action-state').html('Please select from branch');
            return;
        }
        if (!data.to_branch) {
            $('#booking-action-state').html('Please select to branch');
            return;
        }
    }
    
    if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        if (!data.from_station) {
            $('#booking-action-state').html('Please select from station');
            return;
        }
        if (!data.to_station) {
            $('#booking-action-state').html('Please select to station');
            return;
        }
        if (data.from_station == data.to_station) {
            $('#booking-action-state').html('Please select different from and to station');
            return;
        }
    }
    
    if (cargoSetting.userAccountModel.code != 'DINV') {
        if(data.from_phone=="") {
            $('#booking-action-state').html('Please enter sender mobile');
            $('#from_phone').focus();
            return;
        } else if(!isValidPhonenumber(data.from_phone)) {
            $('#booking-action-state').html('Please enter valid sender mobile');
            $('#from_phone').focus();
            return;        
        }
    }

    var mobileNumberValidFrom = $('#from_phone').val();
    var mobileErr = 0;
    $.each(cargoSetting.mobileNumberValidationRegex || [], function(key, value) { 
        if (!new RegExp(value).test(mobileNumberValidFrom)) {
            mobileErr++;
        }
    });

    if (mobileErr > 0) {
        $('#booking-action-state').html('Please enter valid sender mobile');
        $('#from_phone').focus();
        return false;
    }
    
    if(isNull(data.from_name)) {
        $('#booking-action-state').html('Please enter valid sender name');
        $('#from_name').focus();
        return;        
    }
    if(isNotNull(data.from_email) && !isValidEmailAddress(data.from_email)) {
        $('#booking-action-state').html('Please enter valid sender email');
        $('#from_email').focus();
        return;        
    }
    if (cargoSetting.userAccountModel.code != 'DINV') {
        if(data.to_phone=="") {
            $('#booking-action-state').html('Please enter recipient mobile');
            $('#to_phone').focus();
            return;
        } else if(!isValidPhonenumber(data.to_phone)) {
            $('#booking-action-state').html('Please enter valid recipient mobile');
            $('#to_phone').focus();
            return;        
        }
    }

    var mobileNumberValidTo = $('#to_phone').val();
    var mobileErr = 0;
    $.each(cargoSetting.mobileNumberValidationRegex || [], function(key, value) { 
        if (!new RegExp(value).test(mobileNumberValidTo)) {
            mobileErr++;
        }
    });

    if (mobileErr > 0) {
        $('#booking-action-state').html('Please enter valid recipient mobile');
        $('#to_phone').focus();
        return false;
    }

    if(isNull(data.to_name)) {
        $('#booking-action-state').html('Please enter valid recipient name');
        $('#to_name').focus();
        return;        
    } else if(data.cargo_items.length<=0) {
        $('#booking-action-state').html('Please add atleast one article');
        return;
    } else if(data.pay_mode=="PAD" && (menu_permission['ALW-PART-PAYMENT'] != 1 && Number(data.net_pay) != Number(data.now_pay) + Number(tdsTax))) {
        $('#booking-action-state').html('Net amount and Now paying amount not matched');
        return;
    } else if(data.pay_mode=="") {
        $('#booking-action-state').html('Please select payment type');
        // $('#pay_type').focus();
        return;
    }
    if(isNotNull(data.to_email) && !isValidEmailAddress(data.to_email)) {
        $('#booking-action-state').html('Please enter valid recipient email');
        $('#to_email').focus();
        return;        
    }

    // var fromBranchMapping = _.find(branchRoutes, i => i.organization.code == data.from_branch);
    // if (!fromBranchMapping) {
    //     $('#booking-action-state').html('Organization / Branch not mapped!');
    //     return;
    // }
    // var toBranchMapping = _.find(fromBranchMapping.deliveryBranchList, i => i.code == data.to_branch);
    // if (!toBranchMapping) {
    //     $('#booking-action-state').html('Organization / Branch not mapped!');
    //     return;
    // }
    // var toBranchMapping = _.find(branchRoutes, i => i.organization.code == data.to_branch);
    // if (toBranchMapping) {
    //     var payModeMapping = _.find(toBranchMapping.paymentTypeList, i => i.code == data.pay_mode);
    //     if (!payModeMapping) {
    //         $('#booking-action-state').html('Payment type not enabled for given branch');
    //         return;
    //     }
    // }
    
    if ((cargoSetting.mandateAddressOnBookingFlag && $('.pick1:checked').data('code') == 'other') || $('#fr_address').val()){
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
    
    if ((cargoSetting.mandateAddressOnBookingFlag && $('.pick2:checked').data('code') == 'other') || $('#to_address').val()){
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

    if (cargoSetting.mandateAddressOnBookingFlag) {
        if (data.door_pickup && !$('.fs-addon-checkbox[value="DP"]').is(':checked')) {
            if (isNaN(data.dp_charges) || Number(data.dp_charges) <= 0) {
                $('#booking-action-state').html('Pickup charge is mandatory for door pickup.');
                $('#dp_charges').focus();
                return;
            }
        }
        if (data.door_delivery_type && !$('.fs-addon-checkbox[value="DD"]').is(':checked')) {
            if (isNaN(data.dd_charges) || Number(data.dd_charges) <= 0) {
                $('#booking-action-state').html('Delivery charge is mandatory for door delivery.');
                $('#dd_charges').focus();
                return;
            }
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
    
    if(data.pay_mode=="INP"){
        if(data.vendor_user == ''){
            $('#booking-action-state').html('Please select vendor');
            $('#vendor_users').focus();
            return;
        }
    }

    if(data.dd_address_code == 'other'){
        data.dd_address_code == '';
    }
    if(data.dp_address_code == 'other'){
        data.dp_address_code == '';
    }
    //refere addon
    if($('#refer-checkbox').prop('checked')){
        data.cargoAddonsDetails.push({
            addonsType: { code: 'RFLAG' },
            value: $('#ref-amount').val(),
            referenceCode : $('#ref-user').val()
        });
    } 
    //refere addon end
    if (showpreview == 1) {
        $('#booking-action-state').hide();
        show_booking_preview(data);
        return;
    }

    //main func
    // if inclusive gst applied for net amount only it has to word
    // if (data.service_tax > 0 && !hasRCMBasedGST() && $('#include-gst').data('includegst') != false) {
    //     if(addIncludeGST == "OTHER_CHARGES"){
    //         data.dp_charges = makeIncGST($.trim( $('#dp_charges').val() ));
    //         data.dd_charges = makeIncGST($.trim( $('#dd_charges').val() ));
    //         data.service_charges = makeIncGST($.trim( $('#service_charges').val()));
    //         data.hamaliCharge = makeIncGST($.trim( $('#hamali_charges').val()));
    //         data.passCharge = makeIncGST($.trim( $('#pass_charges').val()));
    //         data.docketCharge = makeIncGST($.trim( $('#docket_charges').val())); 
    //         podc = $("#pod_charges_enable").is(':checked') ? parseFloat($('#pod_charges').val()) : 0;

    //     }
    // }
    $('#booking-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#booking-action-state').html(loading_popup);
    $('#booking-action-state').show();

    $('#confirm-booking-btn').attr('disabled', true);
    btnBlock('#confirm-booking-btn');
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/save-booking",
        data: data,
        success: function (response) {
            $('#confirm-booking-btn').attr('disabled', false);
            if (response.status == 1) {
                $('#booking-action-state').removeClass('alert-danger');
                $('#booking-action-state').addClass('alert-success');
                $('#booking-action-state').html('Your request has been completed successfully');
                   
                    getCargoDetails(response.data.code, {
                        params: {onBooked: 1}
                    });
                  

                if ($('#remember-booking').is(':checked')) {
                    $('#to_phone, #to_name, #receiver_gst').val('');
                    setTimeout(function () {
                        toggleToBranch();
                        togglePayType();
                        $('#booking-action-state').hide();
                    }, 1000);
                } else {
                    setTimeout(function () {
                        if (data.additionalAttribute.REFERENCE_CARGO_CODE) {
                            window.location.hash = '#cargo/booking';
                        } else {
                            checkURL();
                        }
                    }, 2000);
                }
            } else {
                $('#booking-action-state').addClass('alert-danger');
                $('#booking-action-state').html(response.errorDesc || 'Unknown Exception');
                $('#booking-form-bttons').show();

                if (response.errorCode == '322' && isNotNull(response.fromCustomerAddressCode)) {
                    $('#from-address-code-hidden').val(response.fromCustomerAddressCode);
                }
            }
        }
    })
}

function show_booking_preview(data) {
    console.log(data);
    
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
        url: base_url + "cargo/cargo-booking-preview",
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

function cargoItemDialog(option) {
    $('#cargo-item-dialog').css('background', '#fff');
    $('#itm-form-action-state').html('');
    $('#itm-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    $('#cargo-item-dialog').removeClass('hide');
    $('#cargo-item-dialog').dialog({
        autoOpen: true,
        height: 500,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    var $event = $('#desc-table tbody');
    $event.find('tr:not(:first-child)').remove();
    if (_isdefined(option)) {
        $('#code').val(option.code);
        $('#name').val(option.name);
        $('#def_rate').val(option.defaultRate);
        $('#desc').val(option.description);
        $('#def_hnd_rate').val(option.defaultHandlingRate);
        $('#min_freight_amt').val(option.minFreightAmount);
        if (option.docRequriedFlag == 1) {
            $('#req_flg').prop('checked', true);
        } else {
            $('#req_flg').prop('checked', false);
        }

        $('#gstExemptedFlag').prop('checked', option.gstExemptedFlag);

        $.each(option.description || [], function (i, val) {
                var $eventrow = $event.find('tr').eq(i);
                $eventrow.find('.desc').val(val);
                addDescRow();
        });
    } else {
        $('#code,#name,#def_rate,#desc,#def_hnd_rate,#min_freight_amt').val('');
        $('.switch-id-req_flg').addClass('switch-on').removeClass('switch-off');
        $('#gstExemptedFlag').prop('checked', false);
    }

}

function saveItems() {
    var data = {};
    data.activeFlag = 1;
    data.docRequriedFlag = $.trim( $('#req_flg').val() );
    data.minFreightAmount = $.trim( $('#min_freight_amt').val() );
    if ($("#req_flg").is(':checked')) {
        data.docRequriedFlag = 1;
    } else {
        data.docRequriedFlag = 0;
    }
    data.defaultRate = $.trim( $('#def_rate').val() );
//    data.description = $.trim( $('#desc').val() );
    data.code = $('#code').val();
    data.name = $.trim( $('#name').val() );
    data.defaultHandlingRate = $.trim( $('#def_hnd_rate').val() );
    data.gstExemptedFlag = $('#gstExemptedFlag').is(':checked');
    var descriptions = [];
    
    $('#desc-table tbody tr').each(function (i, row) {
        var $eventrow = $(row);
        if ($eventrow.find('.desc').val().trim()) {
            descriptions.push($eventrow.find('.desc').val().trim());
        }
    });
        
        data.description = descriptions;
    
    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    }
    if ($('#def_rate').val() == '') {
        $('#def_rate').addClass('inp_error');
        err++;
    }
    if ($('#def_hnd_rate').val() == '') {
        $('#def_hnd_rate').addClass('inp_error');
        err++;
    }

    if (data.minFreightAmount != '' && (Number(data.minFreightAmount) > Number(data.defaultRate) || data.minFreightAmount < 0)) {
        $('#min_freight_amt').addClass('inp_error');
        $('#itm-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#itm-form-action-state').html('Minimum Freight Amount should be less than Default Rate and greater than 0');
        $('#itm-form-action-state').show();
        return false;
    }

    if (err > 0) {
        $('#itm-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#itm-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#itm-form-action-state').show();
        return false;
    } else {
        $('#itm-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#itm-form-action-state').hide();
    }

    $('#form-bttons').hide();
    $('#itm-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#itm-form-action-state').html(loading_popup);
    $('#itm-form-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/update-items",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#itm-form-action-state').removeClass('alert-danger');
                $('#itm-form-action-state').addClass('alert-success');
                $('#itm-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelItems();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#itm-form-action-state').addClass('alert-danger');
                $('#itm-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}

function deleteItems(options) {
    if (confirm('Do you want to delete this item ?')) {
        var data = {};
        data.code = options.code;
        data.name = options.name;
        data.activeFlag = 2;
        data.docRequriedFlag = $('#req_flg').val();
        if (options.docRequriedFlag == 1) {
            data.docRequriedFlag = 1;
        } else {
            data.docRequriedFlag = 0;
        }
        data.defaultRate = options.defaultRate;
        data.description = options.description;
        data.defaultHandlingRate = options.defaultHandlingRate;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-items",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#item_' + options.code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove();
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
                    checkURL();
                    return;
                }, 2000);
            }
        })
    }
}

function cancelItems() {
    $('#cargo-item-dialog').dialog('destroy');
    $('#cargo-item-dialog').hide();
}


function grpDialog(option) {
    $('#grp_name').removeClass('inp_error');
    $('#grp-dialog').css('background', '#fff');
    $('#grp-form-bttons').show();
    $('#grp-dialog').show();
    $('#grp_name').val('');
    $('#grp_code').val('');
    $('#grp-dialog').removeClass('hide');
    $('#grp-action-state').html('');
    $('#grp-action-state').hide();
    $('#grp-dialog').dialog({
        autoOpen: true,
        width: 600,
        maxWidth: 600,
        height: 200,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    $('#txt_am_name,#aid_am_code').val('');
    if (_isdefined(option)) {
        $('#grp_name').val(option.name);
        $('#grp_code').val(option.code);
    }
}

function saveGroup() {
    var data = {};
    data.activeFlag = 1;
    data.code = $('#grp_code').val();
    data.name = $('#grp_name').val();
    var err = 0;
    if ($('#grp_name').val() == '') {
        $('#grp_name').addClass('inp_error');
        err++;
    } else {
        $('#grp_name').removeClass('inp_error');
    }
    if (err > 0) {
        $('#grp-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#grp-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#grp-action-state').show();
        return false;
    } else {
        $('#grp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#grp-action-state').hide();
    }

    $('#grp-form-bttons').hide();
    $('#grp-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#grp-action-state').html(loading_popup);
    $('#grp-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/add-groups",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#grp-form-bttons').hide();
                $('#grp-action-state').removeClass('alert-danger');
                $('#grp-action-state').addClass('alert-success');
                $('#grp-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelGroup();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#grp-action-state').addClass('alert-danger');
                $('#grp-action-state').html(response.errorDesc);
                $('#grp-form-bttons').show();
            }
        }
    })
}

function deleteGroup(code, name) {
    if (confirm('Do you want to delete this group ?')) {
        var data = {};
        data.code = code;
        data.name = name;
        data.activeFlag = 0;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/add-groups",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#grp-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
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

function cancelGroup() {
    $('#grp-dialog').dialog('destroy');
    $('#grp-dialog').hide();
}

function customerDialog(option) {
    $('#cust_name, #cust_group, #cust_company, #cust_mobile, #cust_mode, #cust_gstin, #cust_email').val('');
    $('#cust_station').val(null).trigger("change");
    $('.inp_error').removeClass('inp_error');
    $('#cust-action-state').html('');
    $('#cust-action-state').hide();
    $('#cust-form-buttons').show();
    $('#customer-dialog').dialog({
        autoOpen: true,
        width: 600,
        maxWidth: 600,
        height: 490,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();

    if (_isdefined(option)) {
        // $.each(customerlist, function (keys, values) {
        //     if (values.code == option) {
                var opt = JSON.parse(option);
                $('#cust_code').val(opt.code);
                $('#cust_role').val(opt.role.code);
                $('#cust_ref_code').val(opt.referenceCode);
                $('#cust_name').val(opt.name);
                if (opt.group != 'undefined') {
                    $('#cust_group').val(opt.group);
                }
                $('#cust_mobile').val(opt.mobileNumber);
                $('#cust_mode').val(opt.preferedPaymentType);
                $('#cust_gstin').val(opt.gstin);
                $('#cust_company').val(opt.companyName);
                $('#cust_email').val(opt.email);
                
                var station = [];
                $.each(opt.station, function( key, value ) {
                    station.push(value.code)
                });
                if(station.length > 0){
                    $('#cust_station').val(station).trigger('change');
                }else{
                    $('#cust_station').val(null).trigger('change');
                }                
        //     }
        // });
    }

}

function saveCustomer() {
    var data = {};
    data.activeFlag = 1;
    data.code = $('#cust_code').val();
    data.name = $.trim($('#cust_name').val());
    data.group = $('#cust_group').val();
    data.company = $.trim($('#cust_company').val());
    data.mobile = $.trim($('#cust_mobile').val());
    data.mode = $('#cust_mode').val();
    data.gstin = $.trim($('#cust_gstin').val());
    data.email = $.trim($('#cust_email').val());
    
    data.stations = [];
    $($('#cust_station').val()).each(function (i, row) {
           data.stations.push({ code : row });
    });

    data.role = {};
    data.role.code = $('#cust_role').val();

    data.referenceCode = $('#cust_ref_code').val();
    
    var err = 0;
    if (data.name == '') {
        $('#cust_name').addClass('inp_error');
        err++;
    } else {
        $('#cust_name').removeClass('inp_error');
    }
    if (data.group == '') {
        $('#cust_group').addClass('inp_error');
        err++;
    } else {
        $('#cust_group').removeClass('inp_error');
    }
    if (data.company == '') {
        $('#cust_company').addClass('inp_error');
        err++;
    } else {
        $('#cust_company').removeClass('inp_error');
    }
    if (data.mobile == '') {
        $('#cust_mobile').addClass('inp_error');
        err++;
    } else {
        $('#cust_mobile').removeClass('inp_error');
    }
    if ($('#cust_mode').val() == '') {
        $('#cust_mode').addClass('inp_error');
        err++;
    } else {
        $('#cust_mode').removeClass('inp_error');
    }
    if (data.stations.length <= 0) {
        $('#cust_station').addClass('inp_error');
        err++;
    } else {
        $('#cust_station').removeClass('inp_error');
    }
    if (isNotNull(data.email) && !isValidEmailAddress(data.email)) {
        $('#cust_email').addClass('inp_error');
        err++;
    } else {
        $('#cust_email').removeClass('inp_error');
    }
    
    if(data.gstin != ''){
        if(!isValidGstNumber(data.gstin)) {
            $('#cust_gstin').addClass('inp_error');
            err++;   
        }else{
            $('#cust_gstin').removeClass('inp_error');
        }        
    }else{
        $('#cust_gstin').addClass('inp_error');
        err++;
    } 
    
    if (err > 0) {
        $('#cust-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#cust-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#cust-action-state').show();
        return false;
    } else {
        $('#cust-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#cust-action-state').hide();
    }
    $('#cust-form-buttons').hide();
    $('#cust-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#cust-action-state').html(loading_popup);
    $('#cust-action-state').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/add-customers",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#cust-form-buttons').hide();
                $('#cust-action-state').removeClass('alert-danger');
                $('#cust-action-state').addClass('alert-success');
                $('#cust-action-state').html('Your request has been completed successfully');
                if (data.code != '') {
                    custView(data.code);
                }
                window.setTimeout(function () {
                    cancelCustomer();
                    if (data.code == '') {
                        checkURL();
                    }
                }, 3000);
            } else {
                $('#cust-action-state').addClass('alert-danger');
                $('#cust-action-state').html(response.errorDesc);
                $('#cust-form-buttons').show();
            }
        }
    })
}

function cancelCustomer() {
    $('#customer-dialog').dialog('destroy');
    $('#customer-dialog').hide();
}


function custView(code) {
    $('#cst-viw-rslt').html('<div align="left">' + loading_big + '</div>');
    $('.li_bk').removeClass('li_bk');
    
    // $.each(customerlist, function (keys, values) {
    //     if (values.code == code) {
           

            var data = {}
            data.customerCode = code;
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/get-customer",
                data: data,
                async: true,
                success: function (response) {
                    var res = response.data;

                    var pay = '';
                    if (res.preferedPaymentType == 'TOP') {
                        pay = 'Payment To Pay';
                    }
                    if (res.preferedPaymentType == 'INP') {
                        pay = 'Payment Invoice/Acc Pay';
                    }
                    if (res.preferedPaymentType == 'PAD') {
                        pay = 'Payment Paid';
                    }

                    var usr = $('#customer_detail_view').html();
                    usr = $('<div>').html(usr).clone();
                    usr.find('.viw_name').text(res.name);
                    usr.find('.cmp_name').text(res.companyName);
                    usr.find('.mobile').text(res.mobileNumber);
                    usr.find('.role').text(res.role.name);
                    usr.find('.ref').text(res.referenceCode);
                    usr.find('.gst_no').text((res.gstin)? res.gstin: '-');
                    usr.find('.email').text(res.email);
                    $('#custo_id').val(res.code);
                    usr.find('.payment').text(pay);
                    usr.find('.edt').attr("onclick", "customerDialog('" + JSON.stringify(res) + "')");
                    usr.find('.del').attr("onclick", "deleteCustomer('" + code + "')");//delete
                    usr.find('.addr').attr("onclick", "addressDialog()");//address

                    $('#cst-viw-rslt').html(usr);
                    $('#usr-' + code).addClass('li_bk');
                    $('#cst-viw-rslt').append('<span id="load"><br><br>' + loading_popup + '</span>');
                    
                    if(res.station.length){
                        var html = '<ul class="p_l_15">';            
                        $.each(res.station, function( key, value ) {
                            html += '<li>'+value.name+'</li>';
                            $('#popup_msg').html(""+value.name+" <span class='badge badge-info'></span>");
                        });    
                        html += '</ul>';            
                        $('#popup_msg span').text(res.station.length); 

                        $('[data-toggle=popover]').popover({
                            container: "body",
                            html: true,
                            content: html,
                        });                
                    }else{
                        $('.stations').text('-');
                    }

                    // get user address //
                    var data = {}
                    data.usrCode = code;
                    $.ajax({
                        type: "POST",
                        dataType: 'html',
                        url: base_url + "cargo/get-customer-address",
                        data: data,
                        async: true,
                        success: function (response) {
                            $('#load').html('');
                            $('#cst-viw-rslt').append(response);
        //                    $("#cst_adr").css({
        //                        'max-height': '200px',
        //                    }).perfectScrollbar({
        //                        wheelSpeed: 20,
        //                        wheelPropagation: false,
        //                        suppressScrollX: true,
        //                    });
                        }
                    });

                    // end address function //
                }
            });
        // }
    // });
}

function editCustomerStatus(code, obj) {
    var data = {};
    data.code = code;
    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/edit-status-customer",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('.edt').hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                } else {
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
            window.setTimeout(function () {
                loading_overlay.hide();
            }, 2000);
        }
    })
}

function deleteCustomer(code) {
    if (confirm('Do you want to delete this customer?')) {
        var data = {};
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/delete-customer",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#usr-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove();
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#cst-viw-rslt').html('<div class="p_t_100"><div class="well well-large "> Click any of the customer name to view more details.</div></div>');
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

function addressDialog(option) {
    $('#addr_name, #addr1, #addr2, #landmark, #pincode').val('');
    $('#addr_station').val('').trigger('change');
    $('.inp_error').removeClass('inp_error');
    $('#addr-action-state').html('');
    $('#addr-action-state').hide();
    $('#addr-form-buttons').show();
    $('#address-dialog').dialog({
        autoOpen: true,
        width: 700,
        maxWidth: 700,
        height: 400,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    $('#addr_user_id').val($('#custo_id').val());
    if (_isdefined(option)) {
        $('#addr_name').blur();
        $('#addr_code').val(option.code);
        $('#addr_name').val(option.name);
        $('#addr_station').val(option.station.code).trigger('change');
        $('#addr1').val(option.address1);
        $('#addr2').val(option.address2);
        $('#pincode').val(option.pincode);
        $('#landmark').val(option.landmark);
    }
}

function deleteCustomerAddress(option) {
    if (confirm('Do you want to delete this customer address?')) {
        var data = {};
        data.code = option.code;
        data.activeFlag = 2;
        data.user_id = $('#custo_id').val();
        data.name = option.name;
        data.station = option.station.code;
        data.addr1 = option.address1;
        data.addr2 = option.address2;
        data.pincode = option.pincode;
        data.landmark = option.landmark;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/add-address",
            data: data,
            success: function (response) {
                if (response.status == 1) {
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
                    checkURL();
                    // $('#usr-viw-' + $('#custo_id').val()).trigger('click');
                }, 2000);
            }
        })
    }
}

function saveAddress() {
    var data = {};
    data.activeFlag = 1;
    data.code = $('#addr_code').val();
    data.name = $.trim($('#addr_name').val());
    data.station = $('#addr_station').val();
    data.addr1 = $.trim($('#addr1').val());
    data.addr2 = $.trim($('#addr2').val());
    data.user_id = $('#addr_user_id').val();
    data.pincode = $.trim($('#pincode').val());
    data.landmark = $.trim($('#landmark').val());
    var err = 0;
    if (data.name == '') {
        $('#addr_name').addClass('inp_error');
        err++;
    } else {
        $('#addr_name').removeClass('inp_error');
    }
    if ($('#addr_station').val() == '') {
        $('#addr_station').addClass('inp_error');
        err++;
    } else {
        $('#addr_station').removeClass('inp_error');
    }
    if (data.addr1 == '') {
        $('#addr1').addClass('inp_error');
        err++;
    } else {
        $('#addr1').removeClass('inp_error');
    }
    if (data.addr2 == '') {
        $('#addr2').addClass('inp_error');
        err++;
    } else {
        $('#addr2').removeClass('inp_error');
    }
    if (data.pincode == '') {
        $('#pincode').addClass('inp_error');
        err++;
    } else {
        $('#pincode').removeClass('inp_error');
    }
    if (data.landmark == '') {
        $('#landmark').addClass('inp_error');
        err++;
    } else {
        $('#landmark').removeClass('inp_error');
    }

    if (err > 0) {
        $('#addr-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#addr-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#addr-action-state').show();
        return false;
    } else {
        $('#addr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#addr-action-state').hide();
    }
    $('#addr-form-buttons').hide();
    $('#addr-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#addr-action-state').html(loading_popup);
    $('#addr-action-state').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/add-address",
        data: data,
        success: function (response) {
            if (response.status == 1) {
                $('#addr-form-buttons').hide();
                $('#addr-action-state').removeClass('alert-danger');
                $('#addr-action-state').addClass('alert-success');
                $('#addr-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    cancelAddress();
                    custView(data.user_id);
                }, 3000);
            } else {
                $('#addr-action-state').addClass('alert-danger');
                $('#addr-action-state').html(response.errorDesc);
                $('#addr-form-buttons').show();
            }
        }
    })
}

function cancelAddress() {
    $('#address-dialog').dialog('destroy');
    $('#address-dialog').hide();
}  

//  From booking page
function formatCustomerAddress(type, mobileNumber) {
    var doorPickupEnabled = (type == 1 && $('#door-pickup').is(':checked'));
    var doorDeliveryEnabled = (type == 2 && $('#ddtype-btn-group [name="dd-type"]').is(':checked'));

    if (cargoSetting.showCustomerAddressFlag && (doorPickupEnabled || doorDeliveryEnabled || cargoSetting.mandateAddressOnBookingFlag)) {
        var data = {};
        data.customerMobile = mobileNumber;

        if (!isValidPhonenumber(data.customerMobile)) {
            return;
        }

        var paytype = getPaymentType();
        if (cargoSetting.userAccountModel.code == 'TXRT' && ((paytype == 'INP' && type == '1') || (paytype == 'OATP' && type == '2'))) {
            data.vendorCode = $('#vendor_users').val();

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/get-vendor-address-for-booking',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        setAddress(type, response.data || []);
    
                        $('.row-address-dropdown-' + type).trigger('customerAddressLoaded', [response.data || []]);
                    }
                }
            });
        } else {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'cargo/get-customer-address-for-booking',
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        setAddress(type, response.data || []);
    
                        $('.row-address-dropdown-' + type).trigger('customerAddressLoaded', [response.data || []]);
                    }
                }
            });
        }
    }
}

function setAddress(type, res = []) {
    var doorPickupEnabled = (type == 1 && $('#door-pickup').is(':checked'));
    var doorDeliveryEnabled = (type == 2 && $('#ddtype-btn-group [name="dd-type"]').is(':checked'));

    if (cargoSetting.showCustomerAddressFlag && (doorPickupEnabled || doorDeliveryEnabled || cargoSetting.mandateAddressOnBookingFlag)) {
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

        var paytype = getPaymentType();
        if (cargoSetting.mandateAddressOnBookingFlag == false || !((paytype == 'INP' && type == '1') || (paytype == 'OATP' && type == '2'))) {
            html += '<li><label>';
            html += '<input type="radio" name="addr-rb-' + type + '" class="pick' + type + '" data-code ="other"> [Add New]';
            html += '</label></li>';
        }

        $('.address-dropdown-' + type).html(html);

        $('.pick' + type).on('change', function () {
            var addressCode = $(this).data('code');
            var address = _.find(res || [], o => o.code == addressCode);

            openAddressComponents(type, address);
            setTimeout(function() {
                $('#dropdownMenu' + type).focus().closest('.dropdown.open').removeClass('open');
                // $('.address-dropdown-' + type).siblings('[data-toggle="dropdown"]').dropdown('toggle').focus();
            }, 750);
        });

        if (!res.length || cargoSetting.mandateAddressOnBookingFlag) {
            $('.pick' + type + '[data-code ="other"]').prop('checked', true);
        }
        openAddressComponents(type);
    }
}

function openAddressComponents(code, address) {
    if ($('.pick' + code + ':checked').data('code') == 'other') {
        if (code == 1) {
            $('.from-address-components').removeClass('hide');
            $('#from-address-details').addClass('hide');

            var from = $('#from_branch').select2('data');
            $('#fr_addr_station').val(from && from.station.code);
        } else if (code == 2) {
            $('.to-address-components').removeClass('hide');
            $('#to-address-details').addClass('hide');

            var to = $('#to_branch').select2('data');
            $('#to_addr_station').val(to && to.station.code);
        }
        getAllInputs();
    } else {
        if (code == 1) {
            $('.from-address-components').addClass('hide');
            $('#from-address-details').addClass('hide');

            if (address) {
                var content = _.filter([address.address1, address.address2, address.landmark]);
                content += '<br/>' + address.station.name + ' - ' + address.pincode;
                $('#from-address-details').html(content).removeClass('hide');
            }
        } else if (code == 2) {
            $('.to-address-components').addClass('hide');
            $('#to-address-details').addClass('hide');

            if (address) {
                var content = _.filter([address.address1, address.address2, address.landmark]);
                content += '<br/>' + address.station.name + ' - ' + address.pincode;
                $('#to-address-details').html(content).removeClass('hide');
            }
        }
    }
}

function initAddressDialog(type) {
    $('#c_address1,#c_address2,#c_city,#c_state, #c_pincode, #c_landmark').val('');
    $('.inp_error').removeClass('inp_error');
    
    $('#addr-action-state').html('');
    $('#addr-action-state').hide();
    $('#addr-form-buttons').show();
    $('#address-dialog').dialog({
        autoOpen: true,
        width: 600,
        maxWidth: 600,
        height: 350,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    $('#c_add_type').val(type);
}

function saveBookingAddress() {    
    $('#c_address1,#c_address2,#c_city,#c_state, #c_pincode, #c_landmark').removeClass('inp_error');
    
    var data = {};
    var type = $('#c_add_type').val();
    data.address1 = $.trim($('#c_address1').val());
    data.address2 = $.trim($('#c_address2').val());
    data.city = $.trim($('#c_city').val());
    data.state = $.trim($('#c_state').val());
    data.pincode = $.trim($('#c_pincode').val());
    data.landmark = $.trim($('#c_landmark').val());
    var err = 0;
    
    if (data.address1 == '') {
        $('#c_address1').addClass('inp_error');
        err++;
    } 
    if (data.city == '') {
        $('#c_city').addClass('inp_error');
        err++;
    } 
    if (data.state == '') {
        $('#c_state').addClass('inp_error');
        err++;
    } 

    if (err > 0) {
        $('#addr-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#addr-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#addr-action-state').show();
        return false;
    } else {
        $('#addr-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#addr-action-state').hide();
    }
    $('#addr-form-buttons').hide();
    $('#addr-action-state').removeClass('alert-danger').removeClass('alert-success');    
               
    if(type==1) {   //  pickup address
        data.a_code = ''; 
        p_address = data;
    } else {    //  delivery address
        data.a_code = '';
        d_address = data; 
    }
}

function setupDoorPickup() {
    $('#pickup-charge-panel').addClass('hide');
    if ($('#door-pickup').is(':checked')) {
        $('#pickup-charge-panel').removeClass('hide');
        if (cargoSetting.showCustomerAddressFlag) {
            $('.row-address-dropdown-1').removeClass('hide');
            var mobileNumber = $('#from_phone').val();
            if (isValidPhonenumber(mobileNumber)) {
                formatCustomerAddress(1, mobileNumber);
            } else {
                setAddress(1)
            }
        }
    } else {
        if (!cargoSetting.mandateAddressOnBookingFlag) {
            $('.row-address-dropdown-1').addClass('hide');
            $('.pick1').prop('checked', false);
            $('.from-address-components').addClass('hide');
            $('#from-address-details').addClass('hide');
        }
        setAddress(1);
    }
    $('#dp_charges').val(0);
}

function setupDoorDelivery() {
    $('#delivery-charge-panel').addClass('hide');

    if ($('#ddtype-btn-group [name="dd-type"]').is(':checked')) {
        $('#delivery-charge-panel').removeClass('hide');
        if (cargoSetting.showCustomerAddressFlag) {
            $('.row-address-dropdown-2').removeClass('hide');
            var mobileNumber = $('#to_phone').val();
            if (isValidPhonenumber(mobileNumber)) {
                formatCustomerAddress(2, mobileNumber);
            } else {
                setAddress(2);
            }
        }
        var minvalue = $('#dd_charges').data('minvalue');
        $('#dd_charges').val(minvalue || 0);
    } else {
        if (!cargoSetting.mandateAddressOnBookingFlag) {
            $('.row-address-dropdown-2').addClass('hide');
            $('.pick2').prop('checked', false);
            $('.to-address-components').addClass('hide');
            $('#to-address-details').addClass('hide');
        }
        setAddress(2);
        $('#dd_charges').val(0);
    }
}

function findPrebookingLR() {
    var inpvalue = $.trim( $('#prebooking-find').val() );

    $('#lr-prebooking-code:hidden').val('');

    $('#prebooking-find').removeClass('inp_error');
    if (!inpvalue) {
        $('#prebooking-find').addClass('inp_error');
        return;
    }

    if (isValidPhonenumber(inpvalue)) {
        getPrebookingByMobile(inpvalue);
        return;
    }

    getPrebookingByCode(inpvalue);
}

function getPrebookingByCode(preBookCode) {
    var data = {};
    data.preBookCode = preBookCode;

    if (!data.preBookCode) return;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/get-prebooking-by-code",
        data: data,
        success: function (response) {
            if (response.status == 1 && response.data && response.data.length) {
                prefillBooking(response.data[0]);
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
            } else if (response.data && response.data.length == 0) {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "No data Found!"
                });
            } else {
                alert(response.errorDesc);
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
            }
            setTimeout(function () {
                loading_overlay.hide();
            }, 2000);
        }
    })
}

function getPrebookingByMobile(customerMobile) {
    var data = {};
    data.customerMobile = customerMobile;

    if (!data.customerMobile) return;

    if(!$('#dia-cargo-prebook').length) {
        $('<div id="dia-cargo-prebook" class="hide dialog-content-page"></div>').appendTo('body');
    }
    
    $('#dia-cargo-prebook').removeClass('hide');
    $('#dia-cargo-prebook').dialog({
        autoOpen: true,
        height: 500,
        width: 950,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();   
    $('#dia-cargo-prebook').html(loading_small);

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/get-prebooking-by-mobile",
        data: data,
        success: function (response) {
            $('#dia-cargo-prebook').html(response);
        }
    })
}

function closePrebookingDialog() {
    $('#dia-cargo-prebook').dialog('destroy');
    $('#dia-cargo-prebook').hide();
    $('#dia-cargo-prebook').html('');
}

function prefillBooking(data) {
    if (!data) return;

    $('#lr-prebooking-code:hidden').val(data.code);
    $('#from_branch').val(data.fromOrganization.code).trigger('change');
    toggleToBranch();
    togglePayType();
    toggleToPayType();
    togglePayTypeState();
    $('#door-pickup').prop('checked', data.pickupType && data.pickupType.code == 'PUDO').triggerHandler('click');
    $('#to_branch').val(data.toOrganization.code).trigger('change');

    $('#ddtype-btn-group [name="dd-type"]:checked').prop('checked', false);
    $('#ddtype-btn-group [name="dd-type"][value="' + data.deliveryType.code + '"]').trigger('click');
    $('#door-pickup').val(data.pickupType.code);
    $('#door-pickup').prop('checked', true).trigger('click');

    selectFromCustomer(data.fromCustomer);
    selectToCustomer(data.toCustomer);

    if (isNotNull(data.fromCustomerAddress.code)) {
        $('.row-address-dropdown-1').one('customerAddressLoaded', function () {
            $('.pick1[data-code="' + data.fromCustomerAddress.code + '"]').prop('checked', true).trigger('change');
        });
    }
    if (isNotNull(data.toCustomerAddress.code)) {
        $('.row-address-dropdown-2').one('customerAddressLoaded', function () {
            $('.pick2[data-code="' + data.toCustomerAddress.code + '"]').prop('checked', true).trigger('change');
        });
    }

    $('[name="pay_type_radio"][value="' + data.paymentType.code + '"]').prop('checked', true).trigger('change');

    resetArticles();
    $.each(data.itemDetails || [], function (i, item) {
        var $article = $('.article_row:last');
        $article.find('#code').val(item.cargoItem.code || '');
        $article.find('#name').val(item.cargoItem.name).autocomplete('close');
        $article.find('#article-desc').val(item.cargoItem.description[0]);
        $article.find('#article-unit').val(item.unit.code);
        $article.find('#article-unit-val').val(item.unitValue);
        $article.find('#actual-weight').val(item.actualUnitValue);
        $article.find('#qty').val(item.itemCount);
        $article.find('#price').val(item.fare);
        $article.find('#handling').val(item.loadingChargeAmount);
        $article.find('#unloading').val(item.unloadingChargeAmount);
        addArticleRow();
    });
    $('.article_row:last').find('#name').autocomplete('close');

    $('#dp_charges').val(data.pickupHandlingAmount);
    $('#dd_charges').val(data.deliveryHandlingAmount);

    $('#invoice-list').html('');
    $('#tr_add_invoice_btn').trigger('click')
    $('#vendor_users').val(data.vendorUser.code).trigger('change');
    $('#sender_gst').val(data.fromCustomerGST);
    $('#receiver_gst').val(data.toCustomerGST);
    $('#invoice-list .inv_amount').val(data.invoiceAmount);
    $('#invoice-list .inv_date').val(data.invoiceDate);
    $('#invoice-list .inv_number').val(data.invoiceNumber);

    $.each(data.cargoAddonsDetails || [], function (i, addon) {
        if (addon.addonsType.code == 'EWBL') {
            $('#invoice-list .e_way_bill_number').val(addon.value);
            // getEwayBillDetails('eway_bill');
        }
    });

    $('#booking-remarks').val(data.remarks);
    calculateAmounts();
}

function hasChanged(newData = '', oldData = '') {
    if (isNull(newData)) {
        return false;
    }

    return newData.trim().toLowerCase() != oldData.trim().toLowerCase();
}

function getManualLRNumber() {
    var data = {};

    var lrLoadType = $('[name="lr-load-type"]:checked').val();
    if (lrLoadType == 'RGL') {
        var fromOrgData = $('#from_branch').select2('data') || {};
        data.fromStation = {};
        data.fromStation.code = fromOrgData.station && fromOrgData.station.code;
        data.fromOrganization = {};
        data.fromOrganization.code = fromOrgData.code;
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var fromStationData = $('#from_station').select2('data');
        data.fromStation = {};
        data.fromStation.code = fromStationData && fromStationData.code;
        data.fromOrganization = {};
        data.fromOrganization.code = 'NA';
    }

    if (lrLoadType == 'RGL') {
        var toOrgData = $('#to_branch').select2('data') || {};
        data.toStation = {};
        data.toStation.code = toOrgData.station && toOrgData.station.code;
        data.toOrganization = {};
        data.toOrganization.code = toOrgData.code;
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var toStationData = $('#to_station').select2('data') || {};
        data.toStation = {};
        data.toStation.code = toStationData && toStationData.code;
        data.toOrganization = {};
        data.toOrganization.code = 'NA';
    }
    data.paymentType = {};
    data.paymentType.code = getPaymentType();

    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if(!data.fromStation.code || !data.fromOrganization.code) {
        $('#booking-action-state').html('Please select from branch');
        err++;
    }
    if(!data.toStation.code || !data.toOrganization.code) {
        $('#booking-action-state').html('Please select to branch');
        err++;
    }
    if(!data.paymentType.code) {
        $('#booking-action-state').html('Please select payment type');
        err++;
    }

    if (err > 0) {
        $('#manual-lr-prefix').html('');
        $('#booking-action-state').show();
        return false;
    }

    $('#confirm-booking-btn').attr('disabled', true);

    $('#booking-action-state').html('');
    $('#booking-action-state').hide();

    $('#manual-lr-status').removeClass('text-danger').removeClass('text-success');
    $('#manual-lr-prefix').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/get-manual-lr",
        data: data,
        success: function (response) {
            $('#confirm-booking-btn').attr('disabled', false);
            if (response.status == 1) {
                $('#manual-lr-status').addClass('text-success');
                $('#manual-lr-prefix').html(response.data.code || '')
                checkManualLRNumber();
            } else {
                $('#manual-lr-cb').prop('checked', false);
                $('#manual-lr-status').addClass('text-danger');
                $('#manual-lr-status').html(response.errorDesc);
            }
        }
    })
}

function checkManualLRNumber() {
    var data = {};

    var fromOrgData = $('#from_branch').select2('data') || {};
    data.fromStation = {};
    data.fromStation.code = fromOrgData.station && fromOrgData.station.code;
    data.fromOrganization = {};
    data.fromOrganization.code = fromOrgData.code;

    var toOrgData = $('#to_branch').select2('data') || {};
    data.toStation = {};
    data.toStation.code = toOrgData.station && toOrgData.station.code;
    data.toOrganization = {};
    data.toOrganization.code = toOrgData.code;

    data.paymentType = {};
    data.paymentType.code = getPaymentType();

    data.additionalAttribute = {};
    data.additionalAttribute.CARGO_POSTFIX_CODE = $.trim( $('#manual-lr-no').val() );

    if (!data.additionalAttribute.CARGO_POSTFIX_CODE || isNaN(data.additionalAttribute.CARGO_POSTFIX_CODE)) {
        $('#manual-lr-no').addClass('inp_error');
        $('#manual-lr-status').html('');
        return;
    }

    if ($('#manual-lr-prefix').text() == '') {
        return;
    }

    $('#manual-lr-no').removeClass('inp_error');

    $('#manual-lr-status').removeClass('text-danger').removeClass('text-success');
    $('#manual-lr-status').html(loading_popup);

    $('#confirm-booking-btn').attr('disabled', true);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/check-manual-lr-exists",
        data: data,
        success: function (response) {
            $('#confirm-booking-btn').attr('disabled', false);
            if (response.status == 1) {
                $('#manual-lr-status').addClass('text-success');
                $('#manual-lr-status').html('LR Number available');
            } else {
                $('#manual-lr-no').addClass('inp_error');
                $('#manual-lr-status').addClass('text-danger');
                $('#manual-lr-status').html(response.errorDesc);
            }
        }
    })
}

function getNextLrSequence() {
    var data = {};

    var lrLoadType = $('[name="lr-load-type"]:checked').val();
    if (lrLoadType == 'RGL') {
        var fromOrgData = $('#from_branch').select2('data') || {};
        data.fromStation = {};
        data.fromStation.code = fromOrgData.station && fromOrgData.station.code;
        data.fromOrganization = {};
        data.fromOrganization.code = fromOrgData.code;
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var fromStationData = $('#from_station').select2('data');
        data.fromStation = {};
        data.fromStation.code = fromStationData && fromStationData.code;
        data.fromOrganization = {};
        data.fromOrganization.code = 'NA';
    }

    if (lrLoadType == 'RGL') {
        var toOrgData = $('#to_branch').select2('data') || {};
        data.toStation = {};
        data.toStation.code = toOrgData.station && toOrgData.station.code;
        data.toOrganization = {};
        data.toOrganization.code = toOrgData.code;
    } else if (lrLoadType == 'FTL' || lrLoadType == 'PTL') {
        var toStationData = $('#to_station').select2('data') || {};
        data.toStation = {};
        data.toStation.code = toStationData && toStationData.code;
        data.toOrganization = {};
        data.toOrganization.code = 'NA';
    }

    data.paymentType = {};
    data.paymentType.code = getPaymentType();

    data.vendorUser = {};
    data.vendorUser.code = $('#vendor_users').val();
    
    var fromCustomer = $('#from_phone').data('customerData');
    data.fromCustomer = {};
    if (fromCustomer) {
        data.fromCustomer.code = fromCustomer.code;
        data.fromCustomer.name = fromCustomer.name;
    }
    data.fromCustomer.mobileNumber = $.trim( $('#from_phone').val() );
    
    var toCustomer = $('#to_phone').data('customerData');
    data.toCustomer = {};
    if (toCustomer) {
        data.toCustomer.code = toCustomer.code;
        data.toCustomer.name = toCustomer.name;
    }
    data.toCustomer.mobileNumber = $.trim( $('#to_phone').val() );

    data.additionalAttribute = {};
    data.additionalAttribute.fromCustomerGstType = $('#sender-gst-type [name="sender-gst-type"]:checked').val();
    data.additionalAttribute.toCustomerGstType = $('#receiver-gst-type [name="receiver-gst-type"]:checked').val();
    data.additionalAttribute.CARGO_PRE_BOOK_CODE = $('#lr-prebooking-code:hidden').val();
    data.additionalAttribute.LOAD_TYPE = lrLoadType
    data.additionalAttribute.SHIPMENT_TYPE = $.trim( $('[name="lr-shipment-type"]:checked').val() );
    data.additionalAttribute.SEQUENCE_TYPE = $.trim( $('[name="lr-no-type"]:checked').val() );
    
    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if(!data.fromStation.code || !data.fromOrganization.code) {
        $('#booking-action-state').html('Please select from branch');
        err++;
    }
    if(!data.toStation.code || !data.toOrganization.code) {
        $('#booking-action-state').html('Please select to branch');
        err++;
    }
    if(!data.paymentType.code) {
        $('#booking-action-state').html('Please select payment type');
        err++;
    }

    // if(!data.vendorUser.code) {
    //     $('#booking-action-state').html('Please select a vendor');
    //     err++;
    // }

    if($('#from_name').val() == "") {
        $('#booking-action-state').html('Please enter valid sender name');
        err++;
    }

    if($('#to_name').val() == "") {
        $('#booking-action-state').html('Please enter valid recipient name');
        err++;
    }

    if (err > 0) {
        $('#next-lr-sequence').html('');
        $('#booking-action-state').show();
        return false;
    }

    $('#confirm-booking-btn').attr('disabled', true);

    $('#booking-action-state').html('');
    $('#booking-action-state').hide();

    $('#next-lr-sequence').html(loading_popup);

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "cargo/generate-next-lr-sequence",
        data: data,
        success: function (response) {
            $('#confirm-booking-btn').attr('disabled', false);
            if (response.status == 1) {
                $('#next-lr-sequence').html(('<i class="fa fa-info-circle" title="Next Lr Sequence"></i> <span class="h5 bold">' + response.data.code + '</span>') || '')
            } else {
                $('#booking-action-state').html(response.errorDesc);
            }
        }
    })
}

function init_customer_actions(){
    const customerBhTokenizer = Bloodhound.tokenizers.obj.whitespace('mobileNumber', 'name', 'gstin', 'companyName');
    const CUSTOMERSBH = new Bloodhound({
        datumTokenizer: function (d) {
            let tokens = customerBhTokenizer(d), result = [];
            for (let token of tokens) {
                for (let i = 0; i < token.length; i++) {
                    result.push(token.substr(i, token.length));
                }
            }
            return result;
        },
        queryTokenizer: Bloodhound.tokenizers.ngram,
        sufficient: 8,
        indexRemote: true,
        initialize: false,
        identify: function (obj) {
            return obj.code;
        },
        prefetch: {
            url: base_url + 'cargo/suggest-station-customers',
            cacheKey: 'station_customers',
            thumbprint: ns + ':' + userStationCode + ':v5',
            transform: function (response) {
                if (response.status != 1 || !response.data || response.data.length == 0) return;
                return response.data;
            },
            prepare: function (settings) {
                settings.type = 'POST';
                settings.data = {};
                settings.data.stations = [userStationCode];

                return settings;
            }
        },
        remote: {
            url: base_url + 'cargo/suggest-station-customers',
            prepare: function (query, settings) {
                var frombranch = $('#customer-branch').val();
                
                settings.type = 'POST';
                settings.data = {};
                settings.data.query = query.toUpperCase();
                settings.data.stations = [frombranch];

                return settings;
            },
            transport: function (options, onSuccess, onError) {
                if (!options.data.stations.length || (!isValidPhonenumber(options.data.query) && !isValidGstin(options.data.query) && options.data.query.replace(/ /g, '').length > 7)) {
                    onError('Request Cancelled');
                    return;
                }

                $.ajax(options)
                    .done(function(data, textStatus, request) { onSuccess(data); })
                    .fail(function(request, textStatus, errorThrown) { onError(errorThrown); });
            },
            transform: function (response) {
                if (response.status != 1) return;
                return response.data;
            }
        },
    });

    Object.assign(CUSTOMERSBH.index, {
        serialize: function() {
            return {
                datums: btoa(JSON.stringify(this.datums)),
                trie: this.trie
            }
        },
        bootstrap: function(a) {
            this.datums = JSON.parse(atob(a.datums)),
            this.trie = a.trie
        }
    });

    CUSTOMERSBH.initialize();

    $('#cust_search').on('input', function(e) {
        // CUSTOMERSBH.sufficient = Math.ceil((10 - this.value.length) / 2);
        $(this).data('customerData', null);
    }).on('blur', function(e) {
        let $this = $(this);
        if ($.trim(e.target.value).length < 10 || $this.data('customerData')) {
            return;
        }

        var matches = CUSTOMERSBH.index.search($.trim(e.target.value));
        $.each(matches || [], function (i, match) {
            $this.data('customerData', match);
        });
    });
    var _deepSearched = {};

    const ttOptions = {
        highlight: true,
    };
    const ttTemplates = {
        notFound: function(data) {
            var $tpl = $('<div class="empty-message">&ensp;No matches found.</div>');
            if (data.query.length > 3 && (isValidPhonenumber(data.query) || isValidGstNumber(data.query)) && !_deepSearched[data.query]) {
                $tpl.append('&emsp;<a href="javascript:;" class="tt-deep-search" data-query="' + data.query + '"><i class="fa fa-search"></i> Advanced Find</a>');
            }

            return $tpl;
        },
        suggestion: function(data) {
            var company = '', role = '';
            if (data.role == 'RAC') {
                role += '<span class="small pull-right"><span class="label label-success" title="Registered Account Customer">RAC</span></span>';
            } else if (data.role == 'CMPY') {
                company += '<small title="Company Name">' + data.companyName + '</small><br/>';
                role += '<span class="small pull-right"><span class="label label-success" title="Company">CMPY</span></span>';
            }

            return `<div><b class="text-break">${data.name}</b>${role}<br/>${company}<span class="text-muted"><small>${data.mobileNumber}</small><small class="pull-right">${data.gstin}</small></span></div>`;
        }
    };

    $('#cust_search').typeahead(ttOptions, {
        name: 'customSearch',
        displayKey: 'name',
        source: CUSTOMERSBH.ttAdapter(),
        templates: ttTemplates,
        minLength: 0,
        limit: 100
    }).on('typeahead:selected', function (e, d, n) {
        $('#cust_search').data('customerData', d);
        // $('#cust_search').typeahead('val', d.mobileNumber);
        // $('#cust_search').typeahead('val', d.name);
        custView(d.code);
    });

    $('#cust_search').on('typeahead:asyncrequest', function () {
        $(this).addClass('tt-loading').removeClass('tt-loading', 4000);
    }).on('focus blur typeahead:asynccancel typeahead:asyncreceive', function () {
        $(this).removeClass('tt-loading');
    });

    $('.twitter-typeahead').on('click', '.tt-deep-search', function (e) {
        var $ttinput = $(e.delegateTarget).find('input.tt-input');
        var query = $.trim($(this).data('query'));
        if (query.length < 3) {
            return;
        }

        var data = {};
        if (isValidPhonenumber(query)) {
            data.mobileNumber = query;
        } else if (isValidGstNumber(query)) {
            data.gstin = query;
        } else {
            data.customerName = query;
        }

        var loading_overlay = iosOverlay({
            text: 'Finding...',
            icon: 'fa fa-spinner fa-spin'
        });
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'cargo/get-customers-by-reference',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    _deepSearched[query] = 1;
                    CUSTOMERSBH.add(response.data);
                    $ttinput.typeahead('val', '  ').trigger('keypress').typeahead('val', query);

                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success!'
                    });
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Sorry!'
                    });
                }
                setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        });
    });
}

function getGSTDetails(type) {
    var $input = $('#' + type + '_gst');
    var $button = $('#' + type + '-gst-validate-btn');
    var $hint = $('#' + type + '-gst-hint');

    var data = {};
    data.gstin = $.trim( $input.val() );

    // if (!isValidGstNumber(data.gstin)) {
    //     $hint.html('<div class="text-danger small">Invalid GST Identification Number</div>');
    //     return;
    // }

    $button.prop('disabled', true);
    $hint.html(loading_small);

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/get-gst-details-hint",
        data: data,
        success: function (response) {
            $button.prop('disabled', false);
            $hint.html(response);
        }
    })
}

function getEwayBillDetails(type) {
    var $input = $('#' + type);
    var $button = $('#' + type + '_validate_btn');
    var $hint = $('#' + type + '_details');

    var data = {};
    data.ewayBillNo = $.trim( $input.val() );

    if (isNull(data.ewayBillNo)) {
        $hint.html('<div class="text-danger small">Invalid E-Way Bill Number</div>');
        return;
    }

    $button.prop('disabled', true);
    $hint.html(loading_small);

    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "cargo/get-ewaybill-details",
        data: data,
        success: function (response) {
            $button.prop('disabled', false);
            $hint.html(response);
            
            var duplicate = 0;
            $('#invoice-list .invoice-row').each(function () {
                var ewayBillNumber = $.trim($(this).find('.e_way_bill_number').val());
                if (data.ewayBillNo == ewayBillNumber) {
                    duplicate += 1;
                }
            });

            if (ewayBillDetails && isNotNull(ewayBillDetails.ewayBillNo) && (duplicate == 0)) {
                var $tpl = addInvoiceRow();

                if ($tpl) {
                    $tpl.find('.e_way_bill_number').val(data.ewayBillNo);
                    $tpl.find('.inv_number').val(ewayBillDetails.documentNo || '');
                    $tpl.find('.inv_amount').val(ewayBillDetails.totalInvoiceValue || '');
                    $tpl.find('.inv_date').val(moment(ewayBillDetails.documentDate, 'YYYY-MM-DD').format('DD-MM-YYYY'));
                    calculateAmounts();
                }
            }
        }
    })
}

function checkDuplicateEwayBill(ele) {
    var ewayBill = $(ele).val();
    var curentRow = $(ele).closest("tr").index();

    var ewayBillNumberArray = [];
    $('#invoice-list .invoice-row').each(function(index, val) {
        var ewayBill = $.trim($(val).find('.e_way_bill_number').val());
        if (index != curentRow) {
            ewayBillNumberArray.push(ewayBill);
        }
    })
    
    if ($.inArray(ewayBill, ewayBillNumberArray) != -1) {
        $(ele).val('');
    }
}

function prefillLRData(data, swapFromTo = false) {
    if (!data) return;

    var fromOrganization = data.fromOrganization;
    var toOrganization = data.toOrganization;
    var fromCustomer = data.fromCustomer;
    var toCustomer = data.toCustomer;
    if (swapFromTo) {
        fromOrganization = data.toOrganization;
        toOrganization = data.fromOrganization;
        fromCustomer = data.toCustomer;
        toCustomer = data.fromCustomer;
    }

    $('#lr-reference-code:hidden').val(data.code);
    $('#from_branch').val(fromOrganization.code).trigger('change');
    toggleToBranch();
    togglePayType();
    $('#door-pickup').prop('checked', data.pickupType && data.pickupType.code == 'PUDO').triggerHandler('click');
    $('#to_branch').val(toOrganization.code).trigger('change');
    $('#ddtype-btn-group [name="dd-type"]:checked').prop('checked', false);
    $('#ddtype-btn-group [name="dd-type"][value="' + data.deliveryType.code + '"]').trigger('click');
    $('[name="door-pickup"][value="' + data.pickupType.code + '"]').trigger('click');

    $('[name="pay_type_radio"][value="' + data.paymentType.code + '"]').prop('checked', true).trigger('change');
    selectFromCustomer(fromCustomer);
    selectToCustomer(toCustomer);

    if (isNotNull(data.fromCustomerAddress.code)) {
        $('.row-address-dropdown-1').one('customerAddressLoaded', function () {
            $('.pick1[data-code="' + data.fromCustomerAddress.code + '"]').prop('checked', true).trigger('change');
        });
    }
    if (isNotNull(data.toCustomerAddress.code)) {
        $('.row-address-dropdown-2').one('customerAddressLoaded', function () {
            $('.pick2[data-code="' + data.toCustomerAddress.code + '"]').prop('checked', true).trigger('change');
        });
    }

    $('#vendor_users').val(data.vendorUser.code).trigger('change');

    resetArticles();
    $.each(data.itemDetails || [], function (i, item) {
        var $article = $('.article_row:last');

        $article.find('#code').val(item.cargoItem.code || '');
        $article.find('#name').val(item.cargoItem.name).autocomplete('close');
        $article.find('#article-desc').val(item.cargoItem.description[0]);
        $article.find('#article-unit').val(item.unit.code);
        $article.find('#article-unit-val').val(item.unitValue);
        $article.find('#actual-weight').val(item.actualUnitValue);
        $article.find('#qty').val(item.itemCount);
        $article.find('#price').val(item.fare);
        $article.find('#handling').val(item.loadingChargeAmount);
        $article.find('#unloading').val(item.unloadingChargeAmount);
        addArticleRow();
    });
    $('.article_row:last').find('#name').autocomplete('close');

    $('#hamali_charges').val(data.hamaliCharge);
    $('#pass_charges').val(data.passCharge);
    $('#docket_charges').val(data.docketCharge);
    $('#service_charges').val(data.serviceCharge);
    $('#dp_charges').val(data.pickupHandlingAmount);
    $('#dd_charges').val(data.deliveryHandlingAmount);

    $.each(data.cargoAddonsDetails || [], function (i, row) {
        if (row.addonsType.code == 'FRECR') {
            var valueList = $.trim(row.value).split(',');
            $.each(valueList || [], function (i, value) {
                $('.fs-addon-checkbox[value="' + value + '"]').prop('checked', true);
            });
        } else if (row.addonsType.code == 'PODCH') {
            $('#pod_charges').val(row.value);
        } else if (row.addonsType.code == 'INSUR') {
            $('#insurance_charges').val(row.value);
        } else if (row.addonsType.code == 'MCNHCH') {
            $('#machine_handling_charges').val(row.value);
        } else if (row.addonsType.code == 'EWBL') {
            var $invoiceRow = addInvoiceRow();
            var ewaybill = $.trim(row.value).split('|');

            $invoiceRow.find('.e_way_bill_number').val(row.referenceCode);
            $invoiceRow.find('.inv_amount').val(ewaybill[0] || '');
            $invoiceRow.find('.inv_number').val(ewaybill[1] || '');
            $invoiceRow.find('.inv_date').val(moment(ewaybill[2], 'YYYY-MM-DD').format('DD-MM-YYYY'));
        }
    });

    calculateAmounts();
}

function addTransactionMode() {
    $('#other-transaction-mode').removeClass('hide');
    $('#add-transaction-mode-btn').addClass('hide');
    $('#remove-transaction-mode-btn').removeClass('hide');
}

function removeTransactionMode() {
    $('#transaction-mode-sub').val('CASH').trigger('change');
    $('#amount-sub').val(0).trigger('input');
    $('#other-transaction-mode').addClass('hide');
    $('#remove-transaction-mode-btn').addClass('hide');
    $('#add-transaction-mode-btn').removeClass('hide');
}