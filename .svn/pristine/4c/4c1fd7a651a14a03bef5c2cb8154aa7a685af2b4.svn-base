function newVouchers(){
    $('#info').hide();
    $('#back').show();
    $('#gen').show();
    $('#generate').hide();
    $('#unpid').show();
    $('#rpt_lst').hide();
    $('.voucher_transaction_details').hide();
    $('.get_transactions').show();
    $('#search-panel').show();
    
    $('.unpaid_transactions').hide();
}

/*function generatedVouchers()    {
     $('#back').hide();
     $('#generate').show();
     $('#gen').hide();
	$('.get_transactions').hide();
	$('.voucher_transaction_details').show();
    $('#search-panel-result').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "voucher/voucherlist",
        success: function (response) {
            $('#search-panel-result').html(response);

        }
    })
}*/

function viewUnpaid(){
    $('.get_transactions').hide();
    $('.voucher_transaction_details').hide();
    $('#back').show();
    $('#generate').show();
    $('#unpid').hide();
    $('#rpt_lst').hide();
    
    $('.unpaid_transactions').show();
    
}

function generatedVouchers() {
    $('.get_transactions').hide();
    $('.voucher_transaction_details').show();
    $('#back').hide();
    $('#generate').show();
    $('#rpt_lst').show();
    
    $('.unpaid_transactions').hide();
    $('#unpid').show();
    //$('#rpt_lst').html('');
}

function searchUnpaidTransactions() {
    $('#unpaid-trans-list').html('');
    var data = {};
    data.user = $('#un_users').val();
    data.schedule_code = $('#un_trns_rpt_schedule').val();
    data.from = $('#un_date_from').val();
    data.to = $('#un_date_to').val();
    data.flag = $('#un_date_opt').val();
    var err = 0;
    $('#un_users', '#un_trns_rpt_schedule', '#un_date_from', '#un_date_to').removeClass('inp_error');

    if (data.user  == '') {
        $('#un_users').addClass('inp_error');
        err++;
    }

    if (data.from == '') {
        $('#un_date_from').addClass('inp_error');
        err++;
    } 

    if (data.from == '') {
        if (data.to == '') {
            $('#un_date_to').addClass('inp_error');
            err++;
        } 
    }

    if (data.from != '') {
        if (data.to == '') {
            $('#un_date_to').removeClass('inp_error');
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.to = output;
            $('#un_date_to').val(output);
        }
    }

    if (err > 0) {
        $('#un-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#un-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#un-action-state').show();
        return false;
    } else {
        $('#un-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#un-action-state').html('');
        $('#un-action-state').hide();
    }
    var html = "";
    $('#un-date_to').removeClass('inp_error');
    $('#unpaid-trans-container').removeClass('hidden');
    $('#unpaid-trans-list').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "voucher/unpaid-transactions",
        data: data,
        success: function(response) {
            $('#unpaid-trans-list').html(response);
            calculateUnpaidTransactionsAmount();  
        }
    })
}

function searchTransactions() {
    $('#rpt_lst_voucher').html('');
    var data = {};
    data.user = $('#users').val();
    data.schedule_code = $('#trns_rpt_schedule').val();
    data.from = $('#date_from').val();
    data.to = $('#date_to').val();
    data.flag = $('#date_opt').val();
    var err = 0;
    $('#users', '#trns_rpt_schedule', '#date_from', '#date_to').removeClass('inp_error');

    
    
    if (data.user  == '') {
        $('#users').addClass('inp_error');
        err++;
    }

    if (data.from == '') {
        $('#date_from').addClass('inp_error');
        err++;
    } 

    if (data.from == '') {
        if (data.to == '') {
            $('#date_to').addClass('inp_error');
            err++;
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
    var html = "";
    $('#date_to').removeClass('inp_error');
    $('#voucher-feed-list-container').removeClass('hidden');
    $('#rpt_lst_voucher').html(loading_popup);
    $('#hid-user').val(data.user);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "voucher/new-voucher-list",
        data: data,
        success: function(response) {
            $('#rpt_lst_voucher').html(response);
            calculateTransactionsAmount();  
            
            //$('#dt_report_table').dataTable({ scrollY: 550  });
            //$("select[name=dt_report_table_length]").val("100").change();
        }
    })
}

