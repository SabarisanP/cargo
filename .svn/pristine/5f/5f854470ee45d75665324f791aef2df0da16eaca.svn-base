var ri = false;
function editGroup(option) {
    $('.inp_error').removeClass('inp_error');
    $('#pg-group-dialog').css('background','#fff');
    $('#pg-group-dialog').removeClass('hide');
    $('#pg-group-dialog').dialog({
        autoOpen: true,
        height: 350,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    
    $('#grp-form-action-state').html('');
    $('#grp-form-action-state').hide();
    
    $('#txt_g_name,#txt_g_decription,#aid_g_code').val('');
    $('#sel_g_status').val(1); 
    
    //if(!ri) {
        $('#txt_level').rating({
            'showCaption':false,
            'min':'0', 
            'max':'5', 
            'step':'1', 
            'size':'xs', 
        });

        $('#txt_level').on('rating.change', function(event, value, caption) {
            $('#txt_level').val(value);
        });
        ri = true;
    //}
    if(_isdefined(option)) {
        $('#txt_g_name').val(option.name);
        //$('#txt_g_decription').val(option.decription);
        $('#aid_g_code').val(option.code);
        $('#sel_g_status').val(option.activeFlag);
        $('#txt_level').val(option.level);
        $('#txt_level').rating('update', option.level);
    } else {
        $('#txt_level').val(1);
        $('#txt_level').rating('update', 1);
    }
    
    
}
function saveGroup() {
    var data = {};
    data.activeFlag = $('#sel_g_status').val();
    data.name = $('#txt_g_name').val();
    data.code = $('#aid_g_code').val();
    data.description = $('#txt_g_name').val();
    data.level = $('#txt_level').val();
    var err=0;
     if($('#txt_g_name').val()==''){
       $('#txt_g_name').addClass('inp_error') ;
       err++;
    }else{
        $('#txt_g_name').removeClass('inp_error');
    }

    if(err > 0){
        $('#grp-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#grp-form-action-state').html('Please enter the values in the field that are marked in red');
        $('#grp-form-action-state').show();
        return false;
    }else{
        $('#grp-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#grp-form-action-state').html('');
        $('#grp-form-action-state').hide();
    }
    $('#form-bttons').hide();
    $('#form-loading').html(loading_popup);
    $('#form-loading').show();
    
    $.ajax({
        type: "POST",
        dataType:'json',
        url: base_url+"config/update-group",
        data: data,
        success: function(response) {            
            if(response.status==1) {
                $('#form-loading').html('');
                $('#form-loading').hide();
                $('#grp-form-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#grp-form-action-state').show();
                $('#grp-form-action-state').html('Your request has been completed successfully');                
                window.setTimeout( function() { 
                    cancelGroup(); 
                    checkURL();
                }, 3000);
            } else{                
                $('#form-loading').html('');
                $('#form-loading').hide();
                $('#grp-form-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#grp-form-action-state').html(response.errorDesc);
                $('#grp-form-action-state').show();
                $('#form-bttons').show();
            }
        }
    })     
}
function cancelGroup() {
    $('#pg-group-dialog').dialog('destroy');
    $('#pg-group-dialog').hide();
    $('#txt_level').val(1);
    $('#txt_level').rating('update', 1);
}


function deleteGroup(grp_code, grp_name) {
    if(confirm('Do you want to delete this group?')) {
        var data = {};
        data.code = grp_code;
        data.name = grp_name;
        
        var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
	 });
        $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"config/delete-group",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                    $('#grp-'+grp_code).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
                      loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 
                }else{                
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
function editStatusGroup(grp_code,grp_name,obj){
    
        var data = {};
        data.code = grp_code;
        data.name = grp_name;
        data.activeFlag = $(obj).attr('data-status')==1 ? 0 : 1;
       
        var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
	 }); 
        $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"config/edit-status-group",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                     $(obj).attr('data-status',data.activeFlag);
                     if(data.activeFlag==0){
                         $('#gp_edt_'+grp_code).hide();
                         $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title','Click to enable');//0
                     }else{
                         $('#gp_edt_'+grp_code).show();
                         $(obj).find('.fa').removeClass('fa-check').addClass('fa-times').attr('title','Click to disable');//1
                     }
                    loading_overlay.update({
							icon: "fa fa-check",
							text: "Success!"
		   }); 	
                } else{                
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

function allUserGroup(code){
    $('#all_usr_grp').css('background','#fff');
    $('#all_usr_grp').removeClass('hide');
    $('#all_usr_grp').show();
    $('#all-grp-form-bttons').show();
    $('#all-grp-state').hide();
    $('#all_usr_grp').dialog({
        autoOpen: true,
        height: 400,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    $('#id_grp_code').val(code);
    if($('#alr_grp_usr_'+code).val()!='' && $('#alr_grp_usr_'+code).val()!=',' && $('#alr_grp_usr_'+code).val()!=undefined){
    var id = $('#alr_grp_usr_'+code).val().replace(',', '');
    var lis = id.split(",");
        $('input[name="usr_grp_all"]').each(function () {
            if(jQuery.inArray($(this).val(), lis ) > -1){
                $(this).attr('checked','checked');
                $(this).attr('disabled','disabled');
            }
        });
    }
}

function cancelUserGroup(){
    $('#all_usr_grp').dialog('destroy');
    $('#all_usr_grp').hide();
}

function saveallUserGroup(){
    var data = {}
    data.code = $('#id_grp_code').val();
    data.usrCode = $('input[name="usr_grp_all"]').serializeArray();
    //all_user_organization
    $('#all-grp-form-bttons').hide();
    $('#all-grp-form-loading').html(loading_popup);
    $('#all-grp-form-loading').show();
        $.ajax({
        type: "POST",
        dataType:'json',
        url: base_url+"config/all-user-group",
        data: data,
        success: function(response) {   
            
            if(response.status==1) {
                $('#all-grp-state').removeClass('alert-danger').removeClass('hide');
                $('#all-grp-state').addClass('alert-success');
                $('#all-grp-state').html('Your request has been completed successfully');    
                $('#all-grp-state').show();
                $('#all-grp-form-loading').html('');
                $('#all-grp-form-loading').hide();
                window.setTimeout( function() {
                    cancelUserGroup(); 
                    checkURL();
                    $('a[href="collapse-'+data.code+'"]').trigger('click');
                    return;
                }, 3000);
                
            } else{        
                $('#all-grp-form-loading').html('');
                $('#all-grp-form-loading').hide();
                $('#all-grp-state').addClass('alert-error').removeClass('hide');
                $('#all-grp-state').html(response.errorDesc);
                $('#all-grp-state').show();
                $('#all-grp-form-bttons').show();
            }
        }
    }) 
}