var id = 0;
var dropFlag = false;
var busData = {};
var tripStageCode = new Array();
var tripDate = new Array();
var fromStation = new Array();
var toStation = new Array();
var ticketpnr = new Array();
var busMapData = new Array();
var tripTickets = new Array();
var seatStatusDetails = new Array();
var session_email = '';
var currentTab = "";

var rsu = 0 // date diff between current and searched date.
var adv_days_allowed = 1;
if(menu_permission['SEARCH-PAST-DATE']) {
    var adv_days_allowed = 10;
}

var validateOfflineDiscount = false;
var offlineDiscountAmount = 0;
var offlineDiscountCode = '';

var set = '';
var totamt = 0;
var tax = 0;
var gst = 0;
var seatfare = 0;
var discountFare = 0;

function initSearchTabs() {
    //App.setPage("index");  //Set current page
    //App.init(); //Initialise plugins and elements

    $('.has-popover').popover({
        trigger: 'hover',
        placement: 'top',
        html: true
    });
    addNewTab();

    $("[data-toggle='tooltip']").tooltip();
    $('.nav-tabs').tabdrop();
    
   // fire auto search if from quick search       
    if(q_from!='' && q_to!="" && q_date!="" ) {
         window.setTimeout(function() {
                quickSearch(q_from,q_to,q_date,1);
             }, 1000);
    }
    
    //$.getScript('http://maps.google.com/maps/api/js?sensor=false');

}
 
function loadPassengerDetails(){
    if(menu_permission['WALKIN-DISCOUNT']) {
        var c = $("#busmap-" + id).find('#chkofflinediscount').is(':checked'); 
        if(c==true) {
            $("#busmap-" + id).find('#chkofflinediscount').trigger('click');    // reset
        }
        $("#busmap-" + id).find('#chkofflinediscount').trigger('click');    // Check walk-in discount
    }
    
    $(".gen").prop('checked', false); 
    //$("input[name='name']").val('');
    $("input[name='age']").val('');
    if($("#mobileno").val() == ''){
        return false;
    }
    
    if(!isValidPhonenumber( $("#mobileno").val() )) {
        return false;
    }
    
    var data = {};
    data.mobile = $("#mobileno").val();
    data.seatCount = $('.schedule-seat').length; 
       $.ajax({
            type: "POST",
            url: "search/get-passenger-details",
            dataType: 'json',
            data: data,
            //async: false,
            success: function(res) {
                var obj = $.parseJSON(res);
                if(obj.status == 1){
                    var name_arr = $("input[name='name']");
                    var age_arr = $("input[name='age']");
                    var k,name,age,gendar;
                    var arr_len = obj.data.ticketDetails.length;
                    for(k=0; k<arr_len; k++) {
                        if(k < arr_len){
                            name = obj.data.ticketDetails[k].passengerName;
                            age = obj.data.ticketDetails[k].passengerAge;
                            gendar = obj.data.ticketDetails[k].passengerGendar;
                            var gend = 'gendar-'+k;
                            if(!$(name_arr[k]).val().trim()) {
                                $(name_arr[k]).val(name);
                            }
                            $(age_arr[k]).val(age);
                            $('input[id="' + gend+ '"][value="'+gendar+'"]').prop('checked', true);
                        }
                    }
                }
                recalculateSplDiscount(id);
            }
        });
   }


function clearResult(id) {
    $('#busmap-' + id).find('#bus-result-list-action').html('<br><br><br><div class="well well-large" align="center">Please select a seat to get more options.</div>');
    $('#busmap-' + id).find('.schedule-seat').removeClass('schedule-seat');
    $('#busmap-' + id).find('.cancel-seat-process').removeClass('cancel-seat-process');
    $('#busmap-' + id).find('.phone-seat-process').removeClass('phone-seat-process');
    
    $('#busmap-' + id).find('#trip_quota_container').addClass('hide');
    $('#busmap-' + id).find('#detailedquotabuttonpanel').addClass('hide');
    
    $('#busmap-' + id).find('#gender-preference-panel').addClass('hide');
    
    resetOfflineDiscount();    
}
function initbooking(id, bus) {
    $("#busmap-" + id).find('#emailaddress').val(session_email);
    
    $("#busmap-" + id).find('.btn-getotp').click(function() {
        sendUserOTP();        
        $("#busmap-" + id).find('.btn-confirm').removeClass('hide');
    });
    
    $("#busmap-" + id).find('.btn-confirm').click(function() {
        $("#busmap-" + id).find('.error-list').html('');

        var seatName = new Array();
        var seatFare = new Array();
        var seatCode = new Array();
        var discountFare = new Array();

        var data = {}
        
        data.name = $("#busmap-" + id).find('input[name="name"]').serializeArray();
        data.age = $("#busmap-" + id).find('input[name="age"]').serializeArray();
        data.gender = $("#busmap-" + id).find('.gen').serializeObject();
        
        data.phone = $("#busmap-" + id).find('#mobileno').val();
        data.emailaddress = $("#busmap-" + id).find('#emailaddress').val();
        data.phonebooking = $("#busmap-" + id).find('input[name="phoneBooking"]').is(":checked") == true ? 1 : 0;
        data.freeservice = $("#busmap-" + id).find('input[name="chkfreeservice"]').is(":checked") == true ? 1 : 0;
        data.gogreendonation = $("#busmap-" + id).find('input[name="gogreendonation"]').is(":checked") == true ? 1 : 0;
        
        data.tripCode = tripStageCode[id];
        data.tripDate = tripDate[id];
        data.fromStation = fromStation[id];
        data.toStation = toStation[id];
        
        data.paymentgate = $("#busmap-" + id).find('#payment-gateway').val();
        data.remarks = $("#busmap-" + id).find('#remarks').val();
        
        data.bordingstation = $("#busmap-" + id).find('#bording-point').val();
        data.droppingstation = $("#busmap-" + id).find('#dropping-point').val();
        
        data.spldiscount = $("#busmap-" + id).find('#spldiscount').val();
        data.offlineuser = $("#busmap-" + id).find('#offlineuser').val();
        data.agentservicecharges = Number($("#busmap-" + id).find('#agentservicecharges').val());
        
        
        if(offlineDiscountCode!='') {   // offline discount code
            data.offlineDiscountCode = offlineDiscountCode;
        }
        
        data.offlinepaytype = $("#busmap-" + id).find('#offlinepaytype').val();
        
        data.additionalAttributes = {};
        if(data.phonebooking == 1) {            
            data.additionalAttributes['RELEASE_MINUTES_OVERRIDE'] = $("#busmap-" + id).find('#release-min-override').val();
            data.additionalAttributes['ENABLE_LINKPAY'] = +$("#busmap-" + id).find('#enable-linkpay').is(':checked');
        }
        
        
        
        //
        //        if (ticketpnr[id] != '' && ticketpnr[id] != undefined) {
        //            data.ticketpnr = ticketpnr[id];
        //            if (data.paymentgate != undefined && data.paymentgate == '') {
        //                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please select payment method.</div>');
        //                return false;
        //            }
        //        }
        
        var gen = {};
        $("#busmap-" + id).find('.gen').each(function() {
            if (gen[$(this).attr('name')] != 1)
                gen[$(this).attr('name')] = $(this).is(':checked') == false ? 2 : 1;
        });



        if ($("#busmap-" + id).find('.schedule-seat').length < 0 || $("#busmap-" + id).find('.schedule-seat').length == 0) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please select aleast one seat.</div>');
            //resetOfflineDiscount();
            return false;
        }

        if (data.emailaddress == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter email address.</div>');
            //resetOfflineDiscount();
            return false;
        } else if (!isValidEmailAddress(data.emailaddress)) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter valid email address.</div>');
            //resetOfflineDiscount();
            return false;
        }
        if (data.phone == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter phone / mobile no.</div>');
            //resetOfflineDiscount();
            return false;
        } else if (!isValidPhonenumber(data.phone)) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter valid  phone / mobile no.</div>');
            //resetOfflineDiscount();
            return false;
        }
        
        if (data.bordingstation == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please select boarding point.</div>');
            //resetOfflineDiscount();
            return false;
        }
        
        if (data.droppingstation == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please select dropping point.</div>');
            //resetOfflineDiscount();
            return false;
        }
        
        
        
        var nmeerr = 0;
        var invnmeerr = 0;
        $("#busmap-" + id).find('input[name="name"]').each(function() {
            if (!$(this).hasClass('hide') && $(this).val() == '') {
                nmeerr++;
            } /*else {
                var t = $.trim($(this).val());
                var regex = /\d+/g;
                var matches = t.match(regex);
                alert(matches.length);
                return;
            }*/
        });

        var ageerr = 0;
        $("#busmap-" + id).find('input[name="age"]').each(function() {
            if (!$(this).hasClass('hide') && $(this).val() == '') {
                ageerr++;                
            }
        });
        if (nmeerr > 0) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter name.</div>');
            //resetOfflineDiscount();
            return false;
        }
        if (ageerr > 0) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter age.</div>');
            //resetOfflineDiscount();
            return false;
        }
        if ($.isEmptyObject(data.gender)) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please select gender.</div>');
            //resetOfflineDiscount();
            return false;
        } else {
            var chkerr = 0;
            $.each(gen, function(key, value) {
                if (value == 2) {
                    chkerr++;
                }
            });
            if (chkerr > 0) {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please select gender for all seats.</div>');
                //resetOfflineDiscount();
                return false;
            }
        }


        /*$("#busmap-" + id).find('.schedule-seat').each(function(si, sv) {
            var code = $(this).attr('data-code');
            seatName.push(bus.seatDetails[code]['seatName']);
            seatFare.push(bus.seatDetails[code]['fare']);
            seatCode.push(code)

        });

        data.seatCode = seatCode;
        data.seatName = seatName;
        data.seatFare = seatFare;
        
        */
       data.seats = [];
       $('.seats-'+id).each( function() {
            var seat = {};
            seat.name = $.trim( $(this).find('input[name="name"]').val() );
            seat.age = $.trim( $(this).find('input[name="age"]').val() );
             
            $(this).find('.gen').each( function() {
                if( $(this).is(':checked') == true )
                  seat.gender = $(this).val();
            });

            seat.fare = $(this).attr('data-fare');
            seat.discount = $(this).attr('data-discount');

            seat.seatname = $(this).attr('data-name');
            seat.code = $(this).attr('data-code');

            data.seats.push(seat);
        } );                   
       
        if(Number(data.agentservicecharges)>0) {
           var max_sc_allowed = 300 * Number(data.seats.length);
            if(Number(data.agentservicecharges)> max_sc_allowed) {
              $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Service charges should be '+max_sc_allowed+' or less.</div>');
              //resetOfflineDiscount();
              return false;
            }
        }
                
        if($('#gstpanel').is(':checked')) {
            data.additionalAttributes['GST_IN'] = $.trim( $("#busmap-" + id).find('#gst_gstin').val() );
            data.additionalAttributes['GST_TRADE_NAME'] = $.trim( $("#busmap-" + id).find('#gst_tradename').val() );
            data.additionalAttributes['GST_EMAIL'] = $.trim( $("#busmap-" + id).find('#gst_email').val() );
            
            if(!isValidGstin(data.additionalAttributes['GST_IN'])) {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please enter valid GST number.</div>');
                $("#busmap-" + id).find('#gst_gstin').focus();
                return false;
            }
            if(data.additionalAttributes['GST_TRADE_NAME'] == "") {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please enter GST trade / business name.</div>');
                $("#busmap-" + id).find('#gst_tradename').focus();
                return false;
            }
            if(data.additionalAttributes['GST_EMAIL'] == "" || !isValidEmailAddress(data.additionalAttributes['GST_EMAIL'])) {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please enter valid GST email.</div>');
                $("#busmap-" + id).find('#gst_email').focus();
                return false;
            }
        }  
            
        if(menu_permission['BOOK-ON-OTP']) {
            data.userOTP = $("#busmap-" + id).find('#bookingotp').val();
            if(data.userOTP=="") {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please enter OTP to continue.</div>');
                return false;
            }
        }

        $("#busmap-" + id).find('.btn-booking').hide();
        $("#busmap-" + id).find('.error-list').html(loading_big);

        $.ajax({
            type: "POST",
            url: "search/update-seat-booking-v3",
            dataType: 'json',
            data: data,
            //async: false,
            success: function(res) {
                $("#busmap-" + id).find('.btn-booking').show();
                if (res.status == 0) {
                    $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                } else if (res.status == 1) {
                    if (data.phonebooking == 1) {
                        $("#busmap-" + id).find('#bus-result-list-action').html(loading_big);
                        setUserBalance(res.data.currentBalance);
                        ticketDetails(res.data.code, id);
                    } else if (res.paymentRequestUrl != '' && res.paymentRequestUrl != undefined) {
                        $("#busmap-" + id).find('.error-list').html('');
                        var formControl = '';
                        $.each(res.gatewayInputDetails, function(rekey, reval) {
                            formControl += '<input name="' + rekey + '" id="' + rekey + '" value="' + reval + '" />';
                        });
                        $("#busmap-" + id).find('#bus-result-list-action').html('<form action="' + res.paymentRequestUrl + '" name="payment" id="payment" method="post" style="display:none;">' + formControl + '</form>');
                        $("#payment").submit();
                    } else if (res.data.paymentGatewayProcessFlag) {
                        if (res.data.paymentMode == '' || res.data.paymentMode == undefined) {
                            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Payment gateway is not configured , please contact our admin.</div>');
                            return false;
                        } else {
                            var optionhtml = '';
                            $.each(res.data.paymentMode, function(pkey, pval) {
                                $.each(pval.paymentGatewayPartner, function(pakey, paval) {
                                    optionhtml += '<option value="' + paval.code + '" >' + paval.name + '</option>';
                                });
                            });
                            ticketpnr[id] = res.data.code;
                            $("#busmap-" + id).find('.btn-booking').hide();
                            $("#busmap-" + id).find('#payment-gate').removeClass('hide').fadeIn();
                            $("#busmap-" + id).find('.pygt').append(optionhtml);
                            $("#busmap-" + id).find('.error-list').html('');
                            $("#busmap-" + id).find('.pygt').focus();
                            $("#busmap-" + id).find('.btn-pg-confirm').click(function() {

                                var data = {};
                                data.pnrcode = res.data.code;
                                data.gatewaycode = $("#busmap-" + id).find('.pygt').val();
                                if (data.gatewaycode == '') {
                                    $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please select payment method.</div>');
                                    return false;
                                }
                                $("#busmap-" + id).find('.error-list').html(loading_big);
                                $.ajax({
                                    type: "POST",
                                    url: "search/gateway-details",
                                    dataType: 'json',
                                    data: data,
                                    success: function(res) {
                                        var formControl = '';
                                        $.each(res.gatewayInputDetails, function(rekey, reval) {
                                            formControl += '<input name="' + rekey + '" id="' + rekey + '" value="' + reval + '" />';
                                        });
                                        $("#busmap-" + id).find('#bus-result-list-action').html('<form action="' + res.paymentRequestUrl + '" name="payment" id="payment" method="post" style="display:none;">' + formControl + '</form>');
                                        $("#payment").submit();
                                    }
                                });

                            });
                        }
                    } else {
                        $("#busmap-" + id).find('#bus-result-list-action').html(loading_big);
                        setUserBalance(res.data.currentBalance);
                        ticketDetails(res.data.ticket[0].code, id);

                    }
                }
            }
        });
        
    });
    
    $('#gogreendonation').bind('change', function(){
        recalculateSplDiscount(id);
    });
    
    $('#chkofflinediscount').bind('change', function(){
        var c = $(this).is(':checked'); 
        if(c==true) {
            //$("#busmap-" + id).find('.btn-confirm').trigger('click');
            $("#busmap-" + id).find('.error-list').html('');

            var seatName = new Array();
            var seatFare = new Array();
            var seatCode = new Array();
            var discountFare = new Array();

            var data = {}


            data.phone = $("#busmap-" + id).find('#mobileno').val();
            data.emailaddress = $("#busmap-" + id).find('#emailaddress').val();
            data.phonebooking = $("#busmap-" + id).find('input[name="phoneBooking"]').is(":checked") == true ? 1 : 0;

            data.tripCode = tripStageCode[id];
            data.tripDate = tripDate[id];
            data.fromStation = fromStation[id];
            data.toStation = toStation[id];

            data.offlineuser = $("#busmap-" + id).find('#offlineuser').val();

            if (data.emailaddress == '') {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter email address.</div>');
                //resetOfflineDiscount();
                return false;
            } else if (!isValidEmailAddress(data.emailaddress)) {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter valid email address.</div>');
                //resetOfflineDiscount();
                return false;
            }
            if (data.phone == '') {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter phone / mobile no.</div>');
                //resetOfflineDiscount();
                return false;
            } else if (!isValidPhonenumber(data.phone)) {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter valid  phone / mobile no.</div>');
                //resetOfflineDiscount();
                return false;
            }


           data.seats = [];
           $('.seats-'+id).each( function() {
                var seat = {};

                seat.fare = $(this).attr('data-fare');
                seat.discount = $(this).attr('data-discount');

                seat.seatname = $(this).attr('data-name');
                seat.code = $(this).attr('data-code');

                data.seats.push(seat);
            } ); 

            $('#offlinediscountstatus').removeClass('hide').removeClass('alert-success').removeClass('alert-danger')
            $('#offlinediscountstatus').html(loading_small);

            $.ajax({
                type: "POST",
                url: "search/validate-offline-discount",
                dataType: 'json',
                data: data,
                //async: false,
                success: function(res) {
                    if(res.status==1) {                        
                        if( parseInt(res.data.value) >0 ) {                            
                            offlineDiscountAmount = res.data.value;
                            offlineDiscountCode = res.data.code;
                            recalculateSplDiscount(id);                            
                            $('#offlinediscountstatus').addClass('alert-success');
                            $('#offlinediscountstatus').html('<i class="fa fa-rupee"></i> '+res.data.value+' walk-in discount applied');

                            window.setTimeout(function() {
                                $('#offlinediscountstatus').html('').addClass('hide');
                            }, 3000);
                        } 
                    } else {
                        $('#offlinediscountstatus').addClass('alert-danger');
                        $('#offlinediscountstatus').html('Sorry! No discount available');
                        window.setTimeout(function() {
                            $('#offlinediscountstatus').html('').addClass('hide');
                        }, 3000);
                    }
                }
            });
        } else {
            offlineDiscountCode = '';
            offlineDiscountAmount = 0;
            recalculateSplDiscount(id);
        }        
    });
}

function resetOfflineDiscount() {
    offlineDiscountAmount = 0;
    offlineDiscountCode = '';
    validateOfflineDiscount = false;
    $('#chkofflinediscount').prop("checked", false);
}

