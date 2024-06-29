<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 15:24:52
  from 'E:\xampp\htdocs\cargo\application\views\site\config\organization-detail.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d92ec0e4147_46506583',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '65ab711a64bcd5e5bc97bfe0c6758a172ea24f4f' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\config\\organization-detail.tpl',
      1 => 1716451515,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:site/cargo/file-upload-component.tpl' => 1,
  ),
),false)) {
function content_665d92ec0e4147_46506583 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.replace.php','function'=>'smarty_modifier_replace',),));
?>
<h4>Branch - <span id="stat_title"></span>
    <div class="fr">
        <span class="sp_action">
            <?php if ($_smarty_tpl->tpl_vars['org']->value->latitude != '0') {?>
                <a title="Map" class="btn btn-default btn-sm" id='station-map-<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
'  href="https://maps.google.com/?q=<?php echo $_smarty_tpl->tpl_vars['org']->value->latitude;?>
,<?php echo $_smarty_tpl->tpl_vars['org']->value->longitude;?>
" target="_blank"><i class="fa fa-map-marker" aria-hidden="true"></i></a>
            <?php }?>
            <a title="User" class="btn btn-default btn-sm" id='og_user_<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
'  href="javascript:;" onclick='userOrganizationDialog(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['org']->value), ENT_QUOTES, 'UTF-8', true);?>
)'><i class="fa fa-user" aria-hidden="true"></i></a>
        </span>
        <span class="">
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-DISABLE'] > 0) {?> 
                <a href="javascript:;" class="btn btn-default btn-sm est"  <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-DISABLE'] != 2) {?>onclick='editStatusOrganization(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['org']->value), ENT_QUOTES, 'UTF-8', true);?>
, this)'<?php }?> data-status="<?php echo $_smarty_tpl->tpl_vars['org']->value->activeFlag;?>
">
                    <?php if ($_smarty_tpl->tpl_vars['org']->value->activeFlag == 1) {?>
                        <i class="fa fa-times" title="Click to disable"></i>
                    <?php } else { ?>
                        <i class="fa fa-check" title="Click to enable"></i>
                    <?php }?>
                </a>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-EDIT'] > 0) {?> 
            <a href="javascript:;" title="edit" id='og_edt_<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
' <?php if ($_smarty_tpl->tpl_vars['org']->value->activeFlag == 0) {?>style='display:none'<?php }?> class="btn btn-default btn-sm edat" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-EDIT'] != 2) {?>onclick='editOrganization(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['org']->value), ENT_QUOTES, 'UTF-8', true);?>
)'<?php }?>><i class="fa fa fa-pencil igreen"></i></a>
            <?php }?>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-DELETE'] > 0) {?>
                <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-DELETE'] != 2) {?>onclick="deleteOrganization('<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['org']->value->name;?>
')"<?php }?>><i class="fa fa-trash-o ired"></i></a>
            <?php }?>
        </span>
    </div>
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover org-det-table" >
            <thead>
                <tr>
                    <th class="pth">Station</th>
                    <th class="pth">Address</th>
                    <th class="pth">Contact</th>
                    <th class="pth">Booking payment type</th>
                    <th class="pth">Delivery Payment Type</th>
                    <th class="lat">Hub Flag</th>
                    <th class="lad">Primary User</th>
                    <th class="mno">Tags</th>
                    <th nowrap>Transit Close Time</th>
                </tr>
            </thead>
            <tbody>
                <tr id="sp-<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
">
                    <td class="sp_no"><?php echo $_smarty_tpl->tpl_vars['org']->value->station->name;?>
</td>

                    <td class="sp_name" style="text-overflow: ellipsis;">
                        <?php echo $_smarty_tpl->tpl_vars['org']->value->address1;