function calculateTransactionsAmount() {
    var checkcount = $(":checkbox:checked").length;
   
    if (checkcount > 0) {
        $('.btn-new').show();
    } else {
        $('.btn-new').hide();
    }
    
    var trans_code = [];
    var b_amount = Number(0);
    var b_discount = Number(0);
    var b_comm = Number(0);
    var b_stax = Number(0);
    var b_seats = Number(0);
    
    var c_amount = Number(0);
    var c_refund = Number(0);
    var c_comm = Number(0);
    var c_revoke = Number(0);
    var c_agent_charges = Number(0);
    var c_cancel = Number(0);
    var c_seats = Number(0);
    
    $(':checkbox:checked').each(function(i) {
        ele = $(this);
        trans_code.push( $(ele).attr('data-transcode') );
        if( $(ele).attr('data-type') == "TICKBO" ) {            
            b_amount += Number( $(ele).attr('data-ticketamount') || 0 );
            b_discount += Number( $(ele).attr('data-discount') || 0 );
            b_comm += Number( $(ele).attr('data-commission') || 0 );
            b_stax += Number( $(ele).attr('data-servicetax') || 0 );
            b_seats += Number( $(ele).attr('data-seats') || 0 );
        } else {
            c_amount += Number( $(ele).attr('data-ticketamount') || 0 );
            c_refund += Number( $(ele).attr('data-refund') || 0 );
            c_comm += Number( $(ele).attr('data-commission') || 0 );
            c_cancel += Number( $(ele).attr('data-cancharges') || 0 );
            c_agent_charges += Number( $(ele).attr('data-agentcharges') || 0 );
            c_revoke += Number( $(ele).attr('data-revoke') || 0 );
            c_seats += Number( $(ele).attr('data-seats') || 0 );
        }
    });
    
    var payable  = (b_amount + b_stax - b_comm - b_discount) - (c_refund - c_agent_charges);
    
    $('#fare').html(b_amount.toFixed(2));
    $('#discount').html(b_discount.toFixed(2));
    $('#comm').html(b_comm.toFixed(2));
    $('#stax').html(b_stax.toFixed(2));
    $('#seat').html(b_seats);
    
    $('#c_fare').html(c_amount.toFixed(2));
    $('#refund').html(c_refund.toFixed(2));
    $('#rvkcomm').html(c_revoke.toFixed(2));
    $('#cnclchrg').html(c_cancel.toFixed(2));
    $('#c_ag_charges').html(c_agent_charges.toFixed(2));
    //$('#clseat').html(c_seats.toFixed(2));
    
    $('#ref1').html(payable.toFixed(2));
    $('#ref').html(payable.toFixed(2));
    $('#popup_amt').html(payable.toFixed(2));
    
    $('#hid-total').val(payable.toFixed(2));
}

function calculateUnpaidTransactionsAmount() {
    
    
    var b_amount = Number(0);
    var b_discount = Number(0);
    var b_comm = Number(0);
    var b_stax = Number(0);
    var b_seats = Number(0);
    
    var c_amount = Number(0);
    var c_refund = Number(0);
    var c_comm = Number(0);
    var c_revoke = Number(0);
    var c_agent_charges = Number(0);
    var c_cancel = Number(0);
    var c_seats = Number(0);
    
    $('.un_trans').each(function(i) {
        ele = $(this);        
        if( $(ele).attr('data-type') == "TICKBO" ) {            
            b_amount += Number( $(ele).attr('data-ticketamount') );
            //b_discount += Number( $(ele).attr('data-discount') );
            b_comm += Number( $(ele).attr('data-commission') );
            b_stax += Number( $(ele).attr('data-servicetax') );
            b_seats += Number( $(ele).attr('data-seats') );
        } else {
            c_amount += Number( $(ele).attr('data-ticketamount') );
            c_refund += Number( $(ele).attr('data-refund') );
            c_comm += Number( $(ele).attr('data-commission') );
            c_cancel += Number( $(ele).attr('data-cancharges') );
            c_agent_charges += Number( $(ele).attr('data-agentcharges') );
            c_revoke += Number( $(ele).attr('data-revoke') );
            c_seats += Number( $(ele).attr('data-seats') );
        }
    });
    
    var payable  = (b_amount - b_comm - b_discount) - (c_refund - c_agent_charges);
    
    $('#un_fare').html(b_amount);
    $('#un_fare').html(b_discount);
    $('#un_comm').html(b_comm);
    $('#un_stax').html(b_stax);
    $('#un_seat').html(b_seats);
    
    $('#un_c_fare').html(c_amount);
    $('#un_refund').html(c_refund);
    $('#un_rvkcomm').html(c_revoke);
    $('#un_cnclchrg').html(c_cancel);
    $('#un_c_ag_charges').html(c_agent_charges);
    $('#un_clseat').html(c_seats);
    
    $('#un_ref1').html(payable);
}

function clearVoucher() {
    $('#users').val('');
    $('#date_from').val('');
    $('#date_to').val('');
    $('#trns_rpt_schedule').val('');
    $('#voucher-feed-list-container').addClass('hidden');
    $('#rpt_lst_voucher').html('');
    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#usr-action-state').html('');
    $('#usr-action-state').hide();
    $('input:radio[class=flag]').prop('checked', true);
    $('#hid-user').val('');
    $('#hid-total').val('');
}

