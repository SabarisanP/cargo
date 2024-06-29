<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 12:44:06
  from 'E:\xampp\htdocs\cargo\application\views\site\menu\menu.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bedbe926a50_31584690',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '0618c44a0ba810c6b3b2661044071473f8e41585' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\menu\\menu.tpl',
      1 => 1716451523,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bedbe926a50_31584690 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'menu' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\0618c44a0ba810c6b3b2661044071473f8e41585_0.file.menu.tpl.php',
    'uid' => '0618c44a0ba810c6b3b2661044071473f8e41585',
    'call_name' => 'smarty_template_function_menu_691869247666bedbe27e1f1_28413913',
  ),
  'option' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\0618c44a0ba810c6b3b2661044071473f8e41585_0.file.menu.tpl.php',
    'uid' => '0618c44a0ba810c6b3b2661044071473f8e41585',
    'call_name' => 'smarty_template_function_option_691869247666bedbe27e1f1_28413913',
  ),
));
?><div class="brand_top">
    <h3>Menu</h3> 
    <span class="align-right">
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-ADD'] > 0) {?>  
            <a href="javascript:;" class="btn btn-success  btn-sm" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-ADD'] != 2) {?>onclick="menuDialog()"<?php }?>>Add New Menu</a>
        <?php }?>
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content1" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6" id="menu-list-pannel">
                                        <div class="panel-group">

                                            <div class="col-md-offset-1 col-md-10">
                                                <?php if (count($_smarty_tpl->tpl_vars['f_menus']->value) > 0) {?>
                                                    <div class="cf nestable-lists">
                                                        <div class="dd" id="nestable2">
                                                            
                                                                                            <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'menu', array('data'=>$_smarty_tpl->tpl_vars['f_parent']->value), true);?>

                                                                                        </div>
                                                                                    </div>
                                                                                    <?php } else { ?>
                                                                                        <div class="well well-large ">No Menu found!</div>
                                                                                        <?php }?>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="clear_fix_both"></div>
                                                                                    <div id="menu-dialog" style="display: none;"  class="dialog-content-page">
                                                                                        <form role="form" id="form1" class="form-horizontal ">
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="product_code">Product</label>
                                                                                                    <select  class="form-control" id="product_code">
                                                                                                        <option value="">Select</option>
                                                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['products']->value, 'product');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['product']->value) {
?>
                                                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['product']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['product']->value->name;?>
</option>
                                                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                                    </select>
                                                                                                    <input  placeholder="Action" id="txt_c_name" name="txt_c_name"  class="form-control hide">
                                                                                                </div>
                                                                                            </div>   
                                                                                            
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="parentmenu" class="">Parent Menu</label>
                                                                                                    <select  class="form-control" id="parentmenu">
                                                                                                        <option value="">Select</option>
                                                                                                        
                                                                                                        <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'option', array('data'=>$_smarty_tpl->tpl_vars['f_parent']->value), true);?>

                                                                                                    </select>
                                                                                                </div>
                                                                                            </div>


                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="txt_m_name" class="req">Name</label>
                                                                                                    <input  placeholder="Name" id="txt_m_name" name="txt_m_name"  class="form-control">
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="txt_l_name" class="req">Link</label>
                                                                                                    <input  placeholder="Link" id="txt_l_name" name="txt_l_name"  class="form-control">
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="clear_fix_both"></div>
                                                                                            <br />
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                <label for="">Tag</label>
                                                                                                <select class="form-control" name="menu_tag" id="menu_tag" multiple>
                                                                                                    <option value="New">New</option>
                                                                                                    <option value="Updated">Updated</option>
                                                                                                </select>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-md-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="">Severity</label>
                                                                                                    <select id="menu_severity" class="form-control" name="menu_severity">
                                                                                                        <option value="NA">Select</option>
                                                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['perrmission_severity']->value, 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value;?>
</option>
                                                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                                    </select>
                                                                                                </div>
                                                                                            </div>  
                                                                                            <div class="clear_fix_both"></div><br>

                                                                                            <div class="table-responsive ov_fl">
                                                                                                <table class="table table-striped" id="tbl_list">
                                                                                                    <tr class="tr-head">
                                                                                                        <td>Name</td>
                                                                                                        <td>Permission Type</td>
                                                                                                        <td>Severity</td>
                                                                                                        <td>Operation Code</td>
                                                                                                        <td>Attribute</td>
                                                                                                        <td>Active</td>
                                                                                                        <td></td>
                                                                                                    </tr>
                                                                                                    <tr class="def-tr">
                                                                                                        <td>
                                                                                                            <input type="text" name="evt_name" id="evt_name" class="form-control" /></td>
                                                                                                        <td>

                                                                                                            <select  class="form-control" name="evt_permis">
                                                                                                                <option value="ACT">Active</option>
                                                                                                                <option value="IDL">Ideal</option>

                                                                                                            </select>

                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <select id="event_severity" class="form-control" name="event_severity">
                                                                                                                <option value="NA">Select</option>
                                                                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['perrmission_severity']->value, 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                                                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value;?>
