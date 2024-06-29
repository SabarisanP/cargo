function closeexpense(){
    $("#add-expenses").show();            
    $('#trip-expense-list').show();
    $("#addexpenses").addClass('hide');
}
function saveexpense(tripcode) {
    var data = {};

    data.activeFlag = 1;
    data.amount = $('#amount').val();
    data.tripCode = tripcode;
    //data.tripCode = $('#trp_code').val();
    data.transactionModeIO = $('#transactionModeIO').val();
    data.tripCashHeadIO = $('#tripCashHeadIO').val();
    data.remarks = $('#remarks').val();

    var err = 0;

    if ($('#tripCashHeadIO').val() == '') {
        $('#tripCashHeadIO').addClass('inp_error');
        err++;
    } else {
        $('#tripCashHeadIO').removeClass('inp_error');
    }
    if ($('#amount').val() == '') {
        $('#amount').addClass('inp_error');
        err++;
    } else {
        $('#amount').removeClass('inp_error');
    }

    if ($('#transactionModeIO').val() == '') {
        $('#transactionModeIO').addClass('inp_error');
        err++;
    } else {
        $('#transactionModeIO').removeClass('inp_error');
    }

    if (err > 0) {
        $('#trp-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#trp-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#trp-action-state').show();
        return false;
    } else {
        $('#trp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#trp-action-state').hide();
    }


    $('#form-bttons').hide();
    $('#trp-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#trp-action-state').html(loading_popup);
    $('#trp-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "tripexpenses/update-tripexpense",
        data: data,
        success: function (response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#trp-action-state').removeClass('alert-danger');
                $('#trp-action-state').addClass('alert-success');
                $('#trp-action-state').html('Your request has been completed successfully');
                window.setTimeout(function () {
                    getTripExpenses(tripcode);
                }, 3000);
            } else {
                $('#trp-action-state').addClass('alert-danger');
                $('#trp-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}

function deleteTripExpense(code) {
    if (confirm('Do you want to delete this Trip Expenses?')) {
        var data = {};
        data.code = code;
        data.activeFlag = 2;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "trpexpenses/update-status-tripexpenses",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#trp-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
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
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
}