if ($_smarty_tpl->tpl_vars['org']->value->address2) {
echo ',';
echo $_smarty_tpl->tpl_vars['org']->value->address2;
}
if ($_smarty_tpl->tpl_vars['org']->value->pincode) {
echo ' - ';
echo $_smarty_tpl->tpl_vars['org']->value->pincode;
}?>
                    </td>

                    <td class="sp_no"><?php echo $_smarty_tpl->tpl_vars['org']->value->contact;?>
</td>
                    <td class="sp_no">
                    <a id="popup_msg" 
                        data-content='<ul class="p_l_15">
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['bookingPaymentTypeList']->value, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                            <li><?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['desc']->value->name,"'",'"');?>
</li>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </ul>'>
                        <?php if ($_smarty_tpl->tpl_vars['bookingPaymentTypeList']->value) {?>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['bookingPaymentTypeList']->value, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                                <?php echo $_smarty_tpl->tpl_vars['desc']->value->name;?>

                                <?php break 1;?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <span class="badge badge-info"><?php echo count($_smarty_tpl->tpl_vars['bookingPaymentTypeList']->value);?>
</span>
                        <?php } else { ?>
                            -
                        <?php }?>
                    </a>
                </td>
                <td class="sp_no">
                    <a id="popup_msg" 
                        data-content='<ul class="p_l_15">
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['deliveryPaymentTypeList']->value, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                            <li><?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['desc']->value->name,"'",'"');?>
</li>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </ul>'>
                        <?php if ($_smarty_tpl->tpl_vars['deliveryPaymentTypeList']->value) {?>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['deliveryPaymentTypeList']->value, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                                <?php echo $_smarty_tpl->tpl_vars['desc']->value->name;?>

                                <?php break 1;?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <span class="badge badge-info"><?php echo count($_smarty_tpl->tpl_vars['deliveryPaymentTypeList']->value);?>
</span>
                        <?php } else { ?>
                            -
                        <?php }?>
                    </a>
                </td>
                    <td class="sp_lat">
                        <?php if ($_smarty_tpl->tpl_vars['org']->value->hubFlag == 'true') {?>
                            <span class="badge badge-success">Yes</span>
                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>

                    <td class="sp_lad">
                        <?php if ($_smarty_tpl->tpl_vars['org']->value->user->name) {?>
                            <?php echo $_smarty_tpl->tpl_vars['org']->value->user->name;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td class="sp_mno nowrap">
                        <a id="popup_msg" 
                            data-content='<ul class="p_l_15">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['org']->value->tag, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                                <li><?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['desc']->value->name,"'",'"');?>
</li>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </ul>'>
                            <?php if ($_smarty_tpl->tpl_vars['org']->value->tag) {?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['org']->value->tag, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                                    <?php echo $_smarty_tpl->tpl_vars['desc']->value->name;?>

                                    <?php break 1;?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <span class="badge badge-info"><?php echo count($_smarty_tpl->tpl_vars['org']->value->tag);?>
</span>
                            <?php } else { ?>
                                -
                            <?php }?>
                        </a>
                    </td> 
                    <td align="center">
                        <?php if ($_smarty_tpl->tpl_vars['org']->value->transitCloseMinutes >= 0) {?>
                            <?php echo date('g:i A',mktime(0,$_smarty_tpl->tpl_vars['org']->value->transitCloseMinutes));?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                </tr> 
            </tbody>
        </table>
    </div>
</div>

<div class="clear_fix_both"></div><br />
<h4>Payment Preference
    <div class="fr">
        <?php if (!$_smarty_tpl->tpl_vars['pay_pref']->value) {?>
            <a href="javascript:;" title="Add" id='add-pay-pref' class="btn btn-default btn-sm" onclick='addPaymentPreference()'><i class="fa fa fa-plus igreen"></i></a>
        <?php }?>
        <?php if ($_smarty_tpl->tpl_vars['pay_pref']->value) {?>
            <a href="javascript:;" title="edit" id='edit-pay-pref' <?php if ($_smarty_tpl->tpl_vars['org']->value->activeFlag == 0) {?>style='display:none'<?php }?> class="btn btn-default btn-sm" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-EDIT'] != 2) {?>onclick='addPaymentPreference(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['pay_pref']->value), ENT_QUOTES, 'UTF-8', true);?>
)'<?php }?>><i class="fa fa fa-pencil igreen"></i></a>
        <?php }?>
        <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-DELETE'] != 2) {?>onclick="deletePaymentPreference(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['pay_pref']->value), ENT_QUOTES, 'UTF-8', true);?>
)"<?php }?>><i class="fa fa-trash-o ired"></i></a>
    </div>
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover branch-pay-pref-table" >
            <thead>
                <tr>
                    <th class="pth">From Organization</th>
                    <th class="pth">To Organization</th>
                </tr>
            </thead>
            <tbody>
                <tr id="sp-<?php echo $_smarty_tpl->tpl_vars['pay_pref']->value->code;?>
