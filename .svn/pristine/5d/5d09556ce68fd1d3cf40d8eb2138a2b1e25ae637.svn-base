function editInventoryGroup(code) {
    var data = {};
    data.code = code;
       $.ajax({
        type: "POST",
        dataType:'html',
        url: base_url+"config/inventory-group",
        data: data,
        success: function(response) {            
            $('#inventory-group').html(response);
            
            }
        }
    ); 
    }
 function editgroupInventoryStatus(code,obj){
       var data = {};
        data.code = code;
        data.activeFlag = $(obj).attr('data-status')==1 ? 0 : 1;
        var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
	 }); 
        $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"config/status-inventorygroup",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                     $(obj).attr('data-status',data.activeFlag);
                     if(data.activeFlag==0){
                      
                          $('#inv_edt_'+code).hide();
                         $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title','Click to enable');//0
                     }else{
                          $('#inv_edt_'+code).show();
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
function cancelInventorygroup(){              
    $('#inventory-group').html(" ");
  }

function editInventory(opt){
    
//    $('#groups').val('');
    $('.inp_error').removeClass('inp_error');
    $('#inventory-dialog').css('background','#fff');
    $('#inventory-dialog').removeClass('hide');
    var he = 400; 
    if(_isdefined(opt)) {
      he = 400;
    }
    $('#inventory-dialog').dialog({
        autoOpen: true,
        height:he,
        width: 600,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();
    
    $('#inventory-form-action-state').html('');
    $('#inventory-form-action-state').hide();
    
    $('#inventory-loading').html('');
    $('#inventory-loading').hide();
     $('#namespace').html('');
    var html = '<option value="">--Select--</option>';
    var oprhtm = '';
    var nameArry = [] ; 
    var groupArry = [] ; 
    var sel = '';
    $.each(inventory,function(inkey,inval){  
      /*  if(inval.code!=opt){
        */    
       if(opt!='' && opt != undefined){
          nameArry.push(inval.apiNameSpace.code);  
//          $.each(inval.groupList,function(grkey,grval){  
//              groupArry.push(grval.code);
//          });
      }
       /* }*/
        if(inval.code==opt){ 
          $('#txt_in_name').val(inval.apiToken);
          $('#in_id_code').val(inval.code);
          $('#namespace').val(inval.apiNameSpace.mode);
          sel = inval.apiNameSpace.code;
           $.each(inval.operatorList,function(olkey,olval){  
               var mf='';
               var af='';
               if(olval.mobileTicketFlag==1){
                   mf="checked";
               }
               if(olval.activeFlag==1){
                   af="checked";
               }
              oprhtm +='';
          });
        }
    });
    
   oprhtm +="</div>\n\
    </div>";
   oprhtm += '';
    
    if(_isdefined(opt)) { 
       
         $('#opr-lst').html(oprhtm);
         $('.opov').addClass('ov_fl_70');
         $('.bs_switch').bootstrapSwitch('size', 'mini');
              nameArry.splice(nameArry.indexOf(sel));
         $('.edit-only').show();     
    }else{
        $('#opr-lst').html('').removeClass('ov_fl_70');
         $('.opov').addClass('ov_fl_100');
         $('.edit-only').hide();
         $('#txt_in_name').val('');
         $('#namespace').val('');
         $('#in_id_code').val('');
//         $('#groups').val('');
    
    }
    
    $.each(namespace,function(key,nmval){  
       
             if(jQuery.inArray(nmval.code,nameArry) < 0){
                 html += "<option value='"+nmval.code+"'";
                 if(nmval.code==sel){
                      html += "selected";
                 }
                 html +=">"+nmval.name+"</option>";
             }
         });
      
//      $("#groups").val(groupArry).trigger("change");
      $('#namespace').append(html);
}

function cancelInventory(){
      $('#inventory-dialog').dialog("destroy");
}
function saveInventory(){
    var data = {}
    data.code = $('#in_id_code').val();
    data.namespace = $('#namespace').val();
    data.activeFlag = $('#activeFlag').val();
    data.apiname = $('#txt_in_name').val();
//    data.groups = $('#groups').val();
    data.oprcode =  $('input[name="oprcode"]').serializeArray();
    
    
     var err = 0;
    if ($('#txt_in_name').val() == '') {
        $('#txt_in_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_in_name').removeClass('inp_error');
    }
    
    if ($('#namespace').val() == '') {
        $('#namespace').addClass('inp_error');
        err++;
    } else {
        $('#namespace').removeClass('inp_error');
    }
    
//    $('#s2id_groups').addClass('inp_error');
//    if(data.groups){
//       $('#s2id_groups').removeClass('inp_error');
//    }
//    

    if (err > 0) {
        $('#inventory-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#inventory-form-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#inventory-form-action-state').show();
        return false;
    } else {
        $('#inventory-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#inventory-form-action-state').hide();
    }
    
      
    var cht =  new Array();
    $("input[name='mobil_flg']").each( function() {
        if($(this).is(":checked")==true){
           $(this).val(1)
            cht.push($(this).val());
        }else{
            cht.push(0);
        }
    });
    data.mobileTicketFlag = cht;
    
    var actfg =  new Array();
    $("input[name='mobil_flg']").each( function() {
        if($(this).is(":checked")==true){
           if($(this).val()=='') $(this).val(1)
            actfg.push($(this).val());
        }else{
            actfg.push(0);
        }
    });
    data.OpreactiveFlag = actfg;
    
    $('#inventory-bttons').hide();
    $('#inventory-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#inventory-form-action-state').hide();
    $('#inventory-loading').html(loading_popup);
    $('#inventory-loading').show();
    $.ajax({
        type: "POST",
        dataType:'json',
        url: base_url+"config/update-inventory",
        data: data,
        success: function(response) {            
            if(response.status==1) {
                $('#inventory-loading').html('');
                $('#inventory-loading').hide();
                $('#inventory-form-action-state').removeClass('alert-danger').addClass('alert-success');
                $('#inventory-form-action-state').show();
                $('#inventory-form-action-state').html('Your request has been completed successfully');  
                
                $('#clo').find('input').removeAttr('disabled','disabled');
                $('#clo').find('select').removeAttr('disabled','disabled');
                
                window.setTimeout( function() { 
                    cancelInventory(); 
                    checkURL();
                    return;
                }, 3000);
            } else{                
                $('#inventory-loading').html('');
                $('#inventory-loading').hide();
                $('#inventory-form-action-state').removeClass('alert-success').addClass('alert-danger');
                $('#inventory-form-action-state').html(response.errorDesc);
                $('#inventory-form-action-state').show();
                $('#inventory-bttons').show();
            }
        }
    }) 
}

function saveinventorygroup(){
 
    var data = {}
    data.code = $('#in_id_code').val();
    data.namespace = $('#namespace').val();
    data.activeFlag = $('#activeFlag').val();
    data.apiname = $('#txt_in_name').val();
    data.groups = $('#groups').val();
    data.oprcode =  $('input[name="oprcode"]').serializeArray();
        $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"config/updategroup_inventory",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                     $(obj).attr('data-status',data.activeFlag);
                     if(data.activeFlag==0){
                      
                          $('#inv_edt_'+code).hide();
                         $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title','Click to enable');//0
                     }else{
                          $('#inv_edt_'+code).show();
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



function editInventoryCommission(code){
    $('.inp_error').removeClass('inp_error');
    $('#inventory-commission-dialog').css('background','#fff');
    $('#inventory-commission-dialog').css('z-index','400');
    $('#inventory-commission-dialog').removeClass('hide');
    $('#inventory-commission-dialog').dialog({
        autoOpen: true,
        height:400,
        width: 600,
        modal: true,
        resizable: false,
        dialogClass: 'no-close success-dialog'
    });
    $(".ui-dialog-titlebar").hide(); //inventory-dialog
    $('#inventory-dialog').parent().css('z-index','10');
    $('#inventory-commission-dialog').parent().css('z-index','300');
           if(_isdefined(code) || _isdefined(com_code)){
                     $.each(commission,function(k,vls){
                         if(com_code==vls.code){
                               $('#dpStart').val(vls.activeFrom);
                               $('#dpEnd').val(vls.activeTo);
                               $('#txt_cl').val(vls.creditLimit);
                               $('#txt_vlu').val(vls.value);
                               if(vls.percentageFlag==1){
                                    $("#txt_pt").attr('checked','checked');
                                    $("#txt_pt").attr('checked',true);
                                    $("#txt_pt").prop('checked', true);
                               }          

                               $('#hid_cms_code').val(com_code);
                               $('#hid_cms_status').val(vls.activeFlag);
                               //
                         }
                     });
                     $('#hid_urs_cms_code').val(code);
           }
}

function saveInventoryCommission(){
    var data = {}
    data.creditlimit = $('#txt_cl').val();
    data.activeFrom = $('#dpStart').val();
    data.activeTo = $('#dpEnd').val();
    data.value = $('#txt_vlu').val();
    data.userCode = $('#hid_urs_cms_code').val();
    data.code = $('#hid_cms_code').val();
    data.activeFlag = $('#hid_cms_status').val();
    data.percentageFlag = $('#txt_pt:checked').val()?1:0;
    data.inventorycode = $('#in_id_code').val();
    
    var err=0;
    if(data.creditlimit==''){
        $("#txt_cl").addClass('inp_error');
        err++;
    }else{
        $("#txt_cl").removeClass('inp_error');
    }
    if(data.activeFrom==''){
        $("#dpStart").addClass('inp_error');
        err++;
    }else{
        $("#dpStart").removeClass('inp_error');
    }
    if(data.activeTo==''){
        $("#dpEnd").addClass('inp_error');
        err++;
    }else{
        $("#dpEnd").removeClass('inp_error');
    }
    
    if(data.value==''){
        $("#txt_vlu").addClass('inp_error');
        err++;
    }else{
        $("#txt_vlu").removeClass('inp_error');
    }
    
    if(err>0){
        $('#ur-cms-loading').html('');
         $('#ur-cms-loading').hide();
         $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
         $('#usr-cms-state').html('Please enter the values in the field that are marked in red');
         $('#usr-cms-state').show();
         return false;
    }
         $('#form-cms-bttons').hide();
         $('#ur-cms-loading').html(loading_popup);
         $('#ur-cms-loading').show();
         
      $.ajax({
        type: "POST",
        dataType:'json',
        url: base_url+"config/commission-inventory",
        data: data,
        success: function(response) {            
            if(response.status==1) {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-cms-state').show();
                $('#usr-cms-state').html('Your request has been completed successfully'); 
                
                      window.setTimeout( function() { 
                          cancelCommissionDialog(); 
                          clearDate();
                          $('#usr-viw-'+data.userCode).trigger("click");
                      }, 3000);
            }else if(response.status==3) {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cms-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-cms-state').show();
                $('#form-cms-bttons').show();
            }else if(response.status==4) {
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cms-state').html("Specified date range confliting with existing commissions date.");
                $('#usr-cms-state').show();
                $('#form-cms-bttons').show();
            }else{                
                $('#ur-cms-loading').html('');
                $('#ur-cms-loading').hide();
                $('#usr-cms-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-cms-state').html(response.errorDesc);
                $('#usr-cms-state').show();
                $('#form-cms-bttons').show();
            }
        }
    });
}


function cancelCommission(){
    $('#inventory-dialog').parent().css('z-index','200');
     $('#inventory-commission-dialog').dialog("destroy");
}
function editInventoryStatus(code,obj){
       var data = {};
        data.code = code;
        data.activeFlag = $(obj).attr('data-status')==1 ? 0 : 1;
        var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
	 }); 
        $.ajax({
            type: "POST",
            dataType:'json',
            url: base_url+"config/status-inventory",
            data: data,
            success: function(response) { 
                if(response.status==1) {
                     $(obj).attr('data-status',data.activeFlag);
                     if(data.activeFlag==0){
                      
                          $('#inv_edt_'+code).hide();
                         $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title','Click to enable');//0
                     }else{
                          $('#inv_edt_'+code).show();
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

function deleteInventory(code) {
    if(confirm('Do you want to delete this Inventory?')) {
        var data = {};
        data.code = code;
        data.activeFlag = 0;
        
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
                    $('#int-'+code).animate({backgroundColor:'#1AA1E1'} , 2000, function() { $(this).remove() } );
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
function UpdateToken() {
    var data = {};
    data.code = $('#usr_code').val();
    data.token = $("#token").val();
    var err = 0;

    if ($("#token").val() == '') {
        $("#token").addClass('inp_error');
        err++;
    } else {
        $("#token").removeClass('inp_error');
    }

    if (err > 0) {
        $('#usr-token-state').removeClass('alert-success').addClass('alert-danger');
        $('#usr-token-state').html('Please enter API token');
        $('#usr-token-state').show();
        return false;
    } else {
        $('#usr-token-state').addClass('alert-success').removeClass('alert-danger');
        $('#usr-token-state').html('');
        $('#usr-token-state').hide();
    }

    $('#edit-token-bttons').hide();
    $('#ur-token-loading').html(loading_popup);
    $('#ur-token-loading').show();
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "profile/update-token",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#ur-token-loading').html('');
                $('#ur-token-loading').hide();
                $('#usr-token-state').removeClass('alert-danger').addClass('alert-success');
                $('#usr-token-state').show();
                $('#usr-token-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    $('#usr-token-state').html('');
                    $('#usr-token-state').hide();
                    $('#edit-token-bttons').show();
                    $('.api-tk').removeClass('req');
                    $('#token').hide();
                    $('.lab_tkn').show();
                    $('#tkn_edt').show();
                    $('.token_btn').hide();
                    $('.pd_lts_31').addClass('pd_lt_31').removeClass('pd_lts_31');
                    $('.mr_27').addClass('mr_17').removeClass('mr_27');
                    $('#token').val('');
                    $('#tkn_txt').html(response.data.apiToken);
                }, 3000);
            } else {
                $('#ur-token-loading').html('');
                $('#ur-token-loading').hide();
                $('#usr-token-state').removeClass('alert-success').addClass('alert-danger');
                $('#usr-token-state').html(response.errorDesc);
                $('#usr-token-state').show();
                $('#edit-token-bttons').show();
            }
        }
    });
}

