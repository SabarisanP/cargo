<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-27 17:11:11
  from 'E:\xampp\htdocs\cargo\application\views\site\permission\permissions.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66547157c97f14_96398567',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '81818e3d961d87a2d3aa02cb07e9fe83b933efd5' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\permission\\permissions.tpl',
      1 => 1716451524,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66547157c97f14_96398567 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Permissions</h3> 
    <!--<span class="align-right hidden" id="tc-back-per">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="backToSelectRole();"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>-->
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        


                        <div class="col-md-3"> 
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['PRVGE-NS'] > 0) {?>
                                            <button class='btn btn-success btn-block' onclick="menuPermissionDialog('NS')">Namespace</button>
                                        <?php }?>
                                    </div>
                                    <br>
                                    <div>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['PRVGE-GRP'] > 0) {?>
                                            <button class='btn btn-success btn-block' onclick="switchGroup()">Groups</button>
                                        <?php }?>
                                        <div id="per-table-list-grp" style="display:none">
                                            <div >
                                                 <ul class="user_list " id="user_list_search">
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                        <li id="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">
                                                            <span class="sp_name col-xs-10"><a href="javascript:;" onclick="menuPermissionDialog('GR', '<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</a></span>
                                                        </li> 
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>   
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <br>            
                                    <div>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['PRVGE-USR'] > 0) {?>
                                            <button class='btn btn-success btn-block' onclick="switchhUser()">Users</button>
                                        <?php }?>

                                        <div id="per-table-list-usr" style="display:none">
                                            <div style="max-height:300px; overflow-y: auto;">
                                                <ul class="user_list " id="user_list_search">
                                                    
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['users']->value, 'user', false, 'grpname', 'ol', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grpname']->value => $_smarty_tpl->tpl_vars['user']->value) {
?>
                                                        <li>
                                                            <div class="bold">
                                                                <?php echo $_smarty_tpl->tpl_vars['grpname']->value;?>

                                                            </div>
                                                        </li>
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['user']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                        <li id="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" style="padding-left:10px;">
                                                            <span class="sp_name col-xs-10"><a href="javascript:;" onclick="menuPermissionDialog('UR', '<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</a></span>
                                                        </li> 
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>  
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>  
                                                    
                                                </ul> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                        <div class="col-md-9">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="menupermissions">
                                        <div class="container ">
                                            <div class="row">
                                                <div id="permission" >                                                           
                                                    <div class="heading_b" id='cur-info'>Permissions</div>
                                                    
                                                    <div id="menu-permissions">
                                                        <div class="well text-center">
                                                            Please select an option in left panel to view menu settings.
                                                        </div>    
                                                    </div>      
                                                   
                                                </div>    
                                                <input type="hidden" id="code">
                                                <?php echo '<script'; ?>
>
                                                        var parentmenulist = <?php echo json_encode($_smarty_tpl->tpl_vars['p_parent']->value);?>

                                                        var eventList = <?php echo json_encode($_smarty_tpl->tpl_vars['eventList']->value);?>

                                                        var submenulist = <?php echo json_encode($_smarty_tpl->tpl_vars['p_sub_menu']->value);?>

                                                        var groupsoption = <?php echo json_encode($_smarty_tpl->tpl_vars['groups']->value);?>

                                                        var usersoption = <?php echo json_encode($_smarty_tpl->tpl_vars['users']->value);?>

                                                <?php echo '</script'; ?>
>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>            
                        </div>

                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>





<?php }
}
