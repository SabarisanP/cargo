function init_expenses_page() {
    $('#tsr_travel_date').datepicker({
        todayHighlight: true,
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        getAllTripsForDate();
    });
    
    $("#tsr_travel_date").datepicker("setDate", new Date());
}

function getAllTripsForDate() {
    $('#tsr_trip_cintainer').html(loading_popup);

    var data = {};
    data.travel_date = $('#tsr_travel_date').val();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "trips/get-trip-list",
        data: data,
        success: function (response) {
            if(response.status==1) {
                var html = '<select id="tsr_trip_code" name="trip_code"  class="form-control" >';
                html += '<option value="">Select a trip</option>';
                $.each(response.data, function(catkey, trips) {
                    html += ' <optgroup label="'+catkey+'">';
                    $.each(trips, function(key, trip) {                                
                        html += '<option value='+trip.code+' >'+trip.name+' | '+trip.serviceNumber+' | '+trip.tripTime+'</option>';
                    });
                    html += ' </optgroup>';
                });
                html += '</select>';
                $('#tsr_trip_cintainer').html(html);                            
            } else {
               $('#tsr_trip_cintainer').html('Sorry! No Trips Found'); 
            }
        }
    })
}

function generateExpenses() {
    $('#expenses-list').html('');
    var data = {};
    data.travel_date = $('#tsr_travel_date').val();
    data.trip_code = $('#tsr_trip_code').val();

    data.trip_name = $("#tsr_trip_code option:selected").text();

    var err = 0;
    $('.inp_error').removeClass('inp_error');

    if (data.travel_date == '') {
        $('#tsr_travel_date').addClass('inp_error');
        err++;
    }

    if (data.trip_code == '') {
        $('#tsr_trip_code').addClass('inp_error');
        err++;
    }

    if (err > 0) {
        $('#texp_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#texp_action_state').html('Please enter/select the values in the field that are marked in red');
        $('#texp_action_state').show();
        return false;
    } else {
        $('#texp_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#texp_action_state').html('');
        $('#texp_action_state').hide();
    }
    
    var html = "";
    $('#cons_rpt_date_to').removeClass('inp_error');
    $('#expenses-list-container').removeClass('hidden');
    $('#expenses-list').html(loading_popup);
    
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "payment/expenses-list",
        data: data,
        success: function (response) {
            $('#expenses-list').html(response);
            $('#exc-tr').show();
        }
    });
}

function exportEntries() {
    document.trans_form.action = "payment/expenses-list";
    document.trans_form.target = "ifrm_trans_downloader";
    $('#export').val(1);
    document.trans_form.submit();
    return;
}

function showEntriesDialog(code) {
    $('#expenses-dialog').css('background', '#fff');
    $('#expenses-dialog').removeClass('hide');
    $('#expenses-dialog').show();
    $('#expenses-dialog').dialog({
        autoOpen: true,
        height: 400,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
            
    if(code!='') {
        var obj = _.find(entries, function(o) { return o.code == code; });        
        $('#texp-head').val(obj.tripCashHead.code);        
        $('#texp-mode').val(obj.transactionMode.code);
        $('#texp-amount').val(obj.amount);
        $('#texp-remarks').val(obj.remarks);
        $('#texp-code').val(obj.code);
    } else {    
        $('#texp-head').val('');        
        $('#texp-mode').val('');
        $('#texp-amount').val('');
        $('#texp-remarks').val('');
    }
    $('#texp-head, #texp-mode, #texp-amount').removeClass('inp_error');
}

function closeEntriesDialog() {
    $('#expenses-dialog').dialog('destroy');
    $('#expenses-dialog').hide();
}

function saveTripExpenses() {
    var data = {};        
    data.head = $.trim($('#texp-head').val());
    data.mode = $.trim($('#texp-mode').val());
    data.amount = $.trim($('#texp-amount').val());   
    data.remarks = $.trim($('#texp-remarks').val());    
    data.code = $('#texp-code').val();
    
    data.tripcode = $('#tsr_trip_code').val();
    
    var err = 0;
    if (data.head == '') {
        $('#texp-head').addClass('inp_error');
        err++;
    } 
    
    if (data.mode == '') {
        $('#texp-mode').addClass('inp_error');
        err++;
    } 
    
    if (data.amount == '') {
        $('#texp-amount').addClass('inp_error');
        err++;
    } else if (isNaN(data.amount)) {
        $('#texp-amount').addClass('inp_error');
        err++;
    } 

    if (err > 0) {
        $('#texp-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#texp-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#aspe-form-buttons').show();
        return false;
    } else {
        $('#texp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#aspe-form-buttons').hide();
    }

    $('#aspe-form-buttons').hide();
    $('#texp-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#texp-action-state').html(loading_popup);
    $('#texp-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "payment/update-expense",
        data: data,
        success: function (response) {
            if (response.status == 1) {                
                $('#texp-action-state').removeClass('alert-danger');
                $('#texp-action-state').addClass('alert-success');
                $('#texp-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    $('#aspe-form-buttons').show();
                    $('#texp-action-state').html('');
                    $('#texp-action-state').removeClass('alert-danger').removeClass('alert-success');
                    closeEntriesDialog();
                    generateExpenses();
                }, 3000);
            } else {
                $('#aspe-form-buttons').show();
                $('#texp-action-state').addClass('alert-danger');
                $('#texp-action-state').html(response.errorDesc);
                $('#aspe-form-buttons').show();
            }
        }
    });
}

function deleteTripExpense(code) {
    var obj = _.find(entries, function(o) { return o.code == code; });
    obj.activeFlag = 2;
    
    if (confirm('Do you want to delete this entry?')) {
        var data = {}
        data.dto = obj;
        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "payment/delete-expense",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        generateExpenses();
                        return;
                    }, 2000);
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
        });
    }
}