function init_pending_order_page() {
    /*$('#date_from').datepicker({
     //     todayHighlight: true,
     format: 'yyyy-mm-dd',
     autoclose: true,
     changeMonth: true,
     }).on('changeDate', function(e) {
     var fDate = new Date(e.date);
     var end = new Date(fDate.setDate(fDate.getDate() + 365));
     $('#date_to').datepicker('setStartDate', e.date);
     $("#date_to").datepicker("setEndDate", end)
     });
     $('#date_to').datepicker({
     todayHighlight: true,
     startDate: '-0m',
     format: 'yyyy-mm-dd',
     maxDate: "+365D",
     autoclose: true
     }).on('changeDate', function(e) {
     $('#date_from').datepicker('setEndDate', e.date)
     }); */

    //getPendingOrder();
    //getDeniedOrder();
    //getFailureOrder();
}

function getPendingOrder() {
    var data = {};
    /* $('#pending-order-list').html('');
     
     data.from = $('#date_from').val();
     data.to = $('#date_to').val();
     
     var err = 0;
     
     if (data.from == '') {
     $('#date_from').addClass('inp_error');
     err++;
     } else {
     $('#date_from').removeClass('inp_error');
     }
     
     if (data.from == '') {
     if (data.to == '') {
     $('#date_to').addClass('inp_error');
     err++;
     
     } else {
     $('#date_to').removeClass('inp_error');
     }
     }
     
     if (data.from != '') {
     if (data.to == '') {
     $('#date_to').removeClass('inp_error');
     var d = new Date();
     
     var month = d.getMonth() + 1;
     var day = d.getDate();
     
     var output = d.getFullYear() + '-' +
     (('' + month).length < 2 ? '0' : '') + month + '-' +
     (('' + day).length < 2 ? '0' : '') + day;
     
     data.to = output;
     $('#date_to').val(output);
     }
     }
     
     if (err > 0) {
     $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
     $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
     $('#usr-action-state').show();
     return false;
     } else {
     $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
     $('#usr-action-state').html('');
     $('#usr-action-state').hide();
     }
     */
    var html = "";
    data.order = 'pending';
    data.from = $('#pdate-from').val();
    data.to = $('#pdate-to').val();


    if (data.from != '') {
        if (data.to == '') {
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.to = output;
            $('#pdate-to').val(output);
        }
    }

    if(data.from=="" || data.to=="") return;

    $('#pending-order-list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "report/get-pending-order-list",
        data: data,
        success: function (response) {
            $('#pending-order-list').html(response);
        }
    })
}


function getDeniedOrder() {
    var data = {};
    var html = "";
    data.order = 'denied';
    data.from = $('#ddate-from').val();
    data.to = $('#ddate-to').val();
    if (data.from != '') {
        if (data.to == '') {
            $('#ddate-to').removeClass('inp_error');
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.to = output;
            $('#ddate-to').val(output);
        }
    }

    if(data.from=="" || data.to=="") return;

    $('#denied-order-list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "report/get-pending-order-list",
        data: data,
        success: function (response) {
            $('#denied-order-list').html(response);
        }
    })
}

function getFailureOrder() {
    var data = {};
    var html = "";
    data.order = 'failure';
    data.from = $('#fdate-from').val();
    data.to = $('#fdate-to').val();

    if (data.from != '') {
        if (data.to == '') {
            $('#fdate-to').removeClass('inp_error');
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.to = output;
            $('#fdate-to').val(output);
        }
    }

    if(data.from=="" || data.to=="") return;

    $('#failure-order-list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "report/get-pending-order-list",
        data: data,
        success: function (response) {
            $('#failure-order-list').html(response);
        }
    })
}

function clearPendingSearch() {
    $('#pdate-from').val('');
    $('#pdate-to').val('');
    $('#pending-order-list').html('');
    //getPendingOrder();
}

function clearDeniedSearch() {
    $('#ddate-from').val('');
    $('#ddate-to').val('');
    $('#denied-order-list').html('');
    //getDeniedOrder();
}

