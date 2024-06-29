function init_recharge_pending_order_page() {
    
}
function getRechargePendingOrder() {
    var data = {};
    var html = "";
    data.fromDate = $('#pdate-from').val();
    data.toDate = $('#pdate-to').val();


    if (data.fromDate != '') {
        if (data.toDate == '') {
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.toDate = output;
            $('#pdate-to').val(output);
        }
    }

    if (data.fromDate == "" || data.toDate == "")
        return;

    $('#pending-order-list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "report/get-recharge-pending-order-list",
        data: data,
        success: function (response) {
            $('#pending-order-list').html(response);
        }
    })
}


function clearRechargePendingSearch() {
    $('#pdate-from').val('');
    $('#pdate-to').val('');
    $('#pending-order-list').html('');
    //getPendingOrder();
}

function closePendingTicketDialog() {
    $('#confirm_dialog').dialog('close');
    $('#confirm_dialog').addClass('hidden');
    $('#busmap-1').html('');
    $('#po-c-ticket-details').html('');
}


function doConfirmPendingOrder(code) {
    $('#po-action-msg').html('');
    if (confirm('Do you want to confirm this ticket?')) {
        var data = {};
        data.order_code = code;
        $('#po-action-msg').html('');
        $('#po-action-msg').removeClass("hidden");
        

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/confirm-recharge-pending-order",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.hide();
                    $('#po-action-msg').html('<div class="alert alert-success">Your request has been processed successfully.</div>');
                    $('#row-' + code).animate({backgroundColor: '#1AA1E1'}, 1000, function () {
                            $(this).remove();
                        });
                        
                    window.setTimeout(function () {
                        getRechargePendingOrder();
                        $('#po-action-msg').addClass("hidden");

                    }, 2000);
                } else {
                    loading_overlay.hide();
                    $('#po-action-msg').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');

                }
            }
        });
    }
}

function cancelPendingOrder(ticketCode, transactionCode) {
    var data = {};
    data.ticketcode = ticketCode;
    data.transactionCode = transactionCode;
    if (confirm('Do you want to cancel this ticket?')) {
        var loading_overlay = iosOverlay({
            text: "Cancelling...",
            icon: "fa fa-spinner fa-spin"
        });
        $('#po-action-msg').html('');
        $('#po-action-msg').removeClass("hidden");
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "report/cancel_recharge_pending_order",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.hide();
                    $('#po-action-msg').html('<div class="alert alert-success">Your request has been processed successfully.</div>');
                    $('#row-' + ticketCode).animate({backgroundColor: '#1AA1E1'}, 1000, function () {
                        $(this).remove();
                    });
                    window.setTimeout(function () {
                        getRechargePendingOrder();
                        $('#po-action-msg').addClass("hidden");

                    }, 2000);
                } else {

                    loading_overlay.hide();
                    $('#po-action-msg').html('<div class="alert alert-danger">' + response.errorDesc + '</div>');

                }

            }
        })
    }
}
