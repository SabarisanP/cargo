<link rel="stylesheet" href="assets/lib/magnific-popup/magnific-popup.css"> 
<div class="brand_top">
    <h3>Vehicle Attendant</h3>
    <span class="align-right">
        {if $is_super_namespace==1}<button class="btn btn-primary" onclick="importBitsAttendants()">Import Bits Attendants</button>{/if}
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showAttendantDialog();">Add Attendant</a>
    </span>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12">
                <!-- PAGE HEADER-->
                <div class="row">
                    <div style="clear: both;"></div><br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <ul class="user_list">
                                        <li class="bold no-wrap">
                                            <span class="col-xs-1">Name</span>
                                            <span class="col-xs-1">Age</span>
                                            <span class="col-xs-1">Mobile No</span>
                                            <span class="col-xs-2">Emergency / Alternate Mobile</span>
                                            <span class="col-xs-1">Join Date</span>
                                            <span class="col-xs-3">Address</span>
                                            <span class="col-xs-2">Remarks</span>
                                            <span class="col-xs-1"></span>
                                        </li>
                                        {foreach item=row from=$attendant}
                                            <li id="attendant-{$row->code}" class="no-wrap" data-att-mobile="{$row->mobile}">
                                                <span class="col-xs-1 rt_23">{$row->name}</span>
                                                <span class="col-xs-1 rt_23">{$row->age}</span>
                                                <span class="col-xs-1 rt_23">{$row->mobile}</span>
                                                <span class="col-xs-2 rt_23">{$row->alternateMobile}</span>
                                                <span class="col-xs-1 rt_23">{$row->joiningDate|date_format:$ns_date_format}</span>
                                                <span class="col-xs-3 rt_23">{$row->address}</span>
                                                <span class="col-xs-2 rt_23">{$row->remarks}</span>
                                                <span class="col-xs-1 rt_23">
                                                    {*<span class="sp_action">
                                                    <a href="javascript:;" onclick="editAttendantMode('{$row->code}', {if $row->activeFlag == 1}0{else}9{/if});">
                                                    {if $row->activeFlag==1}
                                                    <i class="fa fa-times fa-lg" title="Click to disable"></i>
                                                    {else}
                                                    <i class="fa fa-check fa-lg" title="Click to enable"></i>
                                                    {/if}
                                                    </a>
                                                    </span>*}
                                                    {if $row->activeFlag==1}
                                                        <span class="p_l_15">
                                                            <a href="javascript:;" title="Edit" onclick="showAttendantDialog('{$row->code}');"><i class="fa fa fa-pencil fa-lg"></i></a>
                                                        </span>
                                                    {/if}
                                                    <span class="p_l_15">
                                                        <a href="javascript:;" title="Delete" onclick="editAttendantMode('{$row->code}');"><i class="fa fa-trash-o fa-lg"></i></a>
                                                    </span>
                                                </span>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="vehicle-attendant-dialog" class="hide dialog-content-page">
    <div class="col-lg-12">
        <div>
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" id="attender-details-link" href="#attender-details">Basic info</a></li>
                <li><a data-toggle="tab" id="attender-gallery-link" href="#attender-gallery" onclick="getAttenderGallery()">Photos</a></li>
            </ul>
            <div class="tab-content">
                <div id="attender-details" class="tab-pane fade in active">
                    <form role="form" class="form-horizontal">
                        <div class="col-lg-12 p_l_n p_r_n">
                            <div>
                                <label for="att-name" class="req">Name</label>
                                <input type="text" placeholder="Name" id="att-name" maxlength="30" class="form-control">
                            </div>
                        </div>
                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-6 p_l_n">
                            <div>
                                <label for="att-mob" class="req">Mobile</label>
                                <input type="tel" placeholder="Mobile" id="att-mob" class="form-control" maxlength="10">
                            </div>
                        </div>
                        <div class="col-lg-6 p_l_n p_r_n">
                            <div>
                                <label for="att-emer" class="req">Emergency / Alternate Mobile</label>
                                <input type="tel" placeholder="Alternate Mobile" id="att-emer" class="form-control" maxlength="10">
                            </div>
                        </div>
                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-6 p_l_n">
                            <div>
                                <label for="att-age" class="req">Age</label>
                                <input type="tel" placeholder="Age" id="att-age" class="form-control" maxlength="2">
                            </div>
                        </div>
                        <div class="col-lg-6 p_l_n p_r_n">
                            <div>
                                <label for="att-joining" class="req">Join Date</label>
                                <input type="text" placeholder="Joining Date" id="att-joining" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="clear_fix_both"></div> <br>
                        <div class="col-lg-6 p_l_n">
                            <div>
                                <label for="att-address" class="">Address</label>
                                <textarea id="att-address" class="form-control rs_no" maxlength="75" placeholder="Address" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="col-lg-6 p_l_n p_r_n">
                            <div>
                                <label for="att-remarks" class="">Remarks</label>
                                <textarea id="att-remarks" class="form-control rs_no" maxlength="75" placeholder="Remarks" rows="3"></textarea>
                            </div>
                        </div>

                        <div class="clear_fix_both"></div> <br>
                        <input type="hidden" id="hid-att-code">
                        <div class="alert col-md-12" style="display: none;" id="vehicle-attendant-action-state"></div>
                    </form>
                    <div class="clear_fix_both"></div>
                    <div class="clear_fix_both">
                        <div class="align-right cre_sve" id="form-bttons">
                            <button class="btn btn-success" type="button" onclick="saveVehicleAttendant();">Save</button>
                            <button class="btn btn-default" type="button" onclick="cancelVehicleAttendant();">Cancel</button>
                        </div>
                    </div>
                </div>
                <div id="attender-gallery" class="tab-pane fade">
                    <div>
                        <div class="align-center" id="user-action-status"></div>
                        <div class="row" id="gal-viw-rslt">
                            <div>
                                <div class="well well-large "> Click any of the driver name to view photos.</div>
                            </div>
                        </div>
                        <div class="clear_fix_both"></div>
                        <div class="align-right" id="form-bttons">
                            <button class="btn btn-default" type="button" onclick="cancelVehicleAttendant();">Cancel</button>
                        </div>
                        <div class="clear_fix_both"></div><br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="import-bits-attendants" class="dialog-content-page" style="display: none">
    <form class="form-horizontal " action="#">

        <div class="form-group">
            <div>
                <label class="req">Bits Attendant</label>
                <select class="form-control" id="bits-attendants" multiple style="display: none"></select>
            </div>
        </div>
       
        <div class="clear_fix_both"></div><br/>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="import-bits-attendants-state"></div>
        <div class="align-right">
            <button type="button" id="btn-save" class="btn btn-success" onclick="saveBitsAttendants()">Save</button>
            <button type="button" class="btn btn-default" onclick="cancelBitsAttendants()">Cancel</button>
        </div>
    </form>
