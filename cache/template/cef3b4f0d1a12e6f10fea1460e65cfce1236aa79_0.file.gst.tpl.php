<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-11 11:07:16
  from 'E:\xampp\htdocs\cargo\application\views\site\config\gst.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6667e28ca43688_10944568',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'cef3b4f0d1a12e6f10fea1460e65cfce1236aa79' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\config\\gst.tpl',
      1 => 1716451518,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6667e28ca43688_10944568 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>GST</h3> 
    
    <span class="align-rights"> 
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['GST-ADD-EDIT'] == 1) {?>
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="editGst('');">Add New</a>
        <?php }?>
    </span>
    
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div style="clear: both;"></div><br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">

                            <table class="table table-hover">
                                <tbody>  
                                    <tr>
                                        <th>Product</th>
                                        <th>Name</th>
                                        <th>GST Number</th>
                                        <th>Trade Name</th>
                                        <th>State</th>
                                        <th>CGST (%)</th>
                                        <th>SGST (%)</th>
                                        <th>IGST (%)</th>
                                        <th>UGST (%)</th>
                                        <th>SAC Number</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                    
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['gsts']->value->data, 'slab', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['slab']->value) {
?>
                                    <tr class="slab-row">
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->productType->name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->gstin;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->tradeName;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->state->name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->cgstValue;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->sgstValue;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->igstValue;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->ugstValue;?>
</td>                                        
                                        <td><?php echo $_smarty_tpl->tpl_vars['slab']->value->sacNumber;?>
</td>
                                        <td>
                                            <?php if ($_smarty_tpl->tpl_vars['slab']->value->activeFlag == 1) {?>
                                                <span class="label label-success" id="lb-<?php echo $_smarty_tpl->tpl_vars['slab']->value->code;?>
">Active</span>
                                            <?php } else { ?>
                                                <span class="label label-danger" id="lb-<?php echo $_smarty_tpl->tpl_vars['slab']->value->code;?>
">Disabled</span>    
                                            <?php }?>
                                        </td>
                                        <td>
                                            <?php if ($_smarty_tpl->tpl_vars['slab']->value->activeFlag == 1) {?>
                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['GST-ADD-EDIT'] == 1) {?>
                                                <a href="javascript:;" onclick="deleteGst('<?php echo $_smarty_tpl->tpl_vars['slab']->value->code;?>
')" title="Click to Disable" class="btn btn-default btn-xs"><i class="fa fa fa-times"></i></a>
                                                <?php }?>
                                            <?php }?>
                                        </td>
                                    </tr>    
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?> 
                                    
                                    <tr class="edit-panel hide">
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <select class="form-control" id="ecs_product">                                                                                                            
                                                        <option value="bits">BITS</option>    
                                                        <option value="cargo">Cargo</option>                                                        
                                                    </select>
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="Name" value="" maxlength="50" id="ecs_name" class="form-control">                                                    
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="GSTIN" value="" maxlength="50" id="ecs_gstn" class="form-control">
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="Trade / Legal Name" value="" maxlength="50" id="ecs_tradename" class="form-control">
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <select class="form-control" id="ecs_state">
                                                        <option value="">Select a state</option>
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value->data, 'st', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['st']->value) {
?>
                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['st']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['st']->value->name;?>
</option>    
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>                                                        
                                                    </select>
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="CGST" value="" maxlength="50" size="5" id="ecs_cgst" class="form-control">
                                                </div>
                                            </div> 
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="SGST" value="" maxlength="50" size="5" id="ecs_sgst" class="form-control">
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="IGST" value="" maxlength="50" size="5" id="ecs_igst" class="form-control">
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="UGST" value="" maxlength="50" size="5" id="ecs_ugst" class="form-control">                                                  
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="form-group">
                                                <div class="">
                                                    <input type="text" placeholder="SAC Number" value="" maxlength="50" id="ecs_sac" class="form-control">                                                  
                                                </div>
                                            </div>
                                        </td>
                                        <td nowrap="nowrap">
                                            <div class="form-group">
                                                <div class="" id="form-bttons">
                                                    <button class="btn btn-success" type="button" onclick="saveGst();">Save</button> &nbsp;
                                                    <button class="btn btn-default" type="button" onclick="clearGst();">Clear</button>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="edit-panel hide">
                                        <td colspan="11" align="right">
                                            <div class="alert" id="st-form-action-state"></div>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div><!--panel Body end-->

<?php echo '<script'; ?>
>
var slabs_json = <?php echo json_encode($_smarty_tpl->tpl_vars['gsts']->value->data);?>
;
function editGst(code){
    //$('.slab-row').hide();    
    $('.edit-panel').removeClass('hide'); 
    
    $('#ecs_name').val('') ;
    $('#ecs_gstn').val('');
    $('#ecs_state').val('');    
    $('#ecs_cgst').val('0.0');
    $('#ecs_sgst').val('0.0');
    $('#ecs_igst').val('0.0');
    $('#ecs_ugst').val('0.0');
    $('#ecs_sac').val('');  
    
    if(code!="") {
        $.each(slabs_json, function(keys, values) {
            if (values.code == code) {
                $('#ecs_product').val(values.product.code) ;
                $('#ecs_name').val(values.name) ;
                $('#ecs_gstn').val(values.gstin);
                $('#ecs_state').val(values.state.code);    
                $('#ecs_cgst').val(values.cgstValue);
                $('#ecs_sgst').val(values.sgstValue);
                $('#ecs_igst').val(values.igstValue);
                $('#ecs_ugst').val(values.ugstValue);
                $('#ecs_sac').val(values.sacNumber);               
            }
        });        
    }
}

function clearGst(){
    $('.slab-row').show();    
    $('.edit-panel').addClass('hide');
    $('#st-form-action-state').removeClass('alert-success').removeClass('alert-danger');    
}

function deleteGst(code) {
    var data = {};
    $.each(slabs_json, function(keys, values) {
        if (values.code == code) {
            data.item = values;              
        }
    });    
    data.item.activeFlag = 0;
    
    if(confirm('Do you want to disable this GST?')) {   
            
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-gst",
            data: data,
            success: function(response) {
                if (response.status == 1) {                
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });

                    window.setTimeout(function() {
                        loading_overlay.hide();
                        checkURL();
                    }, 1000);
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });

                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 1000);
                }
            }
        });
    }
}