</option>
                                                                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                                            </select>
                                                                                                        </td>
                                                                                                        <td><input type="text" name="evt_key" id="evt_key"  class="form-control" /></td>
                                                                                                        <td><input type="text" name="evt_attr" id="evt_attr"  class="form-control" /></td>
                                                                                                        <td>
                                                                                                            <input type="checkbox" name="evt_act" id="evt_act" checked value="1" />
                                                                                                        </td>
                                                                                                        <td><a href="javascript:;" class="btn btn-sm btn-default tr_remove"><i class="fa fa-times"></i></a></td>
                                                                                                    </tr>
                                                                                                    <tr id="clo" class="hide">
                                                                                                        <td><input type="text" name="evt_name" id="evt_name" class="form-control" /></td>
                                                                                                        <td>

                                                                                                            <select  class="form-control" name="evt_permis">
                                                                                                                <option value="ACT">Active</option>
                                                                                                                <option value="IDL">Ideal</option>

                                                                                                            </select>

                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <select id="event_severity" class="form-control" name="event_severity">
                                                                                                                <option value="NA">Select</option>
                                                                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['perrmission_severity']->value, 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                                                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value;?>
</option>
                                                                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                                            </select>
                                                                                                        </td>
                                                                                                        <td><input type="text" name="evt_key" id="evt_key" class="form-control" /></td>
                                                                                                        <td><input type="text" name="evt_attr" id="evt_attr"  class="form-control" /></td>
                                                                                                        <td>
                                                                                                            <input type="checkbox" name="evt_act" value="1" checked id="evt_act" class="de-ck" />
                                                                                                        </td>
                                                                                                        <td><a href="javascript:;" class="btn btn-sm btn-default tr_remove"><i class="fa fa-times"></i></a></td>

                                                                                                    </tr>
                                                                                                    <tr id="tr_add">
                                                                                                        <td colspan="7" align="right">                                                                          
                                                                                                            <button class="btn btn-sm btn-primary" type="button" onclick="addEvents();">Add Event</button>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                            <input type="hidden" name="menu_code" id="menu_code" value="" />
                                                                                            <input type="hidden"  name="menu_status" id="menu_status" value="1" />

                                                                                            <div class="clear_fix_both"></div><br />
                                                                                            <div class="fl" id="mnu-loading"></div>
                                                                                            <div class="alert fl" style="display: none;" id="mnu-action-state"></div>
                                                                                            <div class="align-right" id="mnu-button">
                                                                                                <input type="hidden" name="id_mnu_code" id="id_mnu_code" value="" />
                                                                                                <button class="btn btn-success" type="button" onclick="saveMenu();">Save</button>
                                                                                                <button class="btn btn-default" type="button" onclick="cancelMenu();">Cancel</button>
                                                                                            </div>
                                                                                        </form>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-6 hide" id="assigned-users-pannel-loading"></div>
                                                                                <div class="col-md-6 hide" id="assigned-users-pannel">
                                                                                    <div class="heading_b" id="cur-info">Permission setup for <b></b></div>
                                                                                    <input type="hidden" id="selected-menu">
                                                                                    <div class="col-md-12 m-b-4 p_l_n pb10">
                                                                                        <label class="checkbox-inline">
                                                                                            <input type="checkbox" id="ns-<?php echo $_smarty_tpl->tpl_vars['namespace_code']->value;?>
" class="assigned-cb <?php echo $_smarty_tpl->tpl_vars['namespace_code']->value;?>
" data-role="NS" value="<?php echo $_smarty_tpl->tpl_vars['namespace_code']->value;?>
">&nbsp;<b class="h5 bold">Namespace</b>
                                                                                        </label>
                                                                                    </div>
                                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groupusers']->value['groups'], 'group');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['group']->value) {