function ticketDetails(pnrcode, id) {
    var data = {}
    data.ticketpnrcode = pnrcode;
    data.ticketPage = 1;
    $.ajax({
        type: "POST",
        url: "search/confimation-payment-list",
        dataType: 'html',
        data: data,
        //async: false,
        success: function(res) {
            $("#busmap-" + id).find('#bus-result-list-action').html(res);
            $('#busmap-' + id).find('#bus-result-list-action').find('.btn-clear-ticket').attr('onclick', 'clearList(' + id + ')');
        }
    });
}
function clearList(id){
    var tripCode = $("#result-panel-" + id).find('.li_bk').attr('data-trip');
    var tbid = $("#result-panel-" + id).find('.li_bk').attr('data-tab');
    
    var travelDate = $("#result-panel-" + id).find('.li_bk').attr('data-traveldate');
    var fromCode = $("#result-panel-" + id).find('.li_bk').attr('data-from');
    var toCode = $("#result-panel-" + id).find('.li_bk').attr('data-to');

    Busmapload(tripCode, tbid, travelDate, fromCode, toCode);
}
function initcancel(id) {
    
    $('#busmap-' + id).find('.btn-refund').attr('onclick', 'confirmTicketCancel(' + id + ')');
    $('#busmap-' + id).find('#amount-ovr').on('blur', function() {
        var txt = $.trim($(this).val());
        if (txt != '') {
            $('#busmap-' + id).find('#ref_amt').html('');
            $('#busmap-' + id).find('#ref_amt').html(txt);
        }
    });

    $('#busmap-' + id).find('input[name="pnr_user_list"]').change(function() {
        if (this.checked) {
            $('#busmap-' + id).find('#refe_txt').val('');
            var refund = $('#busmap-' + id).find('#refund').val();
            var checkcount = $('#busmap-' + id).find("input[name='pnr_user_list']:checked").length;
            var total = refund * checkcount;
            if (checkcount > 0) {
                $('#busmap-' + id).find('.btn-refund').show();
            } else {
                $('#busmap-' + id).find('.btn-refund').hide();
            }
            $('#busmap-' + id).find('#rfu_amt').show();
            $('#busmap-' + id).find('#ref_amt').html(total);
            $('#busmap-' + id).find('#refe_txt').val(total);

        }
        else {
            $('#busmap-' + id).find('#refe_txt').val('');
            var refund = $('#busmap-' + id).find('#refund').val();
            var checkcount = $('#busmap-' + id).find("input[name='pnr_user_list']:checked").length;
            var total = refund * checkcount;
            if (checkcount > 0) {
                $('#busmap-' + id).find('.btn-refund').show();
            } else {
                $('#busmap-' + id).find('.btn-refund').hide();
            }
            $('#busmap-' + id).find('#rfu_amt').show();
            $('#busmap-' + id).find('#ref_amt').html(total);
            $('#busmap-' + id).find('#refe_txt').val(total);
        }
    });
}
function confirmTicketCancel(id) {
    if (confirm('Do you want to cancel selected seats ?')) {
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        var data = {};
        data.tickettype = "BO";
        data.seatcode = new Array();
        $('#busmap-' + id).find('.pnr_user_list:checked').each(function() {
            data.seatcode.push($(this).val());
        });
        data.myAccountFlag = $('input[name="cancel_bm_flg"]').is(":checked") == true ? 1 : 0;
        data.pnrcode = $('#busmap-' + id).find('#pnr_code').val();
        data.amount = "";
        if ($('#amount-ovr').val() != '') {
            data.amount = $('#busmap-' + id).find('#amount-ovr').val();
        } /*else {
            data.amount = $('#busmap-' + id).find('#refe_txt').val();
        }*/
        
        

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "search/cancel-ticket-confirmation",
            data: data,
            success: function(res) {
                if (res.status == 1) {
                    $('#busmap-' + id).find('#amount-ovr').val('')

                    $('#refe_txt').val('');
                    $('#ref_amt').html('0');
                    $('#busmap-' + id).find('.btn-refund').hide();
                    $('#seat-' + data.seatcode).animate({
                        backgroundColor: '#1AA1E1'
                    }, 2000, function() {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        clearList(id);

                    }, 2000);                
                } else {
                    loading_overlay.hide();
                    alert(res.errorDesc);
                }
                
            }
        })
    }
}
function togglePNRlist(ele) {
    var action = $(ele).is(':checked');
    $(ele).closest('tbody').find('.pnr_user_list:checkbox:enabled').each(function(i, val) {
        $(val).prop('checked', action).trigger('change');
    });
}
function phoneBookingConfirm(id) {
    var data = {};
    var err = 0;
    data.seatcode = new Array();
    $('#busmap-' + id).find('.pnr_user_list:checked').each(function() {
        data.seatcode.push($(this).val());
    });
    if(data.seatcode.length==0) {
        alert('Please select atleast one seat to confirm');
        return false;
    }
    data.pnrcode = $('#busmap-' + id).find('#pnr_code').val();
    data.bookByMyAccountFlag = $.trim($('#bk_flg').val());
    data.pblRemarks = $.trim( $('#pbl-cnf-remarks').val() );
    data.offlinepaytype = $('#offlinepaytype').val();
    
    $('#bk_flg').removeClass('inp_error');
    if(data.bookByMyAccountFlag == '') {
        $('#bk_flg').addClass('inp_error');
        err++;
    }
    
    if (err > 0) {
        $('#phone_bkg_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#phone_bkg_action_state').html('Please enter/select the values in the field that are marked in red');
        $('#phone_bkg_action_state').show();
        return false;
    } else {
        $('#phone_bkg_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#phone_bkg_action_state').html('');
        $('#phone_bkg_action_state').hide();
    }
   
    $('#phone_bkg_action_state').removeClass('alert-danger').removeClass('alert-success');
    $('#phone_bkg_action_state').html(loading_popup);
    $('#phone_bkg_action_state').show();

    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "search/ticket-confirmation-by-phone",
        data: data,
        success: function(res) {
            if (res.status == 1) {
                /*$('#seat-' + data.seatcode).animate({
                    backgroundColor: '#1AA1E1'
                }, 2000, function() {
                    $(this).remove()
                }); */
                
                $('#phone_bkg_action_state').removeClass('alert-danger');
                $('#phone_bkg_action_state').addClass('alert-success');
                $('#phone_bkg_action_state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    ticketDetails(data.pnrcode, id);
                }, 2000);
            
            } else {
                $('#phone_bkg_action_state').addClass('alert-danger');
                $('#phone_bkg_action_state').html(res.errorDesc);
                $('#phone_bkg_action_state').show();
            }
            
        }
    })
}
function phoneBookingCancel(id) {   
    var data = {};
    data.seatcode = new Array();
    $('#busmap-' + id).find('.pnr_user_list:checked').each(function() {
        data.seatcode.push($(this).val());
    });
    if(data.seatcode.length==0) {
        alert('Please select atleast one seat to cancel');
        return false;
    }
    data.pnrcode = $('#busmap-' + id).find('#pnr_code').val();
    var loading_overlay = iosOverlay({
     text: "Loading",
     icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "search/ticket-cancel-by-phone",
        data: data,
        success: function(res) {
            if (res.status == 1) {
                /*$('#seat-' + data.seatcode).animate({
                    backgroundColor: '#1AA1E1'
                }, 2000, function() {
                    $(this).remove()
                }); */
                loading_overlay.update({
                     icon: "fa fa-check",
                     text: "Success!"
                });
                 window.setTimeout(function() {
                    loading_overlay.hide();
                    ticketDetails(data.pnrcode, id);
                 }, 2000);
             
            } else {
                loading_overlay.hide();
                alert(res.errorDesc);
            }
           
        }
    })
}

function interchangeStations(id) {
    var stcode = $('#from-station-search-' + id).val();
    var tocode = $('#to-station-search-' + id).val();
    if(stcode == "" || tocode == "") {
        return;
    }
    //var html = '<option value=""></option>';
    //$('#to-station-search-' + id).val('');
    //$('#to-station-search-' + id).select2('val', '');
    
    $('#from-station-search-' + id).val(tocode);
    $('#from-station-search-' + id).select2('val', tocode);    
    
    toStationLoading(id);
    
    $('#to-station-search-' + id).val(stcode);
    $('#to-station-search-' + id).select2('val', stcode);
    
    return;   
}

function addNewTab(event, options) {	
    if (id > 5) {
        return false;
    }
	id++;
    if (event){
        event.stopPropagation();
    }
    $('div.active').removeClass('active').removeClass('in');
    $('li.active').removeClass('active');

    var tabtitle = "Plan Your Travel";
	var showCookieResult = true, showSearchPanel = true, callback = null;
	if ( typeof options !== "undefined" ){		
		tabtitle = typeof options.tabtitle !== "undefined" ? options.tabtitle : tabtitle;		
		showCookieResult = typeof options.showCookieResult !== "undefined" ? options.showCookieResult : showCookieResult;		
		showSearchPanel = typeof options.showSearchPanel !== "undefined" ? options.showSearchPanel : showSearchPanel;		
		callback		= typeof options.callback !== "undefined" ? options.callback : callback;		
	}
	
    var tid = "box_tab" + id;
    currentTab = id;
    var divhtml = $('#template-searchform').html();
    divhtml = $('<div>').html(divhtml).clone();
    divhtml.attr('id', '');
    divhtml.find('.from').attr('id', 'from-station-search-' + id).attr('onchange', 'toStationLoading("' + id + '")').css('min-width', '150px');
    divhtml.find('.to').attr('id', 'to-station-search-' + id).css('min-width', '150px');
    divhtml.find('#a_interchange').attr('onclick', 'interchangeStations("' + id + '")');

    divhtml.find('.sdate').attr('id', 'sdate-search-' + id);
    //divhtml.find('.tdate').attr('id','tdate-search-'+id);
    divhtml.find('.btn-search').attr('onclick', 'dosearch("' + id + '")');

    divhtml.find('.btn-clear').attr('onclick', 'clearSearch("' + id + '")');
    divhtml.find('#search-panel').attr('id', 'search-panel-' + id);
    divhtml.find('.cancel-terms').attr('id', 'cancel-terms-dialog' + id).hide();
	//
	divhtml.find('#cookie-result').attr('id', 'cookie-result-' + id);
	divhtml.find('#cookie2-result').attr('id', 'cookie2-result-' + id);
    divhtml.find('#result-panel').attr('id', 'result-panel-' + id).addClass('min_h_300');
    $('<li><a href="#' + tid + '" onclick="sct('+id+')" class="hidden-xs" data-toggle="tab" title="' + tabtitle + '">'+tabtitle+' </a></li>').insertBefore('#add-tab');
    
    $('.tab-content').append('<div class="tab-pane fade active in" id="' + tid + '"> ' + divhtml.html() + ' </div>');
    var opthml = '';
    var farray = new Array();
    $.each(stations, function(rkey, rvls) {
        if (jQuery.inArray(rvls.code, farray) < 0) {
            opthml += '<option id="' + rvls.code + '" value="' + rvls.code + '">' + rvls.name + '</option>';
            farray.push(rvls.code)
        }

    });
    $('#from-station-search-' + id).append(opthml);
    $('#from-station-search-' + id).select2({
        placeholder: "Select Origin",
        escapeMarkup: function(markup) {
            return markup;
        }
    });
    $('#to-station-search-' + id).select2({
        placeholder: "Select Destination",
        escapeMarkup: function(markup) {
            return markup;
        }
    });
	
    if ( showCookieResult ){
            $("#cookie-result-"+id).html(getCookieSearchHistory(id));
    }
    
    var adv_days = '-1d';
    if(menu_permission['SEARCH-PAST-DATE']) {
        var adv_days = '-10d';
    }
	
    $('#sdate-search-' + id).datepicker({
        todayHighlight: true,
        format: "dd-mm-yyyy",
        startDate: adv_days,
        daysOfWeekHighlighted: "0,6",
        autoclose: true
    });
    
    var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1;
    var curr_year = d.getFullYear();
    if (curr_month < 10) {
        curr_month = '0' + curr_month;
    }
    if (curr_date < 10) {
        curr_date = '0' + curr_date;
    }
    //var date_format = curr_year + '-' + curr_month + '-' + curr_date;   
    var date_format = curr_date + '-' + curr_month + '-' + curr_year;   
    $('#sdate-search-' + id).datepicker("setDate", date_format);    
    $('#sdate-search-' + id).val(date_format);
                    

    $('a[href="#' + tid + '"]').parents('li').addClass('active').addClass('in');
    $('#tab #' + tid).tab('show');
	if ( showSearchPanel ){
		$("#search-panel-"+id).show();
	}else{
		$("#search-panel-"+id).hide();
	}
	
	if ( callback !== null ){
            if ( typeof callback === "function" ){
                setTimeout(function(){
                        callback.call(null);
                },100);
            }else if(typeof callback === "string" ){
                setTimeout(function(){
                        eval( callback );
                },100);
            }
	} 
        
}

//  set Current Tab
function sct(n) {
    return currentTab = n;
}
//  get Current Tab
function gct() {
    return currentTab;
}
function quickSearch(fromstation,tostation,searchdate, id){    
    $('#from-station-search-' + id).val(fromstation).trigger("change");
    toStationLoading(id);        
    $('#to-station-search-' + id).val(tostation).trigger("change");

    var days_diff = moment(new Date()).diff(moment(searchdate, 'DD-MM-YYYY'), 'days');
    if(days_diff > (adv_days_allowed+1)) {
        $('#sdate-search-' + id).val('');
        $('#sdate-search-' + id).focus();
        return;
    } else {
        $('#sdate-search-' + id).datepicker("setDate", searchdate);
    }
    
    $('#sdate-search-' + id).datepicker('update');
    dosearch(id);
    /*addNewTab(window.event, {
        tabtitle: $("#"+fromstation).html().substring(0,3)+" to "+$("#"+tostation).html().substring(0,3)+" on "+formatDate(searchdate),
        showCookieResult: false,
        showSearchPanel: false,
        callback:function() {								
            dosearch(id, {
                        fromStation: fromstation,
                        toStation: tostation,
                        sdate: searchdate,
                        saveResult: false,
                        fromQuickSearch: true
                });
        }
    });*/	
}

function tabdelete(obj) {
    $('div.active').removeClass('active').removeClass('in');
    $('li.active').removeClass('active');

    var panelId = $(obj).closest("li");
    var linkid = panelId.find("a").attr("href");
    panelId.remove();
    $(linkid).remove();

    $('#box_tab1').addClass('active').addClass('in');
    $('a[href="#box_tab1"]').parents('li').addClass('active').addClass('in');
    id--;
}
function getsearchfromcookie(value,id){
    var selected = $(value).closest('tr');
    $(selected).find('td').each (function(index) {
    
	if(index==0){
         $('#from-station-search-' + id).val($(this).attr('id'));
         toStationLoading(id);
         }else if(index==1){
         $('#to-station-search-' + id).val($(this).attr('id'));
         }else{
         $('#sdate-search-' + id).val($(this).html());
         return false;
         }
         index++;
});
dosearch(id);
}
function getCookieSearchHistory(id){
    $.cookie.json = true;
	
    var html="<div class='list-group'>";
    //var html2=" ";
    //var pastChoiceLst = JSON.parse($.cookie("searchhistory-data"))? JSON.parse($.cookie("searchhistory-data")) :[];
    var pastChoiceLst = ($.cookie("searchhistory-data"))? JSON.parse($.cookie("searchhistory-data")) :[];

    $.each( pastChoiceLst.reverse(), function( index, item ){
        if(index<=14 && $('#'+item.fromstation).length && $('#'+item.tostation).length){
            html+="<a href='javascript:;' class='list-group-item' style='float: left; margin: -1px 5px; width: 32%;' onclick = quickSearch('"+item.fromstation+"','"+item.tostation+"','"+item.searchdate+"',"+id+")>"+$("#"+item.fromstation).html() ;
            html+=" to "+ $('#'+item.tostation).html() ;
            html+="&nbsp;on&nbsp;"+item.searchdate+"</a>";
        
            //html+="<a href='javascript:;' class='list-group-item' onclick = quickSearch('"+item.fromstation+"','"+item.tostation+"','"+item.searchdate+"',"+id+")>"+$("#"+item.fromstation).html() ;
            //html+=" to "+ $('#'+item.tostation).html() ;
            //html+="&nbsp;on&nbsp;"+formatDate(item.searchdate)+"</a>";
        }
     });
    //$("#cookie2-result-"+id).html(html2);
    html+= "</div>";
    return html;
}
function formatIndDate(str,formats) {
    formats = (formats!='') ? 'ddd DD-MM-YYYY' : formats;
    return moment(str).format(formats);
}
function formatDate( str ){
    var aDate = str.split("-");
    if ( aDate.length > 0 ){
            return aDate[2]+"/"+aDate[1]+"/"+aDate[0];
    }else{
            return "";
    }
}
function formatDateTime(str) {
    return moment(str).format('ddd DD-MM-YYYY hh:mm A');
}

