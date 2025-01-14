function vehiclePopup(code) {
    event && event.stopPropagation();

    $('#vehicle-dialog').css('background', '#fff');
    $('#vehicle-dialog').removeClass('hide');
    $('#vehicle-dialog').dialog({
        autoOpen: true,
        height: 640,
        width: 950,
        modal: true,
        resizable: false
    });
    $(".ui-dialog-titlebar").hide();

    $('#form-bttons').show();
    $('#vehicle-action-state').html('');
    $('#vehicle-action-state').hide();
    $('.inp_error').removeClass('inp_error');

    if (_isdefined(code)) {
        var option = _.find(allVehicleData, function(o) {
            return o.code === code;
        });

        $('#name').val(option.name);
        $('#vehicle_status').val(option.activeFlag);
        $('#reg_no').val(option.registationNumber);
        $('#lic_no').val(option.licNumber);
        $('#Rdate').val(option.registrationDate);
        $('#gps').val(option.gpsDeviceCode);
        $('#gps_vendor').val(option.gpsDeviceVendor.code);
        $('#vehicle_code').val(option.code);
        $('#vehicle_type').val(option.vehicleType.code);
        $('#vehicle_tags').val(option.tag.map(i => i.code)).trigger('change');
        $('#sel_state_id').val(option.state.code);
        $('#vehicle_own_type').val(option.ownershipType.code).trigger('change', option.transporterContact.code);
        //$('#vehicle_trans').val(option.transporterContact.code);
        $('#ph_date').val(option.purchaseDate);
        $('#fc_date').val(option.lastFcDate);
        $('#vehicle_brand').val(option.makeType);
        $('#vehicle_model').val(option.modelType);
        $('#vehicle_fuel').val(option.fuelType.code);
        $('#vehicle_avg_mlg').val(option.averageMileage);
        $('#load_capacity').val(option.loadCapacity);
        $('#ftank_capacity').val(option.fuelTankCapacity);
        $('#oil_capacity').val(option.oilCapacity);
        $('#adblue_capacity').val(option.adblueCapacity);
        // $('#adhar').val(option.aadharNo);

        var dimension = option.dimensions.split('|');
        $('#vehicle_length').val(dimension[0]);
        $('#vehicle_width').val(dimension[1]);
        $('#vehicle_height').val(dimension[2]);
        $('#vehicle_uom').val(option.loadMeasurement).trigger('change');


    } else {
        // alert('no');
        $('#name').val('');
        $('#reg_no').val('');
        $('#lic_no').val('');
        $('#Rdate').val('');
        $('#gps').val('');
        $('#vehicle_code').val('');
        $('#vehicle_type').val('');
        $('#vehicle_tags').val([]).trigger('change');
        $('#sel_state_id').val('');
        $('#ph_date').val('');
        $('#fc_date').val('');
        $('#vehicle_trans').val('').trigger('change');
        $('#vehicle_own_type').val('OWN').trigger('change');
        $('#vehicle_brand').val('');
        $('#vehicle_model').val('');
        $('#vehicle_avg_mlg').val('');
        $('#load_capacity').val('');
        $('#ftank_capacity').val('');
        $('#oil_capacity').val('');
        $('#adblue_capacity').val('');
        $('#vehicle_length').val('');
        $('#vehicle_width').val('');
        $('#vehicle_height').val('');
        // $('#adhar').val('');

    }
}

function cancelVehicle() {
    $('#vehicle-dialog').dialog('destroy');
    $('#vehicle-dialog').hide();
}