function clearFailureSearch() {
    $('#fdate-from').val('');
    $('#fdate-to').val('');
    $('#failure-order-list').html('');
    //getFailureOrder();
}

function closePendingTicketDialog() {
    $('#confirm_dialog').dialog('close');
    $('#confirm_dialog').addClass('hidden');
    $('#busmap-1').html('');
    $('#po-c-ticket-details').html('');
}

var seatStatusDetails = new Array();
var tripDate = new Array();
var fromStation = new Array();
var toStation = new Array();

var stageCode = '';
var pnrCode = '';
var nsCode = '';
var bookingCode = '';

function confirmPendingTicket(stagecode, pnrcode, bookingcode, nscode, providerName) {

    stageCode = stagecode;
    pnrCode = pnrcode;
    nsCode = nscode;
    bookingCode = bookingcode;

    $('#confirm_dialog').removeClass('hidden');
    $('#confirm_dialog').dialog({
        autoOpen: true,
        width: 1030,
        height: 625,
        resizable: false,
        modal: true,
        close: function(){
            $('.popover.in:visible').remove();
        }
    });
    $(".ui-dialog-titlebar").hide();
    $('#busmap-1').html(loading_popup);

    loadPendingTicketDetails(pnrcode);
    loadPendingTicketStatus(pnrcode, providerName, nsCode);
}

function loadPendingTicketBusmap() {
    var data = {};
    data.tripCode = $('#pending-order-tripcode').val();
    data.fromCode = $('#pending-order-fromcode').val();
    data.toCode = $('#pending-order-tocode').val();
    data.travelDate = $('#pending-order-traveldate').val();
    data.ticketpnrcode = $('#pending-order-ticketcode').val();
    data.nsCode = nsCode;

    $('#busmap-1').html(loading_popup);

    $.ajax({
        type: "POST",
        url: "report/get-confirm-busmap",
        dataType: 'json',
        data: data,
        success: function (res) {
            seatStatusDetails[1] = res.busseatlayer;
            renderBusMap(res, 1);

            $("#po-c-ticket-details").find('.seat-list').each(function () {
                var oldcode = $(this).find('#old-seat-no').attr('data-code');
                var o_s_obj = $("#busmap-1").find('.' + oldcode);

                if ($(o_s_obj).hasClass('seat-select-visibility')) {
                    $(this).find('#new-seat-no').attr('data-code', oldcode);
                    $(this).find('#new-seat-no').html($(o_s_obj).html());
                    $(this).find('#new-seat-no').removeClass('no_seat');
                }
            });

            if (isAllOldSeatsAvailable()) {
                $('#po-success-msg').removeClass('hidden');
            } else {
                $("#busmap-1").find('.seat-select-visibility').click(function () {
                    var code = $(this).attr('data-code');
                    var seat_name = $(this).html();

                    if ($(this).hasClass('schedule-seat')) {
                        $(this).toggleClass("schedule-seat");
                        //  de-select a seat and new seat maping
                        $("#po-c-ticket-details").find('.seat-list').each(function () {
                            var newcode = $(this).find('#new-seat-no');
                            if ($(newcode).attr('data-code') == code) {
                                $(newcode).attr('data-code', '');
                                $(newcode).html('');
                                $(newcode).addClass('no_seat');
                            }
                        });
                        return;
                    } else {    //  make sure all seats selected
                        var no_seat_len = $("#po-c-ticket-details").find('.no_seat').length;
                        if (no_seat_len == 0) {
                            alert('Not allowed to select any more seats');
                            return;
                        }
                    }
                    //  map new seat
                    $(this).toggleClass("schedule-seat");
                    var ele = $("#po-c-ticket-details").find('.no_seat').first();
                    $(ele).attr('data-code', code);
                    $(ele).html(seat_name);
                    $(ele).removeClass('no_seat');
                });

            }


        }
    });
}