function dosearch(id, options) {
    //tab = $('div.active').attr('id');
    //tabid = '#'.tab;	
    var data = {}
    data.fromStation = $('#from-station-search-' + id).val();	
    var fromStationName=$("#"+data.fromStation).html();
    data.toStation = $('#to-station-search-' + id).val();
    var toStationName=$("#"+data.toStation).html();
    data.sdate = $('#sdate-search-' + id).val();
    var f_date = data.sdate;
    data.sdate = moment(data.sdate, 'DD-MM-YYYY').format('YYYY-MM-DD');
    
    var date = $('#sdate-search-' + id).datepicker('getDate');
    var toda = new Date()
    
    var a = moment(toda);
    var b = moment(date);   
    
    var rsu = a.diff(b, 'days');
    
    date.setTime(date.getTime() - (1000 * 60 * 60 * 24))

    var d = date;
    var curr_date = d.getDate() + 1;
    var curr_month = d.getMonth() + 1;
    var err = 0;
	
    var saveResult = true, fromQuickSearch = false;	
    if ( typeof options !== "undefined" ){
        if ( typeof options.fromStation !== "undefined" ){
                data.fromStation = options.fromStation;
        }
        if ( typeof options.toStation !== "undefined" ){
                data.toStation = options.toStation;
        }
        if ( typeof options.sdate !== "undefined" ){
                data.sdate = options.sdate;
                f_date = data.sdate;
                data.sdate = moment(data.sdate, 'DD-MM-YYYY').format('YYYY-MM-DD');
        }
        if ( typeof options.saveResult !== "undefined" ){
                saveResult = options.saveResult;
        }
        if ( typeof options.fromQuickSearch !== "undefined" ){
                fromQuickSearch = options.fromQuickSearch;
        }
    }	
    
    $('.parsley-error').removeClass('parsley-error');
    if (data.fromStation == '') {
        $('#from-station-search-' + id).addClass('parsley-error');
        $('#result-panel-' + id).html('<div class="alert fl alert-danger">Please select origin.</div>');
        return false;
    }
    if (data.toStation == '') {
        $('#to-station-search-' + id).addClass('parsley-error');
        $('#result-panel-' + id).html('<div class="alert fl alert-danger">Please select destination.</div>');
        return false;
    }
    if (data.sdate == '') {
        $('#sdate-search-' + id).addClass('parsley-error');
        $('#result-panel-' + id).html('<div class="alert fl alert-danger">Please select date.</div>');
        return false;
    }
    if (data.fromStation == data.toStation) {
        $('#result-panel-' + id).html('<div class="alert fl alert-danger">Both origin and destination should not be same.</div>');
        return false
    }
    $("#cookie2-result-"+id).hide();
    $("#cookie-result-"+id).hide();
    $('#result-panel-' + id).html('<div class="row"><div class="col-md-offset-5" style="padding-top:110px"><img src="'+base_url+'assets/img/loaders/20.gif" /></div></div>');

    if ( saveResult ){		
        $.cookie.json = true;
        //var pastChoiceLst = JSON.parse($.cookie("searchhistory-data"))? JSON.parse($.cookie("searchhistory-data")) :[];
        var pastChoiceLst = ($.cookie("searchhistory-data"))? JSON.parse($.cookie("searchhistory-data")) :[];
        $.each( pastChoiceLst, function( index, item ){
            if(item.fromstation == data.fromStation && item.tostation == data.toStation && item.searchdate == f_date){
                pastChoiceLst.splice(index, 1);
                return false;
            }
        });
        pastChoiceLst.push( new search(data.fromStation,data.toStation,f_date));
        $.cookie("searchhistory-data",JSON.stringify(pastChoiceLst));
    }    
    //$('#search-panel-' + id).hide();
    $.ajax({
        type: "POST",
        url: "search/get-bus-details",
        dataType: 'json',
        data: data,
        async: true,
        success: function(res) {
            
            //$('#result-panel-'+id).html(res);
            var tf = $('#from-station-search-' + id).find(":selected").text();
            var tt = $('#to-station-search-' + id).find(":selected").text();
            if ( !fromQuickSearch ){
                if (date == 0) {
                    $('a[href="#box_tab' + id + '"]').html(tf.substring(0, 4) + ' to ' + tt.substring(0, 4) + '&nbsp;' + curr_date + '/' + curr_month + '&nbsp;&nbsp;'); 
                } else {
                    $('a[href="#box_tab' + id + '"]').html(tf.substring(0, 4) + ' to ' + tt.substring(0, 4) + '&nbsp;' + curr_date + '/' + curr_month + '&nbsp;&nbsp;');
                }
                $('a[href="#box_tab' + id + '"]').attr('title', tf+' to '+tt+' on '+curr_date + '/' + curr_month);
            }
                        
            var html = '<div id="bus' + id + '">\n\
                <div class="row">\n\
                         <div class="col-lg-12 col-md-12 col-sm-12 text-center" style="padding:10px">\n\
                             <!--<span class="bold">On : </span>-->\n\
                             <span class="search-tot-buses"></span>\n\
                             <span class="trp-date">';
                                 if (rsu < adv_days_allowed) {   //  hide past date nav
                                     html += '<a title="Previous day" data-toggle="tooltip" class="prev-day-' + id + '" onclick=\'getPdate(' + id + ',"' + data.sdate + '")\'>\n\
                                                 <i class="glyphicon glyphicon-chevron-left"></i><i class="glyphicon glyphicon-chevron-left"></i>\n\
                                             </a>';
                                 }
                                 html += '&nbsp;&nbsp;\n\
                                     <span id="s_date_' + id + '">' + formatIndDate(data.sdate, "ddd DD-MM-YYYY") + '</span>&nbsp;&nbsp;\n\
                                     <a title="Next day" data-toggle="tooltip" style="cursor:pointer" class="next-day" onclick=\'getNdate(' + id + ',"' + data.sdate + '")\'>\n\
                                         <i class="glyphicon glyphicon-chevron-right"></i><i class="glyphicon glyphicon-chevron-right"></i>\n\
                                     </a>\n\
                             </span>&nbsp; &nbsp;\n\
                             <!--<a id="refresh-list-' + id + '" title="Refresh" data-toggle="tooltip" href="javascript:;"><i class="fa fa-repeat f17"></i></a>&nbsp;\n\
                             <a id="close-list-' + id + '"  title="Clear" data-toggle="tooltip" data-toggle="popover" data-toggle="tooltip" href="javascript:;"><i class="fa fa-times f17"></i></a>-->\n\
                         </div>\n\
                     </div>\n\
                 </div>';            
            
            if (res.data == '' || res.data == null) {                
                html += '<br><div class="row"><div class="col-lg-offset-1 col-lg-10 col-md-12 col-sm-12"><div class="panel panel-default text-center"> Sorry! No bus available.</div></div></div>';
                $('#search-panel-' + id).show();
                $('#result-panel-' + id).html(html);
            } else if (res.data.length > 0) {
                //$('#search-panel-' + id).hide();
                if (res.dropFlag == 1) {
                    dropFlag = true;
                }
                if (res.session_email != '') {
                    session_email = res.session_email;
                }
                
                
                busData[id] = res.data;
                $.each(res.data, function(bkey, bval) {
                    var tripList = $('#template-bus-list').html();
                    tripList = $('<div>').html(tripList).clone();
                    tripList.find('.busName').html(bval.busName);
                    tripList.find('.busCategory').html(bval.busCategory);
                    if(bval.busClimate=="CC01") { // show AC service border.
                        tripList.find('.panel').addClass('highlight-ac-trip');
                    } 
                    tripList.find('.from_route').html(bval.fromStation.name);
                    tripList.find('.to_route').html(bval.toStation.name);
                    tripList.find('.has-cancel-popover').attr('data-stageCode', bval.tripStageCode).attr('data-tap', id).attr('onclick', 'dialogTerms("'+bval.tripStageCode+'", "'+bval.tripCode+'")');
                    tripList.find('.pp').attr('data-station', bval.fromStation.code).attr('data-tripcode', bval.tripCode).attr('data-tap', id);
                    tripList.find('.dp').attr('data-station', bval.toStation.code).attr('data-tripcode', bval.tripCode).attr('data-tap', id);
                    
                    tripList.find('tr:nth-child(2)').attr('data-trip-stage', bval.tripStageCode).attr('data-trip', bval.tripCode).attr('data-tab', id).attr('id', 'trip-'+ bval.tripCode).attr('date-timestatus', bval.tripTimeCrossed);
                    tripList.find('tr:nth-child(2)').attr('data-tripstatus', bval.tripStatusCode).attr('data-schedulecode', bval.scheduleCode).attr('data-traveldate', bval.travelDate).attr('data-from', bval.fromStation.code).attr('data-to', bval.toStation.code).attr('data-from-datetime', bval.fromStation.dateTime).attr('data-seattype-count', bval.fare.length);
                    tripList.find('tr:nth-child(3)').attr('id', 'trip-info-'+ bval.tripCode)
                    tripList.find('tr:nth-child(1)').attr('id', 'trip-row1-'+ bval.tripCode)
                    
                    tripList.find('.settings-icon').attr('data-tap', id).attr('onclick', 'tripMoreOptions(this, "'+bval.scheduleCode+'", "'+bval.tripCode+'","'+data.sdate+'")');
                    tripList.find('.tripmore').find('#boardingtripchart').attr('href', '#boardingtripchart/boarding-trip-chart-list?tc='+bval.tripCode+'&date='+data.sdate);
                    
                    tripList.find('.tripmore').find('.close-adv-booking').attr('onclick', 'setTripBookingStatus("' + bval.tripCode + '", "TPC");');
                    tripList.find('.tripmore').find('.open-adv-booking').attr('onclick', 'setTripBookingStatus("' + bval.tripCode + '", "TPO");');
                    
                    if(bval.tripStatusCode === 'TPO') {
                        tripList.find('.tripmore').find('.open-adv-booking').addClass('hide');
                    } else if(bval.tripStatusCode === 'TPC'){
                        tripList.find('.tripmore').find('.close-adv-booking').addClass('hide');
                    } else {
                        tripList.find('.tripmore').find('.divider').addClass('hide');
                        tripList.find('.tripmore').find('.open-adv-booking').addClass('hide');
                        tripList.find('.tripmore').find('.close-adv-booking').addClass('hide');
                    }
                     
                    tripList.find('#occupancy-graph').attr('onclick', 'getScheduleAdvanceBookingGraph("'+bval.scheduleCode+'", "'+bval.serviceNumber+'")');
                    tripList.find('#audit-log').attr('onclick', 'getAuditHistory("'+bval.scheduleCode+'","'+bval.tripCode+'")');
                    
                    // Trip Yet Open, Not admin
                    if(bval.tripStatusCode=='TPY' && menu_permission['PHB-SHOW-TKT-INFO']!==1) {
                        tripList.find('.view-button').removeClass('btn-success').removeClass('view-button').addClass('btn-default').html('Yet Open');
                    }
                    
                    var fare = '';
                    var discount = new Array();
                    var seatCount = 0;
              
                    $.each(bval.fare, function(fkey, fre) {
                        if (fare != '')
                            fare += ', ';
                        fare += '<i class="fa  fa-rupee"></i>&nbsp;' + fre.fare;
                        
                        if(Number(fre.discountFare)>0) {
                            //discount += '<i class="fa  fa-rupee"></i>&nbsp;' + fre.discountFare +'(off)';
                            discount.push(fre.discountFare);
                        }
                        seatCount = Number(seatCount) + Number(fre.availableSeatCount);
                    });
                    
                   
                   
                    //var vt = via.join(', ');
                    //var len = vt.length;
                    //var vtt = vt;
                    //if(len>40) vtt = vt.substring(0, 40)+'...';
                    //tripList.find('.busVia').html('<span data-toggle="tooltip" title="'+vt+'"><span class="bold text-danger" >Via : </span>'+vtt+'</span>');
                    
                    //bval.fare                   
                    tripList.find('.fare').html(fare);
                    if(discount.length >0) {
                        var m = Math.max.apply(Math,discount);
                        tripList.find('.discount').addClass('discount-badge').html('max <i class="fa  fa-rupee"></i>&nbsp;'+ m +' offer');
                    }
                    tripList.find('.travelTime').html(bval.travelTime+' hrs');
                    tripList.find('.ftime').html(datetimeToTime(bval.fromStation.dateTime));
                    tripList.find('.ttime').html(datetimeToTime(bval.toStation.dateTime));
                    tripList.find('.serviceno').html(bval.serviceNumber);
                    
                    if( bval.tripInfo != "null" ) {
                        if( bval.tripInfo.registrationNumber != '' )
                            tripList.find('.tripinfo-bus').removeClass('hide');                    
                        if( bval.tripInfo.gpsDeviceCode != '' ) {
                            if(bval.tripInfo.gpsDeviceCode != ""){
                                tripList.find('.tripinfo-track').removeClass('hide');
                                tripList.find('.tracklink').attr('onclick', 'trackfleet("'+bval.tripCode+'","'+bval.tripInfo.gpsDeviceCode+'")');
                            }
                        }
                    }
                    
                    tripList.find('.tr_buslayout').attr('id', bval.tripCode);
                    if( parseInt(seatCount) <=0 ) {                         
                        tripList.find('.seat-count').addClass('sold').html('Sold Out');
                    } else {
                        
                        if(bval.tripStatusCode=='TPY' && menu_permission['PHB-SHOW-TKT-INFO']!==1)
                            seatCount = 0;
                        
                        tripList.find('.seat-count').html(seatCount+' seats');
                    }
                    
                    if(bval.tripStatus=='Trip Closed') {
                        tripList.find('.trip-status').addClass('label label-danger').html(bval.tripStatus);
                    } else if(bval.tripStatus=='Trip Yet Open'){
                        tripList.find('.trip-status').addClass('label label-info').html(bval.tripStatus);
                    } else if(bval.tripStatus=='Trip Cancelled'){
                        tripList.find('.trip-status').addClass('label label-warning').html(bval.tripStatus);
                    } else {
                        tripList.find('.trip-status').addClass('label label-default').html(bval.tripStatus);
                    }
                    
                    
                                       
                    html += tripList.html();
                });
                
                //html += "</div>";
                
                //html += '<div id="busmap-' + id + '" class="row box_content min_h_300"><div id="Def_txt"><div class="well well-large">Please select bus to know more details.</div></div></div>';
                html += '<input type="hidden" id="sch_code" value="">\n\
                        <input type="hidden" id="trip_code" value="">\n\
                        <input type="hidden" id="travel_date" value="">\n\
                        <input type="hidden" id="from_station" value="">\n\
                        <input type="hidden" id="from_datetime" value="">\n\
                        <input type="hidden" id="to_station" value="">';
                $('#result-panel-' + id).html(html);
                $('#result-panel-' + id + ' .search-tot-buses').html((res.data.length > 1) ? res.data.length + ' buses found.' : res.data.length + ' bus found.');
                
                $('#refresh-list-' + id).bind('click', function(e) {
                    dosearch(id);
                });
                
                $('#close-list-' + id).bind('click', function(e) {
                    clearSearch(id);
                    $('#search-panel-' + id).slideDown();
                    $("#cookie2-result-"+id).slideDown();
                    $("#cookie-result-"+id).slideDown();
                    $('a[href="#box_tab' + id + '"]').attr('title', 'Plan Your Travel');
                    $('a[href="#box_tab' + id + '"]').html('Plan Your Travel');
                });
//                $('#s_date_' + id).datepicker({
//                    format: 'dd-mm-yyyy',
//                    autoclose: true
//                });
//                $('#s_date_' + id).datepicker().on('changeDate', function(ev) {
//
//                    var dates = $('#s_date_' + id).datepicker('getDate');
//                    dates.setTime(dates.getTime() + (1000 * 60 * 60 * 24))
//
//                    var d = dates;
//                    var curr_date = d.getDate() - 1;
//                    var curr_month = d.getMonth() + 1;
//                    var curr_year = d.getFullYear();
//                    if (curr_month < 10) {
//                        curr_month = '0' + curr_month;
//                    }
//                    if (curr_date < 10) {
//                        curr_date = '0' + curr_date;
//                    }
//
//
//
//                    //var date_format = curr_year + '-' + curr_month + '-' + curr_date;
//                    var date_format =  curr_date + '-' + curr_month + '-' + curr_year;
//                    var date_new = $('#s_date_' + id).datepicker('getDate');
//                    $('#sdate-search-' + id).datepicker("setDate", date_new);
//                    $('#s_date_' + id).html(date_format);
//                    $('#sdate-search-' + id).val(date_format);
//                    dosearch(id);
//                });
                
                $.each(res.data, function(key, trip) {
                    var tripcode = trip.tripCode;
                    
                    //  trip info
                    if( trip.tripInfo != "null" ) {
                        var info = '<table width="200"><tr> <th colspan="2">Bus & Driver Contact</th> </tr>';                     
                        if( trip.tripInfo.registrationNumber != '' ) {
                            info += '<tr> <td width="25%">Bus</td><td width="75%">'+trip.tripInfo.registrationNumber+'</td>';
                        }
                        
                        if( trip.tripInfo.driverName != '' ) {
                            info += '<tr> <td width="25%">Contact</td><td width="75%">'+trip.tripInfo.driverMobile+'</td>';
                            info += '<tr> <td width="25%">Driver</td><td width="75%">'+trip.tripInfo.driverName+'</td>';
                        }
                        info += '</table>';
                    }
                    
                    //  boarding points
                    var boarding = '<table width="200"><tr> <th colspan="2">Boarding Points</th> </tr>';
                    $.each(trip.fromStation.stationPoint, function(pbkey, bp) {
                        boarding += '<tr> <td width="65%">'+bp.name+'</td>    <td width="35%">'+dateToDateTime(bp.dateTime,2)+'</td>';
                    });
                    boarding += '</table>';
                    
                   //   droping points
                    var arrival = '<table width="200"><tr> <th colspan="2">Dropping Points</th> </tr>';
                    $.each(trip.toStation.stationPoint, function(pbkey, dp) {
                        arrival += '<tr> <td width="65%">'+dp.name+'</td>    <td width="35%">'+dateToDateTime(dp.dateTime,2)+'</td>';
                    });
                    arrival += '</table>';
                    
                    //  via routes
                    var via = '<table width="200"><tr> <th colspan="2">Via Routes</th> </tr>';
                    $.each(trip.viaStations, function(vkey, vname) {
                        via += '<tr> <td width="65%">'+vname.name+'</td>    <td width="35%">'+dateToDateTime(vname.dateTime,2)+'</td>';
                    });
                    via += '</table>';
                    
                    //  amenities
                    var amenities = '';
                    if(trip.amenities!='') {
                        $.each(trip.amenities, function(akey, ame) {
                            if(ame.code != 'AMEG2106511') {
                                amenities += '<a href="javascript:;" data-toggle="tooltip" title="'+ame.name+'" ><img src="assets/img/'+ame.code+'.png" width="17" /></a> &nbsp;&nbsp;';
                            }
                        });
                        $('#trip-info-'+tripcode).find('.amenities').html(amenities);
                    }
                    
                    $('#trip-row1-'+tripcode).find('.boarding').popover({
                        container:'body',
                        content:boarding,
                        html:true,
                        placement:'right',
                        trigger:'hover',
                    });

                    $('#trip-row1-'+tripcode).find('.arrival').popover({
                        container:'body',
                        content:arrival,
                        html:true,
                        placement:'right',
                        trigger:'hover',
                    });
                    
                    $('#trip-row1-'+tripcode).find('.via').popover({
                        container:'body',
                        content:via,
                        html:true,
                        placement:'right',
                        trigger:'hover',
                    }); 
                    
                    $('#trip-row1-'+tripcode).find('.tripinfo-bus').popover({
                        container:'body',
                        content:info,
                        html:true,
                        placement:'top',
                        trigger:'hover',
                    }); 

                });
                
                
                
                $("[data-toggle='tooltip']").tooltip();
                
                /*$('.has-cancel-popover').each(function() {
                 var tcode = $(this).attr('data-stageCode');
                 $(this).bind('click', function() {
                 $.ajax({
                 type: "POST",
                 url: "search/cancel-terms",
                 dataType: 'html',
                 data: 'stageCode=' + tcode,
                 //async: false,
                 success: function(res) {
                 dialogTerms(id, res);
                 }
                 });
                 });

                 });*/

                $('#result-panel-' + id).find('.ticket-row').each(function() {
                    var tripstatus = $(this).attr('data-tripstatus');
                    if(tripstatus=='TPY' && menu_permission['PHB-SHOW-TKT-INFO']!==1) { 
                        // do not show bus layout. Trip Yet Open, Not an admin user
                    } else {
                        $(this).bind('click', function(e, r) {						
                            if (!e)
                                e = window.event;

                            if ($(e.target).hasClass('has-cancel-popover') || $(e.srcElement).hasClass('has-cancel-popover')) {
                                return false;
                            }
                            if ($(this).hasClass('li_bk') && r!=1) {
                                $(this).find('.btn-success').html('View Seats');
                                closeBusLayout(id);
                                return false;
                            }
                            $('#Def_txt').val('');
                            $('#Def_txt').remove();

    //                        if ($("#busmap-" + id).html() != '' && !$(this).hasClass('li_bk')) {
    //                            if (!confirm("Are you sure to switch bus?")) {
    //                                return false;
    //                            }
    //                        }

                            $('#result-panel-' + id).find('.tr_buslayout').each(function() {
                                $(this).html('');
                            });

                            $("#result-panel-" + id).find('.li_bk').removeClass('li_bk');
                            $("#result-panel-" + id).find('.view-button').html('View Seats');
                            $("#result-panel-" + id).find('.settings').addClass('hide'); 


                            $(this).addClass('li_bk');
                            $(this).find('.btn-success').html('Hide Seats');


                            var sch_code = $(this).attr('data-schedulecode')
                            var tripCode = $(this).attr('data-trip');                        
                            var travelDate = $(this).attr('data-traveldate');
                            var fromCode = $(this).attr('data-from');
                            var toCode = $(this).attr('data-to');
                            var from_datetime = $(this).attr('data-from-datetime');

                            var tbid = $(this).attr('data-tab');

                            $("#result-panel-" + id).find('#sch_code').val(sch_code);                        
                            $("#result-panel-" + id).find('#trip_code').val(tripCode);
                            $("#result-panel-" + id).find('#travel_date').val(travelDate);
                            $("#result-panel-" + id).find('#from_station').val(fromCode);
                            $("#result-panel-" + id).find('#from_datetime').val(from_datetime);
                            $("#result-panel-" + id).find('#to_station').val(toCode);

                            $("#result-panel-" + id).find('#'+tripCode).html('<td colspan="7" ><div id="busmap-' + id + '" class="row" style="background-color:#fff; min-height:300px;"></div></td>');
                            $("#result-panel-" + id).find('#trip-info-'+tripCode).find('.settings').removeClass('hide');

                            Busmapload(tripCode, tbid, travelDate, fromCode, toCode);

                        });
                    }    
                });
            } else {
                $('#result-panel-' + id).html('<div class="well well-large"> Sorry! No bus available.</div>');
            }
        }
    });
/*html = '<div class=""> <div class=""></div> </div>';
     $('a[href="'+tab+'"]').html('Chennai to Madurai');
     $('#search-panel', tab).hide();
     $('#result-panel', tab).html($('#template').html());

     $('.ticket-row', tab).each(function() {
     $(this).bind('click', function() {
     $('li.active', tab).removeClass('active');
     $(this).addClass('active');
     $('.booking-pre-info', tab).hide();
     $('.booking-container', tab).show();
     $('.booking-container', tab).find('#close').bind('click', function() {
     $('.booking-pre-info', tab).show();
     $('.booking-container', tab).hide();
     $('li.active', tab).removeClass('active');
     });

     });
     });

     $('.has-popover').popover({
     trigger: 'hover',
     placement: 'top',
     html: true
     });
     */

}



function showFareList(){    
    var data = {}
    var id = gct();
    data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
    
    $('#busmap-' + id).find('#bus-result-list-action').addClass('hide');
    $('#busmap-' + id).find('#quota-list-action').addClass('hide');
    $('#busmap-' + id).find('#preference-list-action').addClass('hide');
    
    $('#busmap-' + id).find('#fare-list-action').removeClass('hide');
    
//    if ($("#result-panel-" + id).find('#trip-' + data.tripCode).data('seattype-count') < 3) {
//        var $container = $('#busmap-' + id).find('#fare-list-action');
//    } else {
        var $container = $("#result-panel-" + id).find('#' + data.tripCode).find('#busmap-' + id)
                .html('<div class="col-md-12"></div>').find('.col-md-12');
//    }
            
    $container.html('<br><br><br><div class="text-center">' + loading_big + '</div>');
    
    $.ajax({
        type: "GET",
        url: "search/get-trip-fare",
        dataType: 'html',
        data: data,
        success: function (html) {
            $container.html(html);
        }
    });
}

