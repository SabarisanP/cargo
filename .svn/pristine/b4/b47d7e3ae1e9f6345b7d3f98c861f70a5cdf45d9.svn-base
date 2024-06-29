function saveDialogGallery(code,name) {
    $('#form-buttons').show();
    $('.inp_error').removeClass('inp_error');
    $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger').hide();
    $('.edt_hide').show();

    $('#gall-dialog').dialog({
        autoOpen: true,
        height: 200,
        width: 500,
        modal: true,
        resizable: false
    });
    
    if(code!=''){
        $('#gall_code').val(code);
        $('#gall_name').val(name);
    }else{
        $('#gall_code,#gall_name').val('');
    }
    
    $(".ui-dialog-titlebar").hide();
}

function cancelGallery() {
    $('#gall-dialog').dialog('destroy');
    $('#gall-dialog').hide();
}


function galleryView(code,name){
    $('.li_bk').removeClass('li_bk');
    $('#gall-'+code).addClass('li_bk');
    var data = {};
    data.code=code;
    data.name=name;
    $('#gal-viw-rslt').html(loading_small);
    $.ajax({
        type: "POST",
        dataType: 'html',
        url: base_url + "config/get-gallery-details",
        data: data,
        success: function(response) {
            if (response) {
                $('#gal-viw-rslt').html(response);
            }
        }
    })
}

function deleteGallery(code,name){
     if (confirm('Do you want to delete this gallery?')) {
        var data = {};
        data.activeFlag = 2;
        data.name = name;
        data.code = code;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-gallery",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#gall-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
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
                window.setTimeout(function() {
                    loading_overlay.hide();
                    window.location.reload();
                }, 2000);
            }
        })
    }
}



function saveGallery() {
    var data = {};
    data.activeFlag = 1;
    data.name = $('#gall_name').val();
    data.code = $('#gall_code').val();
    var err = 0;
    if (data.name == '') {
        $('#gall_name').addClass('inp_error');
        err++;
    } else {
        $('#gall_name').removeClass('inp_error');
    }

    if (err > 0) {
        $('#gall-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        $('#gall-action-state').html('Please enter the values in the field that are marked in red');
        $('#gall-action-state').show();
        return false;
    } else {
        $('#gall-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#gall-action-state').html('');
        $('#gall-action-state').hide();
    }


    $('#gall-form-buttons').hide();
    $('#gall-action-state').html(loading_popup);
    $('#gall-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-gallery",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#gall-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#gall-action-state').show();
                $('#gall-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                   window.location.reload();
                }, 3000);
            }
        }
    })
}