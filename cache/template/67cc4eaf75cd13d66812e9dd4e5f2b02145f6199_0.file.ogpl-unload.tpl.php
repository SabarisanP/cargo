<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-27 18:24:24
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-unload.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665482802aa286_92124301',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '67cc4eaf75cd13d66812e9dd4e5f2b02145f6199' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-unload.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665482802aa286_92124301 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3>Unload <?php echo lang('ogpl');?>
</h3>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Unload the transit / dispatch list received for delivery.                 
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">                                        
                                        <div class="">
                                            <div id="search-panel">                                         

                                                <form id="ogpl_form" method="post" name="ogpl_form" action="" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="ogpl_from" readonly placeholder="Date From" value="<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ffromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="ogpl_to" readonly placeholder="Date To" value="<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ftoDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ogpl-vehicle" name="vehicleCode" class="form-control">
                                                                    <option value="" selected="">All Vehicle</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vehicles']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->activeFlag == 1) {?>
                                                                            <option <?php if ($_smarty_tpl->tpl_vars['fvehicle']->value == $_smarty_tpl->tpl_vars['row']->value->code) {?> selected="selected" <?php }?> value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->registationNumber;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleType->name;?>
</option>
                                                                        <?php }?>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['OGPL-UNL-ALLBRNC'] > 0) {?>
                                                            <div class="form-group col-md-2">
                                                                <label  for="rev_rpt_date_to">Branch</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="ogpl-organization" name="organizationCode"  class="form-control select2" >
                                                                        <option value='NA' selected="">All Branch</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch', false, 'bcode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bcode']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['bcode']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>      
                                                                </div>
                                                            </div> 
                                                        <?php }?>

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl_alias_code"><?php echo lang('ogpl');?>
 Number</label>
                                                            <input type="text" name="aliasCode" class="form-control sdate initialism" id="ogpl_alias_code" placeholder="<?php echo lang('ogpl');?>
 Number" value="<?php echo $_smarty_tpl->tpl_vars['faliasode']->value;?>
">
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getOgplList();">Get <?php echo lang('ogpl');?>
</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearOgplList();">Clear</button>
                                                            </div>
                                                        </div>

                                                    </div>  
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="ogpl_cargo_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="find-uncargo-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="find-uncargo-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<iframe name="ifrm_ogpl_lr_downloader" id="ifrm_ogpl_lr_downloader" style="display:none"></iframe>  

<?php echo '<script'; ?>
>
    $('#ogpl_from').datepicker({
        //todayHighlight: true,
        format: 'dd-mm-yyyy',
        startDate: '-6m',
        endDate: "0D",
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#ogpl_to').datepicker('setStartDate', e.date);
        $("#ogpl_to").datepicker("setEndDate", end);
    });
    
    $('#ogpl_to').datepicker({
        //todayHighlight: true,
        startDate: '-3m',
        endDate: "0D",
        format: 'dd-mm-yyyy',
        autoclose: true
    }).on('changeDate', function (e) {
        $('#ogpl_from').datepicker('setEndDate', e.date);
    });

    if ($('#ogpl_from').val() == '' && $('#ogpl_to').val() == '') {
        $('#ogpl_to').datepicker('setDate', '0d');
        $('#ogpl_from').datepicker('setDate', '-3m');
    }
    
    if ($('#ogpl_from').val() != '' && $('#ogpl_to').val() != '') {
        getOgplList();
    }
    
    $('#ogpl-vehicle').select2();
    $('#ogpl-organization').select2();

    function getOgplList() {
        var data = {};
        data.fromDate = $('#ogpl_from').val();
        data.toDate = $('#ogpl_to').val();
        data.vehicleCode = $('#ogpl-vehicle').val();
        data.organizationCode = $('#ogpl-organization').val();
        data.aliasCode = $('#ogpl_alias_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if(data.aliasCode == '') {
            if ($('#ogpl_from').val() == '') {
                $('#ogpl_from').addClass('inp_error');
                err++;
            }            
        }
        
        if (data.fromDate != '') {
            if (data.toDate == '') {
                $('#ogpl_to').removeClass('inp_error');

                var output = moment(data.fromDate, 'DD-MM-YYYY').add(1, 'month').format('DD-MM-YYYY');
                                   
                data.toDate = output;
                $('#ogpl_to').val(output);                
            }
        }

        // if (data.fromDate != '' && data.toDate != '') {
        //     var a = moment(data.fromDate, 'DD-MM-YYYY');
        //     var b = moment(data.toDate, 'DD-MM-YYYY');
        //     var t = b.diff(a, 'days');
        //     if (t > 31) {
        //         $('#ogpl_to').addClass('inp_error');
        //         $('#ogpl_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
        //         $('#ogpl_cargo_action_state').html('Date range should be 31 days or less');
        //         $('#ogpl_cargo_action_state').show();
        //         err++;
        //         return false;
        //     }
        // }

        if (err > 0) {
            $('#ogpl_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#ogpl_cargo_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#ogpl_cargo_action_state').show();
            return false;
        } else {
            $('#ogpl_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#ogpl_cargo_action_state').html('');
            $('#ogpl_cargo_action_state').hide();
        }

        $('#find-uncargo-list-container ').removeClass('hidden');
        $('#find-uncargo-list').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/ogpl-unload-list",
            data: data,
            dataType: 'html',
            success: function (response) {
                $('#find-uncargo-list').html(response);
                $('#download-lr-btn').toggle($('#ogpl-trip-table-list table').length != 0);
                $("html, body").animate({
                    scrollTop: $('#find-uncargo-list-container').offset().top - 35
                }, "slow");
            }
        });
    }

    function clearOgplList() {
        $('#ogpl_from').val('');
        $('#ogpl_to').val('');
        $('#ogpl-vehicle').val('').trigger('change');
        $('#ogpl-organization').val('NA').trigger('change');
        $('#ogpl_alias_code').val('');
        $('.inp_error').removeClass('inp_error');
        $('#find-uncargo-list-container ').addClass('hidden');
        $('#find-uncargo-list').html('');
        $('#ogpl_cargo_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#ogpl_cargo_action_state').html('');
        $('#ogpl_cargo_action_state').hide();
        $('#download-lr-btn').hide();
    }

    function downloadOGPLLR() {
        document.ogpl_form.target = "ifrm_ogpl_lr_downloader";
        document.ogpl_form.action = "cargo/export-ogpl-lr-list"
        $('#export').val(1);
        document.ogpl_form.submit();
        return;
    }
<?php echo '</script'; ?>
><?php }
}
