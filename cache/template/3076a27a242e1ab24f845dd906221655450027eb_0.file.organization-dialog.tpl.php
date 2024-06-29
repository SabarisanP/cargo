<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 15:23:30
  from 'E:\xampp\htdocs\cargo\application\views\site\template\organization-dialog.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d929a6299e4_52725865',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3076a27a242e1ab24f845dd906221655450027eb' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\template\\organization-dialog.tpl',
      1 => 1716451521,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665d929a6299e4_52725865 (Smarty_Internal_Template $_smarty_tpl) {
?><!--Organization dialog-->                     
<div id="edit-user-organization" class="dialog-content-page" style="display: none">
                <form class="form-horizontal " action="#">
                    <label>Please select a organization</label>
                    <div class="ov_fl_230">
                        <ul class="user_list">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'org');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['org']->value) {
?>
                            <li>
                                <div style="padding-left: 10px;"> 
                                    <div class="radio">
                                        <input type="radio" id="org_<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
" value="<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
" class="org_all" data-name="<?php echo $_smarty_tpl->tpl_vars['org']->value->name;?>
"  name="org_rad">
                                        <lable for="org_<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['org']->value->name;?>
</lable>
                                    </div>
                                </div> 
                            </li>
                     <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>   
                        </ul>
                     </div>
                     <div class="clear_fix_both"></div><br/>
                    <input type="hidden" id="hid_org_usr_code" />
                    <input type="hidden" id="hid_org_od_code" />
                    <input type="hidden" id="hid_flg" />
                    <div id="ur-org-loading" style="display:none"></div>
                    <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-org-state"></div>
                    <div class="align-right" id="form-org-bttons">
                        <button type="button" id="btn-save" class="btn btn-success" onclick="saveUserOrganization()">Update</button>
                        <button type="button" class="btn btn-default" onclick="cancelorganization()">Cancel</button>
                    </div>

                </form>
</div>
<!--Organization dialog end-->   <?php }
}