?>
                                                                                        <?php if ($_smarty_tpl->tpl_vars['groupusers']->value['groupusers'][$_smarty_tpl->tpl_vars['group']->value->name]) {?>                                                                                            
                                                                                            <div class="pt10 pb5">
                                                                                                <div class="col-md-12 m-b-4">
                                                                                                    <label class="checkbox-inline">
                                                                                                        <input type="checkbox" id="group-<?php echo $_smarty_tpl->tpl_vars['group']->value->code;?>
" class="assigned-cb <?php echo $_smarty_tpl->tpl_vars['group']->value->code;?>
" data-role="GR" value="<?php echo $_smarty_tpl->tpl_vars['group']->value->code;?>
">&nbsp;<b><?php echo $_smarty_tpl->tpl_vars['group']->value->name;?>
</b>
                                                                                                    </label>
                                                                                                </div>
                                                                                                <div class="col-md-12">
                                                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groupusers']->value['groupusers'][$_smarty_tpl->tpl_vars['group']->value->name], 'user');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['user']->value) {
?>
                                                                                                        <?php if ($_smarty_tpl->tpl_vars['user']->value['activeFlag'] == 1) {?>
                                                                                                            <div class="col-md-4 m-b-4">
                                                                                                                <label class="checkbox-inline">
                                                                                                                    <input type="checkbox" id="usr-<?php echo $_smarty_tpl->tpl_vars['user']->value['code'];?>
" class="assigned-cb <?php echo $_smarty_tpl->tpl_vars['user']->value['code'];?>
" data-role="UR" value="<?php echo $_smarty_tpl->tpl_vars['user']->value['code'];?>
">&nbsp;<?php echo $_smarty_tpl->tpl_vars['user']->value['name'];?>

                                                                                                                </label>
                                                                                                            </div>
                                                                                                        <?php }?>
                                                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                                </div>
                                                                                                <div class="clear_fix_both"></div>
                                                                                            </div>
                                                                                        <?php }?>
                                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                </div>
                                                                                <!--panel Body end-->
                                                                            </div><!--panel end-->

                                                                        </div>

                                                                    </div><!--row end-->
                                                                </div><!--content end-->
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <?php echo '<script'; ?>
>
                    var menulist = <?php echo json_encode($_smarty_tpl->tpl_vars['f_menus']->value);?>

                    $(document).ready(function ()
                    {

                        /*  var updateOutput = function(e)
                         {
                         var list   = e.length ? e : $(e.target),
                         output = list.data('output');
                         if (window.JSON) {
                         output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
                         } else {
                         output.val('JSON browser support required for this demo.');
                         }
                         };*/



                        $('#nestable2').nestable({
                            group: 1
                        })
                                .on('change');

                    });
                    $('#menu_tag').select2();
                    $('.assigned-cb').on('change', function() {
                        var menu = $('#selected-menu').val();
                        var flag = +$(this).is(':checked');
                        var role = $(this).data('role');
                        var code = $(this).val();
                        assignPermission(menu, flag, role, code);
                    });
                                            <?php echo '</script'; ?>
><?php }
/* smarty_template_function_menu_691869247666bedbe27e1f1_28413913 */
if (!function_exists('smarty_template_function_menu_691869247666bedbe27e1f1_28413913')) {
function smarty_template_function_menu_691869247666bedbe27e1f1_28413913(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('level'=>0), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
?>
                                                                              <ol class="dd-list">
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'entry');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['entry']->value) {
?>
                                                                            <li class="dd-item dd3-item" id="mnu_<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
" data-id="<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
">
                                                                                <div class="dd-handle dd3-handle"></div>
                                                                                <div class="dd3-content"> 
                                                                                    <a href="javascript:;" onclick="getAssignedUsers('<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
', this);" data-name="<?php echo $_smarty_tpl->tpl_vars['entry']->value['name'];?>
"><?php echo $_smarty_tpl->tpl_vars['entry']->value['name'];?>
</a>
                                                                                    <div class="pull-right">
                                                                                        <?php if ($_smarty_tpl->tpl_vars['entry']->value["severity"]->code != 'NA') {?>
                                                                                            <?php if ($_smarty_tpl->tpl_vars['entry']->value["severity"]->code == 'DEFAULT') {?>
                                                                                                <span class="badge badge-secondary"><?php echo $_smarty_tpl->tpl_vars['perrmission_severity']->value[$_smarty_tpl->tpl_vars['entry']->value["severity"]->code];?>
</span>
                                                                                            <?php } elseif ($_smarty_tpl->tpl_vars['entry']->value["severity"]->code == 'MAJOR') {?>
                                                                                                <span class="badge badge-primary"><?php echo $_smarty_tpl->tpl_vars['perrmission_severity']->value[$_smarty_tpl->tpl_vars['entry']->value["severity"]->code];?>
</span>
                                                                                            <?php } elseif ($_smarty_tpl->tpl_vars['entry']->value["severity"]->code == 'CRITICAL') {?>
                                                                                                <span class="badge badge-danger"><?php echo $_smarty_tpl->tpl_vars['perrmission_severity']->value[$_smarty_tpl->tpl_vars['entry']->value["severity"]->code];?>
</span>
                                                                                            <?php } elseif ($_smarty_tpl->tpl_vars['entry']->value["severity"]->code == 'BLOCKER') {?>
                                                                                                <span class="badge badge-warning"><?php echo $_smarty_tpl->tpl_vars['perrmission_severity']->value[$_smarty_tpl->tpl_vars['entry']->value["severity"]->code];?>
</span>
                                                                                            <?php }?>
                                                                                            &nbsp;
                                                                                        <?php }?>
                                                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-DISABLE'] > 0) {?> <a href="javascript:;" title="edit" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-DISABLE'] != 2) {?>onclick='editStatusMenu("<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
", this)'<?php }?> data-status="<?php echo $_smarty_tpl->tpl_vars['entry']->value["activeFlag"];?>
">
                                                                                                <?php if ($_smarty_tpl->tpl_vars['entry']->value["activeFlag"] == 1) {?>
                                                                                                    <i class="fa fa-times" title="Click to disable"></i>
                                                                                                <?php } else { ?>
                                                                                                    <i class="fa fa-check" title="Click to enable"></i>
                                                                                                <?php }?>
                                                                                            </a>&nbsp;<?php }?>

                                                                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-EDIT'] > 0) {?><a href="javascript:;" title="edit"  <?php if ($_smarty_tpl->tpl_vars['entry']->value["activeFlag"] == 0) {?>style='display:none'<?php }?> id='mnu_edt_<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