">
                    <td class="sp_no"><?php echo $_smarty_tpl->tpl_vars['pay_pref']->value->fromOrganization->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['pay_pref']->value->fromOrganization->station->name;?>
</td>
                    <td class="sp_mno">
                        <a id="popup_msg" 
                            data-content='<ul class="p_l_15">
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['pay_pref']->value->toOrganizationList, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                                <li><?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['desc']->value->name,"'",'"');?>
 - <?php echo $_smarty_tpl->tpl_vars['desc']->value->station->name;?>
</li>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </ul>'>
                            <?php if ($_smarty_tpl->tpl_vars['pay_pref']->value) {?>
                                <?php if ($_smarty_tpl->tpl_vars['pay_pref']->value->toOrganizationList) {?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['pay_pref']->value->toOrganizationList, 'desc');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['desc']->value) {
?>
                                        <?php echo $_smarty_tpl->tpl_vars['desc']->value->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['desc']->value->station->name;?>

                                        <?php break 1;?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                    <span class="badge badge-info"><?php echo count($_smarty_tpl->tpl_vars['pay_pref']->value->toOrganizationList);?>
</span>
                                <?php } else { ?>
                                    All
                                <?php }?>
                            <?php } else { ?>
                                -
                            <?php }?>
                        </a>
                    </td> 
                </tr> 
            </tbody>
        </table>
    </div>
</div>

<div class="clear_fix_both"></div><br />
<h4>
    Other Details
    <div class="fr">
        <?php if (!$_smarty_tpl->tpl_vars['org_dimension']->value->dimensions) {?>
            <a href="javascript:;" title="Add Details" id='add-dimension' class="btn btn-default btn-xs" onclick="addOrganizationDimension('<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
')"><i class="fa fa fa-plus igreen"></i></a>
        <?php } else { ?>
            <a href="javascript:;" title="Edit Details" id='edit-dimension' class="btn btn-default btn-xs" onclick='editOrganizationDimension(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['org_dimension']->value), ENT_QUOTES, 'UTF-8', true);?>
)'><i class="fa fa fa-pencil igreen"></i></a>
        <?php }?>
    </div>
