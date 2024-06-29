<div class="brand_top">
    <h3>BusBuddy Devices</h3>
    <span class="align-rights">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="generateExchangeToken();">XCH Token</a>
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="newDevice('');">Register New</a>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div style="clear: both;"></div><br>
                <div class="col-lg-6 col-lg-offset-3">

                    <div class="todo_section panel panel-default">
                        <div class="todo_date row">
                            <div class="col-md-9">
                                <h4>Active Devices</h4>
                            </div>
                            <div class="col-md-3">
                                <input type="search" class="form-control pull-right" id="search-box" maxlength="10" placeholder="Search" onkeyup="filterDevices(this);"/>
                            </div>
                        </div>
                        <ul class="todo_list_wrapper">

                            {foreach name=o item=row from=$active_tabs->data}
                                <li>
                                    <div class="row">
                                        <div class="col-lg-1">{$smarty.foreach.o.index+1}</div>
                                        <div class="col-lg-3 dev-name" title="{$row->code}">{$row->name}{if $row->mobileNumber > 0}<br/><span class="text-primary">{$row->mobileNumber}</span>{/if}</div>
                                        <div class="col-lg-2 dev-reg" title="{$row->busVehicle->code}">{$row->busVehicle->registationNumber}</div>
                                        <div class="col-lg-2">
                                            {if $row->activeFlag==1}
                                                <span class="label label-success">Active</span>
                                            {else}
                                                <span class="label label-danger">Active</span>
                                            {/if}
                                            <br/>
                                        </div>
                                        
                                        <div class="col-lg-4">
                                            <div class="btn-group btn-group-xs">                                                
                                                <a href="javascript:;" class="btn btn-default btn-sm" onclick='newDevice({$row|@json_encode})'>
                                                    <i class="fa fa-edit" id="" data-status="0" title="Edit"></i>
                                                </a>
                                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="deRegisterTab('{$row->code}')">
                                                    <i class="fa fa-repeat" id="" data-status="0" title="Unregister"></i>
                                                </a>
                                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="mapVehicle('{$row->code}', '{$row->name}', '{$row->busVehicle->registationNumber}')">
                                                    <i class="fa fa-bus" id="" data-status="0" title="Update Vehicle"></i>
                                                </a>
                                                <a href="javascript:;" class="btn btn-default btn-sm" {if $row->mobileVerifyFlag==1}style="color:green"{else}style="color:tomato"{/if} onclick="generateOtp('{$row->code}')">
                                                    <i class="fa fa-mobile" id="" data-status="0" {if $row->mobileVerifyFlag==1}title="verified"{else}title="Verify Mobile Number"{/if}></i>
                                                </a>    
                                                <a href="javascript:;" class="btn btn-default btn-sm" title="delete" onclick="deleteTab('{$row->code}')">
                                                    <i class="fa fa-trash-o"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {/foreach}

                        </ul>
                    </div>
                    <br>

                    <div class="todo_section panel panel-default">
                            <div class="todo_date">
                                <h4>Pending Devices</h4>
                            </div>
                            <ul class="todo_list_wrapper">

                                {foreach name=o item=row from=$pending->data}
                                    <li>
                                    <div class="row">
                                        <div class="col-lg-3">{$row->user->name}</div>
                                        <div class="col-lg-3">
                                            <div class="btn-group btn-group-xs">
                                                <a href="javascript:;" class="btn btn-default btn-sm" title="generate authorize pin" onclick="generatePin('{$row->code}');">
                                                    <i class="fa fa-send"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    </li>
                                {/foreach}

                            </ul>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div><!--panel Body end-->

<div id="device-dialog" class="hide dialog-content-page" >
    <form role="form" class="form-horizontal">
        <div class="row">
            <label class="col-sm-2 control-label" for="txt_am_name">Name<span class="required">*</span></label>
            <div class="col-sm-10">
                <input type="text" placeholder="Name" id="txt_am_name" class="form-control" maxlength="40">
            </div>
        </div>
        <br>
        <div class="row">
            <label class="col-sm-2 control-label" for="txt_am_mobile">Mobile Number<span class="required">*</span></label>
            <div class="col-sm-10">
                <input type="text" placeholder="Mobile Number" maxlength="10" id="txt_am_mobile" class="form-control">
            </div>
        </div>
        <br>
        <div class="row">
            <div class="align-center alert alert-danger col-sm-12" style="display:none" id="usr-action-state"></div>
        </div>
        <br>
        <div class="row">
            <div class="text-right col-sm-12" id="amt-form-bttons">
                <button class="btn btn-success" type="button" onclick="saveDevice();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelDevice();">Cancel</button>
            </div>
        </div>
    </form>
</div>

