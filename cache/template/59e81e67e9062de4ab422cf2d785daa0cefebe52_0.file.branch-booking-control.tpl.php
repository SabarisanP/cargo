<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-31 22:19:12
  from 'E:\xampp\htdocs\cargo\application\views\site\config\branch-booking-control.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6659ff88660cc6_01839330',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '59e81e67e9062de4ab422cf2d785daa0cefebe52' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\config\\branch-booking-control.tpl',
      1 => 1717174136,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6659ff88660cc6_01839330 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3>Branch Booking Control</h3>
    <div class="text-right noprint">
        <a href="javascript:;" class="btn btn-success btn-sm" onclick="addBranchBookingControl();">Add Branch Booking Control</a>
    </div>
</div>
<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12"> <br>
                <div class="row">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="table table-responsive" style="width: 75%;">
                                    <table class="table table-bordered" id="branch-booking-control-table">
                                        <thead>
                                            <tr class="success">
                                                <td>From Branch</td>
                                                <td>To Branch</td>
                                                <td align="center">Start Date</td>
                                                <td align="center">Day of Week</td>
                                                <td></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                <tr>
                                                    <td>
                                                        <?php echo $_smarty_tpl->tpl_vars['row']->value->fromOrganization->name;?>

                                                    </td>
                                                    <td width="25%">
                                                        <a id="popup_msg" data-content='<ul class="p_l_15">
                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->toOrganizations, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                                                    <li><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
</li>
                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                            </ul>'>
                                                            <?php if ((count($_smarty_tpl->tpl_vars['row']->value->toOrganizations)) >= 1) {
echo $_smarty_tpl->tpl_vars['row']->value->toOrganizations[0]->name;
}?>
                                                            <?php if ((count($_smarty_tpl->tpl_vars['row']->value->toOrganizations)) > 1) {?><span style="cursor:pointer;" class="badge badge-secondary"><?php echo count($_smarty_tpl->tpl_vars['row']->value->toOrganizations);?>
</span><?php }?>
                                                        </a>
                                                    </td>
                                                    <td align="center"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->startDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                                    <td align="center">
                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->dayOfWeek == 'ALRNATE') {?>
                                                            <span class="badge badge-primary">Alternate</span>
                                                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->dayOfWeek != '') {?>
                                                            <?php $_smarty_tpl->_assignInScope('bday', $_smarty_tpl->tpl_vars['row']->value->dayOfWeek);?> 
                                                            <div class="btn-group btn-group-days-display">
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,0,1) == 1) {?>active<?php }?>">S</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,1,1) == 1) {?>active<?php }?>">M</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,2,1) == 1) {?>active<?php }?>">T</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,3,1) == 1) {?>active<?php }?>">W</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,4,1) == 1) {?>active<?php }?>">T</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,5,1) == 1) {?>active<?php }?>">F</label>
                                                                <label class="btn btn-success-list btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['bday']->value,6) == 1) {?>active<?php }?>">S</label>
                                                            </div> 
                                                        <?php }?>
                                                    </td>
                                                    <td>
                                                        <a href="javascript:;" class="btn btn-default btn-sm-not" title="Edit" onclick='addBranchBookingControl("<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
")'><i class="fa fa-pencil"></i></a>
                                                        <a href="javascript:;" class="btn btn-default btn-sm-not" title="Delete" onclick='deleteBranchBookingControl("<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