</h4>
<div class="clear_fix_both"></div>
<div class="row">
    <div class="col-md-6" id="branch-view-files">
        <h5 class="">Branch Photos / Docs</h5>
        <?php $_smarty_tpl->_subTemplateRender("file:site/cargo/file-upload-component.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array('id'=>"ie-fileupload",'axis'=>"horizontal"), 0, false);
?>
        <button type="button" class="btn btn-success hide" id="org-upload-btn" onclick="saveOrganizationDocuments('<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
');">Upload</button>
    </div>
    <div class="col-md-6">
        <h5 class="">
            Bank Details
        </h5>
        <div class="clear_fix_both"></div>
        <div id="org_bank"></div>
        <br>
        <h5 class="">
            Dimension &nbsp;<span class="badge badge-pill" style="background: #c3c1c1;">In Feet</span> 
        </h5>
        <div class="clear_fix_both"></div>
        <div class="table table-responsive">
            <table class="datatable table table-striped table-bordered table-hover org-det-table">
                <thead>
                    <tr>
                        <th>Length</th>
                        <th>Width</th>
                        <th>Height</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="branch-dimension">
                        <td id="org_length"></td>
                        <td id="org_breadth"></td>
                        <td id="org_height"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="clear_fix_both"></div><br />
<h4>Branch Staff
    <div class="fr">
        <a href="javascript:;" title="Add" class="btn btn-default btn-sm del" onclick="addBranchContactsDialog()"><i class="fa fa-plus igreen"></i></a>
    </div>
</h4>
<div class="clear_fix_both"></div><br />
<div class='responsive-table1'>
    <div class='table-responsive'>
        <table id="datatable2" cellpadding="0" cellspacing="0" border="0" class="datatable table table-striped table-bordered table-hover branch-staff-table" >
            <thead>
                <tr>
                    <th>Employee Code</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Category</th>
                    <th>Mobile Number</th>
                    <th>Alt Mobile Number</th>
                    <th>Qualification</th>
                    <th>Language</th>
                    <th>POB <i class="fa fa-info-circle" title="Place Of Birth"></i></th>
                    <th>Address</th>
                    <th>Remark</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brn_con']->value, 'brn', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['brn']->value) {
?>
                    <?php $_smarty_tpl->_assignInScope('pob', '');?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['val']->value->code == $_smarty_tpl->tpl_vars['brn']->value->placeOfBirth) {?>
                            <?php $_smarty_tpl->_assignInScope('pob', $_smarty_tpl->tpl_vars['val']->value->name);?>
                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <tr>
                        <td width="9%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->aliasCode;?>
</td>
                        <td width="8%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->name;?>
</td>
                        <td width="2%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->age;?>
</td>
                        <td width="6%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->category->name;?>
</td>
                        <td width="14%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->mobile;?>
</td>
                        <td width="14%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->alternateMobile;?>
</td>
                        <td width="6%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->qualification;?>
</td>
                        <td width="8%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->languages;?>
</td>
                        <td width="10%">
                            <?php if ($_smarty_tpl->tpl_vars['pob']->value != '') {?>
                                <?php echo $_smarty_tpl->tpl_vars['pob']->value;?>

                            <?php } else { ?>
                                <?php $_smarty_tpl->_assignInScope('p_o_b', explode("-",$_smarty_tpl->tpl_vars['brn']->value->placeOfBirth));?>
                                <?php echo $_smarty_tpl->tpl_vars['p_o_b']->value[1];?>

                            <?php }?>
                        </td>
                        <td width="12%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->address;?>
</td>
                        <td width="7%"><?php echo $_smarty_tpl->tpl_vars['brn']->value->remarks;?>
</td>
                        <td width="4%">
                            <span>
                                <a href="javascript:;" title="edit" class="brn-con-edit" onclick='addBranchContactsDialog(<?php echo json_encode($_smarty_tpl->tpl_vars['brn']->value);?>
)' ><i class="fa fa fa-pencil fa-lg igreen"></i></a>
                            </span>
                            
                            <span>
                                <a href="javascript:;" title="delete" class="brn-con-delete"  onclick='deleteBranchContact(<?php echo json_encode($_smarty_tpl->tpl_vars['brn']->value);?>
)'><i class="fa fa-trash-o fa-lg ired"></i></a>
                            </span>
                        </td>
                    </tr>
                    <?php
}
} else {
?>
                        <tr>
                            <td align="center" colspan="12">No Data Found !!!</td>
                        </tr> 
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
        </table>
    </div>
</div>


<div id="user-organization-dialog" class="hide dialog-content-page">
    <h4>Users <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-ADD-USER'] > 0) {?> <a href="javascript:;" title="Add user" class="btn btn-success pull-right" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-ADD-USER'] != 2) {?>onclick="allUserOrganizations('<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
')" <?php }?>>Add User</a><?php }?></h4>
    <div class="clear_fix_both b_b"></div>
    <?php if (count($_smarty_tpl->tpl_vars['user']->value) > 0) {?>
        <div id="org_scroll">
            <ul class="user_list rmv-tp-br"
                id="org_usr">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['user']->value, 'usr', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['usr']->value) {
?>
                    <li class="p_l_n p_r_n"
                        id="usr_<?php echo $_smarty_tpl->tpl_vars['usr']->value->code;?>
">
                        <div class="pull-left"><?php echo $_smarty_tpl->tpl_vars['usr']->value->name;?>

                        </div>
                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-CHANGE-MAP'] > 0) {?>
                            <div class="pull-right">
                                <a title="Change organization" href="javascript:;" class="btn btn-default btn-xs" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-CHANGE-MAP'] != 2) {?>onclick="organtaionDialogUser('<?php echo $_smarty_tpl->tpl_vars['usr']->value->code;?>
', '<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
', 'org')" <?php }?>><i class="fa fa-pencil"></i></a>
                            </div>
                        <?php }?>
                    </li>
                    <?php $_smarty_tpl->_assignInScope('usr_det', ((string)$_smarty_tpl->tpl_vars['usr_det']->value).",".((string)$_smarty_tpl->tpl_vars['usr']->value->code));?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </ul>

            <input type="hidden" id="alr_usr_<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
" value="<?php echo $_smarty_tpl->tpl_vars['usr_det']->value;?>
" />
        </div>
    <?php } else { ?>
        <div class="well well-large "> No user available .</div>
    <?php }?>
    <div class="clear_fix_both"> <br />
    <div class="align-right" id="user-organization-bttons">
        <button class="btn btn-default" type="button" onclick="cancelUserOrganizationDialog();">Cancel</button>
    </div>
