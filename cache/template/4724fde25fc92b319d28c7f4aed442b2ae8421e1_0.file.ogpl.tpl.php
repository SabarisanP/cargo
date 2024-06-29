<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:42:40
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e3c8ad81b9_14052004',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4724fde25fc92b319d28c7f4aed442b2ae8421e1' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e3c8ad81b9_14052004 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3>Transit / Dispatch</h3>
    <div class="align-right noprint">
        <a href="#cargo/ogpl-loading-sheet" class="btn btn-success  btn-sm"><?php echo lang('loading_sheet');?>
</a>
    	<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['OGPL-DNLD-LR'] > 0) {?>
        <a href="javascript:;" id="download-lr-btn" class="btn btn-primary btn-sm" onclick="downloadOGPLLR();" style="display: none;">Download <?php echo lang('lr');?>
</a>
        <?php }?>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Transit / Dispatch the goods to destination.                 
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
                            <div class="panel panel-default p-0">
                                <div class="clearfix">
                                    <div class="col-md-10">                                        
                                        <div class="panel-body">
                                            <div id="search-panel" class="p-y-10">                                         

                                                <form id="ogpl_form" method="post" name="ogpl_form" action="" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-3">
                                                            <label for="ogpl_range">Date Range</label>
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                <input type="text" name="fromDate" class="form-control sdate" id="ogpl_range" readonly placeholder="Date Range" value="<?php echo implode(' | ',array_filter(array(smarty_modifier_date_format($_smarty_tpl->tpl_vars['ffromDate']->value,'%d-%m-%Y'),smarty_modifier_date_format($_smarty_tpl->tpl_vars['ftoDate']->value,'%d-%m-%Y'))));?>
">
                                                            </div>
                                                        </div>
                                                                
                                                        <div class="form-group col-md-3">
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

                                                        <div class="form-group col-md-3">
                                                            <label for="ogpl_alias_code">Transit Number</label>
                                                            <input type="text" name="aliasCode" class="form-control sdate initialism" id="ogpl_alias_code" placeholder="Transit Number" value="<?php echo $_smarty_tpl->tpl_vars['faliasode']->value;?>
">
                                                        </div>
                                                                
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="last_active_code" id="last_active_code" value="<?php echo $_smarty_tpl->tpl_vars['flastactive']->value;?>
">
                                                                <div class="btn-group btn-group-days pull-right" id="shipment-type-btns" data-toggle="buttons" onclick="toggleOgplList();">
                                                                    <label class="btn btn-success" title="OutStation">
                                                                        <input type="radio" name="lr-shipment-type" id="outstation-shipment-cb" value="OUT" autocomplete="off" checked> OutStation
                                                                    </label>
                                                                    <label class="btn btn-success" title="Local">
                                                                        <input type="radio" name="lr-shipment-type" id="local-shipment-cb" value="LOC" autocomplete="off"> Local
                                                                    </label>
                                                                </div>
                                                                                                                            </div>
                                                        </div>

                                                    </div>  
                                                </form> 
                                            </div>
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="ogpl_cargo_action_state"></div>
                                        </div><!--row end-->
                                    </div>
                                    
                                    <div class="col-md-2 p_r_n well m-0 p-0">
                                        <div class="panel-body">
                                            <span class="col-md-12 f-15">
                                                Want to create a <br>
                                                new <b>Vehicle Transit</b>?<br>
                                                <br>
                                            </span>
                                            <a href="#cargo/add-ogpl?back=ogpl" class="btn btn-default btn-sm pull-right">Create New Transit <img src="assets/img/ogpl/v.png" width="24px"></a>
                                        </div>
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="find-uncargo-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div id="find-uncargo-list"></div>
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
    $('#ogpl_range').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        },
    }).on('show.daterangepicker', function (ev, picker) {
        picker.showCalendars()
    });
    
    $('#ogpl-vehicle').select2();

    function toggleOgplList() {
        setTimeout(getOgplList, 0);
    }

    function getOgplList() {
        var data = {};
        var daterange = $('#ogpl_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vehicleCode = $('#ogpl-vehicle').val();
        data.aliasCode = $('#ogpl_alias_code').val();
        data.lastActiveCode = $('#last_active_code').val();

        var url = 'cargo/ogpl-list';
        var type = $('[name="lr-shipment-type"]:checked').val();
        if (type == 'LOC') {
            data.transittypes = 'INTRNT';
            data.transittypeout = 'OTFD';
            url = 'cargo/local-transit-list';
        } else if (type == 'OUT') {
            data.transittypes = 'TRNT';
            data.transittypeout = 'OTFD';
            url = 'cargo/ogpl-list';
        }

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if(data.aliasCode == '') {
            if ($('#ogpl_range').val() == '') {
                // $('#ogpl_range').addClass('inp_error');
                // err++;

            }            
        }
        // if (data.fromDate != '') {
        //     if (data.toDate == '') {
        //         $('#ogpl_to').removeClass('inp_error');

        //         var output = moment(data.fromDate, 'DD-MM-YYYY').add(1, 'month').format('DD-MM-YYYY');
                                   
        //         data.toDate = output;
        //         $('#ogpl_to').val(output);                
        //     }
        // }

        if (data.fromDate != '' && data.toDate != '') {
            var a = moment(data.fromDate, 'DD-MM-YYYY');
            var b = moment(data.toDate, 'DD-MM-YYYY');
            var t = b.diff(a, 'days');
            if (t > 31) {
                $('#ogpl_to').addClass('inp_error');
                $('#ogpl_cargo_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#ogpl_cargo_action_state').html('Date range should be 31 days or less');
                $('#ogpl_cargo_action_state').show();
                // err++;
                return false;
            }
        }

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

        $('#find-uncargo-list-container').removeClass('hidden');
        $('#find-uncargo-list').html('<div class="text-center" style="padding-top:50px"><img src="'+base_url+'assets/img/loaders/20.gif" /></div>');

        $.ajax({
            type: "POST",
            url: base_url + url,
            data: data,
            dataType: 'html',
            success: function (response) {
                $('#find-uncargo-list').html(response);
                $('#last_active_code').val('');
                $('#download-lr-btn').toggle($('#ogpl-trip-list .transit-row').length != 0);
                $("html, body").animate({
                    scrollTop: $('#find-uncargo-list-container').offset().top - 35
                }, "slow");
            }
        });
    }

    function clearOgplList() {
        $('#ogpl_range').val('');
        $('#ogpl_range').data('daterangepicker').setStartDate({});
        $('#ogpl_range').data('daterangepicker').setEndDate({});
        $('#ogpl_to').val('');
        $('#ogpl-vehicle').val('').trigger('change');
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
    
    if ($('#ogpl_range').val() != '') {
        getOgplList();
    }
<?php echo '</script'; ?>
>

<link href="assets/lib/leaflet/leaflet.css" rel="stylesheet" type="text/css" media="screen">
<?php echo '<script'; ?>
 type="text/javascript" src="assets/lib/leaflet/leaflet.js"><?php echo '</script'; ?>
>
<?php }
}