function voucherPopup() {
    $('#t_mode').val('');
    
    $('#ARdate').val('');
    var c_date = getCurrentDate();
    $('#ARdate').datepicker("setDate", c_date);    
    $('#ARdate').val(c_date);
    
    $('#reg_textarea').val('');
    $('#user').val('');
    $('.inp_error').removeClass('inp_error');
    $('#vou-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#vou-action-state').hide();
    $('#voucher-dialog').css('background', '#fff');
    $('#voucher-dialog').removeClass('hide');
    $('#voucher-dialog').dialog({
        autoOpen: true,
        height: 430,
        width: 700,
        modal: true,
        resizable: false,
        closeOnEscape: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#print-info').addClass('hide');
    $('#org-form-action-state').html('');
    $('#org-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
}

function closeVoucherPopup() {
    $('#voucher-dialog').dialog('destroy');
    $('#voucher-dialog').hide();
}

function confirmVoucher() {
    var data = {};
    data.transactionCode = [];

    $('#rpt_lst_voucher .gen_vou_check:checkbox:checked').each(function(i) {
        data.transactionCode.push( $(this).attr('data-transcode') );
    });
    
    data.AmountReceivedDate = $('#ARdate').val();
    data.Remarks = $('#reg_textarea').val();
    data.TransactionMode = $('#t_mode').val();
    data.User = $('#hid-user').val();

    var err = 0;
    if ($('#t_mode').val() == '') {
        $('#t_mode').addClass('inp_error');
        err++;
    } else {
        $('#t_mode').removeClass('inp_error');
    }
    if ($('#ARdate').val() == '') {
        $('#ARdate').addClass('inp_error');
        err++;
    } else {
        $('#ARdate').removeClass('inp_error');
    }

    if (err > 0) {
        $('#vou-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#vou-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#vou-action-state').show();
        return false;
    } else {
        $('#vou-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vou-action-state').hide();
    }


    $('#form-bttons').hide();
    $('#vou-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#vou-action-state').html(loading_popup);
    $('#vou-action-state').show();


    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "voucher/approve-voucher",
        data: data,
        success: function(res) {
            if (res.status == 1) {
                $('#form-bttons').hide();
                $('#vou-action-state').removeClass('alert-danger');
                $('#vou-action-state').addClass('alert-success');
                $('#vou-action-state').html('Your request has been completed successfully');
                
                $('#print-info').removeClass('hide');
                $('#print-button').attr('href', base_url+'voucher/download?code='+res.data.code);
                $('#print-button').bind('click', function() {
                    closeVoucherPopup();
                    generatedVouchers();
                } );
                window.setTimeout(function() {
                    //closeVoucherPopup();
                    clearVoucher();
                    
                    //$('#search-panel').hide();
                    //$('#info').show();
                    
                    //$('.voucher_transaction_details').show();
                    //$('.get_transactions').hide();
                    
                }, 3000);
            } else {
                $('#vou-action-state').addClass('alert-danger');
                $('#vou-action-state').html(res.errorDesc);
                $('#form-bttons').show();
            }
        }
    });

}
function exportTransactionsPdf() {
    document.frm_voucher.action = "voucher/voucher-list-pdf";
    document.frm_voucher.submit();
    return;
}
function searchTransactionDetails() {
    $('#rpt_lst').html('');
    var data = {};
    data.user = $('#gru_users').val();
    data.from = $('#date_fromdate').val();
    data.to = $('#date_todate').val();
    data.acknowledmentStatus = $('#voucher-ack-status').val();

    var err = 0;
    if (data.user == '') {
        $('#gru_users').addClass('inp_error');
        err++;
    } else {
        $('#gru_users').removeClass('inp_error');
    }
    if (data.from == '') {
        $('#date_fromdate').addClass('inp_error');
        err++;
    } else {
        $('#date_fromdate').removeClass('inp_error');
    }

    if (data.from == '') {
        if (data.to == '') {
            $('#date_todate').addClass('inp_error');
            err++;

        } else {
            $('#date_todate').removeClass('inp_error');
        }
    }

    if (data.from != '') {
        if (data.to == '') {
            $('#date_todate').removeClass('inp_error');
            var d = new Date();

            var month = d.getMonth() + 1;
            var day = d.getDate();

            var output = d.getFullYear() + '-' +
                    (('' + month).length < 2 ? '0' : '') + month + '-' +
                    (('' + day).length < 2 ? '0' : '') + day;

            data.to = output;
            $('#date_todate').val(output);
        }
    }

    if (err > 0) {
        $('#usrv-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#usrv-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#usrv-action-state').show();
        return false;
    } else {
        $('#usrv-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#usrv-action-state').html('');
        $('#usrv-action-state').hide();
    }
    var html = "";
    $('#date_todate').removeClass('inp_error');
    $('#vouchers-list-container').removeClass("hidden");
    $('#gen_voucher_list').html(loading_popup);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "voucher/get-generated-voucherlist",
        data: data,
        success: function(response) {
            $('#gen_voucher_list').html(response);
            $('#download-pdf').show();
        }
    })
}

function clearTransactionDetails() {
    $('#gru_users').val('NA');
    $('#date_fromdate').val('');
    $('#date_todate').val('');
    $('#vouchers-list-container').addClass("hidden");
    $('#gen_voucher_list').html('');
    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
    $('#usr-action-state').html('');
    $('#usr-action-state').hide();
    $('#download-pdf').hide();
}