</div>

<?php echo '<script'; ?>
 type="text/javascript">
    var fileupload = new fileUpload('#ie-fileupload');
    var dmsdomain = '<?php echo $_smarty_tpl->tpl_vars['dms_domain']->value;?>
';
    
    var dim = <?php echo json_encode($_smarty_tpl->tpl_vars['org_dimension']->value);?>
;
    if(dim.dimensions){
        var dimension = dim.dimensions.split('|');
        
        $('#org_breadth').text(dimension[1]);
        $('#org_length').text(dimension[0]);
        $('#org_height').text(dimension[2]);
    }else{
        $('.branch-dimension').html('<td colspan="3" align="center">No data found</td>')
    }

    if (dim.bankDetails) {
        var bank_detail = "";
        $.each(dim.bankDetails, function( key, value ) {
            bank_detail = bank_detail + '<li><b>'+value.bankName+', '+value.branchLocation+'</b><br><b>UPI:</b> '+value.upiId+'</li>'
        });
        $('#org_bank').html('<ol>'+bank_detail+'</ol>');
    } else {
        $('#org_bank').html('<div class="well well-sm m-0"> No bank details available!</div>');
    }

    $('.file-upload-buttons, #org-upload-btn').on('click', function(){
        $('.file-upload-gallery').on('DOMSubtreeModified', function(){
            if($('.file-upload-gallery .file-upload-file').length > 0){
                $('.file-upload-buttons').addClass('hide');
                $('#org-upload-btn').removeClass('hide');
            }else{
                $('.file-upload-buttons').removeClass('hide');
                $('#org-upload-btn').addClass('hide');
            }
        });
    });
    
    $(document).ready(function ($) {
        $("#org_scroll").css({
        'max-height': '220px',
        }).perfectScrollbar({
            wheelSpeed: 20,
            wheelPropagation: false
        });
    });
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
>
    $('a[id=popup_msg]').attr('data-toggle', 'popover').attr('data-container', 'body');
    $('a[id=popup_msg]').attr('data-placement', 'top').attr('data-trigger', 'hover');
    $('[data-toggle=popover]').popover({
        container: "body",
        html: true
    });
<?php echo '</script'; ?>
><?php }
}
