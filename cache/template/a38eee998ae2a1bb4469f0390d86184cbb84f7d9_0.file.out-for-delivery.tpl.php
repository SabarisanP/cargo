<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 18:29:18
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\out-for-delivery.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665dbe261e0211_02180048',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'a38eee998ae2a1bb4469f0390d86184cbb84f7d9' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\out-for-delivery.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665dbe261e0211_02180048 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="brand_top">
    <h3>Door Pickup & Door Delivery</h3>
    <span class="align-right">
        <a href="#cargo/add-out-for-delivery" class="btn btn-success  btn-sm">Add Transit</a>
    </span>
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

                                                <form id="out_for_del_form" method="post" name="out_for_del_form" action="" onsubmit="return false">
                                                    <div class="row">   

                                                        <div class="form-group col-md-3">
                                                            <label for="out_for_del_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="out_for_del_range" readonly placeholder="Date Range" value="<?php echo implode(' | ',array_filter(array(smarty_modifier_date_format($_smarty_tpl->tpl_vars['ffromDate']->value,'%d-%m-%Y'),smarty_modifier_date_format($_smarty_tpl->tpl_vars['ftoDate']->value,'%d-%m-%Y'))));?>
">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label for="out-for-del-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="out-for-del-vehicle" name="vehicleCode" class="form-control">
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

                                                        <div class="form-group col-md-2">
                                                            <label for="out_for_del_alias_code">Transit Number</label>
                                                            <input type="text" name="aliasCode" class="form-control sdate initialism" id="out_for_del_alias_code" placeholder="Transit Number" value="<?php echo $_smarty_tpl->tpl_vars['faliasode']->value;?>
">
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getOutForDelList();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearOutForDelList();">Clear</button>
                                                            </div>
                                                        </div>

                                                    </div>  
                                                </form> 
                                            </div>
                                            <div class="align-center alert alert-danger pull-left" style="display:none;" id="out_for_del_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="ofd-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div id="ofd-lists"></div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>

<?php echo '<script'; ?>
>
    $('#out_for_del_range').daterangepicker({
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

    $('#out-for-del-vehicle').select2();

    function getOutForDelList() {
        var data = {};
        var daterange = $('#out_for_del_range').data('daterangepicker');
        data.fromDate = daterange.startDate.format('DD-MM-YYYY');
        data.toDate = daterange.endDate.format('DD-MM-YYYY');
        data.vehicleCode = $('#out-for-del-vehicle').val();
        data.aliasCode = $('#out_for_del_alias_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        
        if ($('#out_for_del_range').val() == '') {
            $('#out_for_del_range').addClass('inp_error');
            err++;
        } 
        
        if (data.fromDate != '') {
            if (data.toDate == '') {
                var output = moment(data.fromDate, 'DD-MM-YYYY').add(1, 'month').format('DD-MM-YYYY');
                data.toDate = output;              
            }
        }

        if (data.fromDate != '' && data.toDate != '') {
            var a = moment(data.fromDate, 'DD-MM-YYYY');
            var b = moment(data.toDate, 'DD-MM-YYYY');
            var t = b.diff(a, 'days');
            
            if (t > 31) {
                $('#ogpl_to').addClass('inp_error');
                $('#out_for_del_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#out_for_del_action_state').html('Date range should be 31 days or less').show();
                err++;
                return false;
            }
        }

        if (err > 0) {
            $('#out_for_del_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#out_for_del_action_state').html('Please enter/select the values in the field that are marked in red').show();
            return false;
        } else {
            $('#out_for_del_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#out_for_del_action_state').html('').hide();
        }

        $('#ofd-list-container').removeClass('hidden');
        $('#ofd-lists').html(loading_popup);

        $.ajax({
            type: "POST",
            url: base_url + "cargo/out-for-delivery-list",
            data: data,
            dataType: 'html',
            success: function (response) {
                $('#ofd-lists').html(response);
                $("html, body").animate({
                    scrollTop: $('#ofd-list-container').offset().top - 35
                }, "slow");
            }
        });
    }

    function clearOutForDelList() {
        $('#out_for_del_range').val('');
        $('#out_for_del_range').data('daterangepicker').setStartDate({});
        $('#out_for_del_range').data('daterangepicker').setEndDate({});
        $('#out-for-del-vehicle').val('').trigger('change');
        $('#out_for_del_alias_code').val('');
        $('.inp_error').removeClass('inp_error');
        $('#ofd-list-container').addClass('hidden');
        $('#ofd-lists').html('');
        $('#out_for_del_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#out_for_del_action_state').html('').hide();
    }

    if ($('#out_for_del_range').val() != '') {
        getOutForDelList();
    }
<?php echo '</script'; ?>
>

<link href="assets/lib/leaflet/leaflet.css" rel="stylesheet" type="text/css" media="screen">
<?php echo '<script'; ?>
 type="text/javascript" src="assets/lib/leaflet/leaflet.js"><?php echo '</script'; ?>
><?php }
}