")'><i class="fa fa-trash-o"></i></a>
                                                    </td>
                                                </tr>
                                            <?php
}
} else {
?>
                                                <tr>
                                                    <td colspan="5" align="center">No data found</td>
                                                </tr>
                                            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="add-branch-booking-control-dialog" class="dialog-content-page hide">
    <div>
        <div class="row">
            <div class="col-md-4">
                <div class="form-group">
                    <label class="req" for="branch-booking-control-frombranch">From Branch</label>
                    <select id="branch-booking-control-frombranch" class="form-control">                                                                    
                        <option value="">Select a Branch</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchRoutes']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>     
                </div>
            </div>

            <div class="col-md-4">
                <div class="form-group">
                    <label class="req" for="branch-booking-control-tobranch">To Branch</label>
                    <select id="branch-booking-control-tobranch" class="form-control" multiple>                                                                    
                        <option value="">Select a Branch</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchRoutes']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>     
                </div>
            </div>

            <div class="col-md-4">	    
                <div class="form-group">	    
                    <label for="branch-booking-control-startdate" class="req">Start Date</label>
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        <input type="text" name="startDate" id="branch-booking-control-startdate" class="form-control" readonly="true" value="">
                    </div>
                </div>
            </div>
            <div class="clear_fix_both"></div>
            
            <div class="col-md-4">
                <div class="form-group">
                    <label class="" for="day-of-week-type">&nbsp;</label>
                    <div class="input-group">
                        <label class="radio-inline">
                            <input type="radio" name="optradio" class="day-of-week-type" value="ALT" checked>Alternate&nbsp;
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="optradio" class="day-of-week-type" value="DOW">Day of Week&nbsp;
                        </label>
                    </div>
                </div>
            </div>

            <div class="col-md-4 hide" id="DOW-weekdays">
                <div class="form-group">
                    <label>Day of Week</label>
                    <div class="btn-group btn-group-days" id="branch-booking-control-weekdays"  data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="branchBookingControl-weekdays" value="1">S</label>
                    </div> 
                </div>
            </div>
        </div>
        <br>

        <div class="row">
            <div class="col-md-12"> 
                <input type="hidden" id="branch-booking-control-code" value="">
                <div class="clear_fix_both">                       
                    <div class="alert" id="branch-booking-control-action-state" style="display: none;"></div>
                    <div class="align-right" id="branch-booking-control-form-buttons">                    
                        <button class="btn btn-success" type="button" onclick="updateBranchBookingControl();">Save</button>
                        <button class="btn btn-default" type="button" onclick="closeBranchBookingControl();">Cancel</button>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</div>

<iframe name="ifrm_balance_sheet" id="ifrm_balance_sheet" style="display:none"></iframe>

<?php echo '<script'; ?>
>
    var branchBookingControlData = <?php echo json_encode($_smarty_tpl->tpl_vars['result']->value);?>
;
    var branchRoutesData = <?php echo json_encode($_smarty_tpl->tpl_vars['branchRoutes']->value);?>
;
    
    $('a[id=popup_msg]').attr('data-toggle', 'popover');
    $('[data-toggle="popover"]').popover({
        placement: 'center',
        html: true,
        trigger: 'hover'
    });

    $('#branch-booking-control-startdate').datepicker({
        format: 'dd-mm-yyyy',
        autoclose: true,
        changeMonth: true,
        todayHighlight: true
    });
    
    $('#branch-booking-control-frombranch').select2();

    $('#branch-booking-control-tobranch').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default branch-booking-control-tobranch',
    });

    $('#branch-booking-control-frombranch').on('change', function() {
        var fromBranch = $(this).val();
        var options = [];
        options.push(new Option('Select To Branch', ''));
        $.each(branchRoutesData || [], function (i, v) {
            if (v.code != fromBranch) {
                options.push(new Option(v.name, v.code));
            }
        });
        $('#branch-booking-control-tobranch').html(options).multiselect('rebuild');
    });

    $('#day-close-setting-hour').select2();
    if (isNotNull(branchBookingControlData)) {
        $('#branch-booking-control-table').dataTable();
    }

    $('.day-of-week-type').on('change', function() {
        $('#DOW-weekdays').addClass('hide');
        $('#branch-booking-control-weekdays').find('input[name="branchBookingControl-weekdays"]').each(function (i) {
            $(this).attr('checked', true);
            $(this).parent().addClass('active');
        });
        if ($(this).val() == "DOW") {
            $('#DOW-weekdays').removeClass('hide');
        }
    })

    function addBranchBookingControl(code) {
        $('#add-branch-booking-control-dialog').css('background', '#fff');
        $('#add-branch-booking-control-dialog').removeClass('hide');
        $('#add-branch-booking-control-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: $(window).width() - 750,
            modal: true,
            resizable: false,
            closeOnEscape: true
        });
        $('.ui-dialog-titlebar').hide();
        $('.inp_error').removeClass('inp_error');
        $('#branch-booking-control-action-state').removeClass('alert-success, alert-danger').html('').hide();

        $('.day-of-week-type[value=ALT]').prop('checked', true).trigger('change');
        $('#branch-booking-control-code, #branch-booking-control-startdate').val('');
        $('#branch-booking-control-frombranch').val('').trigger('change');
        $('#branch-booking-control-weekdays').find('input[name="branchBookingControl-weekdays"]').each(function (i) {
            $(this).attr('checked', true);
            $(this).parent().addClass('active');
        });
        
        if (isNotNull(code)) {
            var data = _.find(branchBookingControlData, function(o) {
                return o.code === code;
            });
            
            $('#branch-booking-control-code').val(code);

            if (data.dayOfWeek == "ALRNATE") {
                $('.day-of-week-type[value=ALT]').prop('checked', true).trigger('change'); 
            } else {
                $('.day-of-week-type[value=DOW]').prop('checked', true).trigger('change'); 
                
                var str = data.dayOfWeek;
                var res = str.split("");
                $("input[name='branchBookingControl-weekdays']").each(function(i) {
                    if (res[i] == 1) {
                        $(this).attr("checked", true);
                        $(this).parent().addClass('active');
                    } else {
                        $(this).attr('checked', false);
                        $(this).parent().removeClass('active');
                    }
                });
            }
            $('#branch-booking-control-startdate').val(data.startDate);
            $('#branch-booking-control-frombranch').val(data.fromOrganization.code).trigger('change');
            
            $('#branch-booking-control-tobranch').val(data.toOrganizations.map(function(val){
                return val.code;
            })).multiselect('refresh');
        }
    }

    function closeBranchBookingControl() {
        $('#add-branch-booking-control-dialog').addClass('hide');
        $('#add-branch-booking-control-dialog').dialog('destroy');
    }

    function updateBranchBookingControl() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        var data = {};
        data.code = $('#branch-booking-control-code').val();
        data.activeFlag = 1;

        data.startDate = $('#branch-booking-control-startdate').val();

        var type = $('.day-of-week-type:checked').val();
        if (type == 'DOW') {
            data.dayOfWeek = $("input[name='branchBookingControl-weekdays']").map(function () {
                return + $(this).is(':checked');
            }).get().join(''); 
        } else {
            data.dayOfWeek = 'ALRNATE';
        }

        data.fromOrganization = {};
        data.fromOrganization.code = $('#branch-booking-control-frombranch').val();

        var toOrganizations = $('#branch-booking-control-tobranch').val() || [];
        data.toOrganizations = $.map(toOrganizations, function(val) {
            return { code: val };
        });

        if (toOrganizations.length == 0) {
            $('.branch-booking-control-tobranch').addClass('inp_error');
            err++;
        }

        if (isNull(data.fromOrganization.code)) {
            $('#branch-booking-control-frombranch').addClass('inp_error');
            err++;
        }

        if (isNull(data.startDate)) {
            $('#branch-booking-control-startdate').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#branch-booking-control-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#branch-booking-control-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#branch-booking-control-action-state').show();
            return false;
        }
        
        $('#branch-booking-control-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#branch-booking-control-action-state').html(loading_popup).show();
        
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: base_url + 'config/update-branch-booking-control',
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#branch-booking-control-action-state').removeClass('alert-danger');
                    $('#branch-booking-control-action-state').addClass('alert-success');
                    $('#branch-booking-control-action-state').html('Your request has been completed successfully').show();
                    window.setTimeout(function() {
                        closeBranchBookingControl();
                        checkURL();
                    }, 3000);
                } else {
                    $('#branch-booking-control-action-state').addClass('alert-danger');
                    $('#branch-booking-control-action-state').html(response.errorDesc).show();
                }
            }
        });
    }

    function deleteBranchBookingControl(code) {
        if(confirm('Do you want to delete this Branch Booking Control entry?')) {
            var data = _.find(branchBookingControlData, function(o) {
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
                url: base_url + "config/update-branch-booking-control",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
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
                    window.setTimeout(function () {
                        loading_overlay.hide();
                        checkURL();
                    }, 2000);
                }
            });  
        } 
    }
<?php echo '</script'; ?>
><?php }
}
