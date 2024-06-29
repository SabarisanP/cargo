function addEditDriver(option) {
    $('#name').focus();
    $('#driver-dialog').css('background', '#fff');
    $('#driver-dialog').removeClass('hide');
    $('#driver-dialog').dialog({
        autoOpen: true,
        height: 600,
        width: 700,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#form-bttons').show();
    $('#driver-form-action-state').html('');
    $('#driver-form-action-state').hide();
    $('.inp_error').removeClass('inp_error');
    if (_isdefined(option)) {
        
    } else {
        $('#name,#lname,#dob,#blood,#license,#expiry,#qtion,#contact,#ecnt,#jod,#remarks').val('');
    }
}

function saveDriver() {
    var data = {};
    data.activeFlag = 1;
    data.name = $('#name').val();
    data.lname = $('#lname').val();
    data.dob = $('#dob').val();
    data.blood = $('#blood').val();
    data.license = $('#license').val();
    data.expiry = $('#expiry').val();
    data.qualification = $('#qtion').val();
    data.contact = $('#contact').val();
    data.emergency = $('#ecnt').val();
    data.joining = $('#jod').val();
    data.remarks = $('#remarks').val();

    var err = 0;
    if ($('#name').val() == '') {
        $('#name').addClass('inp_error');
        err++;
    } else {
        $('#name').removeClass('inp_error');
    }

    if ($('#dob').val() == '') {
        $('#dob').addClass('inp_error');
        err++;
    } else {
        $('#dob').removeClass('inp_error');
    }

    if ($('#license').val() == '') {
        $('#license').addClass('inp_error');
        err++;
    } else {
        $('#license').removeClass('inp_error');
    }
    if ($('#expiry').val() == '') {
        $('#expiry').addClass('inp_error');
        err++;
    } else {
        $('#expiry').removeClass('inp_error');
    }
    if ($('#contact').val() == '') {
        $('#contact').addClass('inp_error');
        err++;
    } else {
        $('#contact').removeClass('inp_error');
    }
    
    if ($('#ecnt').val() == '') {
        $('#ecnt').addClass('inp_error');
        err++;
    } else {
        $('#ecnt').removeClass('inp_error');
    }
    if ($('#jod').val() == '') {
        $('#jod').addClass('inp_error');
        err++;
    } else {
        $('#jod').removeClass('inp_error');
    }

    if (err > 0) {
        $('#driver-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#driver-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#driver-form-action-state').show();
        return false;
    } else {
        $('#driver-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#driver-form-action-state').hide();
    }
    if(isNaN(data.contact)){
        $('#contact').addClass('inp_error');
        $('#driver-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#driver-form-action-state').html('Please enter valid contact number.');
        $('#driver-form-action-state').show();
        return false;
    }else{
        $('#contact').removeClass('inp_error');
        $('#driver-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#driver-form-action-state').hide();  
    }
    if(isNaN(data.emergency)){
        $('#ecnt').addClass('inp_error');
        $('#driver-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#driver-form-action-state').html('Please enter valid emergency contact number.');
        $('#driver-form-action-state').show();
        return false;
    }else{
        $('#ecnt').removeClass('inp_error');
        $('#driver-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#driver-form-action-state').hide(); 
    }
    

    $('#form-bttons').hide();
    $('#driver-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    return false;
    $('#driver-form-action-state').html(loading_popup);
    $('#driver-form-action-state').show();

    /*$.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-payment-schedules",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#org-form-action-state').removeClass('alert-danger');
                $('#org-form-action-state').addClass('alert-success');
                $('#org-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelOrganization();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#org-form-action-state').addClass('alert-danger');
                $('#org-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })*/
}

function cancelDriver() {
    $('#driver-dialog').dialog('destroy');
    $('#driver-dialog').hide();
}