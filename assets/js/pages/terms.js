$(document).ready(function () {
    //removetr();

});

function removetr(ele) {
    $(ele).parent().parent().hide();
    $(ele).parent().parent().find('#activeflag').val('0');
}

function init_terms_rows() {    
    var row_button = $('#template-row-buttons').html();    
    var html = $(row_button).clone();
    $('#terms tbody').append(html);    
       
    $.each(termslist, function(bkey, bval) {       
        add_row(bval);
    });
    
    var row_tmplate = $('#template-row').html(); 
    var html = $(row_tmplate).clone();
    $('#terms > tbody > tr:last').before(html);   
    
}

function add_row(r) {
    
    var row_tmplate = $('#template-row').html(); 
    var html = $(row_tmplate).clone();
    
    $(html).find('#code').val(r.code);
    $(html).find('#name').val(r.name);
    $(html).find('#sequence').val(r.sequence);
    $(html).find('#activeflag').val(r.activeFlag);
    $('#terms > tbody > tr:last').before(html);
    //$('#terms tbody').append(html);
}

/*
if ($('#tr_add').length) { 
    var $tr_id = 3;
    $('#tr_add_btn').on('click', function (e) {
        $tr_id = $tr_id + 1;
        e.preventDefault();
        var $cloned_tr = $('#tr_clone').clone(true),
                random_id = Math.random().toString(36).substr(2, 9);

        $cloned_tr.attr({
            id: 'terms_row_' + $tr_id
        }).removeAttr('style').find('input').attr({
            id: "txt_name" + $tr_id,
            name: "tms_name" + $tr_id
        });
        $cloned_tr.insertBefore($('#tr_add'));

    });
}
*/

function save() {
    var err = 0;
    
     var data = [];
     
     $('#terms > tbody > tr').each( function() {
         if($.trim( $(this).find('#name').val() ) != "") {
            var term = {}; 
            term.name = $.trim( $(this).find('#name').val() );
            term.code = $(this).find('#code').val();
            term.sequence = $(this).find('#sequence').val();
            term.activeflag = $(this).find('#activeflag').val();

            data.push(term);
        }
     });
         
     if(data.length==0){
        $('#tms-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#tms-form-action-state').html('Please enter atleast one term to proceed');
        $('#tms-form-action-state').show();
        return false;
    }else{
        $('#tms-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#tms-form-action-state').html('');
        $('#tms-form-action-state').show();
    }
    
    $('#tms-form-action-state').html(loading_small);
    var param = {};
    param.terms = data;
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-terms",
        data: param,
        success: function (response) {
            if (response.status == 1) {
                $('#tms-form-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#tms-form-action-state').show();
                $('#tms-form-action-state').html('Your request has been completed successfully');
                $('#tr_add_btn').show();
                window.setTimeout(function () {
                  checkURL();
                }, 3000);
            } else {
                $('#tms-form-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#tms-form-action-state').html(response.errorDesc);
                $('#tms-form-action-state').show();
                $('#tr_add_btn').show();
            }
        }
    })
}


    