function init_phonebooking_confirm_action(){
    $('#date_from').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        autoclose: true,
        changeMonth: true,
    }).datepicker("setDate", "-0d")
}

function getPhoneBookingList() {
    var data = {};
    $('#phone-order-list-container').removeClass('hidden');
    $('#phone-order-list').html('');
    data.date = $('#date_from').val(); 
    var err = 0;

    if (data.date == '') {
        $('#date_from').addClass('inp_error');
        err++;
    } else {
        $('#date_from').removeClass('inp_error');
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
    
    $('#date_from').removeClass('inp_error');
    $('#phone-order-list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "phonebooking/get-phone-booking-list",
        data: data,
        success: function(response) {
            $('#phone-order-list').html(response);
        }
    })
}

function bookCancelPB(pnrcode) {
    var data = {};    
    data.ticketpnrcode = pnrcode; 
    var err = 0;  
    
    $('#pb_dialog').dialog({
        autoOpen: true,
        width: 800,
        maxWidth: 800,
        height: 650,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    
    $('#pb_dialog').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "phonebooking/get-ticket-details",
        data: data,
        success: function(response) {
            $('#pb_dialog').html(response);
            $('.bs_switch').bootstrapSwitch('size', 'mini');
        }
    })
}

function closePhoneBookDialog() {
    $('#pb_dialog').dialog('close');
}

function phoneBookConfirm(pnr) {
    var data = {};
    var err = 0;
    data.seatcode = new Array();
    $('#pb_dialog').find('.pnr_user_list:checked').each(function() {
        data.seatcode.push($(this).val());
    });
    if(data.seatcode.length==0) {
        alert('Please select atleast one seat to confirm');
        return false;
    }
    data.pnrcode = pnr;
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
                $('#phone_bkg_action_state').removeClass('alert-danger');
                $('#phone_bkg_action_state').addClass('alert-success');
                $('#phone_bkg_action_state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    closePhoneBookDialog();
                    getPhoneBookingList();
                }, 3000);
            } else {
                $('#phone_bkg_action_state').addClass('alert-danger');
                $('#phone_bkg_action_state').html(res.errorDesc);
                $('#phone_bkg_action_state').show();
            }
        }
    })
}

function phoneBookCancel(pnr) {
    var data = {};
    data.seatcode = new Array();
    $('#pb_dialog').find('.pnr_user_list:checked').each(function() {
        data.seatcode.push($(this).val());
    });
    if(data.seatcode.length==0) {
        alert('Please select atleast one seat to cancel');
        return false;
    }
    data.pnrcode = pnr;
   
    var loading_overlay = iosOverlay({
     text: "Cancelling...",
     icon: "fa fa-spinner fa-spin"
    });
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "search/ticket-cancel-by-phone",
        data: data,
        success: function(res) {
            if (res.status == 1) {
                loading_overlay.update({
                 icon: "fa fa-check",
                 text: "Cancelled!"
                 });
            } else {
                loading_overlay.update({
                 icon: "fa fa-check",
                 text: "Sorry! Try Again."
                 });
            }
            window.setTimeout(function() {
                loading_overlay.hide();
                closePhoneBookDialog();
                getPhoneBookingList();
              }, 2000);
        }
    })
}

function clearPhoneBookingReport(){
    $('#date_from').val('');
    $('#phone-order-list-container').addClass('hidden');
    $('#phone-order-list').html('');
}
