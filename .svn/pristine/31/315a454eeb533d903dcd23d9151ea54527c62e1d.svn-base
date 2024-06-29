function editNamespace(code) {
    $('#pro-dialog').css('background','#fff');
    
     $('#amt-form-bttons').show();
    $('#pro-dialog').show();
    $('#pro-dialog').removeClass('hide');
    
    $('#pro-dialog').dialog({
        autoOpen: true,
        height: 300,
        width: 600,
        resizable: false,
        modal: true,
    });
    $(".ui-dialog-titlebar").hide();
    
    $('#amt-form-bttons').show();
    $('#pro-dialog').show();
    $('#pro-dialog').removeClass('hide');
    $('#pwd-action-state').html('');
    $('#pwd-action-state').hide();
    $('#e_code').removeAttr('disabled','disabled');
     $('#e_name,#e_pin,#e_code').val('')
        $('').val('');
    if(code!=1)
    {
        $.each(namespae,function(keys,values){
            if(code==values.code){
                $('#e_name').val(values.name);
                $('#e_pin').val(values.pin);
                $('#flag').val(values.activeFlag);
                $('#e_code').val(code).attr('disabled','disabled');
                $('#np-code').hide();
            }
        });
    }
    
}

function cancelProAddEdit() {
    $('#pwd-action-state').hide();
    $('#pro-dialog').dialog('close');
}

function saveNamespace() {
    var data = {};
    data.activeFlag = 1;
    data.name = $('#e_name').val();
    data.code = $('#e_code').val();
    data.pin = $('#e_pin').val();
    data.mode = $('#e_mode').val();
    $('#pwd-action-loading').html('');
    $('#pwd-action-loading').hide();
    
    var reg = /^[a-zA-Z0-9\\s]*$/;
    
    if ($('#e_name').val() == '') {
        
        $('#pwd-action-state').show();
        $('#pwd-action-state').removeClass('alert-success');
        $('#pwd-action-state').addClass('alert-danger');
        $('#pwd-action-state').html('Please enter name');
        return false;
    }
    else if ($('#e_pin').val() == '') {
        
        $('#pwd-action-state').show();
        $('#pwd-action-state').removeClass('alert-success');
        $('#pwd-action-state').addClass('alert-danger');
        $('#pwd-action-state').html('Please enter pin');
        return false;
    } 
    
   
    if (!reg.test(data.code)) {
        $("#pwd-action-state").width(400);
        $('#pwd-action-state').show();
        $('#pwd-action-state').removeClass('alert-success');
        $('#pwd-action-state').addClass('alert-danger');
        $('#pwd-action-state').html('Please enter valid Code.');
        return false;
    }
    
    $('#amt-form-bttons').hide();
    $('#pwd-action-loading').html(loading_popup);
    $('#pwd-action-loading').show();
    
    
    $.ajax({
        type: "POST",
        dataType:'json',
        url: base_url+"config/update-namespace",
        data: data,
        success: function(response) {            
            if(response.status==1) {
                $('#pwd-action-loading').html('');
                $('#pwd-action-loading').hide();
                $('#pwd-action-state').show();
                $('#pwd-action-state').removeClass('alert-danger');
                $('#pwd-action-state').addClass('alert-success');
                $("#pwd-action-state").width(550);
                $('#pwd-action-state').html('Your request has been completed successfully'); 
                
                if($('#nsp-'+data.code).length > 0 ){
                    var li = $('#nsp-'+data.code);
                    li.find("h5").text(data.name);
                    li.find("small").text(data.pin+",OWN");
                }else{
                    namespae.push(response.data);
                    var li = $('#namespace_view').html();
                    li = $('<div>').html(li).clone(); 
                    li.find("h5").text(data.name);
                    li.find("small").text(data.pin+",OWN");
                    li.find("a").attr('onclick','editNamespace("'+data.code+'")');
                    $('#user_list_search').append(li);
                }                              
                window.setTimeout( function() {
                    cancelProAddEdit(); 
                  
                }, 3000);
            } else{                
                $('#pwd-action-loading').html('');
                $('#pwd-action-loading').hide();
                $('#pwd-action-state').show();
                $('#pwd-action-state').addClass('alert-error');
                $('#pwd-action-state').html(response.errorDesc);
                $('#amt-form-bttons').show();
                 window.setTimeout( function() {
                     $('#pwd-action-state').hide();
                     $('#amt-form-bttons').show();
                 }, 3000);
            }
        }
    })     
}

$(document).ready(function(){
    $('input#list_search').quicksearch('#user_list_search > li');
				
    $('.user_check_all input:checkbox').on('ifChecked', function(event){
            $('#user_list_search li:visible .user_check input:checkbox').iCheck('check'); 
    }).on('ifUnchecked', function(event){
            $('#user_list_search li:visible .user_check input:checkbox').iCheck('uncheck'); 
    }); 
});