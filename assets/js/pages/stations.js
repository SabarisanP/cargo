function buildStationsList() {
    $('#search-status').html('');
    var data = {};
    data.state_code = $('#sel_state_id').val();
    if (data.state_code == "") {
        $('#search-status').html('Please select a state');
        return;
    }

    $('#address-book').html('<div align="left">' + loading_big + '</div>');
    $('#result-panel').show();
    $('#result-panel').removeClass('hide');
    $('#contact-card').hide();
    $.ajax({
        type: "POST",
        url: base_url + "config/get-stations/stations",
        data: data,
        success: function(response) {
            $('#address-book').html(response);
            // $('#address-book').sliderNav();
        }
    })
}

function bulidStationPoint() {
    $('#action-status').html('');
    var data = {};
    data.state_code = $('#sel_state_id').val();
    if (data.state_code == "") {
        $('#action-status').html('<span class="warning-text">Please select a state</span>');
        return;
    }
    $('#sp-list').removeClass('hidden');
    $('.col-lg-6', '#sp-list').html('<div align="left">' + loading_small + '</div>');
    //$('#address-book').html('<div align="left">'+loading_big+'</div>');
    $('#result-panel').show();
    $('#result-panel').removeClass('hide');
    $('#contact-card').hide();
    $.ajax({
        type: "POST",
        url: base_url + "config/get-stations/stationspoint",
        data: data,
/*<<<<<<< .mine
        dataType: 'json',
        success: function(response) {

            $("#station_list").select2("destroy");
            $('.col-lg-6', '#sp-list').html('<select id="station_list" class="form-control wi_200"></select>');
            $("#station_list").html('');
            var dd = '';
            dd += "<option value=''>Select a station</option>";
            $.each(response.data, function(i, obj) {
                dd += "<option value = '" + obj.code + "'>" + obj.name + "</option>";
            });
=======*/
        dataType:'json',
        success: function(response) { 
          
           $("#station_list").select2("destroy");
           $('.col-lg-6','#sp-list').html('<select id="station_list" class="form-control wi_200"></select>');
           $("#station_list").html('');
           var dd = '';
               dd +="<option value=''>Select a station</option>"; 
             $.each(response.data, function(i, obj) {
                        if(obj.activeFlag==1)dd += "<option value = '"+obj.code+"'>"+obj.name+"</option>";
              });

            $("#station_list").append(dd);
            $('#station_list').select2({
                allowClear: true,
                width: 'resolve',
                placeholder: "Select a station"
            });
            $('#address-book').html('');
            //buildNameSpaceMappingList();

        }
    })
}

function editStation(station) {
    $('.inp_error').removeClass('inp_error');
    $('#contact-card').show();
    $('#form-buttons').show();
    $('#addedit_state_id').val('');
    $('#stm-form-action-state').html('');
    $('#stm-form-action-state').hide();
    $('#addedit-state-id, #txt_st_name,#hid_st_code').val('');
    $('#btn-save').html('Add');

    $('#addedit_lat').val('');
    $('#addedit_lng').val('');
    $('#addedit_rad').val('1').trigger('change');
    if (_isdefined(station)) {
        $('#addedit_state_id').val($('#sel_state_id').val());
        $('#txt_st_name').val(station.name);
        $('#addedit_api_flag').val(station.apiFlag);
        $('#sel_st_status').val(station.activeFlag);
        $('#hid_st_code').val(station.code);
        $('#addedit_lat').val(station.latitude).trigger('change');
        $('#addedit_lng').val(station.longitude).trigger('change');
        $('#addedit_rad').val(station.radius).trigger('change');
        $('#btn-save').html('Update');

        if(!(station.longitude && station.latitude)){
            getLatLangStation();             
       }
       
       if(!station.radius){
           $('#addedit_rad').val('1').trigger('change');
       }
    }
     $('.err_bor').removeClass('err_bor');
    $('#state-dialog').show();
    $('#state-dialog').css('background', '#fff');
    $('#state-dialog').dialog({

			autoOpen: true,
			height: 650,
			width: 900,
			modal: true,
			resizable: false,			
		});

    $(".ui-dialog-titlebar").hide();
}