</div>

<script>
    var vehicleAttendant = {$attendant|json_encode};
    var bitsAttendantlist = []; 

    $('#att-joining').datepicker({
        todayHighlight: true,
        endDate: '-0d',
        autoclose: true,
        format: 'yyyy-mm-dd'
    });

    $('#bits-attendants').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropLeft: true,
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        buttonClass: 'btn btn-default bits-attendants',
        buttonContainer: '<div id="bits-attendants-list-container" class="custom-cb multiselect-inline bits-attendants"></div>',
        templates: {
            button: '',
            ul: '<ul class="multiselect-container bits-attendants-list" style="width: 100%;"></ul>',
            li: '<li><label></label></li>',
        }
    });

    function showAttendantDialog(code) {
        $('.inp_error').removeClass('inp_error');
        $('#vehicle-attendant-action-state').hide();
        $('#attender-details-link').trigger('click');
        $('#vehicle-attendant-dialog').css('background', '#fff');
        $('#vehicle-attendant-dialog').removeClass('hide');
        $('#vehicle-attendant-dialog').dialog({
            autoOpen: true,
            height: 525,
            width: 550,
            modal: true,
            resizable: false
        });
        $('.ui-dialog-titlebar').hide();

        if (_isdefined(code)) {
            var data = vehicleAttendant.find(function (e) {
                return e.code == code;
            });
            $('#hid-att-code').val(data.code);
            $('#att-name').val(data.name);
            $('#att-age').val(data.age);
            $('#att-joining').val(data.joiningDate);
            $('#att-mob').val(data.mobile);
            $('#att-emer').val(data.alternateMobile);
            $('#att-address').val(data.address);
            $('#att-remarks').val(data.remarks);
            
            $('#attender-gallery-link').show();
        } else {
            $('#hid-att-code').val('');
            $('#att-name').val('');
            $('#att-age').val('');
            $('#att-joining').val('');
            $('#att-mob').val('');
            $('#att-emer').val('');
            $('#att-address').val('');
            $('#att-remarks').val('');
            
            $('#attender-gallery-link').hide();
        }
    }

    function cancelVehicleAttendant() {
        $('#vehicle-attendant-dialog').dialog('destroy');
        $('#vehicle-attendant-dialog').hide();
    }

    function saveVehicleAttendant() {
        var data = {}, err = 0;

        data.code = $.trim($('#hid-att-code').val());
        data.name = $.trim($('#att-name').val());
        data.age = $.trim($('#att-age').val());
        data.joiningDate = $.trim($('#att-joining').val());
        data.mobile = $.trim($('#att-mob').val());
        data.alternateMobile = $.trim($('#att-emer').val());
        data.address = $.trim($('#att-address').val());
        data.remarks = $.trim($('#att-remarks').val());
        data.activeFlag = 1;

        $('.inp_error').removeClass('inp_error');

        if (data.name == '') {
            $('#att-name').addClass('inp_error');
            err++;
        }
        if (data.age == '' || isNaN(data.age)) {
            $('#att-age').addClass('inp_error');
            err++;
        }
        if (data.mobile.length != 10 || isNaN(data.mobile)) {
            $('#att-mob').addClass('inp_error');
            err++;
        }
        if (data.alternateMobile.length != 10 || isNaN(data.alternateMobile)) {
            $('#att-emer').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#vehicle-attendant-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vehicle-attendant-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vehicle-attendant-action-state').show();
            return false;
        } else {
            $('#vehicle-attendant-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle-attendant-action-state').hide();
        }

        $('#vehicle-attendant-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vehicle-attendant-action-state').html(loading_popup);
        $('#vehicle-attendant-action-state').show();

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/update-vehicle-attendant',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#vehicle-attendant-action-state').removeClass('alert-danger');
                    $('#vehicle-attendant-action-state').addClass('alert-success');
                    $('#vehicle-attendant-action-state').html('Your request has been completed successfully');
                    setTimeout(function () {
                        cancelVehicleAttendant();
                        checkURL();
                    }, 3000);
                } else {
                    $('#vehicle-attendant-action-state').addClass('alert-danger');
                    $('#vehicle-attendant-action-state').html(response.errorDesc);
                }
            }
        });
    }

    function editAttendantMode(code, flag = 2) {
        var data = vehicleAttendant.find(function (e) {
            return e.code == code;
        });
        data.activeFlag = flag;

        if (flag == 2 && !confirm('Do you want to delete this Attendant?')) {
            return;
        }

        var loading_overlay = iosOverlay({
            text: 'Loading',
            icon: 'fa fa-spinner fa-spin'
        });

        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: 'config/update-vehicle-attendant',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: 'fa fa-check',
                        text: 'Success!'
                    });
                } else {
                    loading_overlay.update({
                        icon: 'fa fa-times',
                        text: 'Sorry!'
                    });
                }
                setTimeout(function () {
                    loading_overlay.hide();
                    checkURL();
                }, 2000);
            }
        });
    }

    function getAttenderGallery(loading = true) {
        var data = {};
        data.code = $('#hid-att-code').val();
        
        loading && $('#gal-viw-rslt').html(loading_small);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "config/get-attender-gallery",
            data: data,
            success: function (response) {
                if (response) {
                    $('#gal-viw-rslt').html(response);
                }
            }
        })
    }

    function importBitsAttendants() {
        $('.inp_error').removeClass('inp_error');
        $('#bits-attendants-list-container ul').html($('<li/>').html(loading_popup));
        $('#import-bits-attendants-state').hide();

        $('#import-bits-attendants').dialog({
            autoOpen: true,
            height: 500,
            width: 600,
            modal: true,
            resizable: false
        });

        $(".ui-dialog-titlebar").hide();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/import-bits-attendants",
            success: function(response) {
                if (response.status == 1) {
                    bitsAttendantlist = response.data;
                    var options = [];
                    $.each(response.data || [], function (i, v) {
                        if (!$('[data-att-mobile="' + v.mobile + '"]').length) {
                            options.push(new Option(v.name + ' (' + v.mobile + ', Age : ' + v.age + ')' , v.code));
                        }
                    });

                    if(options.length == 0) {
                        $('#bits-attendants-list-container ul').html('<li><div class="well well-large">No Attendants Found</div></li>');
                    } else {
                        $('#bits-attendants').html(options).multiselect('rebuild');
                    }
                } else {
                    $('#import-bits-attendants-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-attendants-state').html(response.errorDesc);
                    $('#import-bits-attendants-state').show();                    
                }
            }
        });
    }

    function cancelBitsAttendants() {
        $('#import-bits-attendants').dialog('destroy');
        $('#import-bits-attendants').hide();
    }

    function saveBitsAttendants() {        
        var err = 0;
        var data = {};
        data.attendantList = [];

        $.each(bitsAttendantlist || [], function (i, v) {
            if($('#bits-attendants [value="' + v.code + '"]').is(':selected')) {
                data.attendantList.push(v);
            }
        });

        $('.inp_error').removeClass('inp_error');

        if ((data.attendantList || []).length == 0) {
            $("ul.bits-attendants-list").addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#import-bits-attendants-state').removeClass('alert-success').addClass('alert-danger');
            $('#import-bits-attendants-state').html('Please enter the values in the field that are marked in red');
            $('#import-bits-attendants-state').show();
            return false;
        }
        $('#import-bits-attendants-state').removeClass('alert-success alert-danger');
        $('#import-bits-attendants-state').html(loading_popup);
        $('#import-bits-attendants-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-bits-attendants",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#import-bits-attendants-state').removeClass('alert-danger').addClass('alert-success');
                    $('#import-bits-attendants-state').show();
                    $('#import-bits-attendants-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelBitsAttendants();
                        checkURL();
                    }, 2000);
                } else {
                    $('#import-bits-attendants-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-attendants-state').html(response.errorDesc);
                    $('#import-bits-attendants-state').show();
                }
            }
        });
    }   
</script>