function saveVehicle() {
    var data = {};
    
    data.code = $('#vehicle_code').val();
    data.activeFlag = $('#vehicle_status').val();
    data.name = $('#name').val().trim();
    data.registationNumber = $('#reg_no').val().trim();
    data.licNumber = $('#lic_no').val().trim();
    data.registrationDate = $('#Rdate').val();
    data.gpsDeviceCode = $('#gps').val();

    data.gpsDeviceVendor = {};
    data.gpsDeviceVendor.code = $('#gps_vendor').val();

    data.vehicleType = {};
    data.vehicleType.code = $('#vehicle_type').val();

    data.tag = $.map($('#vehicle_tags').val() || [], (tag) => ({ code: tag }));

    // data.vehicleStatus = $('#status').val();
    // data.aadharNo = $('#adhar').val();
    data.transporterContact = {};
    data.transporterContact.code = $('#vehicle_trans').val();

    data.ownershipType = {};
    data.ownershipType.code = $('#vehicle_own_type').val();

    data.state = {};
    data.state.code = $('#sel_state_id').val();

    data.purchaseDate = $('#ph_date').val();
    data.lastFcDate = $('#fc_date').val();
    data.makeType = $('#vehicle_brand').val();
    data.modelType = $('#vehicle_model').val();

    data.fuelType = {};
    data.fuelType.code = $('#vehicle_fuel').val();

    data.averageMileage = $('#vehicle_avg_mlg').val();
    data.dimensions = $('#vehicle_length').val() + '|' + $('#vehicle_width').val() + '|' +$('#vehicle_height').val();
    data.fuelTankCapacity = $('#ftank_capacity').val();
    data.oilCapacity = $('#oil_capacity').val();
    data.adblueCapacity = $('#adblue_capacity').val();
    data.loadCapacity = $('#load_capacity').val();
    data.loadMeasurement = $('#vehicle_uom').val();

    var err = 0;
    $('.inp_error').removeClass('inp_error');
    if (data.name == '') {
        $('#name').addClass('inp_error');
        err++;
    }

    if (data.registationNumber == '') {
        $('#reg_no').addClass('inp_error');
        err++;
    }
    
    if (data.licNumber == '') {
        $('#lic_no').addClass('inp_error');
        err++;
    }
    
    if (data.registrationDate == '') {
        $('#Rdate').addClass('inp_error');
        err++;
    }
    
    if (data.vehicleType == '') {
        $('#vehicle_type').addClass('inp_error');
        err++;
    }
    
    if (data.state.code == '') {
        $('#sel_state_id').addClass('inp_error');
        err++;
    }
    
    if (data.purchaseDate == '') {
        $('#ph_date').addClass('inp_error');
        err++;
    }
    
    if (data.lastFcDate == '') {
        $('#fc_date').addClass('inp_error');
        err++;
    }
    
    if (data.makeType == '') {
        $('#vehicle_brand').addClass('inp_error');
        err++;
    }
    
    if(data.transporterContact.code == ''){
        $('#vehicle_trans').addClass('inp_error');
        err++;
    }
    
    if (data.modelType == '') {
        $('#vehicle_model').addClass('inp_error');
        err++;
    }
    
    if (data.averageMileage == '') {
        $('#vehicle_avg_mlg').addClass('inp_error');
        err++;
    }
    
    if (data.loadCapacity == '') {
        $('#load_capacity').addClass('inp_error');
        err++;
    }
    
    if (data.fuelTankCapacity == '') {
        $('#ftank_capacity').addClass('inp_error');
        err++;
    }
    
    if (data.oilCapacity == '') {
        $('#oil_capacity').addClass('inp_error');
        err++;
    }
    
    if (data.adblueCapacity == '') {
        $('#adblue_capacity').addClass('inp_error');
        err++;
    }
    
    if ($('#vehicle_length').val() == '') {
        $('#vehicle_length').addClass('inp_error');
        err++;
    }
    
    if ($('#vehicle_width').val() == '') {
        $('#vehicle_width').addClass('inp_error');
        err++;
    }
    
    if ($('#vehicle_height').val() == '') {
        $('#vehicle_height').addClass('inp_error');
        err++;
    }
    
    if (err > 0) {
        $('#vehicle-action-state').removeClass('alert-success').addClass('alert-danger');
        $('#vehicle-action-state').html('Please enter/select the values in the field that are marked in red');
        $('#vehicle-action-state').show();
        return false;
    } else {
        $('#vehicle-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#vehicle-action-state').hide();
    }

    $('#form-bttons').hide();
    $('#vehicle-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#vehicle-action-state').html(loading_popup);
    $('#vehicle-action-state').show();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/add-vehicle",
        data: data,
        success: function(response) {

            if (response.status == 1) {
                $('#form-bttons').hide();
                $('#vehicle-action-state').removeClass('alert-danger');
                $('#vehicle-action-state').addClass('alert-success');
                $('#vehicle-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    cancelVehicle();
                    checkURL();
                    return;
                }, 3000);
            } else {
                $('#vehicle-action-state').addClass('alert-danger');
                $('#vehicle-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    })
}



function deleteVehicle(code) {
    event && event.stopPropagation();

    if (confirm('Do you want to delete this vehicle?')) {
        var data = _.find(allVehicleData, function(o) {
            return o.code === code;
        });
        data.activeFlag = 2;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/add-vehicle",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    $('#oz-' + response.data.code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove()
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
function editStatusVehicle(code, obj) {
    event && event.stopPropagation();

    var data = _.find(allVehicleData, function(o) {
        return o.code === code;
    });
    data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;

    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/add-vehicle",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                $(obj).attr('data-status', data.activeFlag);
                if (data.activeFlag == 0) {
                    $('#edt_sch_' + code).hide();
                    $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                    $('#oz-' + response.data.code).find('.status-label').removeClass('label-success').addClass('label-warning').html('Disabled');
                } else {
                    $('#edt_sch_' + code).show();
                    $(obj).find('.fa').removeClass('fa-check').addClass('fa-times').attr('title', 'Click to disable');//1
                    $('#oz-' + response.data.code).find('.status-label').removeClass('label-warning').addClass('label-success').html('Active');
                }
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

function resetVehicle(code){
    var data ={};
    var vehicle = _.find(allVehicleData, (o) => o.code == code) || {};
    console.log(vehicle);
    if(vehicle.lastOdometer==0){
        alert('Odometer Already Reset !!');
        return;
    }
    if (!confirm("Do you want to reset the odometer?")) {
       return
    }
    var loading_overlay = iosOverlay({
        text: "Please Wait...",
        icon: "fa fa-spinner fa-spin"
    });

    data.vehicleCode =code;
    $('.myButton').prop('disabled', true);
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/vehicle-reset",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                window.setTimeout(function() {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Done !",
                        color: '#0000'
                    });
                    checkURL();
                }, 1000);
            } 
            window.setTimeout(function() {
                loading_overlay.hide();
            }, 2000);
        }
    })
}