'  <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-EDIT'] != 2) {?>onclick='menuDialog("<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
")'<?php }?>>
                                                                                                    <i class="fa fa-pencil igreen"></i>
                                                                                                </a>&nbsp;<?php }?>

                                                                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-DELETE'] > 0) {?> <a href="javascript:;" title="Delete" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['MNU-DELETE'] != 2) {?>onclick='deleteMenu("<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
")'<?php }?>>
                                                                                                        <i class="fa fa-trash-o ired"></i>
                                                                                                    </a><?php }?>
                                                                                                </div>
                                                                                            </div>
                                                                                            <?php if (count($_smarty_tpl->tpl_vars['f_sub_menu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']]) > 0) {?>
                                                                                                <?php if (is_array($_smarty_tpl->tpl_vars['f_sub_menu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']])) {?>
                                                                                                    <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'menu', array('data'=>$_smarty_tpl->tpl_vars['f_sub_menu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']]), true);?>
		
                                                                                                <?php }?>

                                                                                            <?php }?>
                                                                                        </li>
                                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                                        </ol>
                                                                                        <?php
}}
/*/ smarty_template_function_menu_691869247666bedbe27e1f1_28413913 */
/* smarty_template_function_option_691869247666bedbe27e1f1_28413913 */
if (!function_exists('smarty_template_function_option_691869247666bedbe27e1f1_28413913')) {
function smarty_template_function_option_691869247666bedbe27e1f1_28413913(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('level'=>0), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
?>
 
                                                                                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'entry');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['entry']->value) {
?>
                                                                                                                <option value="<?php echo $_smarty_tpl->tpl_vars['entry']->value['code'];?>
">
                                                                                                                    <?php if ($_smarty_tpl->tpl_vars['level']->value != 0) {?>
                                                                                                                        <?php
$__section_l_0_loop = (is_array(@$_loop=$_smarty_tpl->tpl_vars['level']->value) ? count($_loop) : max(0, (int) $_loop));
$__section_l_0_total = $__section_l_0_loop;
$_smarty_tpl->tpl_vars['__smarty_section_l'] = new Smarty_Variable(array());
if ($__section_l_0_total !== 0) {
for ($__section_l_0_iteration = 1, $_smarty_tpl->tpl_vars['__smarty_section_l']->value['index'] = 0; $__section_l_0_iteration <= $__section_l_0_total; $__section_l_0_iteration++, $_smarty_tpl->tpl_vars['__smarty_section_l']->value['index']++){
?>
                                                                                                                            -
                                                                                                                        <?php
}
}
?>
                                                                                                                    <?php }?>
                                                                                                                    <?php echo $_smarty_tpl->tpl_vars['entry']->value['name'];?>

                                                                                                                </option>
                                                                                                                <?php if (count($_smarty_tpl->tpl_vars['f_sub_menu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']]) > 0) {?>
                                                                                                                    <?php if (is_array($_smarty_tpl->tpl_vars['f_sub_menu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']])) {?>
                                                                                                                        <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'option', array('data'=>$_smarty_tpl->tpl_vars['f_sub_menu']->value[$_smarty_tpl->tpl_vars['entry']->value['code']],'level'=>$_smarty_tpl->tpl_vars['level']->value+1), true);?>
		
                                                                                                                    <?php }?>

                                                                                                                <?php }?>
                                                                                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                                                                                                        <?php
}}
/*/ smarty_template_function_option_691869247666bedbe27e1f1_28413913 */
}