<div id="generate-pin-dialog" class="hide dialog-content-page" >

    <div id="pin-panel">
        <div class="row">
            <div class="col-md-12 text-right">
                <a title="close" href="javascript:;" class="btn-lg" onclick="closePinPopup(); " style="position:relative;"> <i class="fa fa-times-circle fa-lg"></i> </a>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-12 text-center">Enter this code in to your device to activate.</div>
        </div>
        <br>

        <div class="row" style="padding-top: 10px;">
            <div class="col-md-12 text-center" id="pin">
                <h2>9089</h2>
            </div>
        </div>
        <br>

        <div class="row">
            <div class="col-md-12 text-right">Click "Next" button once the device activated.</div>
        </div>
        <div class="row">
            <div class="col-md-12 text-right">
                <button class="btn btn-success" type="button" onclick="toFleetPanel();">Next</button>
            </div>
        </div>
    </div>

    <div id="fleet-panel" class="hide">
        <form role="form" class="form-horizontal">
            <div class="row">
                <div class="col-md-12 text-right">
                    <a title="close" href="javascript:;" class="btn-lg" onclick="closePinPopup(); " style="position:relative;"> <i class="fa fa-times-circle fa-lg"></i> </a>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-12 text-center bold">Select a vehicle - <span id="vehiclefor"></span></div>
            </div>
            <br>

            <div class="row">
                <div class="col-md-12 text-center" id="vehicle-pane">
                </div>
            </div>
            <br>

            <div class="row">
                <div class="text-right alert alert-danger col-sm-12" style="display:none" id="flt-action-state"></div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-12 text-right" id="flt-form-bttons">
                    <button class="btn btn-success" type="button" onclick="saveDeviceVehicle();">Save</button>
                </div>
            </div>
        </form>
    </div>

</div>

<div id="generate-otp-dialog" class="hide dialog-content-page">
    <form role="form" id="generate-otp-form" class="form-horizontal">
        <div class="row">
            <div class="align-center alert alert-danger col-sm-12" style="display:none" id="pob-otp-action-state"></div>
        </div>
        <br>
        <div class="row">
            <div class="text-right col-sm-12" id="pob-otp-btns">
                <button class="btn btn-default" type="button" onclick="closePobOtp();">Cancel</button>
            </div>
        </div>
    </form>
    <div id="view-otp-form" style="display:none">
        <br/><br/>
        <div class="row">
            <div class="col-md-12 text-center">Exchange Token.</div>
        </div>
        <br>
        <div class="row" style="padding-top: 10px;">
            <div class="col-md-12 text-center">
                <h2 id="pob-otp-code"></h2>
            </div>
        </div>
        <div class="row">
            <div class="text-right col-sm-12">
                <button class="btn btn-default" type="button" onclick="closePobOtp();">Close</button>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="hid_device_id" value="" />
<input type="hidden" id="hid_device_code" value="" />