function saveStation() {
    var data = {};
    data.stateCode = $('#addedit_state_id').val();
    data.name = $('#txt_st_name').val();
    data.apiflag = $('#addedit_api_flag').val();
    data.activeFlag = $('#sel_st_status').val();
    data.code = $('#hid_st_code').val();

    data.latitude = $('#addedit_lat').val();
    data.longitude = $('#addedit_lng').val();
    data.radius = $('#addedit_rad').val();

    var err = 0;
    if ($('#addedit_state_id').val() == '') {
        $('#addedit_state_id').addClass('inp_error');
        err++;
    } else {
        $('#addedit_state_id').removeClass('inp_error');
    }

    if ($('#txt_st_name').val() == '') {
        $('#txt_st_name').addClass('inp_error');
        err++;
    } else {
        $('#txt_st_name').removeClass('inp_error');
    }

    if (err > 0) {
        $('#stm-form-action-state').show();
        $('#stm-form-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#stm-form-action-state').html('Please enter/select the values in the field that are marked in red');
        return false;
    } else {
        $('#stm-form-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#stm-form-action-state').hide();
    }


    $('#form-buttons').hide();
    $('#stm-form-action-state').html(loading_popup);
    $('#stm-form-action-state').show();
    $('#stm-form-action-state').removeClass('hide').removeClass('alert-danger').removeClass('alert-success');

    var err = 0;
    $('.err_bor').removeClass('err_bor');
    if(data.name==''){        
        $('#txt_st_name').addClass('err_bor');
        err++;
    }
    if(data.stateCode==''){        
        $('#addedit_state_id').addClass('err_bor');
        err++;
    }
    if(err >0 ){
        $('#stm-form-action-state').addClass('alert-danger'); 
        $('#stm-form-action-state').html('Please enter/select the values in the field that are marked in red.');
        $('#form-buttons').show();
        return false;
    }

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/update-station",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#stm-form-action-state').removeClass('alert-danger');
                $('#stm-form-action-state').addClass('alert-success');
                $('#stm-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelAddEditForm();
                    buildStationsList();
                }, 3000);
            } else {
                $('#stm-form-action-state').addClass('alert-danger');
                $('#stm-form-action-state').html(response.errorDesc);
                $('#form-buttons').show();
                //window.setTimeout( function() { $('#stm-form-action-state').hide(); }, 3000);
                //$('#form-buttons').show();
            }
        }
    })
}
function editStationStatus(stations) {

    var data = {};
    data.code = stations.code;
    data.stateCode = stations.stateCode;
    data.apiflag = stations.apiFlag;
    data.name = stations.name;
    data.activeFlag = $('#sta-' + stations.code).attr('data-status');
    /*$('#action-status').html(loading_small);
     $('#action-status').show();*/
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/edit-station-status",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $('#action-status').html('');//stations.code
                var chg = data.activeFlag == 1 ? 0 : 1;
                $('#sta-' + stations.code).attr('data-status', chg);
                if ($('#sta-' + stations.code).attr('data-status') == 1) {
                    $('#station-edit-list-' + stations.code).hide();
                    $('#sta-' + stations.code).removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');
                    $('#lb-' + stations.code).removeClass('label-success').addClass('label-danger').html('Disabled');

                } else {
                    $('#station-edit-list-' + stations.code).show();
                    $('#sta-' + stations.code).removeClass('fa-check').addClass('fa-times').attr('title', 'Click to disable');
                    $('#lb-' + stations.code).removeClass('label-danger').addClass('label-success').html('Active');
                }
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
            } else {
                /* $('#action-status').addClass('alert-error');
                 $('#action-status').html('Sorry! Problem in processing your request');*/
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
function deleteStation(stations) {
    if (confirm('Do you want to delete this station?')) {
        var data = {};
        data.code = stations.code;
        data.stateCode = stations.stateCode;
        data.apiflag = stations.apiFlag;
        data.name = stations.name;

        /*$('#action-status').html(loading_small);
         $('#action-status').show();*/
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-station",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#st-' + stations.code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    /*$('#action-status').addClass('alert-error');
                     $('#action-status').html('Sorry! Problem in processing your request');*/
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

function clearStsearch() {
    $('#sel_state_id').val('')
    $('#result-panel').hide();
    $('#contact-card').hide();
}

function cancelAddEditForm() {
    $('#state-dialog').dialog('destroy');
    $('#state-dialog').hide();
}