function saveFareSetup() {
    var id = gct();
    $('#busmap-' + id).find('.fare-cells').removeClass('inp_error');
    $('#busmap-' + id).find('#fare-action-error').html('');
    var new_fares = [];
    var er = false;
    $('#busmap-' + id).find('.fare-cells').each(function() {
        if(er==false) {
            var t= {};
            t.busSeatTypeCode = $(this).attr('data-type');
            t.fromcode = $(this).attr('data-from');
            t.tocode = $(this).attr('data-to');
            t.oldfare = $(this).attr('data-oldfare');
            t.newfare = $.trim( $(this).val() );
            t.minfare = Number($(this).attr('data-minfare'));
            t.maxfare = Number($(this).attr('data-maxfare'));

            if(t.newfare=="") {
                $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Fare value should not empty</div>');
                er = true;
                $(this).addClass('inp_error').focus();
            } else if(isNaN(t.newfare)) {
                $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Fare should be valid number</div>');
                er = true;                
                $(this).addClass('inp_error').focus();
            } if(t.newfare.length<3) {
                $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Fare should be more than 2 numbers</div>');
                er = true;
                $(this).addClass('inp_error').focus();
            } else if(t.minfare > 0 && Number(t.newfare) < t.minfare) {
                $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Please update the fare ' + t.minfare + ' or above</div>');
                er = true;
                $(this).addClass('inp_error').focus();
            } else if(t.maxfare > 0 && Number(t.newfare) > t.maxfare) {
                $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Please update the fare ' + t.maxfare + ' or below</div>');
                er = true;
                $(this).addClass('inp_error').focus();
            }
            
            if( Number(t.newfare)!= Number(t.oldfare)) {
               new_fares.push(t); 
            }
        }
    });
    
    if(er==false) {
        if(new_fares.length==0) {
            $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Nothing changed to update</div>');
            return;
        }
        $('#busmap-' + id).find('#fare-action-error').html(loading_small);
        $('#busmap-' + id).find('#fare-action-button').hide();
        var data = {};
        data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
        data.fares = new_fares;
        $.ajax({
            type: "POST",
            url: "search/save-trip-fare",
            dataType: 'json',
            data: data,
            success: function(res) {
                if(res.status==1) {
                    refreshBusLayout();
                    ga_track_event('Search', 'Trip Fare', 'Change Trip Fare');
                } else {
                    $('#busmap-' + id).find('#fare-action-error').html('<div class="alert alert-danger">Failed to update fare, try again</div>');
                    $('#busmap-' + id).find('#fare-action-button').show();
                }
            }
        });
    }
}

function clearFareSetup() { 
    var id = gct();
    $('#busmap-' + id).find('#quota-list-action').addClass('hide');    
    $('#busmap-' + id).find('#fare-list-action').addClass('hide');
    
    $('#busmap-' + id).find('#bus-result-list-action').removeClass('hide');
    $('#busmap-' + id).find('#bus-result-list-action').html('<br><br><br><div class="well well-large" align="center">Please select a seat to get more options.</div>');
    
    if(!$('#busmap-' + id).find('#fare-list-action').length) {
        refreshBusLayout();
    }
}

function showQuotaList(){    
    var data = {}
    var id = gct();
    data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
    
    $('#busmap-' + id).find('#bus-result-list-action').addClass('hide');
    $('#busmap-' + id).find('#fare-list-action').addClass('hide');
    $('#busmap-' + id).find('#preference-list-action').addClass('hide');
    
    $('#busmap-' + id).find('#quota-list-action').removeClass('hide');
    $('#busmap-' + id).find('#quota-list-action').html('<br><br><br><div class="text-center">'+loading_big+'</div>');
    $.ajax({
        type: "GET",
        url: "search/get-detailed-quota",
        dataType: 'html',
        data: data,
        success: function(html) {
           $('#busmap-' + id).find('#quota-list-action').html(html);
        }
    });
}

function deleteDetailedQuota(index) {
    if(confirm('Do you want to delete this quota?')) {
        var id = gct();
        busmap = busMapData[id];
        var quota = detaildquota[index];
        quota.activeFlag = 2;
        $('#busmap-' + id).find('#quota-list-action').find('#releasebtn'+index).html(loading_popup);
        var data = {};    
        data.quota = quota;
        data.tripCode = busmap.busmap.tripCode;
        $.ajax({
            type: "POST",
            url: "search/delete-detailed-quota",
            dataType: 'json',
            data: data,
            success: function(result) {
                if(result.status==1) {
                    $('#busmap-' + id).find('#quota-list-action').find('#releasebtn'+index).html('Deleted');
                    $('#busmap-' + id).find('#quota-list-action').find('#quotarow'+index).animate({backgroundColor: '#1AA1E1'}, 4000, function() {
                        $(this).remove()
                    });
                } else {

                }
            }
        });
    }
}

function clearDetailedQuotaList() { 
    var id = gct();
    $('#busmap-' + id).find('#quota-list-action').addClass('hide');    
    $('#busmap-' + id).find('#fare-list-action').addClass('hide');
    
    $('#busmap-' + id).find('#bus-result-list-action').removeClass('hide');
    $('#busmap-' + id).find('#bus-result-list-action').html('<br><br><br><div class="well well-large" align="center">Please select a seat to get more options.</div>');
}

function saveQuotaSeats() {
    var data = {}
    var id = gct();
    data.scheduleCode = $("#result-panel-" + id).find('#sch_code').val();
    data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
    data.travelDate = $("#result-panel-" + id).find('#travel_date').val();
    data.user = $("#result-panel-" + id).find('#quota-user').val();
    data.route = $("#result-panel-" + id).find('#alloc-quota-route').val();
    data.scope = $("#result-panel-" + id).find("input[name='alloc-quota-scope']:checked").val();
    data.releaseminute = $("#result-panel-" + id).find('#quota-rele-time').val();
    data.remarks = $("#result-panel-" + id).find('#aloc-remarks').val().trim();
    
    var ts = [];
    $('#busmap-' + id).find('.schedule-seat').each(function() {
        ts.push( $(this).attr('data-code') );
    });
    
    data.seats = ts;
    
    $('#busmap-' + id).find('#quota-action-error').removeClass('alert alert-danger').html('');
    
    if (data.scope == undefined && data.user == "" || data.scope == 'UR' && data.user == "") {
        $('#busmap-' + id).find('#quota-action-error').addClass('alert alert-danger').html('Please select a user');
        return;
    }
    if(data.scope == 'SG' && data.route=="") {
        $('#busmap-' + id).find('#quota-action-error').addClass('alert alert-danger').html('Please select a Route');
        return;
    }
    
    if(data.seats=="") {
        $('#busmap-' + id).find('#quota-action-error').addClass('alert alert-danger').html('Please select atleast one seat');
        return;
    }
    
    $.ajax({
        type: "POST",
        url: "search/save-trip-quota",
        dataType: 'json',
        data: data,
        success: function(res) {
            if(res.status==1) {
                refreshBusLayout();
            }
        }
    });
}

function setQuotaSeatsPane(){    
    var id = gct();
    $('#busmap-' + id).find('#quota-list-action').addClass('hide');    
    $('#busmap-' + id).find('#fare-list-action').addClass('hide');    
    $('#busmap-' + id).find('#bus-result-list-action').removeClass('hide');
    
    busmap = busMapData[id];
    var tmpl = $('#template-quota-container').html();
    tmpl = $('<div>').html(tmpl).clone();
        
    $('#busmap-' + id).find('#bus-result-list-action').html(tmpl); 
    
    if(menu_permission['ADD-QUOTA-TO-OTHERS']==1) {
        $("#result-panel-" + id).find('#detailed-quota-user').select2({
            placeholder: "Select a user"
        });
    }
    
    $('#busmap-' + id).find('.schedule-seat').each(function() {
        var tr = $('#template-quota-pane-seat-list').html();
        tr = $('<div>').html(tr).clone();
        
        var code = $(this).attr('data-code');
        tr.find('.gen').attr('name', 'gender-' + id + '-' + code);
        
        if (busmap.seatDetails[code]['genderstatus'] == 'AM' && busmap.seatDetails[code]['genderstatus'] != undefined) {
            tr.find('.female').attr('disabled', 'disabled');
            tr.find('.male').attr('checked', true);            
        } else if (busmap.seatDetails[code]['genderstatus'] == 'AF' && busmap.seatDetails[code]['genderstatus'] != undefined) {
            tr.find('.male').attr('disabled', 'disabled');
            tr.find('.female').attr('checked', true);
        } else {
            tr.find('.male').attr('checked', true);
        }
        
        tr.find('.seat-no').html(busmap.seatDetails[code]['seatName']);
        tr.find('tr').attr('data-code', code);
        tr.find('tr').attr('data-name', busmap.seatDetails[code]['seatName']);
        
        $("#busmap-" + id).find('#quota-contact-list tbody').append(tr.html());
    });
    
    $('#busmap-' + id).find('.btn-quotaclr').click(function() {
        clearResult(id);
    });
    
    $('#busmap-' + id).find('.btn-quotaconfirm').click(function() {
        var data = {};
        data.fromStation = busmap.busmap.fromStation.code;
        data.toStation = busmap.busmap.toStation.code;
        data.remarks = '';
        data.tripCode = busmap.busmap.tripCode;
        data.user = $("#result-panel-" + id).find('#detailed-quota-user').val();
        data.releaseminute = $("#result-panel-" + id).find('#detailed-quota-rele-time').val();
        data.seats = [];
        
        $('.quota-row').each( function() {
            var seat = {};
            $(this).find('.gen').each( function() {
                if( $(this).is(':checked') == true )
                  seat.passengerGendar = $(this).val();
            });
            seat.seatCode = $(this).attr('data-code');
            seat.seatName = $(this).attr('data-name');
            
            data.seats.push(seat);
        });
        
        if(data.user=="") {
            $('#busmap-' + id).find('#quotarow-action').removeClass('hide');
            $('#busmap-' + id).find('#quotarow-action').html('<div class="alert alert-danger">Please select a user to assign quota</div>');
            return;
        }
        
        $('#busmap-' + id).find('#quotarow-button').addClass('hide');
        $('#busmap-' + id).find('#quotarow-action').removeClass('hide');            
        $('#busmap-' + id).find('#quotarow-action').html(loading_popup);

        $.ajax({
            type: "POST",
            url: "search/add-detailed-quota",
            dataType: 'json',
            data: data,
            success: function(result) {
                $('#busmap-' + id).find('#quotarow-action').html('<div class="alert alert-success">Your request has been processed successfully</div>');
                if(result.status == 1) {
                    window.setTimeout(function() {
                        refreshBusLayout();
                        ga_track_event('Search', 'Quota allocation', 'Detailed quota allocation');
                    }, 3000);                
                } else {
                    $('#busmap-' + id).find('#quotarow-action').html('<div class="alert alert-danger">'+result.errorDesc+'</div>');
                    $('#busmap-' + id).find('#quotarow-button').removeClass('hide');
                }
            }
        });
        
    });
}

function blockQuotaSeats() {
    var data = {}
    var id = gct();
    data.scheduleCode = $("#result-panel-" + id).find('#sch_code').val();
    data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
    data.travelDate = $("#result-panel-" + id).find('#travel_date').val();
    data.user = $("#result-panel-" + id).find('#quota-user').val();
    data.route = $("#result-panel-" + id).find('#alloc-quota-route').val();
    data.scope = $("#result-panel-" + id).find("input[name='alloc-quota-scope']:checked").val();
    data.releaseminute = $("#result-panel-" + id).find('#quota-rele-time').val();
    data.remarks = $("#result-panel-" + id).find('#aloc-remarks').val().trim();
    
    var ts = [];
    $('#busmap-' + id).find('.schedule-seat').each(function() {
        ts.push( $(this).attr('data-code') );
    });
    
    data.seats = ts;
    
    $('#busmap-' + id).find('#quota-action-error').removeClass('alert alert-danger').html('');
    
    if(data.seats=="") {
        $('#busmap-' + id).find('#quota-action-error').addClass('alert alert-danger').html('Please select atleast one seat');
        return;
    }
    
    if(data.scope == 'SG' && data.route=="") {
        $('#busmap-' + id).find('#quota-action-error').addClass('alert alert-danger').html('Please select a Route');
        return;
    }
    
    if(data.scope == undefined && data.user == "" || data.scope == 'UR' && data.user == "") {
        if(confirm('Do you want to block selected seats from all users?')) {
            $.ajax({
                type: "POST",
                url: "search/block-trip-quota",
                dataType: 'json',
                data: data,
                success: function(res) {
                    if(res.status==1) {
                        refreshBusLayout();
                    }
                }
            });
        }
    } else {
        $.ajax({
            type: "POST",
            url: "search/block-trip-quota",
            dataType: 'json',
            data: data,
            success: function(res) {
                if(res.status==1) {
                    refreshBusLayout();
                }
            }
        });
    }
}

function clearQuotaSeats() {
    var id = gct();
    $('#busmap-' + id).find('#quota-user').val('');
    $('#busmap-' + id).find('#quota-rele-time').val('-1');
    $('#busmap-' + id).find('#quota-action-error').removeClass('alert alert-danger').html('');
}

function releaseQuotaSeats(){
    var data = {}
    var id = gct();
    var ts = [];
    $('#busmap-' + id).find('.selected-for-release').each(function() {
        ts.push( $(this).attr('data-code') );
    });    
    data.seats = ts;
    
    if(confirm('Do you want to release this seat?')) {        
        data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
        $('#busmap-' + id).find('#release-button').hide();
        $('#busmap-' + id).find('#release-action-error').removeClass('alert alert-danger').html(loading_small);  
        $.ajax({
            type: "POST",
            url: "search/delete-trip-quota",
            dataType: 'json',
            data: data,
            success: function(res) {
                if(res.status==1) {
                    refreshBusLayout();
                } else {
                    $('#busmap-' + id).find('#release-action-error').addClass('alert alert-danger').html('Sorry! Try again');
                    $('#busmap-' + id).find('#release-button').show();
                    window.setTimeout(function() {
                        $('#busmap-' + id).find('#release-action-error').removeClass('alert alert-danger').html('');
                    }, 4000);
                }               
            }
        });
    }
}

function renderBookingSummary(summary, id) {  
    var bhtml = '<table width="300"><tr class="bborder"><td class="bold" >Boarding Details</td><td class="bold text-center" >Seats</td></tr>';
    var btot = 0;
    $.each(summary.boarding, function(pbname, pb) {
        bhtml += '<tr class="bborder"><td>'+pbname+'</td><td align="center">'+pb.length+'</td></tr>';
        btot += pb.length;
    });
    if (btot > 0) {
        bhtml += '<tr class="bborder"><td><b>Total</b></td><td align="center"><b>' + btot + '</b></td></tr>';
    }
    bhtml += '</table>';    
    $('#busmap-' + id).find('#s-boarding').popover({
        container:'body',
        content:bhtml,
        html:true,
        placement:'right',
        trigger:'hover',
    });
                    
    var rhtml = '<table width="300"><tr class="bborder"><td class="bold" >Route</td><td class="bold text-center" >Seats</td></tr>';
    $.each(summary.route, function(name, v) {
        rhtml += '<tr class="bborder"><td>'+name+'</td><td align="center">'+v.length+'</td></tr>';
    });
    rhtml += '</table>';
    $('#busmap-' + id).find('#s-route').popover({
        container:'body',
        content:rhtml,
        html:true,
        placement:'right',
        trigger:'hover',
    });
    
    var uhtml = '<table width="300"><tr class="bborder"><td class="bold" >Booked By</td><td class="bold text-center" >Seats</td></tr>';
    $.each(summary.user, function(name, v) {
        uhtml += '<tr class="bborder"><td>'+name+'</td><td align="center">'+v.length+'</td></tr>';
    });
    uhtml += '</table>';
    $('#busmap-' + id).find('#s-bookedby').popover({
        container:'body',
        content:uhtml,
        html:true,
        placement:'right',
        trigger:'hover',
    });
    
    var gender = {'M': 'Male', 'F': 'Female'}
    var uhtml = '<table width="300"><tr class="bborder"><td class="bold" >Gender</td><td class="bold text-center" >Seats</td></tr>';
    $.each(summary.gender, function(name, v) {
        uhtml += '<tr class="bborder"><td>'+gender[name]+'</td><td align="center">'+v.length+'</td></tr>';
    });
    uhtml += '</table>';
    $('#busmap-' + id).find('#s-gender').popover({
        container:'body',
        content:uhtml,
        html:true,
        placement:'right',
        trigger:'hover',
    });
}

function Busmapload(trip, id, travelDate, fromCode, toCode) {
    $('.has-popover').each(function() {
        $(this).popover('hide');
    });

    var data = {}
    data.tripCode = trip; //$(this).attr('data-trip');    
    data.travelDate = travelDate;
    data.fromCode = fromCode;
    data.toCode = toCode;
    
    tripStageCode[id] = data.tripCode;
    data.id = id;
    $(this).attr('data-tab');
    $("#busmap-" + id).html('<div class="row"><div class="col-md-offset-5" style="padding-top:110px"><img src="'+base_url+'assets/img/loaders/20.gif" /></div></div>');

    $.ajax({
        type: "POST",
        url: "search/get-busmap-v3",
        dataType: 'json',
        data: data,
        success: function(res) {
            if(res.status==0){
                $("#busmap-" + id).html('<div class="alert alert-danger"> Sorry! Falied loading data </div>');
                return;
            }
            seatStatusDetails[id] = res.busmap.bus.seatLayoutList;
            busMapData[id] = res;
            tripTickets[id] = res.tripSync.tickets;
            busMap(res, id);
            if(res.summaryStatus>0) {
                $("#busmap-" + id).find('.busmap-summary').removeClass('hide');
                renderBookingSummary(res.summary, id);
            }
            $("[data-toggle='tooltip']").tooltip();
            
            $('#busmap-' + id).find('#alloc-quota-route').html('<option value="' + res.busmap.fromStation.code + '-' + res.busmap.toStation.code + '">' + res.busmap.fromStation.name + ' - ' + res.busmap.toStation.name + '</option>');
            $('#busmap-' + id).find("input[name='alloc-quota-scope']").off('change').on('change', function() {
                if($('#busmap-' + id).find("input[name='alloc-quota-scope']:checked").val() == "SG") {
                    $('#busmap-' + id).find('.quota-user-cont').addClass('hide');
                    $('#busmap-' + id).find('.alloc-quota-route-cont').removeClass('hide');
                } else {
                    $('#busmap-' + id).find('.quota-user-cont').removeClass('hide');
                    $('#busmap-' + id).find('.alloc-quota-route-cont').addClass('hide');
                }
            });
            
            $('html, body').animate({
                scrollTop: $('#trip-'+trip).offset().top-80
            }, 1000);
        }
    });
}

function init_route_map(stages) {
    //   init map tab
    var source = [];
    var start = [];
    var c = parseInt(1);
    var loc = [];
    $.each(stages.data, function(key, stage) {           
        loc.push('<span class="f14"> <i class="fa fa-map-marker"></i> '+stage.fromStation.name+' </span> &nbsp; ');
        loc.push('<i class="fa fa-long-arrow-right f14"></i> &nbsp; ');
        $.each(stage.fromStation.stationPoint, function(pbkey, bp) {
            var data = {};
            data.name = bp.name;
            data.latitude = bp.latitude;
            data.longitude = bp.longitude;
            data.address = bp.address;
            data.landmark = bp.landmark;
            data.time = dateToDateTime(bp.dateTime,2);
            if(c==1) start.push(data);
            else source.push(data);
            c++;
        });                          
    });
    loc.pop();
    var t = loc.join(' ');
    $('.map-locations').html(loc);
            
    var opt = {};
    opt.element = 'g-map';
    opt.startpoint = start[0]; 
    opt.endpoint = source.pop();
    opt.source = source;    
    opt.center = {lat:'13.06917', lang:'80.19139'};    
    
    myRouter.init(opt);
    
}
function getAuditHistory(schcode, tripcode) {
    $('#trip-settings').removeClass('hidden');
    $('#trip-settings').dialog({
        autoOpen: true,
        height: 600,
        width: 600,
        modal: true,
        resizable: false,
        clickOutside: true
    });
    $(".ui-dialog-titlebar").hide();
    
    $("#trip-settings").html(loading_popup);
    var data = {};
    data.scheduleCode = schcode;
    data.tripCode = tripcode;
    $.ajax({
         type: "POST",
         url: base_url + "report/trip-audit-history",
         data: data,
         dataType: 'html',
         success: function(res) {             
            $("#trip-settings").html(res);                        
         }
     });
}