<script>
    var active_tabs = {$active_tabs->data|json_encode};
    var registered_pob = {$registered_pob|json_encode};
    $.ui.dialog.prototype._allowInteraction = function(e) {
        return !!$(e.target).closest('.ui-dialog, .ui-datepicker, .select2-drop').length;
    };
    function newDevice(code){
        
        $('#txt_am_name').removeClass('inp_error');
        $('#txt_am_mobile').removeClass('inp_error');
        $('#device-dialog').css('background', '#fff');
        $('#amt-form-bttons').show();
        $('#device-dialog').show();
        $('#device-dialog').removeClass('hide');
        

        $('#device-dialog').dialog({
            autoOpen: true,
            width: 600,
            maxWidth: 600,
            height: 300,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();

        $('#amt-form-bttons').show();
        $('#device-dialog').show();
        $('#device-dialog').removeClass('hide');
        $('#usr-action-state').html('');
        $('#usr-action-state').hide();
        
        if(code == ""){
         $('#txt_am_name').val('');
        $('#txt_am_mobile').val('');
        }
        else{
        //console.log("edit");
        $('#txt_am_name').val(code.name);
        $('#txt_am_mobile').val(code.mobileNumber);
        $('#hid_device_code').val(code.code);
        
        }
        
    }

    function deleteTab(code) {
        var obj = _.find(active_tabs, function(o) { return o.code == code; });
        obj.activeFlag = 2;
        if (confirm('Do you want to delete this device?')) {
            var data = {}
            data.device = obj;
            var loading_overlay = iosOverlay({
                text: "Deleting...",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/delete-pob-device",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function () {
                            checkURL();
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

    function saveDevice() {
        var data = {};
        data.name = $('#txt_am_name').val();
        data.mobileNumber = $('#txt_am_mobile').val();
        data.code = $('#hid_device_code').val();
        
        var err = 0;
        if (data.name == '') {
            $('#txt_am_name').addClass('inp_error');
            err++;
        } else {
            $('#txt_am_name').removeClass('inp_error');
        }
        if (data.mobileNumber == '') {
            $('#txt_am_mobile').addClass('inp_error');
            err++;
        } else {
            $('#txt_am_mobile').removeClass('inp_error');
        }

        if (err > 0) {
            $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#usr-action-state').html('Please enter the values in the field that are marked in red');
            $('#usr-action-state').show();
            return false;
        } else {
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
        }


        $('#amt-form-bttons').hide();
        $('#usr-action-state').html(loading_popup);
        $('#usr-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-pob-device",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('.er_msg').addClass('hide');
                    $('#usr-action-state').show();
                    $('#usr-action-state').removeClass('alert-danger');
                    $('#usr-action-state').addClass('alert-success');

                    $('#usr-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelDevice();
                        checkURL();
                    }, 3000);
                } else {
                    $('#usr-action-state').show();
                    $('#usr-action-state').addClass('alert-error');
                    $('#usr-action-state').html(response.errorDesc);
                    $('#amt-form-bttons').show();
                    window.setTimeout(function() {
                        $('#usr-action-state').hide();
                        $('#amt-form-bttons').show();
                    }, 3000);
                }
            }
        });
    }
    function cancelDevice() {
        $('#usr-action-state').hide();
        $('#device-dialog').dialog('destroy');
        $('#device-dialog').hide();
    }
    function closeGenerate() {
        $('#device-dialog').dialog('destroy');
        $('#device-dialog').hide();
    }
    function closePinPopup() {
        $('#generate-pin-dialog').dialog('destroy');
        $('#generate-pin-dialog').hide();
    }

    function generatePin(code) {
        $('#generate-pin-dialog').css('background', '#fff');
        $('#generate-pin-dialog').show();
        $('#generate-pin-dialog').removeClass('hide');

        $('#generate-pin-dialog').dialog({
            autoOpen: true,
            width: 500,
            maxWidth: 500,
            height: 300,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();

        $('#pin').html(loading_popup);
        $('#hid_device_id').val(code);
        var data = {};
        data.device = code;

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/generate-pin",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#pin').html('<h2>'+response.data.code+'</h2>');
                }
            }
        });
    }

    function mapVehicle(code, dname, regno) {
        $('#pin-panel').removeClass('hide');
        $('#fleet-panel').addClass('hide');

        $('#generate-pin-dialog').css('background', '#fff');
        $('#generate-pin-dialog').show();
        $('#generate-pin-dialog').removeClass('hide');

        $('#generate-pin-dialog').dialog({
            autoOpen: true,
            width: 500,
            maxWidth: 500,
            height: 300,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();
        $('#hid_device_id').val(code);
        $('#vehiclefor').html(dname + ', ' + regno);
        toFleetPanel();
    }

    function toFleetPanel() {
        $('#pin-panel').addClass('hide');
        $('#fleet-panel').removeClass('hide');
        $("#vehicles").select2("destroy");
        $('#vehicle-pane').html(loading_popup);
        var data = {};
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/get-vehicle-list",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    var html = '<select class="form-control" id="vehicles">';
                    $.each(response.data, function (key, fleet) {
                        if(fleet.activeFlag==1) {
                            var regd = (registered_pob[fleet.registationNumber]) ? ' - ' + registered_pob[fleet.registationNumber].replace(/,\s*$/, '') : '';
                            html += '<option value="'+fleet.code+'">' + fleet.registationNumber + regd + '</option>';
                        }
                    });
                    html += '</select';
                    $('#vehicle-pane').html(html);
                    $('#vehicles').select2({
                        dropdownParent: '#generate-pin-dialog',
                        placeholder: "Select Origin",
                        escapeMarkup: function(markup) {
                            return markup;
                        }
                    });
                }
            }
        });
    }

    function saveDeviceVehicle() {
        var data = {};
        data.vehicle_id = $('#vehicles').val();
        data.device_id = $('#hid_device_id').val();

        var err = 0;
        if (data.vehicle_id == '') {
            $('#vehicles').addClass('inp_error');
            err++;
        } else {
            $('#txt_am_name').removeClass('inp_error');
        }

        if (err > 0) {
            $('#flt-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#flt-action-state').html('Please enter the values in the field that are marked in red');
            $('#flt-action-state').show();
            return false;
        } else {
            $('#flt-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#flt-action-state').html('');
            $('#flt-action-state').hide();
        }


        $('#flt-form-bttons').hide();
        $('#flt-action-state').html(loading_popup);
        $('#flt-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-device-vehicle",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('.er_msg').addClass('hide');
                    $('#flt-action-state').show();
                    $('#flt-action-state').removeClass('alert-danger');
                    $('#flt-action-state').addClass('alert-success');

                    $('#flt-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        closePinPopup();
                        checkURL();
                    }, 3000);
                } else {
                    $('#flt-action-state').show();
                    $('#flt-action-state').addClass('alert-error');
                    $('#flt-action-state').html(response.errorDesc);
                    $('#flt-form-bttons').show();
                    window.setTimeout(function() {
                        $('#flt-action-state').hide();
                        $('#flt-form-bttons').show();
                    }, 3000);
                }
            }
        })
    }

    function deRegisterTab(code){
        if(!confirm('Do you want to unregister this device?')) return;
        var data = {};
        data.tabletCode = code;

        var loading_overlay = iosOverlay({
            text: "Unregistering...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/deregister-pob-device",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    window.setTimeout(function () {
                        checkURL();
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

    function filterDevices(ele){
        var value = $.trim($(ele).val());
        $('ul.todo_list_wrapper li').each(function(i, li) {
            var $li =  $(li);
            if ($li.find('.dev-name').text().search(new RegExp(value, 'i')) > -1 ||
                $li.find('.dev-reg').text().search(new RegExp(value, 'i')) > -1) {
                $li.show();
            } else {
                $li.hide();
            }
        });
    }

    function generatePobOtp() {
        
    }

    function closePobOtp() {
        $('#generate-otp-dialog').dialog('destroy');
        $('#generate-otp-dialog').hide();
    }

    function getPobOtp() {
        var data = {};
        data.mobileNumber = $('#pob-otp-mob').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.mobileNumber.length != 10 || isNaN(data.mobileNumber)) {
            $('#pob-otp-mob').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#pob-otp-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#pob-otp-action-state').html('Please enter the values in the field that are marked in red');
            $('#pob-otp-action-state').show();
            return false;
        } else {
            $('#pob-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#pob-otp-action-state').html('');
            $('#pob-otp-action-state').hide();
        }

        $('#pob-otp-btns').hide();
        $('#pob-otp-action-state').html(loading_popup);
        $('#pob-otp-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/get-pob-otp",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('.er_msg').addClass('hide');
                    $('#pob-otp-action-state').show();
                    $('#pob-otp-action-state').removeClass('alert-danger');
                    $('#pob-otp-action-state').addClass('alert-success');

                    $('#pob-otp-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        $('#view-otp-form').show();
                        $('#generate-otp-form').hide();
                        $('#pob-otp-code').html(response.data.code);
                    }, 500);
                } else {
                    $('#pob-otp-action-state').show();
                    $('#pob-otp-action-state').addClass('alert-error');
                    $('#pob-otp-action-state').html(response.errorDesc);
                    $('#pob-otp-btns').show();
                    window.setTimeout(function() {
                        $('#pob-otp-action-state').hide();
                        $('#pob-otp-btns').show();
                    }, 3000);
                }
            }
        });
    }
    
    function generateOtp(code){
        var data = {}
            data.code = code;
            var loading_overlay = iosOverlay({
                text: "Verifying...",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/generate-otp",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        window.setTimeout(function () {
                            checkURL();
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
        
    function generateExchangeToken(code) {
        var data = {};
            
        $('#view-otp-form').hide();
        $('#generate-otp-form').show();

        $('#pob-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#pob-otp-action-state').html('');
        $('#pob-otp-action-state').hide();
        $('#pob-otp-btns').show();

        $('#generate-otp-dialog').css('background', '#fff');
        $('#generate-otp-dialog').show();
        $('#generate-otp-dialog').removeClass('hide');
        $('#generate-otp-dialog').dialog({
            autoOpen: true,
            width: 500,
            maxWidth: 600,
            height: 300,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();
        
        $('#pob-otp-btns').hide();
        $('#pob-otp-action-state').html(loading_popup);
        $('#pob-otp-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/generate-pob-exchange-token",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('.er_msg').addClass('hide');
                    $('#pob-otp-action-state').show();
                    $('#pob-otp-action-state').removeClass('alert-danger');
                    $('#pob-otp-action-state').addClass('alert-success');

                    $('#view-otp-form').show();
                    $('#generate-otp-form').hide();
                    $('#pob-otp-code').html(response.data.slug);
                } else {
                    $('#pob-otp-action-state').show();
                    $('#pob-otp-action-state').addClass('alert-error');
                    $('#pob-otp-action-state').html(response.errorDesc);
                    $('#pob-otp-btns').show();
                    window.setTimeout(function() {
                        $('#pob-otp-action-state').hide();
                        $('#pob-otp-btns').show();
                    }, 3000);
                }
            }
        });
    }   
   
</script>