function loadPendingTicketDetails(pnrcode) {
    //  load ticket details
    var data = {};
    data.ticketpnrcode = pnrcode;
    data.nsCode = nsCode;
    $('#po-c-ticket-details').html(loading_popup);
    $.ajax({
        type: "POST",
        url: "report/get-pending-ticket-details",
        dataType: 'html',
        data: data,
        success: function (res) {
            $('#po-c-ticket-details').html(res);
            loadPendingTicketBusmap();





        }
    });
}

function isAllOldSeatsAvailable() {
    var allow = true;
    $("#po-c-ticket-details").find('.seat-list').each(function () {
        var newcode = $(this).find('#new-seat-no').attr('data-code');
        var oldcode = $(this).find('#old-seat-no').attr('data-code');
         if(newcode!=oldcode) allow = false;
    });
    return allow;
}

function doConfirmPendingTicket(code) {
    $('#po-action-msg').html('');
    var no_seat_len = $("#po-c-ticket-details").find('.no_seat').length;
    if (no_seat_len > 0) {
        $('#po-action-msg').removeClass('hidden');
        $('#po-action-msg').html('<div class="alert alert-danger">Please select new seat all seats.</div>');
        return false;
    }

    var seatcodes = [];
    $("#po-c-ticket-details").find('.seat-list').each(function () {
        var newcode = $(this).find('#new-seat-no').attr('data-code');
        var oldcode = $(this).find('#old-seat-no').attr('data-code');
        seatcodes.push(oldcode + '-' + newcode);
    });

    if (confirm('Do you want to confirm this ticket?')) {
        var data = {};
        data.pnr_code = code;
        data.nsCode = nsCode;
        data.seat_codes = seatcodes.join(',');
        $('#po-action-msg').removeClass('hidden');
        $('#po-action-msg').html(loading_popup);
        $('#po-action-button').hide();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/confirm-pending-order",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#po-action-msg').html('<div class="alert alert-success">Your request has been processed successfully.</div>');
                    window.setTimeout(function () {
                        closePendingTicketDialog();
                        $('#row-' + bookingCode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                            $(this).remove();
                        });
                        //getPendingOrder();
                    }, 2000);
                } else {
                    $('#po-action-msg').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                    $('#po-action-button').show();
                }
            }
        });
    }
}

function cancelPendingTicket(code, booking) {
    var data = {};
    data.ticketcode = code;
    data.nsCode = nsCode;
    data.bookingcode = booking;
    if (confirm('Do you want to cancel this ticket?')) {
        var loading_overlay = iosOverlay({
            text: "Cancelling...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/cancel-pending-order",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Ticket Cancelled."
                    });
                    closePendingTicketDialog();

                    $('#row-' + bookingCode).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                        $(this).remove();
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Error in cancel."
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}

function renderBusMap(bus, id) {

    var html = '';
    var upst;
    var lwst;
    var busmap = $('#template-busmap-list').html();
    busmap = $('<div>').html(busmap).clone();
    var result = busSeat(bus.lrowmax, bus.lcolmax, bus.lrowmin, bus.lcolmin, bus.seatStatus, bus.seatDetails, 1, id);
    html = result[0];

    if (result[1] != '') {
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
        if (result[1] != '') {
            upst = result[1];
        }
        busmap.find('.upper').html(html);
        busmap.find('.upper-layer').removeClass('hide');
        busmap.find('.seat-map-selayer').removeClass('hide');
    }

    $("#busmap-" + id).html(busmap.html());
    if (lwst != '') {
        $("#busmap-" + id).find(lwst).show();
    }
    if (upst != '') {
        $("#busmap-" + id).find(upst).show();
    }





    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });
}