function closeTripHistoryDialog() {
    $('#trip-settings').dialog('destroy');
    $('#trip-settings').hide();
}

var settings_code = '';
var settings_date = '';
function tripMoreOptions(ele, schedule, trip, date) {
    var id = gct();
    var act = $(ele).attr('data-ref');
    settings_code = schedule;
    settings_date = date;
    
    $("#result-panel-" + id).find('#sch-workspace-content').html('');   //  clear schedule more option container to aviod conflit            
    $("#result-panel-" + id).find('#sch_code').val(settings_code);
        
    if(act=='visiblity'){
        load_seat_visiblity();
    } else if(act=='fareoverride'){
        var tmp = $('#template-trip-setings').html();
        $("#result-panel-" + id).find('#'+trip).find('#busmap-'+id).html(tmp).clone();
        load_fare_overrides();
    }
}

function close_settings_popup() {
    $('#trip-settings').dialog('close');
    refreshBusLayout();
}

function load_fare_overrides() {    
    var data = {};
    var id = gct();
    data.code = settings_code;
    data.tripDate = settings_date;
    $("#result-panel-" + id).find('#trip-workspace').html(loading_popup);
    $.ajax({
         type: "POST",
         url: base_url + "schedules/get-schedule-auto-override?from=search",
         data: data,
         dataType: 'html',
         success: function(res) {             
             $("#result-panel-" + id).find('#trip-workspace').html(res);
             //$('#fao-date_disc').val(settings_date+' | '+settings_date); 
         }
     });
}

function load_seat_visiblity() {    
    var data = {};
    var id = gct();
    data.code = settings_code;
    data.tripDate = settings_date;
    
    $("#busmap-" + id).html('');
    
    $('#trip-settings').removeClass('hidden');
    $('#trip-settings').dialog({
        autoOpen: true,
        height: 600,
        width: 1050,
        modal: true,
        resizable: false,
        clickOutside: true
    });
    $(".ui-dialog-titlebar").hide();
    
    $("#trip-settings").html(loading_popup);
    $.ajax({
         type: "POST",
         url: base_url + "schedules/trip-seat-visiblity?from=search",
         data: data,
         dataType: 'html',
         success: function(res) {             
            $("#trip-settings").html(res);                        
         }
     });
}

function close_info_popup() {
    $('#trip-info').dialog('close');
}