function saveGst() {
    var data = {};
    
    data.product = $.trim( $('#ecs_product').val() );
    data.name = $.trim( $('#ecs_name').val() );
    data.gstn = $.trim($('#ecs_gstn').val());
    data.tradename = $.trim($('#ecs_tradename').val());    
    data.state = $.trim($('#ecs_state').val());    
    data.cgst = $.trim($('#ecs_cgst').val());       
    data.sgst = $.trim($('#ecs_sgst').val());
    data.igst = $.trim($('#ecs_igst').val());
    data.ugst = $.trim($('#ecs_ugst').val());
    data.sac = $.trim($('#ecs_sac').val());
    
    $('.err_bor').removeClass('err_bor');
    var err = 0;
    
    if(data.name=="") {
        $('#ecs_name').addClass('err_bor');
        err++;
        return;
    } 
    
    if(data.tradename=="") {
        $('#ecs_tradename').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.gstn=="") {
        $('#ecs_gstn').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.state=="") {
        $('#ecs_state').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.cgst=="") {
        $('#ecs_cgst').addClass('err_bor');
        err++;
        return;
    }
    if(isNaN(data.cgst=="")) {
        $('#ecs_cgst').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.sgst=="") {
        $('#ecs_sgst').addClass('err_bor');
        err++;
        return;
    }
    if(isNaN(data.sgst=="")) {
        $('#ecs_cgst').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.igst=="") {
        $('#ecs_igst').addClass('err_bor');
        err++;
        return;
    }
    if(isNaN(data.igst=="")) {
        $('#ecs_igst').addClass('err_bor');
        err++;
        return;
    }
    
    if(data.ugst=="") {
        $('#ecs_ugst').addClass('err_bor');
        err++;
        return;
    }
    if(isNaN(data.ugst=="")) {
        $('#ecs_ugst').addClass('err_bor');
        err++;
        return;
    }
    
    
    $('#form-bttons').hide();
    $('#st-form-action-state').removeClass('alert-danger').removeClass('alert-success');
    $('#st-form-action-state').html(loading_popup);
    $('#st-form-action-state').show();
    
    
    if (err > 0) {
        $('#st-form-action-state').removeClass('alert-success');
        $('#st-form-action-state').addClass('alert-danger');
        $('#form-bttons').show();
        return false;
    }
    
    var loading_overlay = iosOverlay({
        text: "Loading",
        icon: "fa fa-spinner fa-spin"
    });
    
    $.ajax({
        type: "POST",
        dataType: 'json',
        url: base_url + "config/save-gst",
        data: data,
        success: function(response) {
            if (response.status == 1) {
                loading_overlay.update({
                    icon: "fa fa-check",
                    text: "Success!"
                });
                    
                $('.er_msg').remove();
                $('#st-form-action-state').removeClass('alert-danger');
                $('#st-form-action-state').addClass('alert-success');
                $('#st-form-action-state').html('Your request has been completed successfully');
                window.setTimeout(function() {
                    loading_overlay.hide();
                    checkURL();
                }, 1000);
            } else {                
                loading_overlay.hide();                
                $('#st-form-action-state').addClass('alert-danger');
                $('#st-form-action-state').html(response.errorDesc);
                $('#form-bttons').show();
            }
        }
    });
}    
<?php echo '</script'; ?>
>            <?php }
}
