var id = 0;
var dropFlag = false;
var busData = {};
var tripStageCode = new Array();
var tripDate = new Array();
var fromStation = new Array();
var toStation = new Array();
var ticketpnr = new Array();
var seatStatusDetails = new Array();
var session_email = '';
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
    $(".gen").prop('checked', false); 
    $("input[name='name']").val('');
    $("input[name='age']").val('');
    if($("#mobileno").val() == ''){
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
                          $(name_arr[k]).val(name);
                          $(age_arr[k]).val(age);
                          $('input[id="' + gend+ '"][value="'+gendar+'"]').prop('checked', true);
                    }
                 }
             }
          }
     });
}


function clearResult(id) {
    $('#busmap-' + id).find('#bus-result-list-action').html('');
    $('#busmap-' + id).find('.schedule-seat').removeClass('schedule-seat');
    $('#busmap-' + id).find('.cancel-seat-process').removeClass('cancel-seat-process');
    $('#busmap-' + id).find('.phone-seat-process').removeClass('phone-seat-process');
}
function initbooking(id, bus) {
    $("#busmap-" + id).find('#emailaddress').val(session_email);
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
        data.phonebooking = $('input[name="phoneBooking"]').is(":checked") == true ? 1 : 0;
        data.stageCode = tripStageCode[id];
        data.tripDate = tripDate[id];
        data.fromStation = fromStation[id];
        data.toStation = toStation[id];
        data.paymentgate = $("#busmap-" + id).find('#payment-gateway').val();
        data.remarks = $("#busmap-" + id).find('#remarks').val();
        
        data.bordingstation = $("#busmap-" + id).find('#bording-point').val();
        data.droppingstation = $("#busmap-" + id).find('#dropping-point').val();
        
        data.spldiscount = Number($("#busmap-" + id).find('#spldiscount').val());
        data.offlineuser = $("#busmap-" + id).find('#offlineuser').val();
        data.agentservicecharges = Number($("#busmap-" + id).find('#agentservicecharges').val());
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
            return false;
        }

        if (data.emailaddress == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter email address.</div>');
            return false;
        } else if (!isValidEmailAddress(data.emailaddress)) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter valid email address.</div>');
            return false;
        }
        if (data.phone == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter phone / mobile no.</div>');
            return false;
        } else if (!isValidPhonenumber(data.phone)) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter valid  phone / mobile no.</div>');
            return false;
        }
        
        if (data.bordingstation == '') {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please select boarding point.</div>');
            return false;
        } 
        
        var nmeerr = 0;
        $("#busmap-" + id).find('input[name="name"]').each(function() {
            if (!$(this).hasClass('hide') && $(this).val() == '') {
                nmeerr++;
            }
        });

        var ageerr = 0;
        $("#busmap-" + id).find('input[name="age"]').each(function() {
            if (!$(this).hasClass('hide') && $(this).val() == '') {
                ageerr++;
            }
        });
        if (nmeerr > 0) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter name.</div>');
            return false;
        }
        if (ageerr > 0) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger" >Please enter age.</div>');
            return false;
        }
        if ($.isEmptyObject(data.gender)) {
            $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Please select gender.</div>');
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
           var max_sc_allowed = 100 * Number(data.seats.length);
            if(Number(data.agentservicecharges)> max_sc_allowed) {
              $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">Service charges should be '+max_sc_allowed+' or less.</div>');
              return false;
            }
        }
       
        $("#busmap-" + id).find('.btn-booking').hide();
        $("#busmap-" + id).find('.error-list').html(loading_big);
        $.ajax({
            type: "POST",
            url: "search/update-seat-booking",
            dataType: 'json',
            data: data,
            //async: false,
            success: function(res) {
                $("#busmap-" + id).find('.btn-booking').show();
                if (res.status == 0) {
                    $("#busmap-" + id).find('.error-list').html('<div class="alert alert-danger">' + res.errorDesc + '</div>');
                } else if (res.status == 1) {
                    if (data.phonebooking == 1) {
                        $("#busmap-" + id).html(loading_big);
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
                        $("#busmap-" + id).html(loading_big);
                        setUserBalance(res.data.currentBalance);
                        ticketDetails(res.data.ticket[0].code, id);

                    }
                }
            }
        });

    });
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
            $("#busmap-" + id).html(res);
            $('#busmap-' + id).find('.btn-clear-ticket').attr('onclick', 'clearList(' + id + ')');
        }
    });
}
function clearList(id){
    var tripCode = $("#bus" + id).find('.li_bk').attr('data-trip');
    var stageCode = $("#bus" + id).find('.li_bk').attr('data-trip-stage');
    var tbid = $("#bus" + id).find('.li_bk').attr('data-tab');

    Busmapload(tripCode, stageCode, tbid);
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
        if ($('#amount-ovr').val() != '') {
            data.amount = $('#busmap-' + id).find('#amount-ovr').val();
        } else {
            data.amount = $('#busmap-' + id).find('#refe_txt').val();
        }
        
        

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
function phoneBookingConfirm(id) {
    var data = {};
    data.seatcode = new Array();
    $('#busmap-' + id).find('.pnr_user_list:checked').each(function() {
        data.seatcode.push($(this).val());
    });
    if(data.seatcode.length==0) {
        alert('Please select atleast one seat to confirm');
        return false;
    }
    data.pnrcode = $('#busmap-' + id).find('#pnr_code').val();
    data.bookByMyAccountFlag = $('input[name="bk_flg"]').is(":checked") == true ? true : false;
   
    var loading_overlay = iosOverlay({
     text: "Loading",
     icon: "fa fa-spinner fa-spin"
    });
    
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
	divhtml.find('#cookie-result').attr('id', 'cookie-result-' + id).css("width","30%");
	divhtml.find('#cookie2-result').attr('id', 'cookie2-result-' + id).css("width","30%");
    divhtml.find('#result-panel').attr('id', 'result-panel-' + id).addClass('min_h_300');
    $('<li><a href="#' + tid + '" class="hidden-xs" data-toggle="tab" title="' + tabtitle + '">'+tabtitle+' <span title="Close" class="fa fa-times" onclick=\'tabdelete(this)\'></span></a></li>').insertBefore('#add-tab');
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
	
    $('#sdate-search-' + id).datepicker({
        todayHighlight: true,
        format: "yyyy-mm-dd",
        startDate: '-1d',
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
    var date_format = curr_year + '-' + curr_month + '-' + curr_date;   
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


function quickSearch(fromstation,tostation,searchdate, id){    
    $('#from-station-search-' + id).val(fromstation).trigger("change");
    toStationLoading(id);        
    $('#to-station-search-' + id).val(tostation).trigger("change");
    var aDate = searchdate.split("-");    
    $('#sdate-search-' + id).datepicker("setDate", new Date(aDate[0], aDate[1]-1, aDate[2]));
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
    var html2=" ";
    var pastChoiceLst = JSON.parse($.cookie("searchhistory-data"))? JSON.parse($.cookie("searchhistory-data")) :[];

    $.each( pastChoiceLst, function( index, item ){        
        if(index<=10){
            html+="<a href='javascript:;' class='list-group-item' onclick = quickSearch('"+item.fromstation+"','"+item.tostation+"','"+item.searchdate+"',"+id+")>"+$("#"+item.fromstation).html() ;
            html+=" to "+ $('#'+item.tostation).html() ;
            html+="&nbsp;on&nbsp;"+formatDate(item.searchdate)+"</a>";
        } else if(index>10 && index<=20){
            html2+="<a href='javascript:;' class='list-group-item' onclick = quickSearch('"+item.fromstation+"','"+item.tostation+"','"+item.searchdate+"',"+id+")>"+$("#"+item.fromstation).html() ;
            html2+=" to "+ $('#'+item.tostation).html() ;
            html2+="&nbsp;on&nbsp;"+formatDate(item.searchdate)+"</a>";
        }
     });
    $("#cookie2-result-"+id).html(html2);
    html+= "</div>";
    return html;
}
function formatDate( str ){
    var aDate = str.split("-");
    if ( aDate.length > 0 ){
            return aDate[2]+"/"+aDate[1]+"/"+aDate[0];
    }else{
            return "";
    }
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
    $('#result-panel-' + id).html(loading_big);

    if ( saveResult ){		
        $.cookie.json = true;
        var pastChoiceLst = JSON.parse($.cookie("searchhistory-data"))? JSON.parse($.cookie("searchhistory-data")) :[];
        $.each( pastChoiceLst, function( index, item ){
                if(item.fromstation == data.fromStation && item.tostation == data.toStation && item.searchdate == data.sdate){
                        pastChoiceLst.splice(index, 1);
                        return false;
                }
        });
        pastChoiceLst.push( new search(data.fromStation,data.toStation,data.sdate));
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

            if ( !fromQuickSearch ){
                if (date == 0) {
                    $('a[href="#box_tab' + id + '"]').html($('#from-station-search-' + id).find(":selected").text().substring(0, 3) + ' to ' + $('#to-station-search-' + id).find(":selected").text().substring(0, 3) + '&nbsp;' + curr_date + '/' + curr_month + '&nbsp;&nbsp;<span title="Close" class="fa fa-times" onclick=\'tabdelete(this)\'></span>&nbsp;&nbsp;'); //<br><span id="s_date_' + id + '">' + data.sdate + '</span>&nbsp;&nbsp;<a title="Click to view next day details" data-toggle="tooltip" style="cursor:pointer" class="next-day" onclick=\'getNdate(' + id + ',"' + data.sdate + '")\'><i class="glyphicon glyphicon-chevron-right"></i></a>
                } else {
                    $('a[href="#box_tab' + id + '"]').html($('#from-station-search-' + id).find(":selected").text().substring(0, 3) + ' to ' + $('#to-station-search-' + id).find(":selected").text().substring(0, 3) + '&nbsp;' + curr_date + '/' + curr_month + '&nbsp;&nbsp;<span title="Close" class="fa fa-times" onclick=\'tabdelete(this)\'></span>&nbsp;&nbsp;');
                }
            }
			
            if (res.data == '' || res.data == null) {
                $('#search-panel-' + id).show();
                $('#result-panel-' + id).html('<div class="well well-large"> Sorry! No bus available.</div>');

            } else if (res.data.length > 0) {
                //$('#search-panel-' + id).hide();
                if (res.dropFlag == 1) {
                    dropFlag = true;
                }
                if (res.session_email != '') {
                    session_email = res.session_email;
                }
                var html = '<div id="bus' + id + '">\n\
                                       <div class="col-md-6 p_l_n">\n\
                                            <div class="scroller box_content" data-height="650px" data-always-visible="1" data-rail-visible="1">\n\
                                                 <div class="header">\n\
                                                    <div class="pull-left col-lg-3">\n\
                                                         <span class="bold">From : </span><span class="frm-sta">' + $('#from-station-search-' + id).find(":selected").text() + '</span>\n\
                                                    </div>\n\
                                                    <div class="pull-left col-lg-3">\n\
                                                         <span class="bold">To : </span><span class="to-sta">' + $('#to-station-search-' + id).find(":selected").text() + '</span>\n\
                                                    </div>\n\
                                                    <div class="pull-left col-lg-4">\n\
                                                         <span class="bold">On : </span><span class="trp-date">';
                if (rsu<1) {   //  hide past date nav
                    html += '<a title="Previous day" data-toggle="tooltip" class="prev-day-' + id + '" onclick=\'getPdate(' + id + ',"' + data.sdate + '")\'><i class="glyphicon glyphicon-chevron-left"></i></a>';
                }
                html += '&nbsp;&nbsp;<span id="s_date_' + id + '">' + data.sdate + '</span>&nbsp;&nbsp;<a title="Next day" data-toggle="tooltip" style="cursor:pointer" class="next-day" onclick=\'getNdate(' + id + ',"' + data.sdate + '")\'><i class="glyphicon glyphicon-chevron-right"></i></a></span>\n\
                                                    </div>\n\
                                                     <div class="pull-right">\n\
                                                            <a id="refresh-list-' + id + '" title="Refresh" data-toggle="tooltip" href="javascript:;"><i class="fa fa-repeat f17"></i></a>&nbsp;\n\
                                                            <a id="close-list-' + id + '"  title="Clear" data-toggle="tooltip" data-toggle="popover" data-toggle="tooltip" href="javascript:;"><i class="fa fa-times f17"></i></a>\n\
                                                    </div>            \n\
                                             </div>\n\
                                            <div class="clear_fix_both"></div>\n\
                                        <ul class="list-unstyled trip-list">';
                /* <div class="pull-right"> <a id="close" title="close" data-toggle='tooltip' href="javascript:;"><i class="fa fa-times f17"></i></a></div>
                 <div class="pull-right"> <a id="refresh" title="refresh" data-toggle='tooltip' href="javascript:;"><i class="fa fa-repeat f17"></i></a></div>*/

                busData[id] = res.data;
                $.each(res.data, function(bkey, bval) {
                    var tripList = $('#template-bus-list').html();
                    tripList = $('<div>').html(tripList).clone();
                    tripList.find('.busName').html(bval.busName);
                    tripList.find('.busCategory').html(bval.busCategory);
                    tripList.find('.has-cancel-popover').attr('data-stageCode', bval.tripStageCode).attr('data-tap', id).attr('onclick', 'dialogTerms("'+bval.tripStageCode+'", "'+bval.tripCode+'")');
                    tripList.find('.pp').attr('data-station', bval.fromStation.code).attr('data-tripcode', bval.tripCode).attr('data-tap', id);
                    tripList.find('.dp').attr('data-station', bval.toStation.code).attr('data-tripcode', bval.tripCode).attr('data-tap', id);
                    tripList.find('li').attr('data-trip-stage', bval.tripStageCode).attr('data-trip', bval.tripCode).attr('data-tab', id).attr('id', 'trip-'+ bval.tripCode).attr('date-timestatus', bval.tripTimeCrossed);
                    tripList.find('.settings-icon').attr('data-tap', id).attr('onclick', 'tripMoreOptions("'+bval.scheduleCode+'", "'+bval.tripCode+'","'+data.sdate+'")');
                    var fare = '';
                    var discount = '';
                    var seatCount = 0;
              
                    $.each(bval.fare, function(fkey, fre) {
                        if (fare != '')
                            fare += ', ';
                        fare += '<i class="fa  fa-rupee"></i>&nbsp;' + fre.fare;
                        if (discount != '')
                        	discount += ',';
                        if(Number(fre.discountFare)>0)
                            discount += '<i class="fa  fa-rupee"></i>&nbsp;' + fre.discountFare +'(off)';
                        seatCount = Number(seatCount) + Number(fre.availableSeatCount);
                    });
                    
                   
                    
                    var via = [];
                    $.each(bval.viaStations, function(vkey, vname) {
                        via.push(vname.name);                     
                    });
                    var vt = via.join(', ');
                    var len = vt.length;
                    var vtt = vt;
                    if(len>25) vtt = vt.substring(0, 24)+'...';
                    tripList.find('.busVia').html('<span data-toggle="tooltip" title="'+vt+'"><span class="bold text-danger" >Via : </span>'+vtt+'</span>');
                    
                    //bval.fare                   
                    tripList.find('.fare').html(fare);
                    if(discount!='')
                        tripList.find('.discount').html('&nbsp;' +discount);
                    tripList.find('.travelTime').html(bval.travelTime+' hrs');
                    tripList.find('.ftime').html(datetimeToTime(bval.fromStation.dateTime));
                    tripList.find('.ttime').html(datetimeToTime(bval.toStation.dateTime));
                    if( parseInt(seatCount) <=0 ) {
                        tripList.find('.seat-count').parent().removeClass('label-success').addClass('label-danger');
                        seatCount = 'Sold Out';
                    } else {
                        seatCount += ' seats';
                    }
                    tripList.find('.seat-count').html(seatCount);
                    tripList.find('.trip-status').html(bval.tripStatus);
                    
                    //  amenities
                    var amenities = '';
                    if(bval.amenities!='') {
                        $.each(bval.amenities, function(akey, ame) {
                            if(ame.code != 'AMEG2106511') {
                                amenities += '<img data-toggle="tooltip" data-original-title="'+ame.name+'" src="assets/img/'+ame.code+'.png" width="17" />';
                            }
                        });
                        tripList.find('.amenities').html(amenities);
                    }
                                       
                    html += tripList.html();
                });
                html += "</ul></div></div>";
                html += '<div id="busmap-' + id + '" class="col-md-6 box_content min_h_300"><div id="Def_txt"><div class="well well-large">Please select bus to know more details.</div></div></div>';
                $('#result-panel-' + id).html(html);
                $("[data-toggle='tooltip']").tooltip();
                $('#refresh-list-' + id).bind('click', function(e) {
                    dosearch(id);
                });
                $('#close-list-' + id).bind('click', function(e) {
                    clearSearch(id);
                    $('#search-panel-' + id).slideDown();
                    $("#cookie2-result-"+id).slideDown();
                    $("#cookie-result-"+id).slideDown();
                    $('a[href="#box_tab' + id + '"]').attr('title', 'Plan Your Travel');
                    $('a[href="#box_tab' + id + '"]').html('Plan Your Travel <span title="Close" class="fa fa-times" onclick=\'tabdelete(this)\'></span>');
                });
                $('#s_date_' + id).datepicker({
                    format: 'yyyy-mm-dd',
                    autoclose: true
                });
                $('#s_date_' + id).datepicker().on('changeDate', function(ev) {

                    var dates = $('#s_date_' + id).datepicker('getDate');
                    dates.setTime(dates.getTime() + (1000 * 60 * 60 * 24))

                    var d = dates;
                    var curr_date = d.getDate() - 1;
                    var curr_month = d.getMonth() + 1;
                    var curr_year = d.getFullYear();
                    if (curr_month < 10) {
                        curr_month = '0' + curr_month;
                    }
                    if (curr_date < 10) {
                        curr_date = '0' + curr_date;
                    }



                    var date_format = curr_year + '-' + curr_month + '-' + curr_date;
                    var date_new = $('#s_date_' + id).datepicker('getDate');
                    $('#sdate-search-' + id).datepicker("setDate", date_new);
                    $('#s_date_' + id).html(date_format);
                    $('#sdate-search-' + id).val(date_format);
                    dosearch(id);
                });
                
                $.each(res.data, function(key, trip) {
                    var tripcode = trip.tripCode;
                    var boarding = '<table width="200"><tr> <th colspan="2">Boarding Points</th> </tr>';
                    $.each(trip.fromStation.stationPoint, function(pbkey, bp) {
                        boarding += '<tr> <td width="65%">'+bp.name+'</td>    <td width="35%">'+dateToDateTime(bp.dateTime,2)+'</td>';
                    });
                    boarding += '</table>';
                   
                    var arrival = '<table width="200"><tr> <th colspan="2">Dropping Points</th> </tr>';
                    $.each(trip.toStation.stationPoint, function(pbkey, dp) {
                        arrival += '<tr> <td width="65%">'+dp.name+'</td>    <td width="35%">'+dateToDateTime(dp.dateTime,2)+'</td>';
                    });
                    arrival += '</table>';
                    
                    $('#trip-'+tripcode).find('.boarding').popover({
                        container:'body',
                        content:boarding,
                        html:true,
                        placement:'right',
                        trigger:'hover',
                    });

                    $('#trip-'+tripcode).find('.arrival').popover({
                        container:'body',
                        content:arrival,
                        html:true,
                        placement:'right',
                        trigger:'hover',
                    });

                });
                
                
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

                $('.ticket-row').each(function() {
                    $(this).bind('click', function(e) {						
                        if (!e)
                            e = window.event;

                        if ($(e.target).hasClass('has-cancel-popover') || $(e.srcElement).hasClass('has-cancel-popover')) {
                            return false;
                        }
//                        if ($(this).hasClass('li_bk')) {
//                            return false;
//                        }
                        $('#Def_txt').val('');
                        $('#Def_txt').remove();

                        if ($("#busmap-" + id).html() != '' && !$(this).hasClass('li_bk')) {
                            if (!confirm("Are you sure to switch bus?")) {
                                return false;
                            }
                        }
                        $("#result-panel-" + id).find('.li_bk').removeClass('li_bk');                        
                        
                        
                        $(this).addClass('li_bk');
                        var tripCode = $(this).attr('data-trip');
                        var stageCode = $(this).attr('data-trip-stage');

                        var tbid = $(this).attr('data-tab');
                        Busmapload(tripCode, stageCode, tbid);
                    });
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

function Busmapload(trip, stage, id) {

    $('.has-popover').each(function() {
        $(this).popover('hide');
    });

    var data = {}
    data.tripCode = trip; //$(this).attr('data-trip');
    data.stageCode = stage;//$(this).attr('data-trip-stage');
    tripStageCode[id] = data.stageCode;
    data.id = id;
    $(this).attr('data-tab');
    $("#busmap-" + id).html(loading_big);

    $.ajax({
        type: "POST",
        url: "search/get-busmap",
        dataType: 'json',
        data: data,
        success: function(res) {
            if(res.status==0){
                $("#busmap-" + id).html('<div class="alert alert-danger"> Sorry! Falied loading data </div>');
                return;
            }
            seatStatusDetails[id] = res.busmap.bus.seatLayoutList;
            busMap(res, id);
            $("[data-toggle='tooltip']").tooltip();
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
var settings_code = '';
var settings_date = '';
function tripMoreOptions(schedule, trip, date) {
    $('#sch-workspace-content').html('');   //  clear schedule more option container to aviod conflit
    t = $('li[data-trip='+trip+']');
    tab = $(t).attr('data-tab');
    
    troute = $('#result-panel-'+tab).find('.frm-sta').text()+' To ' + $('#result-panel-'+tab).find('.to-sta').text();
    tdate = $('#s_date_'+tab).text();
    ttime = $(t).find('.ftime').text();
    tbus = $(t).find('.busCategory').text();
    
    var tmp = $('#template-trip-setings').html();
    $('#trip-settings').html(tmp).clone();
    $('#trip-setting-head').html(troute + ', ' + tdate + ', ' + ttime + ', ' + tbus);
    
    $('#tabs_s a:first').tab('show');
    
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
        
    settings_code = schedule;
    settings_date = date;
    $('#sch_code').val(settings_code);
    
    load_fare_overrides();
}

function close_settings_popup() {
    $('#trip-settings').dialog('close');
}

function load_fare_overrides() {    
    var data = {};
    data.code = settings_code;
    data.tripDate = settings_date;
    $('#s_fare_override_s').html(loading_popup);
    $.ajax({
         type: "POST",
         url: base_url + "schedules/get-schedule-auto-override?from=search",
         data: data,
         dataType: 'html',
         success: function(res) {             
             $('#s_fare_override_s').html(res);
             $('#fao-date_disc').val(settings_date+' | '+settings_date); 
         }
     });
}

function load_seat_visiblity() {    
    var data = {};
    data.code = settings_code;
    data.tripDate = settings_date;
    $('#s_seat_visiblity_s').html(loading_popup);
    $.ajax({
         type: "POST",
         url: base_url + "schedules/trip-seat-visiblity?from=search",
         data: data,
         dataType: 'html',
         success: function(res) {             
            $('#s_seat_visiblity_s').html(res);
                        
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
    var result = busSeat(bus.lrowmax, bus.lcolmax, bus.lrowmin, bus.lcolmin, bus.seatStatus, bus.seatDetails, 1, id);
    
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
        var result = busSeat(bus.urowmax, bus.ucolmax, bus.urowmin, bus.ucolmin, bus.seatStatus, bus.seatDetails, 2, id);
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
        $("#busmap-" + id).html('<div id="Def_txt"><div class="well well-large">Please select bus to know more details.</div></div>');
    });
    $("#busmap-" + id).find('#refresh').click(function() {
        $("#busmap-" + id).html('');
        $("#bus" + id).find('.li_bk').trigger('click');
        var tripCode = $("#bus" + id).find('.li_bk').attr('data-trip');
        var stageCode = $("#bus" + id).find('.li_bk').attr('data-trip-stage');
        var tbid = $("#bus" + id).find('.li_bk').attr('data-tab');

        Busmapload(tripCode, stageCode, tbid);
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
        html: true
    });
    $("#busmap-" + id).find('.seat-select-visibility').click(function() {

        if ($("#busmap-" + id).find('.cancel-seat-process').length > 0 || $("#busmap-" + id).find('.phone-seat-process').length > 0) {
            alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
            return false;
        } //
        var sel_seat_cnt = $("#busmap-" + id).find('.schedule-seat').length;
        $(this).toggleClass("schedule-seat");
        var set = '';
        var totamt = 0;
        var tax = 0;
        var seatfare = 0;
        var discountFare = 0;

        var seat = bus.seatDetails[$(this).attr('data-code')]['seatName'];
        var seat_code = $(this).attr('data-code');
        //

        if ($("#busmap-" + id).find('.schedule-seat').length == 1) { // available seats.
            //$('')template-book-list
            ts = $("#busmap-" + id).find('#trip-status').attr('data-tripstatus'); 
            tts = $("#busmap-" + id).find('#trip-status').attr('data-timestatus'); // trip time past or not
                        
            if(ts=="TPY")  {    // trip yet to open
                $(this).toggleClass("schedule-seat");
                alert('Sorry! Booking not allowed');
                return false;
            }
            
            if(ts=="TPC")  {    // trip closed
                if(parseInt( menu_permission['BOOK-AFTER-TRIP-TIME'] ) != 1 || tts==0) {                
                    $(this).toggleClass("schedule-seat");
                    alert('Sorry! Booking not allowed');
                    return false;
                }
            }
            
            var seatDiv = $('#template-book-list').html();
            seatDiv = $('<div>').html(seatDiv).clone();
            seatDiv.find('.btn-cancel').attr('onclick', 'clearResult(' + id + ')');
            var option = '<option value="">Bording Points</option>';
            $.each(bus.busmap.fromStation.stationPoint, function(ke, svalue) {
                option += '<option value="' + svalue.code + '">' + svalue.name + ' - '+ dateToDateTime(svalue.dateTime,2) +'</option>';
            });
            seatDiv.find('#bording-point').html(option);
            if (dropFlag) {
                //var option = '<option>Dropping Points</option>';
                var option = '';
                $.each(bus.busmap.toStation.stationPoint, function(dkey, dval) {
                    option += '<option value="' + dval.code + '">' + dval.name + ' - '+ dateToDateTime(dval.dateTime,2) +'</option>';
                });
                seatDiv.find('#dropping-point').html(option);
                seatDiv.find('.drp-lst').removeClass('hide')
            //
            }
            
            $("#busmap-" + id).find('#bus-result-list-action').html(seatDiv.html());
            $("#busmap-" + id).find('#offlineuser').select2({
                placeholder: "Select a user",
                escapeMarkup: function(markup) {
                    return markup;
                }
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
                tax = tax + Number(bus.seatDetails[code]['serviceTax']);
                seatfare = seatfare + Number(bus.seatDetails[code]['fare']);
                discountFare = discountFare + Number(bus.seatDetails[code]['discount']);

                totamt = totamt + Number(bus.seatDetails[code]['fare']) + Number(bus.seatDetails[code]['serviceTax'])- Number(bus.seatDetails[code]['discount']);
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
        
        if($('#agentservicecharges').length>0) {    //  special discount
            var agentcharges = $.trim($('#agentservicecharges').val());
            tax = tax + Number(agentcharges);
            totamt = totamt + Number(agentcharges);
        }
        
        if($('#spldiscount').length>0) {    //  special discount
            var spldiscount = $.trim($('#spldiscount').val());            
            totamt = totamt - spldiscount;
        }
            

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

        //  show ax only if available
        $("#busmap-" + id).find('#tax-container').addClass('hidden');
        if(Number(tax)>0) {            
            $("#busmap-" + id).find('#tax-container').removeClass('hidden');
        }
        $("#busmap-" + id).find('.total-tax').html(Number(tax).toFixed(2));
        $("#busmap-" + id).find('#discount-container').addClass('hidden');
        if(Number(discountFare)>0) {            
            $("#busmap-" + id).find('#discount-container').removeClass('hidden');
        }
        $("#busmap-" + id).find('.discount').html(Number(discountFare).toFixed(2));
        $("#busmap-" + id).find('.fare').html(Number(totamt).toFixed(2));
        
        //  for spl discount calculation
        $("#busmap-" + id).find('.discount').attr('data-adiscount', discountFare);
        $("#busmap-" + id).find('.fare').attr('data-total', totamt);    
        
        recalculateSplDiscount(id);        
        
        if ($("#busmap-" + id).find('.schedule-seat').length == 0) {
            $("#busmap-" + id).find('#bus-result-list-action').html('');
        }

    });
    //                         $.ajax({
    //                             type: "POST",
    //                             url: "search/update-seat-booking",
    //                             dataType : 'json',
    //                             data:data,
    //                             //async: false,
    //                             success: function(seatlist) {
    //                                 $.each(seatlist,function(keys,vals){
    //                                    alert("test");
    //                                 });
    //                             }
    //                         });
    $("#busmap-" + id).find('.seat-booked[data-tcode="BL39FG"]').click(function() {
        if ($("#busmap-" + id).find('.schedule-seat').length > 0 || $("#busmap-" + id).find('.cancel-seat-process').length > 0) {
            alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
            return false;
        }
                
        $(this).toggleClass("cancel-seat-process");
        if ($(this).hasClass('cancel-seat-process')) {
            $.each(seatStatusDetails[id], function(keys, vals) {
                var code = $('#busmap-' + id).find('.cancel-seat-process').attr('data-code');
                if (code == vals.code) {
                    var ss = vals.seatStatus.code
                    $.each(seatStatusDetails[id], function(keys, hlt) {
                        if (vals.ticketCode == hlt.ticketCode) {
                            $('#busmap-' + id).find('.seat-booked[data-code="' + hlt.code + '"]').addClass('schedule-seat');
                        }
                    });
                }
            });
        }
        var divButton = $('#template-success-button').html();
        divButton = $('<div>').html(divButton).clone();
        $('#busmap-' + id).find('#bus-result-list-action').html(divButton.html());
        $('#busmap-' + id).find('.btn-cnl').click(function() {
            loadCancelInfo(id);
        });
        $('#busmap-' + id).find('.btn-print').click(function() {
            loadBookedInfo(id);
        });
        $('#busmap-' + id).find('.btn-clr').click(function() {
            clearResult(id);
        });
    });
    $("#busmap-" + id).find('.seat-phone-blocked[data-tcode = "BL39FG"]').click(function() {
        if ($("#busmap-" + id).find('.schedule-seat').length > 0 || $("#busmap-" + id).find('.cancel-seat-process').length > 0 || $("#busmap-" + id).find('.phone-seat-process').length > 0) {
            alert("Invalid selection. \n\n Have to clear current selection to select another seat.");
            return false;
        }
        $(this).toggleClass("phone-seat-process");
        var code = $(this).attr('data-code');
        $.each(seatStatusDetails[id], function(keys, vals) {
            if (code == vals.code) {
                var ss = vals.seatStatus.code
                if (code == vals.code) {
                    var ss = vals.seatStatus.code
                    $.each(seatStatusDetails[id], function(keys, hlt) {
                        if (vals.ticketCode == hlt.ticketCode) {
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
//  calculate spl discount
function recalculateSplDiscount(id) {
    var idt = id;
    if(typeof(id) == "object") {
        id = $(id).attr('index');
    }
    $("#busmap-" + id).find('#discount-container').addClass('hidden');
    
    var df = $("#busmap-" + id).find('.discount').attr('data-adiscount');
    var tot = $("#busmap-" + id).find('.fare').attr('data-total');
    
    var spldiscount = $.trim( $('#spldiscount').val() );
    if(isNaN(spldiscount) || spldiscount == "")
        spldiscount = 0;
    
    df = Number(df) +  parseInt(spldiscount);
    tot = Number(tot) - parseInt(spldiscount);
    if(df>0)
         $("#busmap-" + id).find('#discount-container').removeClass('hidden');

    $("#busmap-" + id).find('.discount').html(Number(df).toFixed(2));
    $("#busmap-" + id).find('.fare').html(Number(tot).toFixed(2));
    
    //  service charges    
    $("#busmap-" + id).find('#service-container').addClass('hidden');           
    var agent_charges = $.trim( $('#agentservicecharges').val() );
    if(isNaN(agent_charges) || agent_charges == "")
        agent_charges = 0;
    
    tot = Number(tot) + parseInt(agent_charges);
    if(parseInt(agent_charges)>0) {
         $("#busmap-" + id).find('#service-container').removeClass('hidden');
         $("#busmap-" + id).find('.total-service').html(Number(agent_charges).toFixed(2));
     }
    
    $("#busmap-" + id).find('.fare').html(Number(tot).toFixed(2));
    
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
function busSeat(row, col, rowmin, colmin, seatstatus, seatDetails, lay, id) {
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
        "BL": "Blocked"
    };
    var seatStatusClass = {
        "AM": "seat-available-gents", 
        "AF": "seat-available-ladies", 
        "AL": "", 
        "BO": "seat-booked", 
        "BM": "seat-booked-gents", 
        "BF": "seat-booked-ladies", 
        "AY": "seat-available-you", 
        "AO": "seat-available-other", 
        "UK": "seat-booked-blocked", 
        "TBL": "seat-booked-blocked", 
        "PBL": "seat-phone-blocked", 
        "BL": "seat-booked-blocked"
    };
    var rowSeatFoundCount = {};
    for (var i = rowmin; i <= row; i++) {
        for (var j = colmin; j <= col; j++) {
            var set = lay + "" + i + "" + j;
            if(rowSeatFoundCount[i] != undefined){
                rowSeatFoundCount[i] = rowSeatFoundCount[i]+1;
            }else{
                rowSeatFoundCount[i] = 1;
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

                var dataPop = "<div style='text-align:center'>" 
                              + seatDetails[seatstatus[set]['code']]['seatName'] 
                              + " , "+ seatstatus[set]['seatType'] 
                              + " , <i class='fa fa-rupee'></i> " + seatstatus[set]['fare'] + "<br />" 
                              + seatStatusList[seatstatus[set]['status']['code']] + "";
                if(menu_permission['PHB-SHOW-TKT-INFO']!==1 && 
                        (seatstatus[set]['status']['code'] == 'AO' 
                         || seatstatus[set]['status']['code'] == 'BL') ) {
                     var dataPop = "<div style='text-align:center'>" + seatStatusList[seatstatus[set]['status']['code']] + "";
                }      

                if (seatstatus[set]['code'] != undefined && seatstatus[set]['status'] != undefined) {
                    if(htm!='') htm += ',';

                    if(htm.indexOf(seatstatus[set]['code']) == -1) 
                        htm = seatstatus[set]['status']['code']
                    if (seatstatus[set]['status']['code'] != 'BO' &&  seatstatus[set]['status']['code'] != 'BL' 
                            && seatstatus[set]['status']['code'] != 'AO' && seatstatus[set]['status']['code'] != 'TBL' 
                            && seatstatus[set]['status']['code'] != 'BF' && seatstatus[set]['status']['code'] != 'BM' 
                            && seatstatus[set]['status']['code'] != 'PBL' && seatstatus[set]['status']['code'] != undefined) {
                        seatclass += ' seat-select-visibility ' + seatStatusClass[seatstatus[set]['status']['code']];
                    } else {
                        seatclass += seatStatusClass[seatstatus[set]['status']['code']];
                    }
                    c = ' data-code = "' + seatstatus[set]['code'] + '"';
                    if ( seatstatus[set]['status']['code'] == 'AO' || seatstatus[set]['status']['code'] == 'BL') {
                        var temp = '';
                        if (seatstatus[set]['userName'] != undefined) {
                            temp += ' to ' + seatstatus[set]['userName']+" (U) "; //userName
                        }
                        if (seatstatus[set]['groupName'] != undefined) {
                            if(temp!='') temp += ',';
                            temp += ' to ' + seatstatus[set]['groupName']+" (G) ";
                        }
                        if(temp!='' && menu_permission['PHB-SHOW-TKT-INFO']==1){
                            dataPop += temp;
                        }
                    }
                    dataPop += "</div>";
                    sn = seatDetails[seatstatus[set]['code']]['seatName'];
                    if (seatstatus[set]['status']['code'] == 'BO' || seatstatus[set]['status']['code'] == 'PBL') {
                        
                        $.each(seatStatusDetails[id], function(t, tik) {
                            if (seatstatus[set]['code'] == tik.code) {                                
                                if(tik.ticketCode != '' && tik.ticketCode != undefined) { //  show ticket info
                                    c += ' data-tcode = "BL39FG"';
                                    dataPop = "<div style='text-align:center'>" + tik.ticketCode;
                                    //dataPop += "<br />Age     :" + tik.passengerAge; //
                                    //dataPop += "<br />Phone   :" + tik.contactNumber; //
                                    dataPop += "<br />" + tik.passengerName + "(" + tik.seatGendarStatus.code + ")" + " - " + tik.contactNumber;
                                    dataPop += "<br />" + tik.route

                                    if (tik.boardingPointName != undefined) {
                                        dataPop += "<br>" + tik.boardingPointName;
                                    }
                                    if (tik.droppingPointName != undefined) {
                                        dataPop += "&nbsp;-&nbsp;" + tik.droppingPointName;
                                    }

                                    dataPop += "<br />Booked By : " + tik.user.name;
                                    dataPop += "</div>";
                                } else {
                                    c = '';
                                    //dataPop = '' // reset popovers
                                } 
                                
                                if (tik.seatGendarStatus != undefined) {                                
                                    if (tik.seatGendarStatus.code == "M" && tik.seatGendarStatus.code != undefined) {
                                        seatclass += ' seat-booked-gents ';
                                    } else if (tik.seatGendarStatus.code == "F" && tik.seatGendarStatus.code != undefined) {
                                        seatclass += ' seat-booked-ladies ';
                                    }
                                }
                            }                            
                            
                        });                        
                    }
                }
                
                if (seatstatus[set]['status'] != '' && seatstatus[set]['status'] != undefined && seatstatus[set]['status'] == 1 && seatstatus[set] != undefined) {
                    seatclass += ' seat-booked ' + seatStatusClass[seatstatus[set]['status']['code']];
                }
                if (seatstatus[set]['seatType'] != '' && seatstatus[set]['seatType'] != undefined && (seatstatus[set]['seatType'] == "Sleeper" || seatstatus[set]['seatType'] == "Upper Sleeper" || seatstatus[set]['seatType'] == "Lower Sleeper") ) {
                    BusSeatTypeclass =' sleeper-lay-search ';
                    sleeperSeatFound = true;
                }else{
                    sleeperSeatFound = false;
                }
                preSeatType = seatstatus[set]['seatType'];
            } else if(rowSeatFoundCount[i] != undefined && rowSeatFoundCount[i] > 0 && !sleeperSeatFound){// && seatstatus[previousSeatPos]['seatType'] != '' && seatstatus[previousSeatPos]['seatType'] != undefined && seatstatus[previousSeatPos]['seatType'] == "Sleeper" ){
                sn = '&nbsp;';
                dataPop = '';
                if(preSeatType == "Sleeper" || preSeatType == "Upper Sleeper" || preSeatType == "Lower Sleeper") BusSeatTypeclass =' sleeper-lay-search ';
            }else if(rowSeatFoundCount[i] == 0 && !axialFound){
                sn = '&nbsp;';
                axialFound = true;
                dataPop = '';
            }
            
            if(sn != ''){
                s += '<div class="p_tool  seat-lay-out ' + BusSeatTypeclass +seatclass +  '" ' + c 
                if(dataPop !='' )
                    s += ' data-toggle="popover" data-container="body" data-placement="left" data-trigger="hover" data-content="' + dataPop + '"'
                s +=' >' + sn + '</div>';
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
    var date_format = curr_year + '-' + curr_month + '-' + curr_date;
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
    var date_format = curr_year + '-' + curr_month + '-' + curr_date;
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