function busSeat(row, col, rowmin, colmin, seatstatus, seatDetails, lay, id) {
    var s = '';
    var htm = '';
    var seatStatusList = {
        "AM": "Available male",
        "AF": "Available female",
        "AL": "Available for all",
        "BO": "Booked",
        "BM": "Booked for Male",
        "BF": "Booked for Female",
        "AY": "Allocated for You",
        "AO": "Allocated to ",
        "UK": "Un Known,yet identified",
        "TBL": "Blocked",
        "PBL": "Phone Booking",
        "BL": "Blocked Seat to"
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
            if (rowSeatFoundCount[i] != undefined) {
                rowSeatFoundCount[i] = rowSeatFoundCount[i] + 1;
            } else {
                rowSeatFoundCount[i] = 1;
            }
        }
    }
    var axialFound = false;
    for (var i = rowmin; i <= row; i++) {
        var sleeperSeatFound = false;
        for (var j = colmin; j <= col; j++) {
            var set = lay + "" + i + "" + j;
            var seatclass = '';
            var BusSeatTypeclass = ' seat-lay-search ';

            var c = '';
            var sn = ''

            if (seatstatus[set] != undefined) {

                var dataPop = "<div style='text-align:center'>" + seatstatus[set]['seatType'] + " - <i class='fa fa-rupee'></i> " + seatstatus[set]['fare'] + "<br />" + seatStatusList[seatstatus[set]['status']['code']] + "";

                if (seatstatus[set]['code'] != undefined && seatstatus[set]['status'] != undefined) {
                    if(htm!='') htm += ',';

                   if(htm.indexOf(seatstatus[set]['code']) == -1) htm = seatstatus[set]['status']['code']
                    if (seatstatus[set]['status']['code'] != 'BO' && seatstatus[set]['status']['code'] != 'BL' && seatstatus[set]['status']['code'] != 'AO' && seatstatus[set]['status']['code'] != 'TBL' && seatstatus[set]['status']['code'] != 'BF' && seatstatus[set]['status']['code'] != 'BM' && seatstatus[set]['status']['code'] != 'PBL' && seatstatus[set]['status']['code'] != undefined) {
                        seatclass += seatstatus[set]['code'] + ' seat-select-visibility ' + seatStatusClass[seatstatus[set]['status']['code']];
                    } else {
                        seatclass += seatStatusClass[seatstatus[set]['status']['code']];
                    }
                    c = ' data-code = "' + seatstatus[set]['code'] + '"';
                    if (seatstatus[set]['status']['code'] == 'AO' || seatstatus[set]['status']['code'] == 'BL') {
                        var temp = '';
                        if (seatstatus[set]['userName'] != undefined) {
                            temp += '&nbsp;' + seatstatus[set]['userName'] + "(u)"; //userName
                        }
                        if (seatstatus[set]['groupName'] != undefined) {
                             if(temp!='') temp += ',';
                            temp += '&nbsp;' + seatstatus[set]['groupName'] + "(g)";
                        }
                        if (temp != '') {
                            dataPop += temp;
                        }
                    }
                    sn = seatDetails[seatstatus[set]['code']]['seatName'];
                    if (seatstatus[set]['status']['code'] == 'BO' || seatstatus[set]['status']['code'] == 'PBL') {
                        $.each(seatStatusDetails[id], function (t, tik) {
                            if (seatstatus[set]['code'] == tik.code && tik.ticketCode != '' && tik.ticketCode != undefined) {
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
                dataPop += "</div>";
                if (seatstatus[set]['status'] != '' && seatstatus[set]['status'] != undefined && seatstatus[set]['status'] == 1 && seatstatus[set] != undefined) {
                    seatclass += ' seat-booked ' + seatStatusClass[seatstatus[set]['status']['code']];
                }
                if (seatstatus[set]['seatType'] != '' && seatstatus[set]['seatType'] != undefined && seatstatus[set]['seatType'] == "Sleeper") {
                    BusSeatTypeclass = ' sleeper-lay-search ';
                    sleeperSeatFound = true;
                } else {
                    sleeperSeatFound = false;
                }

            } else if (rowSeatFoundCount[i] != undefined && rowSeatFoundCount[i] > 0 && !sleeperSeatFound) {// && seatstatus[previousSeatPos]['seatType'] != '' && seatstatus[previousSeatPos]['seatType'] != undefined && seatstatus[previousSeatPos]['seatType'] == "Sleeper" ){
                sn = '&nbsp;';
                dataPop = '';
            } else if (rowSeatFoundCount[i] == 0 && !axialFound) {
                sn = '&nbsp;';
                axialFound = true;
                dataPop = '';
            }

            if (sn != '') {
                s += '<div class="p_tool  seat-lay-out ' + BusSeatTypeclass + seatclass + '" ' + c + ' data-toggle="popover" data-container="body" data-placement="left" data-trigger="hover" data-content="' + dataPop + '">' + sn + '</div>';
            }
        }
        s += '<div class="clear_fix_both"></div>';
    }
    return [s, htm];
}

function loadPendingTicketStatus(pnrcode, providerName, nsCode) {
    var data = {};
    data.ticketpnrcode = pnrcode;
    data.providerName = providerName;
    data.nsCode = nsCode;

    $('#order-status').html(loading_popup);

    $.ajax({
        type: "POST",
        url: "report/get-pending-ticket-status",
        dataType: 'json',
        data: data,
        success: function (res) {
            if (res.status == 1) {
                $('#order-status').html('');
                Object.keys(res.data).forEach(function (key, val) {
                    if (res.data[key] && res.data[key] != 'null') {
                        var k = key.slice(0, 1).toUpperCase() + key.slice(1);
                        $('#order-status').append('<div class="col-md-6"><b>' + k.replace(/([A-Z])/g, ' $1').trim() + '</b> : ' + res.data[key] + '</div>');
                    }
                });
            }
        }
    });
}

function getBlockCancelled() {
    var data = {};
    data.order = 'blocked';
    data.from = $('#bdate-from').val();
    data.to = $('#bdate-to').val();

    if (data.from != '' && data.to == '') {
        $('#bdate-to').datepicker('setDate', 'now');
        data.to = $('#bdate-to').val();
    }

    if (data.from == '' || data.to == '')
        return;

    $('#block-cancelled-list').html(loading_popup);
    $.ajax({
        type: 'POST',
        dataType: 'html',
        url: base_url + 'report/get-pending-order-list',
        data: data,
        success: function (response) {
            $('#block-cancelled-list').html(response);
        }
    });
}

function clearBlockCancelled() {
    $('#bdate-from').val('');
    $('#bdate-to').val('');
    $('#block-cancelled-list').html('');
}

function failureToPending(ticketcode) {
    var data = {};
    data.ticketcode = ticketcode;
    
    if (confirm('Do you want to Move this ticket?')) {
        var loading_overlay = iosOverlay({
            text: "Loading...",
            icon: "fa fa-spinner fa-spin"
        });
        $('#po-action-msg').html('');
        $('#po-action-msg').removeClass("hidden");
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/move-failure-order-to-pending",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Ticket Moved."
                    });
                    
                    window.setTimeout(function () {
                        getFailureOrder();
                        loading_overlay.hide();
                        //$('#po-action-msg').addClass("hidden");

                    }, 2000);
                } else {
                    loading_overlay.hide();
                    $('#po-action-msg').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');
                }
                
            }
        })
    }


}

function refundPendingTicket(ticketcode, bookingCode) {
    var data = {};
    data.transactionCode = ticketcode;
    data.orderCode = bookingCode;
    
    if (confirm('Do you want to Refund this ticket?')) {
        var loading_overlay = iosOverlay({
            text: "Loading...",
            icon: "fa fa-spinner fa-spin"
        });
        $('#po-action-msg').html('');
        $('#po-action-msg').removeClass("hidden");
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/refund-ticket-from-pending",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Refund Issued."
                    });
                    
                    window.setTimeout(function () {
                        getPendingOrder();
                        loading_overlay.hide();
                        closePendingTicketDialog();
                    }, 2000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);  
                    $('#po-action-msg').html('<div class="alert alert-danger">' + response.errorDesc + '</div>').show();
                }
                
            },
            error: function () {
                loading_overlay.update({
                    icon: "fa fa-times",
                    text: "Sorry!"
                });
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);        
            }
        });
    }
}