var trip_stages = '';
function dialogTerms(stagecode, tripcode) {    
    var tmp = $('#template-trip-info').html();
    $('#trip-info').html(tmp).clone();
    $('#tabs_a_exp a:first').tab('show');
    
    $('#g-map').html('');
    $('#i-boarding').html('');
    
    $('#trip-info').removeClass('hidden');
    $('#trip-info').dialog({
        autoOpen: true,
        height: 600,
        width: 950,
        modal: true,
        resizable: false,
        clickOutside: true
    });
    $(".ui-dialog-titlebar").hide();
    
    $('a[href="#t-map"]').on('shown.bs.tab', function (e) {        
        //init_route_map(trip_stages);
    })
    
    $('#i-from').html( $('.from').html() );
    $('#i-to').html( $('.to').html() );
    $('#i-date').html( $('.date').html() );
    
    //  staion points
    var data = {};
    data.tripCode = tripcode;
    $.ajax({
         type: "POST",
         url: base_url + "search/stage-details",
         data: data,
         dataType: 'json',
         success: function(res) {
             trip_stages = res;
             if(res.status==1) {
                //  render station points
               var html = '<table class="table"><tr><th>Name</th><th>Address</th><th>Landmark</th><th>Time</th></tr>';
               $.each(res.data, function(key, stage) {
                    html += '<tr class="active bold"><td  colspan="4">'+stage.fromStation.name+' - '+dateToDateTime(stage.fromStation.dateTime,2)+'</td></tr>';
                    $.each(stage.fromStation.stationPoint, function(pbkey, bp) {
                        html += '<tr> <td>'+bp.name+'</td><td>'+bp.address+'<br>'+bp.number+'</td><td>'+bp.landmark+'</td><td>'+dateToDateTime(bp.dateTime,2)+'</td></tr>';
                    });                          
               });
               html += '</table>';
               $('#i-boarding').html(html);
               
               //init_route_map(res); // google map init function

               //$('#tabmap').bind( 'click', function() {
                   //init_route_map(res);
               //});
             } else {
                 
             }
         }
     });
     
    //  cancellation policy
    $('#policy-loader').removeClass('hidden');
    $('#policy-loader').html('Please wait...');
    var data = {};
    data.stageCode = stagecode;
    $.ajax({
         type: "POST",
         url: base_url + "search/cancel-terms",
         data: data,
         dataType: 'json',
         success: function(res) {             
             if(res.status==1) {
                $('#policy-loader').addClass('hidden');
                var policy = '';
                $.each(res.data.policyList, function(pbkey, bp) {
                    policy += '<tr> <td>'+bp.term+'</td><td>'+bp.deductionAmountTxt+'</td><td>'+bp.refundAmountTxt+'</td><td>'+bp.chargesTxt+'</td></tr>';
                });
                $('#i-policy').removeClass('hidden');
                $('#i-policy').find('.table>tbody').html(policy);
             } else{
                 $('#policy-loader').removeClass('hidden');
                 $('#policy-loader').html('Sorry. Problem in showing cancellation policy.');
             }
         }
     });
     
    return;
    
    var id = $(obj).attr('data-tap');
    $('#cancel-terms-dialog' + id).css('background', '#fff');
    $('#cancel-terms-dialog' + id).html('');

    $('#cancel-terms-dialog' + id).dialog({
        autoOpen: true,
        height: 300,
        width: 400,
        modal: true,
        closeOnEscape: false,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#cancel-terms-dialog' + id).show();
    $('#cancel-terms-dialog' + id).html(loading_big);
    var tcode = $(obj).attr('data-stageCode');

    $.ajax({
        type: "POST",
        url: "search/cancel-terms",
        dataType: 'html',
        data: 'stageCode=' + tcode,
        success: function(res) {
            $('#cancel-terms-dialog' + id).html(res);
            $('#cancel-terms-dialog' + id).find('.close-cancel').attr('onclick', 'closeCancelDialog(' + id + ')');
            $('#cancel-terms-dialog' + id).find('.ovr_cancel').css('max-height', '170px').perfectScrollbar({
                wheelSpeed: 20,
                wheelPropagation: false
            });
        }
    });


    $('#cancel-terms-dialog' + id).show();


//
}
function closeCancelDialog(id) {
    $('#cancel-terms-dialog' + id).dialog('destroy');
    $('#cancel-terms-dialog' + id).hide();
}
function busMap(bus, id) {

    var html = '';
    var upst;
    var lwst;
    var busmap = $('#template-busmap-list').html();
    busmap = $('<div>').html(busmap).clone();
    
    var seaterFound = false;
    $.each(bus.busmap.stageFare, function(ke, stg) {
        if( stg.seatType == "SS" || stg.seatType == "ST" | stg.seatType == "PB" )
            seaterFound = true;
    });
    
    var result = busSeat(bus.lrowmax, bus.lcolmax, bus.lrowmin, bus.lcolmin, bus.seatStatus, bus.seatDetails, 1, id, seaterFound, bus.tripSync);
    
    busmap.find('#trip-status').attr('data-tripstatus', bus.busmap.tripStatus.code );
    var tts = $('#trip-'+bus.busmap.tripCode).attr('date-timestatus');
    busmap.find('#trip-status').attr('data-timestatus', tts );
    
    if(bus.busmap.tripStatus.code=="TPC") {
       busmap.find('#trip-status').removeClass('hidden');
       busmap.find('#trip-status').find('.alert').html('Trip has been closed and booking not allowed');
    }
    
    if(bus.busmap.tripStatus.code=="TPY") {
       busmap.find('#trip-status').removeClass('hidden');
       busmap.find('#trip-status').find('.alert').html('Trip not yet opened and booking not allowed');
    }
    
    if(bus.busmap.tripStatus.code=="TCA") {
       busmap.find('#trip-status').removeClass('hidden');
       busmap.find('#trip-status').find('.alert').html('Trip cancelled and booking not allowed');
    }
    
    html = result[0];

    if(result[1]!=''){
        lwst = result[1];
    }

    busmap.find('.lower').html(html);
    busmap.find('.frm-sta').html("&nbsp;" + bus.busmap.fromStation.name);
    busmap.find('.to-sta').html("&nbsp;" + bus.busmap.toStation.name);
    busmap.find('.trp-date').html("&nbsp;" + dateToDateTime(bus.busmap.fromStation.dateTime));
    tripDate[id] = bus.busmap.fromStation.dateTime;
    fromStation[id] = bus.busmap.fromStation.code;
    toStation[id] = bus.busmap.toStation.code;
    if (bus.urowmax != '' && bus.urowmax != undefined && bus.ucolmax != '' && bus.ucolmax != undefined) {
        var result = busSeat(bus.urowmax, bus.ucolmax, bus.urowmin, bus.ucolmin, bus.seatStatus, bus.seatDetails, 2, id, seaterFound, bus.tripSync);
        html = result[0];
        if(result[1]!=''){
            upst = result[1];
        }
        busmap.find('.upper').html(html);
        busmap.find('.upper-layer').removeClass('hide');
        busmap.find('.seat-map-selayer').removeClass('hide');
    }


    $("#busmap-" + id).html(busmap.html());
    if(lwst!=''){
        $("#busmap-" + id).find(lwst).show();
    }
    if(upst!=''){
        $("#busmap-" + id).find(upst).show();
    }

    $("#busmap-" + id).find('#close').click(function() {
        //$("#busmap-" + id).html('<div id="Def_txt"><div class="well well-large">Please select bus to know more details.</div></div>');
        //$("#busmap-" + id).parent().remove();
        //$("#result-panel-" + id).find('.li_bk').removeClass('li_bk'); 
        closeBusLayout(id);
    });
    $("#busmap-" + id).find('#refresh').click(function() {
        $("#busmap-" + id).html('');
        //$("#result-panel-" + id).find('.li_bk').trigger('click');
        var tripCode = $("#result-panel-" + id).find('.li_bk').attr('data-trip');
        var tbid = $("#result-panel-" + id).find('.li_bk').attr('data-tab');
        
        var travelDate = $("#result-panel-" + id).find('.li_bk').attr('data-traveldate');
        var fromCode = $("#result-panel-" + id).find('.li_bk').attr('data-from');
        var toCode = $("#result-panel-" + id).find('.li_bk').attr('data-to');
                        
        Busmapload(tripCode, tbid, travelDate, fromCode, toCode);
    });
    
    
    
    /*  $("#busmap-"+id).find('.viewBookList').click(function() {

     if($(this).is(':checked')){

     for(var loop=1; loop < $("#busmap-"+id).find('.name').length; loop++)
     {
     $('#bname-'+id+'-'+loop).show().removeClass('hide');
     $('#bage-'+id+'-'+loop).show().removeClass('hide');
     }
     }else{
     for(var loop=1; loop< $("#busmap-"+id).find('.name').length; loop++)
     {
     $('#bname-'+id+'-'+loop).hide().addClass('hide');
     $('#bage-'+id+'-'+loop).hide().addClass('hide');
     }
     }
     });*/
    $('[data-toggle=popover]').popover({
        container: "body",
        placement:'right',
        html: true
    });
    
    // manage available seats clicks
    $("#busmap-" + id).find('.seat-select-visibility').click(function() {

        if ($("#busmap-" + id).find('.cancel-seat-process').length > 0 || 
                $("#busmap-" + id).find('.phone-seat-process').length > 0 ) {
            alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
            return false;
        } //
        
        if( !$(this).hasClass('seat-available-you') ) { //  validate for release & booking
            var r = false;
            $("#busmap-" + id).find('.selected-for-release').each(function() {  
                if( $(this).hasClass('seat-available-other') ) {
                    r = true;
                }           
            });

            if(r==true) {
                alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
                return false;
            }
        }
        
        var sel_seat_cnt = $("#busmap-" + id).find('.schedule-seat').length;
        $(this).toggleClass("schedule-seat");
        set = '';
        totamt = 0;
        tax = 0;
        gst = 0;
        seatfare = 0;
        discountFare = 0;
        
        resetOfflineDiscount();

        var seat = bus.seatDetails[$(this).attr('data-code')]['seatName'];
        var seat_code = $(this).attr('data-code');
        //

        if ($("#busmap-" + id).find('.schedule-seat').length == 1) { // available seats.
            //$('')template-book-list
            ts = $("#busmap-" + id).find('#trip-status').attr('data-tripstatus'); 
            tts = $("#busmap-" + id).find('#trip-status').attr('data-timestatus'); // trip time past or not
                        
            if(ts=="TPY" || ts=="TCA")  {    // trip yet to open, trip cancelled
                //$(this).toggleClass("schedule-seat");
                //alert('Sorry! Booking not allowed');
                return false;
            }
            
            if(ts=="TPC")  {    // trip closed
                if(parseInt( menu_permission['BOOK-AFTER-TRIP-TIME'] ) != 1 || tts==0) {                
                    //$(this).toggleClass("schedule-seat");
                    //alert('Sorry! Booking not allowed');
                    return false;
                }
            }

            
            
            var seatDiv = $('#template-book-list').html();
            seatDiv = $('<div>').html(seatDiv).clone();
            seatDiv.find('.btn-cancel').attr('onclick', 'clearResult(' + id + ')');
            var option = '<option value="">Boarding Points</option>';
            $.each(bus.busmap.fromStation.stationPoint, function(ke, svalue) {
                option += '<option value="' + svalue.code + '" data-fare="' + svalue.fare + '">' + svalue.name + ' - '+ dateToDateTime(svalue.dateTime,2) +'</option>';
            });
            seatDiv.find('#bording-point').html(option).attr('onchange', 'recalculateSplDiscount(' + id + ')');
            if (dropFlag) {
                var option = ''; 
                if(bus.busmap.toStation.stationPoint.length>1) {    // select default if only one drop available
                    option += '<option value="">Dropping Points</option>'; 
                }
                $.each(bus.busmap.toStation.stationPoint, function(dkey, dval) {
                    option += '<option value="' + dval.code + '" data-fare="' + dval.fare + '">' + dval.name + ' - '+ dateToDateTime(dval.dateTime,2) +'</option>';
                });
                seatDiv.find('#dropping-point').html(option).attr('onchange', 'recalculateSplDiscount(' + id + ')');
                //seatDiv.find('.drp-lst').removeClass('hide')
            //
            }
            
            $("#busmap-" + id).find('#bus-result-list-action').html(seatDiv.html());
            $("#busmap-" + id).find('#offlineuser').select2({
                placeholder: "Select a user",
                escapeMarkup: function(markup) {
                    return markup;
                }
            });

            $('#quota-user').select2({
                placeholder: "Select a user"
            });
            
            $("#busmap-" + id).find('#spldiscount').attr('index', id);
            $("#busmap-" + id).find('#agentservicecharges').attr('index', id);
            
            initbooking(id, bus);
            
            
        }

        if ( !$(this).hasClass('schedule-seat')) {
            $('.seat-' + id + '-'+ seat_code).remove();
        }
        
        $("#busmap-" + id).find('.schedule-seat').each(function(i, v) {            
            var code = $(this).attr('data-code');
            if (set != '')
                set += ',';
            if (bus.seatDetails[code] != undefined) {
                set += bus.seatDetails[code]['seatName'];
            }
            if (bus.seatDetails[code] != undefined) {
                gst = Number(bus.seatDetails[code]['serviceTax']);
                seatfare = seatfare + Number(bus.seatDetails[code]['fare']);
                discountFare = discountFare + Number(bus.seatDetails[code]['discount']);

                totamt = totamt + Number(bus.seatDetails[code]['fare']) - Number(bus.seatDetails[code]['discount']);
            }
            
            if ($('#bname-' + id + '-' + code).val() == undefined) {
                var tr = $('#template-contact-list').html();
                tr = $('<div>').html(tr).clone();
                if (i == 0) {
                    tr.find('.name').addClass('autofill');
                } else {
                    tr.find('.name').addClass('fillauto');
                }
                
                var gen_len = $('.schedule-seat').length - 1;
                tr.find('.name').attr('id', 'bname-' + id + '-' + code);
                tr.find('.age').attr('id', 'bage-' + id + '-' + code);
                tr.find('.gen').attr('id', 'gendar-' + gen_len);
                tr.find('.gen').attr('name', 'gender-' + id + '-' + code);
                
                tr.find('.gen').attr('onchange', 'recalculateSplDiscount(' + id + ')'); // validate female discount
                
                if (bus.seatDetails[code]['genderstatus'] == 'AM' && bus.seatDetails[code]['genderstatus'] != undefined) {
                    tr.find('.female').attr('disabled', 'disabled');
                }
                if (bus.seatDetails[code]['genderstatus'] == 'AF' && bus.seatDetails[code]['genderstatus'] != undefined) {
                    tr.find('.male').attr('disabled', 'disabled');
                }
                tr.find('.seat-no').html(bus.seatDetails[code]['seatName']);
                if (bus.seatDetails[code] != undefined) {
                    tr.find('.seat-fare-list').html('<i class="fa fa-rupee"></i> ' + bus.seatDetails[code]['fare']);
                }
                if (bus.seatDetails[code] != undefined && bus.seatDetails[code]['discount'] > 0) {
                    tr.find('.discount-list').html('<i class="fa fa-rupee"></i> ' + bus.seatDetails[code]['discount']);
                }else{
                	tr.find('.discount-list').html('<i class="fa fa-rupee"></i> ' + 0);
                }
                tr.find('tr').addClass('seat-' + id + '-'+ code);
                
                tr.find('tr').addClass('seats-' + id );
                tr.find('tr').attr('data-code', code);
                tr.find('tr').attr('data-fare', bus.seatDetails[code]['fare']);
                tr.find('tr').attr('data-discount', bus.seatDetails[code]['discount']);
                tr.find('tr').attr('data-name', bus.seatDetails[code]['seatName']);
                
                $("#busmap-" + id).find('#bus-contact-list tbody').append(tr.html());
            }
        });
        
//        if($("#busmap-" + id).find('#agentservicecharges').length>0) {    //  special discount
//            var agentcharges = $.trim($("#busmap-" + id).find('#agentservicecharges').val());
//            //tax = tax + Number(agentcharges);
//            //totamt = totamt + Number(agentcharges);
//        }
//        
//        if($("#busmap-" + id).find('#spldiscount').length>0) {    //  special discount
//            var spldiscount = $.trim($("#busmap-" + id).find('#spldiscount').val());            
//            totamt = totamt - spldiscount;
//        }
            

        $("#busmap-" + id).find('input[name="name"]').addClass('fillauto').removeClass('autofill');
        $("#busmap-" + id).find('input[name="name"]:first').addClass('autofill').removeClass('fillauto').unbind("blur");
        $("#busmap-" + id).find('input[name="name"]:first').blur(function() {
            var navl = $(this).val();
            $('.fillauto').val(navl);
        });
        if (set == '')
            set = '-';
        if (totamt == 0)
            totamt = '0';
        $("#busmap-" + id).find('.seat-list').html(set);
        $("#busmap-" + id).find('.seat-fare').html(seatfare);
        $("#busmap-" + id).find('.discount').html(discountFare);

        //  show tax only if available
        $("#busmap-" + id).find('#tax-container').addClass('hidden');
        
        var payable = totamt;
        if(Number(gst)>0) {
            tax = (gst/100) * totamt;
            payable = Number(payable) + Number(tax);
            $("#busmap-" + id).find('#tax-container').removeClass('hidden');
        }
        $("#busmap-" + id).find('.total-tax').html(Number(tax).toFixed(2));
        $("#busmap-" + id).find('#discount-container').addClass('hidden');
        if(Number(discountFare)>0) {            
            $("#busmap-" + id).find('#discount-container').removeClass('hidden');
        }
        $("#busmap-" + id).find('.discount').html(Number(discountFare).toFixed(2));
        $("#busmap-" + id).find('.fare').html(Number(payable).toFixed(2));
        
        //  for spl discount calculation
        $("#busmap-" + id).find('.discount').attr('data-adiscount', discountFare);
        $("#busmap-" + id).find('.fare').attr('data-total', seatfare);        
        recalculateSplDiscount(id);
        
        $('#trip_quota_container').removeClass('hide');
        $("#busmap-1").find('.schedule-seat').each(function() {
            if($(this).hasClass('seat-available-you') ) {
                $('#trip_quota_container').addClass('hide'); //  hide quota panel
            }
        });
        
        $('#busmap-' + id).find('#detailedquotabuttonpanel').removeClass('hide');  //  show detailed quota button
        
        if ($("#busmap-" + id).find('.schedule-seat').length == 0) {
            $("#busmap-" + id).find('#bus-result-list-action').html('<br><br><br><div class="well well-large" align="center">Please select a seat to get more options.</div>');
            $('#trip_quota_container').addClass('hide'); //  hide quota panel
            $('#busmap-' + id).find('#detailedquotabuttonpanel').addClass('hide');  //  hide detailed quota button
        }
                
        if ($("#busmap-" + id).find('.schedule-seat.available-for-all').length > 0
            && $("#busmap-" + id).find('.schedule-seat.seat-available-gents').length == 0
            && $("#busmap-" + id).find('.schedule-seat.seat-available-ladies').length == 0) {
            $('#busmap-' + id).find('#gender-preference-panel').removeClass('hide');
        } else {
            $('#busmap-' + id).find('#gender-preference-panel').addClass('hide');
        }

    });
    
    //  handle booked seat click
    $("#busmap-" + id).find('.seat-booked[data-tcode="BL39FG"]').click(function() {
        if ($("#busmap-" + id).find('.schedule-seat').length > 0 || 
                $("#busmap-" + id).find('.cancel-seat-process').length > 0 ||
                $("#busmap-" + id).find('.selected-for-release').length > 0) {
            alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
            return false;
        }
                
        $(this).toggleClass("cancel-seat-process");
        var t_seats = [];
        if ($(this).hasClass('cancel-seat-process')) {
            var selseatcode = $('#busmap-' + id).find('.cancel-seat-process').attr('data-code');
            var ticket = _.filter(tripTickets[id], { tck: [ { sc: selseatcode } ]});
            t_seats.push(ticket[0]);
            $.each(ticket[0].tck, function(si,seat) { // highlight all seats in selected PNR
                $('#busmap-' + id).find('.seat-booked[data-code="' + seat.sc + '"]').addClass('schedule-seat');
            });
        }
        var divButton = $('#template-success-button').html();
        divButton = $('<div>').html(divButton).clone();
        
        if(t_seats.length>0) {
            $(divButton).find('#pnr').html(t_seats[0].c);
            $(divButton).find('#route').html(t_seats[0].fs.n+' to '+t_seats[0].ts.n);
            $(divButton).find('#boarding').html(t_seats[0].fs.sp.n);
            $(divButton).find('#mobile').html(t_seats[0].pmn);
            $(divButton).find('#bookedby').html(t_seats[0].ur.n);
            $(divButton).find('#bookedat').html(formatDateTime(t_seats[0].tat));
            
            var th = ''; var tot = 0; var seatCodes = new Array();
            $.each(t_seats[0].tck, function(k, ticket) {
                tot = parseInt(tot) + ticket.sf;
                seatCodes.push({
                    seat : ticket.sc,
                    text :  ticket.sn+' - '+ticket.pn
                });
                th  += '<tr>'
                    +'<td style="border:1px solid #dddddd">'+ticket.pn+'</td>'
                    +'<td style="border:1px solid #dddddd">'+ticket.sn+'</td>'
                    +'<td style="border:1px solid #dddddd">'+ticket.sg+'</td>'
                    +'<td style="border:1px solid #dddddd">'+ticket.pa+'</td>'
                    +'<td style="border:1px solid #dddddd" align="right">'+ticket.sf+'</td>'
                    +'</tr>';
            });
            th += '<tr>'
                  +'<td colspan="4" align="right"> Total :</td>'
                  +'<td align="right"> '+tot+'</td>'
                  +'</tr>';          
            $(divButton).find('.body_table').html(th);
        }        
        
        $('#busmap-' + id).find('#bus-result-list-action').html(divButton.html());
        $('#busmap-' + id).find('.btn-cnl').click(function() {
            loadCancelInfo(id);
        });
        
        if(moment().isBefore(moment($('#from_datetime').val(), "YYYY-MM-DD hh:mm:ss").subtract(3, 'hours'))) {
            $('#busmap-' + id).find('.btn-travel-status:has(".btn-traveled")').hide();
        } else {
            $('#busmap-' + id).find('.btn-traveled').click(function() {
                showTravelStatusDialog(t_seats[0].c,'TRAVELED',seatCodes);
            });
            $('#busmap-' + id).find('.btn-not-traveled').click(function() {
                showTravelStatusDialog(t_seats[0].c,'NOTTRAVELED',seatCodes);
            });
        }
        
        $('#busmap-' + id).find('.btn-notify-tkt').click(function() {
            notifyTicket(id, t_seats[0].c, $(this).data('notify-type'));
            });
        
        $('#busmap-' + id).find('.btn-notify-whatsapp').click(function() {
            var data = {};
            data.type = $(this).data('notify-type');
            data.pnr = t_seats[0].c;
            
            var eventaction = (data.type === 'TICKET') ? 'Whatsapp Ticket' : 'Whatsapp Tracking';
            ga_track_event('Ticket', eventaction, '');
            
            var url = base_url + "ticket/whatsapp-share?" + $.param(data);
            var wo = window.open(url, "_blank");
        });
        
        $('#busmap-' + id).find('.btn-moreinfo').click(function() {
            loadBookedInfo(id);
        });
        $('#busmap-' + id).find('.btn-editticket').click(function() {
            editTicket(t_seats[0].c);
        });
        $('#busmap-' + id).find('.btn-transfer').click(function() {
            transferTickets(t_seats);
        });
        
        $('#busmap-' + id).find('.btn-print').click(function() {
            var url = base_url + "search/print-sheet?print=1&pnrCode=" + t_seats[0].c;
            var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1050, height=650");
        });
        
        $('#busmap-' + id).find('.btn-mini-print').click(function() {
            var url = base_url + "search/print-mini-sheet?pnrCode=" + t_seats[0].c;
            var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
        });
        
        $('#busmap-' + id).find('.btn-clr').click(function() {
            clearResult(id);
        });
    });
        
    //  manage live / tentative booking seats.
    if(menu_permission['RELE-TENTA-BOOK']==1) {   
        $("#busmap-" + id).find('.live-booking').click(function() {
            if ($("#busmap-" + id).find('.schedule-seat').length > 0 || 
                    $("#busmap-" + id).find('.cancel-seat-process').length > 0 ||
                    $("#busmap-" + id).find('.selected-for-release').length > 0) {
                alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
                return false;
            }

            $(this).toggleClass("cancel-seat-process");
            var t_seats = [];
            if ($(this).hasClass('cancel-seat-process')) {
                
                var selseatcode = $('#busmap-' + id).find('.cancel-seat-process').attr('data-code');
                var ticket = _.filter(tripTickets[id], { tck: [ { sc: selseatcode } ]});
                t_seats.push(ticket[0]);
                $.each(ticket[0].tck, function(si,seat) { // highlight all seats in selected PNR
                    $('#busmap-' + id).find('.live-booking[data-code="' + seat.sc + '"]').addClass('schedule-seat');
                });
                
            }
            var divButton = $('#template-live-booking-ticket').html();
            divButton = $('<div>').html(divButton).clone();

            if(t_seats.length>0) {                
                $(divButton).find('#pnr').html(t_seats[0].c);
                $(divButton).find('#route').html(t_seats[0].fs.n+' to '+t_seats[0].ts.n);
                $(divButton).find('#boarding').html(t_seats[0].fs.sp.n);
                $(divButton).find('#mobile').html(t_seats[0].pmn);
                $(divButton).find('#bookedby').html(t_seats[0].ur.n);
                $(divButton).find('#bookedat').html(formatDateTime(t_seats[0].tat));

                var th = ''; var tot = 0; var seatCodes = new Array();
                $.each(t_seats[0].tck, function(k, ticket) {
                    tot = parseInt(tot) + ticket.sf;
                    seatCodes.push({
                        seat : ticket.sc,
                        text :  ticket.sn+' - '+ticket.pn
                    });
                    th  += '<tr>'
                        +'<td style="border:1px solid #dddddd">'+ticket.pn+'</td>'
                        +'<td style="border:1px solid #dddddd">'+ticket.sn+'</td>'
                        +'<td style="border:1px solid #dddddd">'+ticket.sg+'</td>'
                        +'<td style="border:1px solid #dddddd">'+ticket.pa+'</td>'
                        +'<td style="border:1px solid #dddddd" align="right">'+ticket.sf+'</td>'
                        +'</tr>';
                });
                th += '<tr>'
                      +'<td colspan="4" align="right"> Total :</td>'
                      +'<td align="right"> '+tot+'</td>'
                      +'</tr>';          
                $(divButton).find('.body_table').html(th);
            }        

            $('#busmap-' + id).find('#bus-result-list-action').html(divButton.html());        

            $('#busmap-' + id).find('.btn-release').click(function() {
                if(confirm('Do you want to force release this seat(s)?')) {
                    $('#busmap-' + id).find('#livebooking-button-pane').addClass('hide');
                    $('#busmap-' + id).find('#livebooking-action').removeClass('hide');            
                    $('#busmap-' + id).find('#livebooking-action').html(loading_popup);

                    var data = {}
                    data.ticketCode = t_seats[0].c;
                    $.ajax({
                        type: "POST",
                        url: "ticket/release-tentative",
                        dataType: 'json',
                        data: data,
                        success: function(result) {
                            $('#busmap-' + id).find('#livebooking-action').html('<div class="alert alert-success">Your request has been processed successfully</div>');
                            if(result.status == 1) {
                                window.setTimeout(function() {
                                    refreshBusLayout();
                                    ga_track_event('Search', 'Tentative Booking Release', 'Force Relase from search');
                                }, 4000);                
                            } else {
                                $('#busmap-' + id).find('#livebooking-action').html('<div class="alert alert-danger">'+result.errorDesc+'</div>');
                                $('#busmap-' + id).find('#livebooking-button-pane').removeClass('hide');
                            }
                        }
                    });
                }
            });

            $('#busmap-' + id).find('.btn-liveclr').click(function() {
                clearResult(id);
            });
        });
    }
    
    //  manage allocate / block panel.
    if(menu_permission['MNG-QUOTA']==1) {        
        $("#busmap-" + id).find('.seat-select-visibility').click(function() {
            if ( $("#busmap-" + id).find('.cancel-seat-process').length > 0
                 || $("#busmap-" + id).find('.phone-seat-process').length > 0) {
                alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
                return false;
            }

            //$(this).toggleClass("schedule-seat");
            $("#busmap-" + id).find('#trip_quota_container').addClass('hide'); //  acivate quota panel
            if($("#busmap-" + id).find('.schedule-seat').length>0)
                $("#busmap-" + id).find('#trip_quota_container').removeClass('hide'); //  acivate quota panel

            var ts = [];        
            $("#busmap-" + id).find('.schedule-seat').each(function() {  
                if( $(this).hasClass('seat-available-you')) {
                    $("#busmap-" + id).find('#trip_quota_container').addClass('hide'); //  hide quota panel
                }
                ts.push( $(this).html() );
            });
            $("#busmap-" + id).find('#quota_sel_seats').html(ts.join(', '));

        });

        //  manage release quota panel. Click on allocated / blocked seats
        $("#busmap-" + id).find('.seat-available-other, .seat-available-you, .seat-booked-blocked').click(function() {
            if($(this).hasClass('live-booking') ) { // dont show release button for live booking seat.
                return false;
            }
            
            if ( $("#busmap-" + id).find('.cancel-seat-process').length > 0
                 || $("#busmap-" + id).find('.phone-seat-process').length > 0) {
                alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
                return false;
            }
    
            $(this).toggleClass("selected-for-release");

            $("#busmap-" + id).find('#trip_release_container').addClass('hide'); //  acivate quota panel
            if($("#busmap-" + id).find('.selected-for-release').length>0)
                $("#busmap-" + id).find('#trip_release_container').removeClass('hide'); //  acivate quota panel

            var ts = [];        
            $("#busmap-" + id).find('.selected-for-release').each(function() {  
    //            if($(this).hasClass('seat-available-you') ) {
    //                $('#trip_release_container').addClass('hide'); //  hide quota panel
    //            }
                ts.push( $(this).html() );
            });
            $("#busmap-" + id).find('#release_sel_seats').html(ts.join(', '));

        });    
    }
    
    // click on a phone blocked seat.
    $("#busmap-" + id).find('.seat-phone-blocked[data-tcode = "BL39FG"]').click(function() {
        if ( $("#busmap-" + id).find('.schedule-seat').length > 0 || 
                $("#busmap-" + id).find('.cancel-seat-process').length > 0 || 
                $("#busmap-" + id).find('.phone-seat-process').length > 0 || 
                $("#busmap-" + id).find('.selected-for-release').length > 0) {
            alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
            return false;
        }
        $(this).toggleClass("phone-seat-process");
        var code = $(this).attr('data-code');
        var t_seats = [];
        $.each(seatStatusDetails[id], function(keys, vals) {
            if (code == vals.code) {
                var ss = vals.seatStatus.code
                if (code == vals.code) {
                    var ss = vals.seatStatus.code
                    $.each(seatStatusDetails[id], function(keys, hlt) {
                        if (vals.ticketCode == hlt.ticketCode) {
                            t_seats.push(hlt);
                            $('#busmap-' + id).find('.seat-phone-blocked[data-code="' + hlt.code + '"]').addClass('schedule-seat');
                        }
                    });
                }

                if (ss == 'PBL' && ss != undefined) {
                    $('#busmap-' + id).find('.busmap-container').hide();
                    var seatinfo = $('#template-booked-cancel').html();
                    seatinfo = $('<div>').html(seatinfo).clone();
                    seatinfo.find('.btn-cancel').attr('data-code', vals.ticketCode);
                    $('#busmap-' + id).find('#bus-result-list-action').html(loading_big);
                    var data = {}
                    data.ticketpnrcode = vals.ticketCode;
                    data.type = "PHO";
                    data.return = "PK";
                    $.ajax({
                        type: "POST",
                        url: "search/cancel-ticket",
                        dataType: 'html',
                        data: data,
                        success: function(result) {
                            $('#busmap-' + id).find('#bus-result-list-action').html(result);
                            $('.bs_switch').bootstrapSwitch('size', 'mini');
                            $('#busmap-' + id).find('.btn-phb-cfm').attr('onclick', 'phoneBookingConfirm(' + id + ')');
                            $('#busmap-' + id).find('.btn-phb-cnl').attr('onclick', 'phoneBookingCancel(' + id + ')');
                            $('#busmap-' + id).find('.btn-phb-crl').attr('onclick', 'clearResult(' + id + ')');
                            
                            var ptkt_info = _.filter(tripTickets[id], { tck: [ { sc: code } ]});
                            $('#busmap-' + id).find('.btn-transfer').click(function() {
                                transferTickets(ptkt_info);
                            });
                            
                            var seatCodes = new Array();
                            $.each(t_seats, function(k, ticket) {
                                seatCodes.push({
                                    seat : ticket.code,
                                    text :  ticket.seatName+' - '+ticket.passengerName
                                });
                            });
                            if(moment().isBefore(moment($('#from_datetime').val(), "YYYY-MM-DD hh:mm:ss").subtract(3, 'hours'))) {
                                $('#busmap-' + id).find('.btn-travel-status:has(".btn-traveled")').hide();
                            } else {
                                $('#busmap-' + id).find('.btn-traveled').click(function() {
                                    showTravelStatusDialog(vals.ticketCode,'TRAVELED',seatCodes);
                                });
                                $('#busmap-' + id).find('.btn-not-traveled').click(function() {
                                    showTravelStatusDialog(vals.ticketCode,'NOTTRAVELED',seatCodes);
                                });
                            }
                            
                            $('#busmap-' + id).find('.btn-pb-notify-tkt').click(function() {
                                notifyTicket(id, vals.ticketCode, $(this).data('notify-type'));
                            });

                            $('#busmap-' + id).find('.btn-pb-notify-whatsapp').click(function() {
                                var data = {};
                                data.type = $(this).data('notify-type');
                                data.pnr = vals.ticketCode;

                                var eventaction = (data.type === 'TICKET') ? 'Whatsapp Ticket' : 'Whatsapp Tracking';
                                ga_track_event('Ticket', eventaction, '');

                                var url = base_url + "ticket/whatsapp-share?" + $.param(data);
                                var wo = window.open(url, "_blank");
                            });
                        //initcancel(id);

                        }
                    });
                }
            }
        });
    /*if ($("#busmap-" + id).find('.phone-seat-process').length == 0) {
         $("#busmap-" + id).find('#bus-result-list-action').html('');
         }*/

    });
}

function closeBusLayout(id) {
    //var id = 1;
    $("#busmap-" + id).parent().remove();
    $("#result-panel-" + id).find('.li_bk').removeClass('li_bk');
    $("#result-panel-" + id).find('.btn-success').html('View Seats');
    
    var t = $("#result-panel-" + id).find('#trip_code').val()
    $("#result-panel-" + id).find('.settings').addClass('hide'); 
    $('.popover.in:visible').remove();
}

function refreshBusLayout(){
    var id = gct();
    $("#busmap-" + id).html('');
    //$("#result-panel-" + id).find('.li_bk').trigger('click', 1);
    var tripCode = $("#result-panel-" + id).find('.li_bk').attr('data-trip');
    var tbid = $("#result-panel-" + id).find('.li_bk').attr('data-tab');

    var travelDate = $("#result-panel-" + id).find('.li_bk').attr('data-traveldate');
    var fromCode = $("#result-panel-" + id).find('.li_bk').attr('data-from');
    var toCode = $("#result-panel-" + id).find('.li_bk').attr('data-to');

    Busmapload(tripCode, tbid, travelDate, fromCode, toCode);
    $('.popover.in:visible').remove();
}


//  calculate spl discount
function recalculateSplDiscount(id) {
   
    if(typeof(id) == "object") {
        id = $(id).attr('index');
    }
    $("#busmap-" + id).find('#discount-container').addClass('hidden');
    
    var df = $("#busmap-" + id).find('.discount').attr('data-adiscount');
    var seatfare = $("#busmap-" + id).find('.fare').attr('data-total');
    
    var spldiscount = $.trim( $('#spldiscount').val() );
    if(isNaN(spldiscount) || spldiscount == "") {
        spldiscount = 0;
    }
    
    df = Number(df) +  parseInt(spldiscount) + parseInt(offlineDiscountAmount);    
    tot = Number(seatfare) - Number(df);
    if(df>0) {
        $("#busmap-" + id).find('#discount-container').removeClass('hidden');
    }
    
    //  process female discount
    var femalediscount = 0;
    var fdopt = {};
    $.each(busMapData[id].busmap.discountList, function(key , opt) {
        if(opt.femaleDiscountFlag==1) {
             fdopt = opt;
        }
    });
    
    if(fdopt.femaleDiscountFlag == 1 && fdopt.discountValue > 0) {
        $('.seats-'+id).each( function() {        
            var g = '';
            var fare = $(this).attr('data-fare');
            $(this).find('.gen').each( function() {
                if( $(this).is(':checked') == true )
                  g = $(this).val();
            });

            if(g=='F') {
                if(fdopt.percentageFlag == 1) {
                    femalediscount += ((fdopt.discountValue/100) *  fare);
                } else {
                    femalediscount += fdopt.discountValue;
                }
            }            
        } ); 
    }
    
    $("#busmap-" + id).find('#femalediscount-container').addClass('hidden');
    if(parseInt(femalediscount)>0) {
        tot = Number(tot) - parseInt(femalediscount); 
        $("#busmap-" + id).find('#femalediscount-container').removeClass('hidden');
        $("#busmap-" + id).find('.total-femalediscount').html(Number(femalediscount).toFixed(2));
    }
    // end of processing female discount
       
    var seats = $('.seats-'+id).length;
    // Boarding Fare
    var boardingFare = $("#busmap-" + id).find('#bording-point option:selected').data('fare') || 0;
    boardingFare = Number(boardingFare) * seats;
    tot = Number(tot) + Number(boardingFare);
    $("#busmap-" + id).find('.boarding-fare').html(Number(boardingFare).toFixed(2));
    //$("#busmap-" + id).find('#boarding-fare-container').toggleClass('hidden', Number(boardingFare) <= 0);
    
    // Dropping Fare
    var droppingFare = $("#busmap-" + id).find('#dropping-point option:selected').data('fare') || 0;
    droppingFare = Number(droppingFare) * seats;
    tot = Number(tot) + Number(droppingFare);
    $("#busmap-" + id).find('.dropping-fare').html(Number(droppingFare).toFixed(2));
    //$("#busmap-" + id).find('#dropping-fare-container').toggleClass('hidden', Number(droppingFare) <= 0);
    $("#busmap-" + id).find('.seat-fare').html(Number(tot).toFixed(2));
    
    var payable = Number(tot);
    if(gst>0) {
        tax = (gst/100) * tot;
        $("#busmap-" + id).find('#tax-container').removeClass('hidden');
        $("#busmap-" + id).find('.total-tax').html(Number(tax).toFixed(2));
        payable = Number(payable) + Number(tax);
    }
    
    $("#busmap-" + id).find('.discount').html(Number(df).toFixed(2));
    $("#busmap-" + id).find('.fare').html(Number(payable).toFixed(2));
        
    //  service charges    
    $("#busmap-" + id).find('#service-container').addClass('hidden');           
    var agent_charges = $.trim( $('#agentservicecharges').val() );
    if(isNaN(agent_charges) || agent_charges == "")
        agent_charges = 0;    
    
    if(parseInt(agent_charges)>0) {
        payable = Number(payable) + parseInt(agent_charges);
        $("#busmap-" + id).find('#service-container').removeClass('hidden');
        $("#busmap-" + id).find('.total-service').html(Number(agent_charges).toFixed(2));
     }
    
    // Go Green donation
    var gogreenamount = 10;
    $("#busmap-" + id).find('#gogreen-container').addClass('hidden');
    if( $('#gogreendonation').is(':checked') ) {
        payable = Number(payable) + parseInt(gogreenamount); 
        $("#busmap-" + id).find('#gogreen-container').removeClass('hidden');
        $("#busmap-" + id).find('.total-gogreen').html(Number(gogreenamount).toFixed(2));
    }
    
    $("#busmap-" + id).find('.fare').html(Number(payable).toFixed(2));  
}

function loadBookedInfo(id) {
    $.each(seatStatusDetails[id], function(keys, vals) {

        var code = $('#busmap-' + id).find('.cancel-seat-process').attr('data-code');
        if (code == vals.code) {
            var ss = vals.seatStatus.code
            if (ss == 'BO' && ss != undefined) {
                $('#busmap-' + id).find('.busmap-container').hide();
                $.each(seatStatusDetails[id], function(keys, hlt) {
                    if (vals.ticketCode == hlt.ticketCode) {
                        $('#busmap-' + id).find('.seat-booked[data-code="' + hlt.code + '"]').addClass('schedule-seat');
                    }
                });
                $('#busmap-' + id).find('#bus-result-list-action').html(loading_big);
                bookedDetails(vals.ticketCode, id)
            }
        }
    });
}
function  bookedDetails(pnrcode, id) {
    var data = {}
    data.ticketpnrcode = pnrcode;
    data.ticketPage = 1;
    $.ajax({
        type: "POST",
        url: "search/confimation-payment-list",
        dataType: 'html',
        data: data,
        //async: false,
        success: function(res) {
            $("#busmap-" + id).find('#bus-result-list-action').html(res);
            $('#busmap-' + id).find('.btn-clear-ticket').attr('onclick', 'clearResult(' + id + ')');
        }
    });
}
function loadCancelInfo(id) {
    $.each(seatStatusDetails[id], function(keys, vals) {

        var code = $('#busmap-' + id).find('.cancel-seat-process').attr('data-code');
        if (code == vals.code) {
            var ss = vals.seatStatus.code
            if (ss == 'BO' && ss != undefined) {
                $('#busmap-' + id).find('.busmap-container').hide();
                var seatinfo = $('#template-booked-cancel').html();
                seatinfo = $('<div>').html(seatinfo).clone();
                seatinfo.find('.btn-cancel').attr('data-code', vals.ticketCode);
                $.each(seatStatusDetails[id], function(keys, hlt) {
                    if (vals.ticketCode == hlt.ticketCode) {
                        $('#busmap-' + id).find('.seat-booked[data-code="' + hlt.code + '"]').addClass('schedule-seat');
                    }
                });
                $('#busmap-' + id).find('#bus-result-list-action').html(loading_big);
                var data = {}
                data.ticketpnrcode = vals.ticketCode;
                data.type = "CAN";
                data.return = "BK";
                $.ajax({
                    type: "POST",
                    url: "search/cancel-ticket",
                    dataType: 'html',
                    data: data,
                    //async: false,
                    success: function(result) {
                        $('#busmap-' + id).find('#bus-result-list-action').html(result);
                        $('#busmap-' + id).find('.clear-ticket').attr('onclick', 'clearList(' + id + ')');
                        $('#cancel_bm_flg').bootstrapSwitch('size', 'mini');
                        initcancel(id);
                    }
                });
            }
        }
    });
    if ($("#busmap-" + id).find('.cancel-seat-process').length == 0) {
        $("#busmap-" + id).find('#bus-result-list-action').html('');
    }
}
function busSeat(row, col, rowmin, colmin, seatstatus, seatDetails, lay, id, seaterFound, tripSync) {
    seaterFound = false;   
    var s = '';
    var htm ='';
    var seatStatusList = {
        "AM": "Available male", 
        "AF": "Available female", 
        "AL": "Available for all", 
        "BO": "Booked", 
        "BM": "Booked for Male", 
        "BF": "Booked for Female", 
        "AY": "Allocated for You", 
        "AO": "Allocated", 
        "UK": "Un Known,yet identified", 
        "TBL": "Blocked", 
        "PBL": "Phone Booking", 
        "BL": "Blocked",
        "QS": "Quota",
        "NA": ""
    };
    var seatStatusClass = {
        "AM": "seat-available-gents", 
        "AF": "seat-available-ladies", 
        "AL": "available-for-all", 
        "BO": "seat-booked", 
        "BM": "seat-booked-gents", 
        "BF": "seat-booked-ladies", 
        "AY": "seat-available-you", 
        "AO": "seat-available-other", 
        "UK": "seat-booked-blocked", 
        "TBL": "seat-booked-blocked", 
        "PBL": "seat-phone-blocked", 
        "BL": "seat-booked-blocked",
        "QS": "seat-quota-blocked",        
        "NA": "restroom-sleeper-filer"
    };
    
    //  hide allocated info from agents
    if(menu_permission['PHB-SHOW-TKT-INFO']!==1) {
        seatStatusList['AO'] = 'Booked';
        seatStatusClass['AO'] = 'seat-booked-gents';
        
        seatStatusList['BL'] = 'Booked';
        seatStatusClass['BL'] = 'seat-booked-gents';   
        
        seatStatusList['PBL'] = 'Booked';
        //seatStatusList['QS'] = 'Booked';
    }
    var rowSeatFoundCount = {};
    for (var i = rowmin; i <= row; i++) {
        for (var j = colmin; j <= col; j++) {
            var set = lay + "" + i + "" + j;
            if(rowSeatFoundCount[i] != undefined){
                rowSeatFoundCount[i] = rowSeatFoundCount[i]+1;
            }else{
                rowSeatFoundCount[i] = 1;
            }
            
            //  check is this layer has mixed seats.
            if(_isdefined(seatstatus[set])) {
                if( seatstatus[set]['seatTypeCode'] == "SS" || seatstatus[set]['seatTypeCode'] == "ST" | seatstatus[set]['seatTypeCode'] == "PB" ) {
                    seaterFound = true;
                }
            }
        }
    }
    var axialFound = false;
    var preSeatType = '';
   
    for (var i = rowmin; i <= row; i++) {
        var sleeperSeatFound = false;
        for (var j = colmin; j <= col; j++) {
            var set = lay + "" + i + "" + j;
            var seatclass = '';
            var BusSeatTypeclass = ' seat-lay-search ';
            
            var c = '';
            var sn = ''
               
            if (seatstatus[set] != undefined) {
                
                if(seatstatus[set]['seatType'] == "Rest Room" || seatstatus[set]['seatType'] == "Free Space") {

                } else {    
                    var dataPop = "<div style='text-align:center'>" 
                                  + seatDetails[seatstatus[set]['code']]['seatName'] 
                                  + " , "+ seatstatus[set]['seatType'];               
                    if( parseInt(seatstatus[set]['fare'])>0 ) { 
                        dataPop +=     " , <i class='fa fa-rupee'></i> " + seatstatus[set]['fare'];
                    } 
                    dataPop +=     "<br />"+seatStatusList[seatstatus[set]['status']['code']];              

                    if(menu_permission['PHB-SHOW-TKT-INFO']!==1 && 
                            (seatstatus[set]['status']['code'] == 'AO' 
                            || seatstatus[set]['status']['code'] == 'BL' 
                            || seatstatus[set]['status']['code'] == 'BO'
                            || seatstatus[set]['status']['code'] == 'PBL') ) {
                         var dataPop = "<div style='text-align:center'>" + seatStatusList[seatstatus[set]['status']['code']] + "";
                    }      

                    if (seatstatus[set]['code'] != undefined && seatstatus[set]['status'] != undefined) {
                        if(htm!='') htm += ',';

                        if(htm.indexOf(seatstatus[set]['code']) == -1) 
                            htm = seatstatus[set]['status']['code']
                        if (seatstatus[set]['status']['code'] != 'BO' &&  seatstatus[set]['status']['code'] != 'BL' 
                                && seatstatus[set]['status']['code'] != 'AO' && seatstatus[set]['status']['code'] != 'TBL' 
                                && seatstatus[set]['status']['code'] != 'BF' && seatstatus[set]['status']['code'] != 'BM' 
                                && seatstatus[set]['status']['code'] != 'PBL' && seatstatus[set]['status']['code'] != undefined
                                && seatstatus[set]['status']['code'] != 'QS') {
                            seatclass += ' seat-select-visibility ' + seatStatusClass[seatstatus[set]['status']['code']];
                        } else {
                            seatclass += seatStatusClass[seatstatus[set]['status']['code']];
                        }
                        c = ' data-code = "' + seatstatus[set]['code'] + '"';
                        if ( seatstatus[set]['status']['code'] == 'AO' 
                            || seatstatus[set]['status']['code'] == 'BL'
                            || seatstatus[set]['status']['code'] == 'TBL'
                            || seatstatus[set]['status']['code'] == 'QS'
                            || menu_permission['PHB-SHOW-TKT-INFO']==1) {
                                var temp = '';
                                if (seatstatus[set]['userName'] != undefined) {
                                    temp += ' to ' + seatstatus[set]['userName']+" (U) "; //userName
                                }
                                if (seatstatus[set]['groupName'] != undefined) {
                                    if(temp!='') temp += ',';
                                    temp += ' to ' + seatstatus[set]['groupName']+" (G) ";
                                }
                                if(seatstatus[set]['status']['code'] == 'QS') {
                                    if(temp!='') temp += ',';
                                    temp += ' <br> ' + seatstatus[set]['quotaRoute'];
                                    temp += ' <br> ' + seatstatus[set]['quotaGender'];                                
                                }

                                if(seatstatus[set]['status']['code'] != 'TBL') {
                                    if (seatstatus[set]['updatedBy'] != undefined && seatstatus[set]['updatedBy'] != '' && seatstatus[set]['updatedBy'] != 'null') {
                                        temp += ' <br> By : ' + seatstatus[set]['updatedBy'];
                                    } 
                                }

                                if (seatstatus[set]['updatedAt'] != undefined && seatstatus[set]['updatedAt'] != '') {
                                    temp += ' <br> At : ' + formatDateTime(seatstatus[set]['updatedAt']);
                                } 

                                if(temp!='' && menu_permission['PHB-SHOW-TKT-INFO']==1){
                                    dataPop += temp;
                                }
                        }

                        if(seatstatus[set]['status']['code']=='TBL' 
                                && seatstatus[set]['bookingLive'] == 1 
                                && menu_permission['PHB-SHOW-TKT-INFO'] ==1) {    //  seat currently booking
                            dataPop +=     "<br />Booking In-Progress";
                        } 

                        if(seatstatus[set]['status']['code'] != 'BO' && seatstatus[set]['status']['code'] != 'PBL' 
                                && seatstatus[set]['remarks']!='') {    //  show remarks added while updated in seat visiblity
                           dataPop +=     "<br /> <i class='fa fa-exclamation-circle'></i> "+seatstatus[set]['remarks']
                        }

                        dataPop += "</div>";
                        sn = seatDetails[seatstatus[set]['code']]['seatName'];                        
                                
                        var popupContent = [];
                        var tripFromStationCode = $('#result-panel-' + id).find('#from_station:hidden').val();
                        var tripToStationCode = $('#result-panel-' + id).find('#to_station:hidden').val();

                        $.each(tripSync.tickets || [], function (i, pnr) {                            
                            $.each(pnr.tck || [], function (i, r) {
                                 if (seatstatus[set]['code'] === r.sc && $.inArray(r.ss.c, ['BO', 'PBL']) !== -1) {
                                    var seatNames = [];
                                    $.each(pnr.tck, function(a,b){
                                        seatNames.push("<span class='seat-gender " + b.sg + "'>" + b.sn + " (" + b.sg + ")</span>");
                                    })
                                 
                                    var bp = (pnr.fs.sp) ? pnr.fs.sp.n : "";
                                    var dp = (pnr.ts.sp) ? pnr.ts.sp.n : "";
                                    var rt = (pnr.trt) ? "<br/>Release At : " + formatDateTime(pnr.trt) : "";
                                    
                                    var content =
                                            "<div class='text-center'>" + pnr.c + " - <i class='fa fa-inr'></i> " + r.sf +
                                            "<br/>" + seatNames.join(', ') +
                                            "<br/>" + r.pn + " - " + pnr.pmn +
                                            "<br/>" + pnr.fs.n + " - " + pnr.ts.n +
                                            "<br/>" + bp + " - " + dp +
                                            "<br/>Booked By : " + pnr.ur.n +
                                            "<br/>" + formatDateTime(pnr.tat) + rt + "</div>";

                                    if (pnr.fs.c === tripFromStationCode && pnr.ts.c === tripToStationCode) {
                                        popupContent.unshift(content);
                                    } else {
                                        popupContent.push(content);
                                    }
                                    return false;
                                }
                            });
                        });
                        if(popupContent.length > 1) {
                            seatclass += ' multi-stage ';
                        }
                        popupContent = popupContent.join("<hr class='divider'/>").replace(/undefined/g, '');
                            
                        if (seatstatus[set]['status']['code'] == 'BO' || seatstatus[set]['status']['code'] == 'PBL') {
                            
                            if (popupContent.trim()) {
                                dataPop = popupContent;
                            }

                            $.each(seatStatusDetails[id], function(t, tik) {
                                if (seatstatus[set]['code'] == tik.code) {                                
                                    if(tik.ticketCode != '' && tik.ticketCode != undefined) { //  show ticket info
                                        c += ' data-tcode = "BL39FG"';
                                    } else {
                                        c = '';
                                        //dataPop = '' // reset popovers
                                    } 

                                    if (tik.seatGendarStatus != undefined) {                                
                                        if (tik.seatGendarStatus.code == "M" && tik.seatGendarStatus.code != undefined) {
                                            seatclass += ' seat-booked-gents ';
                                            if(menu_permission['PHB-SHOW-TKT-INFO']==1) {   // role based seat colors
                                                seatclass += ' seat-booked-male-role-'+seatstatus[set]['groupCode']+'  ';
                                            }
                                        } else if (tik.seatGendarStatus.code == "F" && tik.seatGendarStatus.code != undefined) {
                                            seatclass += ' seat-booked-ladies ';
                                            if(menu_permission['PHB-SHOW-TKT-INFO']==1) {   // role based seat colors
                                                seatclass += ' seat-booked-ladies-role-'+seatstatus[set]['groupCode']+'  ';
                                            }
                                        }
                                    }
                                }                            

                            });                        
                        } else {
                            if (popupContent.trim()) {
                                seatclass += ' multi-stage ';
                                dataPop += "<hr class='divider'/>" + popupContent;
                            }
                        }
                    }

                    if (seatstatus[set]['status'] != '' && seatstatus[set]['status'] != undefined && seatstatus[set]['status'] == 1 && seatstatus[set] != undefined) {
                        seatclass += ' seat-booked '+ seatStatusClass[seatstatus[set]['status']['code']];
                    }

                    if (seatstatus[set]['seatType'] != '' && 
                            seatstatus[set]['seatType'] != undefined && 
                            (seatstatus[set]['seatType'] == "Sleeper" || 
                            seatstatus[set]['seatType'] == "Upper Sleeper" || 
                            seatstatus[set]['seatType'] == "Lower Sleeper" ||
                            seatstatus[set]['seatType'] == "Single Lower Sleeper" ||
                            seatstatus[set]['seatType'] == "Single Upper Sleeper") ) {
                        BusSeatTypeclass =' sleeper-lay-search ';
                        sleeperSeatFound = true;
                    }else{
                        sleeperSeatFound = false;
                    }
                    preSeatType = seatstatus[set]['seatType'];

                    if ( seatstatus[set]['zaxis'] == 1 ) {
                        BusSeatTypeclass += ' vertical-seat ';
                    }

                    if(seatstatus[set]['status']['code']=='TBL' 
                            && seatstatus[set]['bookingLive'] == 1
                            && menu_permission['PHB-SHOW-TKT-INFO']==1
                            ) {
                        BusSeatTypeclass += ' live-booking ';
                    }
                }
            } else if(rowSeatFoundCount[i] != undefined && rowSeatFoundCount[i] > 0 && !sleeperSeatFound){// && seatstatus[previousSeatPos]['seatType'] != '' && seatstatus[previousSeatPos]['seatType'] != undefined && seatstatus[previousSeatPos]['seatType'] == "Sleeper" ){
                sn = '&nbsp;';
                dataPop = '';
                
                if(preSeatType == "Sleeper" || preSeatType == "Upper Sleeper" || preSeatType == "Lower Sleeper" || preSeatType == "Single Lower Sleeper" || preSeatType == "Single Upper Sleeper") {
                    BusSeatTypeclass =' sleeper-lay-search ';
                    if(seaterFound) {
                        BusSeatTypeclass =' seat-lay-search ';
                    }                    
                }
                
            } else if(rowSeatFoundCount[i] == 0 && !axialFound){
                sn = '&nbsp;';
                axialFound = true;
                dataPop = '';
            }
            
            if(_isdefined(seatstatus[set])) {   //  render rest room cell
                if(seatstatus[set]['seatType'] == "Rest Room") {
                    BusSeatTypeclass = ' restroom-sleeper-filer ';
                    dataPop = '';
                    sn+= '<div class="restroom-lay" data-toggle="popover" data-container="body" data-placement="left" data-trigger="hover" data-content="Rest Room"> &nbsp; </div>';
                }
            }
            
            if(_isdefined(seatstatus[set])) {   //  render filler cell
                if(seatstatus[set]['seatType'] == "Free Space") {
                    sn = '&nbsp;';
                    BusSeatTypeclass = ' restroom-sleeper-filer ';
                    dataPop = '';
                }
            }
            
            if(sn != ''){
                s += '<div class="p_tool  seat-lay-out ' + BusSeatTypeclass + seatclass +  '" ' + c 
                if(dataPop !='' )
                    s += ' data-toggle="popover" data-container="body" data-placement="left" data-trigger="hover" data-content="' + dataPop + '"'
                s +=' ><span>' + sn + '</span></div>';                
            }
        }
        s += '<div class="clear_fix_both"></div>';
    }
    return [s,htm];
}
function clearSearch(id) {
    $('#from-station-search-' + id).val('');
    $('#to-station-search-' + id).html('');
    $('#sdate-search-' + id).val('');
    $('#from-station-search-' + id).select2('val', '');
    $('#to-station-search-' + id).select2('data', null);
    $('#to-station-search-' + id).select2({
        placeholder: "Select Destination"
    });
    $('#result-panel-' + id).html('');
}
function tabedit(obj) {
    var id = $(obj).attr('data-id');
    $('#search-panel-' + id).slideDown();
}
function toStationLoading(id) {
    var stcode = $('#from-station-search-' + id).val();
    var html = '<option value=""></option>';
    $('#to-station-search-' + id).val('');
    $('#to-station-search-' + id).select2('val', '');
    
    var to_codes = eval(routes[stcode]);
    var html="<option selected='selected' value=''>Select Destination</option>";
    $(to_codes).each(function() {
        html+="<option value="+this.code+">"+this.name+"</option>";
    });
    $('#to-station-search-' + id).html(html);
    return;    
}


function getPdate(tabid, date) {
    var date = $('#sdate-search-' + tabid).datepicker('getDate');
    date.setTime(date.getTime() - (1000 * 60 * 60 * 24))

    var d = date;
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1;
    var curr_year = d.getFullYear();
    if (curr_month < 10) {
        curr_month = '0' + curr_month;
    }
    if (curr_date < 10) {
        curr_date = '0' + curr_date;
    }

    var date_new = new Date();
    //var date_format = curr_year + '-' + curr_month + '-' + curr_date;
    var date_format =  curr_date + '-' + curr_month + '-' + curr_year;
    $('#sdate-search-' + tabid).datepicker("setDate", date);
    $('#sdate-search-' + tabid).val(date_format);
    $('#s_date_' + tabid).html(date_format);
    $('.hidden-xs').click(function(e) {
        e.preventDefault();
    //do other stuff when a click happens
    });
    if (date >= date_new) {
        dosearch(tabid);
    } else {
        $('.prev-day-' + tabid).hide();
        dosearch(tabid);
    }



}

function getNdate(tabid, date) {
    var date = $('#sdate-search-' + tabid).datepicker('getDate');
    date.setTime(date.getTime() + (1000 * 60 * 60 * 24))

    var d = date;
    var curr_date = d.getDate();
    var curr_month = d.getMonth() + 1;
    var curr_year = d.getFullYear();
    if (curr_month < 10) {
        curr_month = '0' + curr_month;
    }
    if (curr_date < 10) {
        curr_date = '0' + curr_date;
    }
    var date_new = new Date();
    //var date_format = curr_year + '-' + curr_month + '-' + curr_date;
    var date_format =  curr_date + '-' + curr_month + '-' + curr_year;
    $('#sdate-search-' + tabid).datepicker("setDate", date);
    $('#sdate-search-' + tabid).val(date_format);
    $('#s_date_' + tabid).html(date_format);
    $('.hidden-xs').click(function(e) {
        e.preventDefault();
    });
    dosearch(tabid);
}

function search(fromstation,tostation,searchdate){
    this.fromstation = fromstation;
    this.tostation = tostation;
    this.searchdate = searchdate;
}

function addFareWith(){
    var fare = parseInt($('#customFare').val());
    if(!fare){
        $('#customFare').addClass('inp_error');
        return;
    }
    $('#customFare').removeClass('inp_error');  
    $('.seat-type:checkbox:checked').each(function () {
        $('.quick-fare-route-cb:checked').closest('tr').find('input[data-type="' + this.value + '"]').each(function () {
            this.value = parseInt(this.value) + fare;
        }).addClass('inp_success').removeClass('inp_success', 2000);
    });
}

function subtractFareWith(){
    var fare = parseInt($('#customFare').val());
    if(!fare){
        $('#customFare').addClass('inp_error');
        return;
    }
    $('#customFare').removeClass('inp_error');  
    $('.seat-type:checkbox:checked').each(function () {
        $('.quick-fare-route-cb:checked').closest('tr').find('input[data-type="' + this.value + '"]').each(function () {
            this.value = parseInt(this.value) - fare;
        }).addClass('inp_success').removeClass('inp_success', 2000);
    });
}

function setFare(){
    var fare = parseInt($('#customFixedFare').val());
    if(!fare){
        $('#customFixedFare').addClass('inp_error');
        return;
    }
    $('#customFixedFare').removeClass('inp_error');
    $('.seat-type:checkbox:checked').each(function () {
        $('.quick-fare-route-cb:checked').closest('tr').find('input[data-type="' + this.value + '"]').each(function () {
            this.value = fare;
        }).addClass('inp_success').removeClass('inp_success', 2000);
    });
}

function resetFare(){
    $('.fare-cells').each(function() {
        $(this).val($(this).attr('data-oldfare')).addClass('inp_success').removeClass('inp_success', 3000);
    });
}

function fareQuickEdit(){
    $('#quickEditButton').hide();
    $('#fareQuickEdit').slideToggle('slow');
    $('#route-fare-tb').find('.qe-cb').toggleClass('hide');
}

function toggleAllRouteFareCb(cb) {
    $('#route-fare-tb .quick-fare-route-cb').prop('checked', cb.checked);
}

function changeTravelStatus(code,status){
    var msg = 'Are you sure, do you want to change travel status?';  
    var data = {};
    data.travelStatus = status;
    data.ticketCode = code;
    data.seatCodes = $('input[name="ts-checkbox"]:checked').map(function() {
        return this.value;
    }).get().join(',');

    if(data.seatCodes=="") {
        $('#travel-status-action').html('<div class="alert alert-danger">Please select atleast 1 seat to continue</div>');
        $('#travel-status-action').removeClass('hide');
        return false;
    }
    
    $('#ts-btn-pane').hide();
    
    if(confirm(msg)){   
        $('#travel-status-action').html(loading_popup);
        $.ajax({
            type: "POST",
            url: base_url + "search/change-travel-status",
            data: data,
            dataType: 'json',
            success: function(res) { 
                $('#travel-status-action').html('<div class="alert alert-success">Your request has been processed successfully</div>');
                if(res.status == 1) {
                    window.setTimeout(function() {
                        $('#travel-status-seats').dialog();
                        $('#travel-status-seats').dialog('close');
                        refreshBusLayout();
                    }, 2000);                
                } else {
                    $('#travel-status-action').html('<div class="alert alert-danger">'+res.errorDesc+'</div>');
                    $('#ts-btn-pane').show();
                }
            }
        });    
    }
}
function showTravelStatusDialog(code,status,seatCodes) {   
//    if(seatCodes.length <= 1) {
//        $('input[name="ts-checkbox"]').val(seatCodes[0].seat);
//        changeTravelStatus(code,status);
//    } else {
        $('#travel-status-seats').removeClass('hide');
        $('#travel-status-seats').dialog({
            autoOpen: true,
            height: 400,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#ts-info').hide();
        
        title = 'Please select the seats want to update <span class="success-text bold">TRAVELLED</span>';
        if(status=="NOTTRAVELED") {
            title = 'Please select the seats want to update <span class="warning-text bold">NOT TRAVELLED</span>';
            $('#ts-info').show();
        }
        $('#lbl-title').html(title);
        $('#travel-status-action').html('');
        $('#ts-btn-pane').show();
        
        $('#travel-status-seats .user_list').html('');
        $(seatCodes).each(function(i, val) {
            $('#travel-status-seats .user_list').append('<li><div><input type="checkbox" name="ts-checkbox" value="'+val.seat+'">&nbsp;<lable>'+val.text+'</lable></div></li>');
        });
        $('#travel-status-btn').attr('onclick',"changeTravelStatus('"+code+"','"+status+"');");
    //}
}
function closeTravelStatusdialog() {
    $('#travel-status-seats').dialog('close');
    $('#travel-status-seats').addClass('hide');
}

function transferTickets(tickets) {
    $('#bus-result-list-action').html(loading_popup);
    $.ajax({
        type: 'POST',
        url: base_url + 'search/transfer-ticket-search',
        dataType: 'html',
        success: function(res) { 
            $('#bus-result-list-action').html(res);
            $('.schedule-seat').addClass('seat-transfer-from');
            $('#transfer-frm-station').val(tickets[0].fs.c).trigger('change');
            $('#transfer-to-station').val(tickets[0].ts.c);
            $('#transfer-date').datepicker('update', $('#travel_date:hidden').val());
            
            $('#spn-pnr').html('<a href="javascript:;" title="more details" onclick=PrintTck("'+tickets[0].c+'")> '+tickets[0].c+'</a>');
            $('#spn-boarding').text(tickets[0].fs.sp.n).attr('data-code', tickets[0].fs.sp.c);
            $('#spn-dropping').text(tickets[0].ts.sp.n).attr('data-code', tickets[0].ts.sp.c);
            $('#transfer-from-pnr:hidden').val(tickets[0].c);
            
            var tpl = $('#tranfer-table-tpl').html();
            var rows = '';
            $.each(tickets[0].tck, function(i, tkt) {
                var $tr = $(tpl);
                $tr.find('tr').attr('id', 'from_' + i);
                $tr.find('.sch_o_seat').html(tkt.sn);
                $tr.find('.sch_n_seat').html('').addClass('sch_n_seat_' + i);
                $tr.find('.sch_o_name').html(tkt.pn);
                $tr.find('.sch_o_age').html(tkt.pa);
                $tr.find('.sch_o_gendar').html(tkt.sg);
                rows += $tr.html();
            });
            
            $('#table-transfer table tbody').html(rows);
            $('#table-transfer').removeClass('hidden');
        }
    });
}

function setTripBookingStatus(code, state) {
    if (state == 'TPC') {
        var title = "Do you want to close the bookings for this trip?";
        var txt = 'This action will stop further bookings from all the channels.';
    } else if (state == 'TPO') {
        var title = "Do you want to open the bookings for this trip?";
        var txt = 'This action will open bookings in all the channels.';
    }
    
    swal({
        title: title,
        text: txt,
        type: "warning",
        showCancelButton: true,
        confirmButtonClass: "btn-danger",
        confirmButtonText: "Yes, Continue!",
        closeOnConfirm: false
    }, function () {
        var data = {};
        data.trip_state = state;
        data.trip_code = code;

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'schedules/update-trip',
            data: data,
            success: function (res) {
                if (res.status == 1) {
                    if(state == 'TPC'){
                        $('#trip-' + code + ' .trip-status').removeClass('label-default').addClass('label-danger').html('Trip Closed');
                        $('#trip-info-' + code + ' .close-adv-booking').addClass('hide');
                        $('#trip-info-' + code + ' .open-adv-booking').removeClass('hide');
                        swal("Booking Closed!", "Booking has been closed.", "success");

                    } else if(state == 'TPO'){
                        $('#trip-' + code + ' .trip-status').removeClass('label-danger').addClass('label-default').html('Trip Open');
                        $('#trip-info-' + code + ' .close-adv-booking').removeClass('hide');
                        $('#trip-info-' + code + ' .open-adv-booking').addClass('hide');
                        swal("Booking Open!", "Booking has been open.", "success");
                    }
                    refreshBusLayout();
                }
            }
        });
    });
}

function doSeatSelection(cls, ele) {
    $(ele).parents('.busmap-list').find('.' + cls).not('.selected-for-release, .schedule-seat').each(function() {
	$(this).trigger('click');
    });
}
function doSeatUnSelection(ele) {
    $(ele).parents('.busmap-list').find('.selected-for-release, .schedule-seat').trigger('click');
}

function showSeatPreferenceList(){    
    var data = {}
    var id = gct();
    data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
    
    $('#busmap-' + id).find('#bus-result-list-action').addClass('hide');
    $('#busmap-' + id).find('#fare-list-action').addClass('hide');
    $('#busmap-' + id).find('#quota-list-action').addClass('hide');
    
    $('#busmap-' + id).find('#preference-list-action').removeClass('hide');
    $('#busmap-' + id).find('#preference-list-action').html('<br><br><br><div class="text-center">'+loading_big+'</div>');
    
    $.ajax({
        type: "GET",
        url: "search/get-detailed-gender-preference",
        dataType: 'html',
        data: data,
        success: function(html) {
           $('#busmap-' + id).find('#preference-list-action').html(html);
        }
    });
}

function setSeatPreference(gender) {
    var id = gct();
    if($('#busmap-' + id).find('.schedule-seat.available-for-all').length == 0) {
        return;
    }
    $('#seat-preference-dialog').removeClass('hidden');
    $('#seat-preference-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 550,
        modal: true,
        resizable: false,
        clickOutside: true
    });
    $(".ui-dialog-titlebar").hide();
    var genderName = '';
    if(gender == 'M') {
        genderName = 'Male';
    } else if(gender == 'F') {
        genderName = 'Female';
    }
    busmap = busMapData[id];
    var seats = $('#busmap-' + id).find('.schedule-seat.available-for-all').map(function() { 
        return busmap.seatDetails[$(this).data('code')].seatName;
    }).get();
    $('#seat-preference-dialog').find('#dialog-content').html('Do you want to set the seat <b>' + seats + '</b> to <b>' + genderName + '</b>?');
    $('#seat-preference-dialog').find('#hid-seat-pref-gender').val(gender);
}

function confirmSetSeatPreference() {
    var id = gct();
    var data = {};
    data.preferenceGendar = $('#seat-preference-dialog').find('#hid-seat-pref-gender').val();
    data.busSeatLayout = $('#busmap-' + id).find('.schedule-seat.available-for-all').map(function() { 
        return {code: $(this).data('code')}
    }).get();
    data.groupList = [];
    busmap = busMapData[id];
    data.tripCode = busmap.busmap.tripCode;
    
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
        
    $.ajax({
        type: "POST",
        url: "search/set-detailed-gender-preference",
        dataType: 'json',
        data: data,
        success: function(result) {
            if (result.status == 1) {
                loading_overlay.update({
                     icon: "fa fa-check",
                     text: "Success!"
                });
                 window.setTimeout(function() {
                    loading_overlay.hide();
                    closeSetSeatPreference();
                    refreshBusLayout();
                 }, 2000);
             
            } else {
                loading_overlay.hide();
                alert(result.errorDesc);
            }
        }
    });
}

function closeSetSeatPreference() {
    $('#seat-preference-dialog').dialog('destroy');
    $('#seat-preference-dialog').hide();
}

function deleteGenderSeatPreference(index) {
    if(confirm('Do you want to delete this Gender Preference?')) {
        var id = gct();
        busmap = busMapData[id];
        $('#busmap-' + id).find('#preference-list-action').find('#releasepref'+index).html(loading_popup);
        var data = detailGenderPreference[index] || {};
        data.tripCode = busmap.busmap.tripCode;
        $.ajax({
            type: "POST",
            url: "search/delete-detailed-gender-preference",
            dataType: 'json',
            data: data,
            success: function(result) {
                if(result.status==1) {
                    $('#busmap-' + id).find('#preference-list-action').find('#releasepref'+index).html('Deleted');
                    $('#busmap-' + id).find('#preference-list-action').find('#genderprefrow'+index).animate({backgroundColor: '#1AA1E1'}, 4000, function() {
                        $(this).remove()
                    });
                }
            }
        });
    }
}

function clearSeatPreferenceList() { 
    var id = gct();
    $('#busmap-' + id).find('#preference-list-action').addClass('hide');    
    $('#busmap-' + id).find('#fare-list-action').addClass('hide');
    
    $('#busmap-' + id).find('#bus-result-list-action').removeClass('hide');
    $('#busmap-' + id).find('#bus-result-list-action').html('<br><br><br><div class="well well-large" align="center">Please select a seat to get more options.</div>');
    refreshBusLayout();
}

function togglePBOptions(cb) {
    var id = gct();    
    $('#busmap-' + id).find('#phone-blocking-options').toggleClass(!cb.checked);
    
    if(menu_permission['SRP-PBO-MOB-BLO'] && cb.checked){
        validatePhoneBooking(id, cb);
    } else {
        $("#busmap-" + id).find('.error-list').html('');
        $("#busmap-" + id).find('.btn-booking').show();
    }
}

function toggleGstOptions(cb) {
    var id = gct();
    $('#busmap-' + id).find('#gst-formcontainer').toggleClass(!cb.checked);
    $('#busmap-' + id).find('#gst_gstin').focus();
}

function notifyTicket(id, pnr, type) {
    var data = {};
    var url, msg;
    if(type == 'SMS' || type == 'RSNDGPSHJ') {
        data.type = type;
        data.ticketpnrcode = pnr;
        data.tripCode = $("#result-panel-" + id).find('#trip_code').val();
        url = "search/sms-ticket";
        msg = 'SMS has been sent successfully';
        
        var eventaction = (type=='MAIL') ? 'SMS Ticket': 'SMS Tracking';
        ga_track_event('Ticket', eventaction, '');
    } else if(type == 'MAIL' || type == 'INVOICE') {        
        data.pnr = pnr;
        data.type = type;
        url = "search/email-ticket";
        msg = 'Email has been sent successfully';
        
        var eventaction = (type=='MAIL') ? 'Email Ticket': 'Email Invoice';
        ga_track_event('Ticket', eventaction, '');
    }
    
    $('#busmap-' + id).find('#notify-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#busmap-' + id).find('#notify-action-state').show();
    $('#busmap-' + id).find('#notify-action-state').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + url,
        data: data,
        success: function (res) {
            if (res.status == 1) {
                $('#busmap-' + id).find('#notify-action-state').addClass('alert-success').removeClass('alert-danger');
                $('#busmap-' + id).find('#notify-action-state').html(msg);
                setTimeout(function () {
                    $('#busmap-' + id).find('#notify-action-state').html('');
                    $('#busmap-' + id).find('#notify-action-state').hide();
                }, 3000);
            } else {
                $('#busmap-' + id).find('#notify-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#busmap-' + id).find('#notify-action-state').html(res.errorDesc);
                setTimeout(function () {
                    $('#busmap-' + id).find('#notify-action-state').html('');
                    $('#busmap-' + id).find('#notify-action-state').hide();
                }, 3000);
            }
        }
    })
}

function validatePhoneBooking(id, cb) { 
//    var id = gct();    
    var data = {};
    data.phone = $("#busmap-" + id).find('#mobileno').val();
    
    $("#busmap-" + id).find('.error-list').html('');
    
    if(data.phone == '' &&  !isValidPhonenumber(data.phone)){
        $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please enter valid  phone / mobile no.</div>');
        $(cb).prop('checked', false);
        return false;
    }
    $("#busmap-" + id).find('#mobileno').on('input', function() {
        $(cb).prop('checked' , false); 
        $("#busmap-" + id).find('.error-list').html('');
        $("#busmap-" + id).find('.btn-booking').show();
    });
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: "search/validate-phone-boooking",
        data: data,
        success: function (res) {
            if (res.status == 0) {
                $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">'+res.errorDesc+'</div>');
                $("#busmap-" + id).find('.btn-booking').hide();
            } else {
                $("#busmap-" + id).find('.error-list').html(''); 
                $("#busmap-" + id).find('.btn-booking').show();               
            }
        }
    });
}
