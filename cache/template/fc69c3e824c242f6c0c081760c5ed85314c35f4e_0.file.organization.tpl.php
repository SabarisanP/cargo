<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 15:23:29
  from 'E:\xampp\htdocs\cargo\application\views\site\config\organization.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d9299713210_69222706',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'fc69c3e824c242f6c0c081760c5ed85314c35f4e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\config\\organization.tpl',
      1 => 1716451515,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:site/template/organization-dialog.tpl' => 1,
  ),
),false)) {
function content_665d9299713210_69222706 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Organizations</h3> <span class="align-right"><?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-ADD'] > 0) {?><a href="javascript:;"
                class="btn btn-success  btn-sm" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['ORG-ADD'] != 2) {?>onclick="editOrganization();" <?php }?>>Add New
            Organization</a><?php }?></span>
</div>
<div id="main_wrapper">
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
                                    <div class="col-md-3">
                                        <div class="align-center" id="action-status"></div>
                                        <h4>Branch</h4>
                                        <div id="namespace">
                                            <div class="well well-sm">
                                                <input type="text" class="form-control" placeholder="Find Branch..." id="list_search">
                                            </div>
                                            <div class="user_list_action bt_36">
                                                <ul class="user_list " id="user_list_search">
                                                    <ul class="user_list " id="user_list_search" style="border:none">
                                                        <?php if (count($_smarty_tpl->tpl_vars['branch']->value) > 0) {?>
                                                            <div id="station_scroll">
                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branch']->value, 'stgrp', false, 'statename');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statename']->value => $_smarty_tpl->tpl_vars['stgrp']->value) {
?>
                                                                    <li class="rt_8">
                                                                        <div class="bold">
                                                                            <?php echo $_smarty_tpl->tpl_vars['statename']->value;?>

                                                                        </div>
                                                                    </li>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stgrp']->value, 'branch');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                                                        <li id="ns-<?php echo $_smarty_tpl->tpl_vars['branch']->value['code'];?>
" style="padding-left:10px;">
                                                                            <div class="fl rt_8">
                                                                                <a href="javascript:;" onclick="getbranchDetail(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['branch']->value), ENT_QUOTES, 'UTF-8', true);?>
);"><?php echo $_smarty_tpl->tpl_vars['branch']->value['name'];?>
</a>
                                                                            </div>
                                                                            <div class="fr fr_7">
                                                                                <?php echo $_smarty_tpl->tpl_vars['branch']->value['shortCode'];?>

                                                                            </div>
                                                                            <div>
                                                                                <?php if ($_smarty_tpl->tpl_vars['branch']->value['activeFlag'] == 0) {?>
                                                                                    <a href="javascript:;" onclick="getbranchDetail(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['branch']->value), ENT_QUOTES, 'UTF-8', true);?>
);" class="label label-warning  left no-hover">Disabled</a>
                                                                                <?php }?>
                                                                            </div>
                                                                        </li>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                            </div>
                                                        <?php } else { ?>
                                                            <li class="er_msg">
                                                                <div class="well well-large "> No Branch found!</div>
                                                            </li>
                                                        <?php }?>
                                                    </ul>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div id="branch-result">
                                            <div class="p_t_100">
                                                <div class="well well-large "> Click any of the branch to view the branch details.</div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" value="" id="addedit_sel_station_id"
                                        name="addedit_sel_station_id" />
                                </div>
                                <!--panel Body end-->
                            </div>
                            <!--panel end-->
                        </div>
                    </div>
                    <!--row end-->
                </div>
                <!--content end-->
            </div>
        </div>
    </div>

</div>

<input type="hidden" id="branch-detail">

<div id="pg-organization-dialog" class="hide dialog-content-page">
    <div class="">
        <div class="col-md-6">
            <form role="form" id="form1" class="form-horizontal ">
                <div class="row">
                    <div class="col-md-5">
                        <div class="form-group">
                            <div>
                                <label for="txt_oz_type">Organization Type</label>
                                <select id="txt_oz_type" class="form-control">
                                    <option value="" selected>Regular</option>
                                    <option value="CDB">Collection / Delivery Branch</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="input-group col-md-12 hide" id="branchCode">
                            <label for="txt_oz_lookupCode">Branch</label>
                            <select id="txt_oz_lookupCode" class="form-control">
                                <option value="">Select Branch</option>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchrg']->value, 'stgrp', false, 'statename');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['statename']->value => $_smarty_tpl->tpl_vars['stgrp']->value) {
?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stgrp']->value, 'branchrg');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['branchrg']->value) {
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['branchrg']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['branchrg']->value['name'];?>
</option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <div class="form-group">
                            <div>
                                <label for="txt_oz_name" class="req">Organization
                                    name</label>
                                <input placeholder="Organization name" id="txt_oz_name" name="txt_oz_name"
                                    class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group p_l_15">
                            <label for="txt_oz_transit_close_time">Transit Close Time</label>
                            <input type="time" name="transitCloseTime" class="form-control" id="txt_oz_transit_close_time" placeholder="Transit Close Time">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="org-bookpaylist">Booking payment type</label>
                            <div>
                                <select id="org-bookpaylist" style="z-index:1000;" class="form-control" multiple>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['payment_status']->value, 'row', false, 'bpt');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bpt']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['bpt']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value;?>
</option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group p_l_15">
                            <label for="org-delpaylist">Delivery payment type</label>
                            <div>
                                <select id="org-delpaylist" style="z-index:1000;" class="form-control" multiple>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['payment_status']->value, 'row', false, 'dpt');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['dpt']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['dpt']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value;?>

                                        </option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div>
                        <label for="txt_oz_address1" class="req">Address1</label>
                        <textarea placeholder="Address1" id="txt_oz_address1" name="txt_oz_address1"
                            class="form-control rs_no"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="txt_oz_address2">Address2</label>
                    <div>
                        <textarea placeholder="Address2" id="txt_oz_address2" name="txt_oz_address2"
                            class="form-control rs_no"></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="txt_oz_contact" class="req">Contact
                                Number</label>
                            <div>
                                <input placeholder="Contact Number" id="txt_oz_contact" name="txt_oz_contact"
                                    class="form-control rs_no">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group p_l_15">
                            <label for="txt_oz_shortcode">Short code</label>
                            <input placeholder="Short Code" id="txt_oz_shortcode" name="Short Code"
                                onblur="validateStation();" class="form-control capitalize" maxlength="5">
                            <span class="text-danger short-code-warning"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="station_list" class="req">Station</label>
                            <div>
                                <select id="station_list" class="form-control col-md-6">
                                    <option value="">Select</option>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'row', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>

                                        </option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group p_l_15">
                            <label for="txt_oz_pincode">Pin code</label>
                            <input placeholder="Pin Code" id="txt_oz_pincode" name="Pin Code"
                                class="form-control rs_no">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="txt_oz_lat">Latitude</label>
                            <input type="number" placeholder="Latitude" id="hid_oz_lat" name="Latitude"
                                class="form-control rs_no">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group p_l_15">
                            <label type="number" for="txt_oz_lng">Longitude</label>
                            <input placeholder="Longitude" id="hid_oz_lng" name="Longitude" class="form-control rs_no">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="txt_oz_user">Primary User</label>
                            <div class="input-group col-md-12">
                                <select id="txt_oz_user" name="userCode" class="form-control">
                                    <option value="" selected="">Select User</option>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groupusers']->value, 'group', false, 'groupname', 'g', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['groupname']->value => $_smarty_tpl->tpl_vars['group']->value) {
?>
                                        <optgroup label="<?php echo $_smarty_tpl->tpl_vars['groupname']->value;?>
">
                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['group']->value, 'usr', false, NULL, 'u', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['usr']->value) {
?>
                                                <option value="<?php echo $_smarty_tpl->tpl_vars['usr']->value->code;?>
" data-orgcode="<?php echo $_smarty_tpl->tpl_vars['usr']->value->organization->code;?>
"><?php echo $_smarty_tpl->tpl_vars['usr']->value->name;?>
</option>
                                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                        </optgroup>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group p_l_15">
                            <label for="txt_oz_lat">Min Freight Amount
                                Deviation</label>
                            <div class="input-group">
                                <input type="number" placeholder="Deviation Percentage" id="deviation_percentage" name="Deviation" min="0" max="100" class="form-control rs_no no-spin">
                                <span class="input-group-addon bold">%</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="org-tags">Tags</label>
                            <div>
                                <select id="org-tags" class="form-control col-md-6" multiple>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargotags']->value, 'row', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>

                                        </option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <br>
                        <label>
                            <input type="checkbox" class="he_25 form-check-input" id="hub_flag"> Hub Branch
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="org-transactionMode">Transaction Mode</label>
                            <div>
                                <select id="org-transactionMode" class="form-control" multiple>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transactionMode']->value, 'row', false, 'bpt');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bpt']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <option value="<?php echo $_smarty_tpl->tpl_vars['bpt']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value;?>
</option>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group p_l_15">
                            <label for="org-branch-type">Branch Type</label>
                            <select id="org-branch-type" class="form-control" name="branchType">
                                <option value="AGENT" selected>Agent</option>
                                <option value="OFFICE">Office</option>
                            </select>
                        </div>
                    </div>
                </div>
            </form>

            <div class="clear_fix_both"></div><br><br>
            <div class="clear_fix_both">
                <div class="alert fl" style="display: none;" id="org-form-action-state"></div>
                <div class="align-right" id="form-bttons">
                    <input type="hidden" name="id_oz_code" id="id_oz_code" value="" />

                    <button class="btn btn-success" type="button" onclick="saveOrganization();">Save</button>
                    <button class="btn btn-default" type="button" onclick="cancelOrganization();">Cancel</button>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div id="map_canvas" style="width: 95%;"></div>
        </div>
    </div>
</div>

<div id="all_usr_org" class="hide dialog-content-page">
    <form role="form" id="form_org" class="form-horizontal ">
        <label>Please select user</label>
        <div class="ov_fl_230">
            <ul class="user_list">

                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['users']->value, 'usr');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['usr']->value) {
?>
                    <li>
                        <div style="padding-left: 10px;">
                            <div class="radio">
                                <input type="checkbox" id="usr_org_<?php echo $_smarty_tpl->tpl_vars['usr']->value->code;?>
" value="<?php echo $_smarty_tpl->tpl_vars['usr']->value->code;?>
"
                                    class="org_usr_all" data-name="<?php echo $_smarty_tpl->tpl_vars['usr']->value->name;?>
" name="usr_org_all">
                                <label for="usr_org_<?php echo $_smarty_tpl->tpl_vars['usr']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['usr']->value->name;?>
</label>
                            </div>
                        </div>
                    </li>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </ul>
        </div>

        <div class="clear_fix_both"> <br />
            <div class="fl" id="all-form-loading"></div>
            <div class="alert fl" style="display: none;" id="all-org-state"></div>
            <div class="align-right" id="all-form-bttons">
                <input type="hidden" name="aid_oz_code" id="aid_oz_code" value="" />
                <input type="hidden" name="sel_oz_status" id="sel_oz_status" value="1" />

                <button class="btn btn-success" type="button" onclick="saveUserOrganizatio();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelUserOrganization();">Cancel</button>
            </div>
        </div>
    </form>
</div>

<div id="branch-pay-pref-dialog" class="hide dialog-content-page">
    <form role="form" id="pay_pref_form" class="form-horizontal ">
        <div class="form-group" style="display: none;">
            <div>
                <label for="pay-pref-from" class="req">From Organization</label>
                <select class="form-control" id="pay-pref-from" required>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                        <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['val']->value->station->name;?>
</option>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </select>
            </div>
        </div>
        <div class="form-group">
            <div>
                <label for="pay-pref-to" class="req">Dayclosing Preferred branch</label>
                <select class="form-control" id="pay-pref-to" required multiple>
                    <option value="">All</option>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['val']->value->user->code) {?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['val']->value->station->name;?>
</option>
                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </select>
            </div>
        </div>
        <div class="clear_fix_both"> <br />
            <div class="fl" id="all-form-loading"></div>
            <div class="alert fl" style="display: none;" id="pay-pref-action-state"></div>
            <div class="align-right" id="pay-pref-form-bttons">
                <input type="hidden" name="pay-pref_code" id="pay_pref_code" value="" />

                <button class="btn btn-success" type="button" onclick="savePaymentPreference();">Save</button>
                <button class="btn btn-default" type="button" onclick="cancelPaymentPreference();">Cancel</button>
            </div>
        </div>
    </form>
</div>

<div id="org-dimension-dialog" class="hide dialog-content-page">
    <div id="org-dimension-panel" class="clearfix">
        <div class="clearfix">
            <h5>Dimensions</h5>
        </div>
        <div class="row">
            <div class="col-md-4">
                <label class="req">Length</label>
                <input type="number" placeholder="Length" id="organization_length" name="length"  class="form-control" maxlength="6">
            </div>
            <div class="col-md-4">
                <label class="req">Width</label>
                <input type="number" placeholder="Width" id="organization_breadth" name="width"  class="form-control" maxlength="6">
            </div>
            <div class="col-md-4">
                <label class="req">Height</label>
                <input type="number"  placeholder="Height" id="organization_height" name="height"  class="form-control" maxlength="6">
            </div>
        </div>
        <br>
        <div class="clearfix">
            <h5>Bank Details</h5>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="organization_bank">Bank Info</label>
                    <select class="form-control" id="organization_bank" multiple>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['bank_detail']->value, 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?>
                                <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
, Acc No: <?php echo $_smarty_tpl->tpl_vars['val']->value->accountNumber;?>
, Acc Type: <?php echo $_smarty_tpl->tpl_vars['val']->value->accountType->name;?>
, Bank: <?php echo $_smarty_tpl->tpl_vars['val']->value->bankName;?>
, Location: <?php echo $_smarty_tpl->tpl_vars['val']->value->branchLocation;?>
, IFSC: <?php echo $_smarty_tpl->tpl_vars['val']->value->ifscCode;?>
, UPI: <?php echo $_smarty_tpl->tpl_vars['val']->value->upiId;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                                    </div>
            </div>
            <div class="col-md-12">
                <div class="form-group">
                    <label for="organization_bank_img">QR Image</label>
                    <div style="overflow: auto;white-space: nowrap;display: block;">
                        <div class="form-group" id="organization_bank_img"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div><br>
        <div class="col-md-12 text-right" id="org-dimension-panel-btn">
            <input type="hidden" id="org_dimension_code" value="">
            <div id="org-dimension-action-state" class="alert text-left"></div>
            <button type="button" class="btn btn-success" onclick="saveOrganizationDimension();">Save</button>&nbsp;
            <button type="button" class="btn btn-default" id="org-dimension-cancel" onclick="cancelOrganizationDimension();">Cancel</button>&nbsp;
        </div>
    </div>
</div>  


<div id="add-branch-contact-dialog" class="hide dialog-content-page">
    <div class="clear_fix_both">
        <h4>Add Branch Staff</h4>
    </div>
    <div id="">
        <form role="form" class="form-horizontal">
            <div class="col-lg-4">
                <label for="brn-con-alias" class="req">Employee Code</label>
                <input type="text" class="form-control" id="brn-con-alias" placeholder="Employee Code">
            </div>
            
            <div class="col-lg-4">
                <label for="brn-con-name" class="req">Name</label>
                <input type="text" class="form-control" id="brn-con-name" placeholder="Name">
            </div>

            <div class="col-lg-4">
                <label for="brn-con-category" class="req">Category</label>
                <select id="brn-con-category" class="form-control">
                    <option value="">Select</option>
                    <option value="ELEC">Electrician</option>
                    <option value="MECH">Mechanic</option>
                    <option value="SPVSR">Supervisor</option>
                    <option value="LDMN">Loadman</option>
                    <option value="STF">Staff</option>
                    <option value="MNGR">Manager</option>
                </select>
            </div>
            <div class="clear_fix_both"></div><br/>

            <div class="col-lg-4">
                <label for="brn-con-age" class="req">Age</label>
                <input type="number" class="form-control" id="brn-con-age" placeholder="Age" maxlength="2" oninput="this.value=this.value.slice(0,this.maxLength)">
            </div>

            <div class="col-lg-4">
                <label for="brn-con-mob" class="req">Mobile Number</label>
                <input type="text" class="form-control" id="brn-con-mob" placeholder="Mobile Number" onkeypress="return /^[0-9,]*$/.test(event.key)" maxlength="25">
                <span class="text-muted" style="font-size: 11px;"><i class="fa fa-info-circle"></i> Min(10 digits), If more than one mobile number, then follow example ex: xxxxxxxxxx, xxxxxxxxxx</span>
            </div>

            <div class="col-lg-4">
                <label for="brn-con-alt-mob" class="">Alternate Mobile Number</label>
                <input type="text" class="form-control" id="brn-con-alt-mob" placeholder="Alternate Mobile Number" onkeypress="return /^[0-9,]*$/.test(event.key)" maxlength="25">
                <span class="text-muted" style="font-size: 11px;"><i class="fa fa-info-circle"></i> Min(10 digits), If more than one mobile number, then follow example ex: xxxxxxxxxx, xxxxxxxxxx</span>
            </div>
            <div class="clear_fix_both"></div><br/>

            
            <div class="col-lg-8">
                <label for="brn-con-address" class="req">Address</label>
                <textarea id="brn-con-address" placeholder="Enter your Address" style="resize:none" class="form-control" rows="2" cols="10"></textarea>
            </div>

            <div class="col-lg-4">
                <label for="brn-con-qual" class="req">Qualification</label>
                <select id="brn-con-qual" class="form-control">
                    <option value="">Select</option>
                    <option value="10 th">10 th</option>
                    <option value="12 th">12 th</option>
                    <option value="Diploma">Diploma</option>
                    <option value="Degree">Degree</option>
                </select>
            </div>
            <div class="clear_fix_both"></div> <br/>

            <div class="col-lg-4">
                <label for="brn-con-lang" class="req">Languages Known</label>
                <select id="brn-con-lang" class="form-control" multiple>
                    <option value="English">English</option>
                    <option value="Hindi">Hindi</option>
                    <option value="Kannada">Kannada</option>
                    <option value="Malayalam">Malayalam</option>
                    <option value="Tamil">Tamil</option>
                    <option value="Telugu">Telugu</option>
                </select>
            </div>

            <div class="col-lg-4">
                <label for="brn-con-POB" class="req">Place Of Birth</label>
                <select class="form-control" id="brn-con-POB" >
                    <option value="">Select a State</option>   
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value, 'val', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                        <option value="<?php echo $_smarty_tpl->tpl_vars['val']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['val']->value->name;?>
</option>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <option value="OTHERS">Others</option>
                </select>
                <span class="text-muted" style="font-size: 11px;"><i class="fa fa-info-circle"></i> Choose 'Others' if POB location isn't available</span>
            </div>

            <div class="col-lg-4 hide" id="brn-con-other-pob">
                <label for="brn-con-other-POB" class="req">POB (Others)</label>
                <input type="text" class="form-control" id="brn-con-other-POB" placeholder="Enter your POB manually" onkeypress="return /[0-9a-zA-Z]/i.test(event.key)">
            </div>
            <div class="clear_fix_both"></div><br/>

            <div class="col-lg-12">
                <label for="brn-con-remarks" class="">Remarks</label>
                <textarea id="brn-con-remarks" placeholder="Enter your remarks here..." style="resize:none" class="form-control" rows="3" cols="10" name="remark" maxlength="120"></textarea>
            </div>
            <div class="clear_fix_both"></div>
        </form>
    </div>
    <div class="clear_fix_both"> <br />
    
    <div class="clear_fix_both">
        <div class="alert m_b_5" style="display: none;" id="brn_con_action_state"></div>
        <div class="align-right" id="brn-con-add-btns">
            <input type="hidden" id="brn-con-code"/>
            <button class="btn btn-success" type="button" onclick="saveBranchContact();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelBranchContactsDialog();">Cancel</button>
        </div>
    </div>
    <style>
        .form-horizontal {
            padding: 20px;
            min-height: 500px;
            max-height: 500px;
            overflow-y: scroll;
            overflow-x: hidden;
        }
    </style>
    <?php $_smarty_tpl->_subTemplateRender('file:site/template/organization-dialog.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

    <?php echo '<script'; ?>
>
        $('#txt_oz_lookupCode,#station_list').select2();

        $(document).ready(function() {
            $('#txt_oz_type').change(function() {
                var demo = $(this).val();
                if (demo == 'REG' ||demo =='') {
                    $('#branchCode').addClass('hide');
                } else {
                    $('#branchCode').removeClass('hide');
                }
            });
        });

        $('#organization_bank').multiselect({
            maxHeight: 160,
            numberDisplayed: 1,
            buttonWidth: '100%',
            dropLeft: true,
            buttonClass: 'btn btn-default organization_bank',
            templates: {
                // button: '',
                ul: '<ul class="multiselect-container dropdown-menu" style="width: 100%;"></ul>',
                li: '<li><a><label style="white-space: normal;"></label></a></li>',
            }
        });

        $(document).ready(function() {
            $('input#list_search').quicksearch('#user_list_search #station_scroll > li');
        });
        var primary_user_option = $('#txt_oz_user').html();
        $.ui.dialog.prototype._allowInteraction = function(e) {
            return !!$(e.target).closest('.ui-dialog, .ui-datepicker, .select2-drop').length;
        };
        $('#txt_oz_user').select2();
        $('#org-tags').select2({
            placeholder: 'Select Tags'
        });
        $('#org-transactionMode').select2({
            placeholder: 'Select Transactions'
        });
        $('#org-bookpaylist').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '100%',
            dropLeft: true,
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonClass: 'btn btn-default org-bookpaylist',
            templates: {
                ul: '<ul class="multiselect-container dropdown-menu" style="max-height: 200px; min-width: 100%; overflow: hidden auto;"></ul>',
            }
        });
        $('#org-delpaylist').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '100%',
            dropLeft: true,
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonClass: 'btn btn-default org-delpaylist',
            templates: {
                ul: '<ul class="multiselect-container dropdown-menu" style="max-height: 200px; min-width: 100%; overflow: hidden auto;"></ul>',
            }
        });
        $('#brn-con-POB').select2();

        $('#brn-con-lang').select2({
            placeholder: 'Select Language'
        });

        $("#station_scroll").css({
            'max-height': '350px',
        }).perfectScrollbar({
            wheelSpeed: 20,
            wheelPropagation: false
        });

        $('#pay-pref-to').select2({
            placeholder: 'Select To Organization'
        })

        $("#txt_oz_shortcode").bind("input", function(e) {
            this.value = this.value.replace(/[^0-9a-zA-Z]+/g, '').toUpperCase();
        });

        if (typeof google === 'object' && typeof google.maps === 'object') {
            initOrganizationMap();
        } else {
            jQuery.getScript(
                'https://maps.googleapis.com/maps/api/js?key=AIzaSyBka1c5xHw4fhXWhdCYoswmocCSJ1wXqLk&sensor=false&async=2&callback=initOrganizationMap'
            );
        }

        $('#org-all-data').dataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt'
        });

        $('#search-btn').on('keyup click', function() {
            $('#org-all-data').dataTable().fnFilter($('.search-box').val());
            $('#org-all-data tbody tr').removeClass('none');
            $('#org-detail').addClass('none');
        });

        $('#brn-con-POB').on('change', function() {
            if ($(this).val() == 'OTHERS') {
                $('#brn-con-other-pob').removeClass('hide');
            } else {
                $('#brn-con-other-pob').addClass('hide');
            }
        });

        function view(get_data) {
            if ($('#org-detail').hasClass('none')) {
                $('#org-all-data tbody tr').not('#org-' + get_data.code + ', #hid-tr').addClass('none');
                $('#org-detail').removeClass('none');

                var address = get_data.address1 + ',' + get_data.address2 + ' - ' + get_data.pincode;
                $('.address').text(address);
                $('.contact').text(get_data.contact);
            } else {
                $('#org-all-data tbody tr').removeClass('none');
                $('#org-detail').addClass('none');
                $('.address').text('');
                $('.contact').text('');
            }
        }

        function initOrganizationMap() {
            var location = new google.maps.LatLng(13.0827, 80.2707);

            var map = new google.maps.Map(document.getElementById('map_canvas'), {
                zoom: 12,
                center: location,
                streetViewControl: false,
                gestureHandling: 'greedy',
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });

            var marker = new google.maps.Marker({
                position: location,
                map: map,
                draggable: true
            });

            var getLatLng = function(e) {
                if ($('#hid_oz_lat').val().trim() && $('#hid_oz_lng').val().trim()) {
                    location = new google.maps.LatLng($('#hid_oz_lat').val(), $('#hid_oz_lng').val());
                    map.setZoom(18);
                } else {
                    location = new google.maps.LatLng(13.0827, 80.2707);
                    map.setZoom(12);
                }
                marker.setPosition(location);
                map.panTo(location);
            };

            var setLatLng = function(e) {
                $('#hid_oz_lat').val(e.latLng.lat());
                $('#hid_oz_lng').val(e.latLng.lng());
            };

            google.maps.event.addListener(marker, 'dragend', setLatLng);

            google.maps.event.addListener(map, 'click', function(e) {
                marker.setPosition(e.latLng);
                map.setZoom(18);
                map.panTo(e.latLng);
                setLatLng(e);
            });

            $('#hid_oz_lat, #hid_oz_lng').on('change', getLatLng);
        }

        function validateStation() {
            $('#txt_oz_shortcode').removeClass('inp_error');
            $('.short-code-warning').text('')

            var orgcode = $('#aid_oz_code').val();
            var shortcode = $('#txt_oz_shortcode').val().trim().toUpperCase();
            if (!shortcode) return true;

            if ($('.sc-span[data-shortcode="' + shortcode + '"]').not('[data-code="' + orgcode + '"]').length) {
                $('.short-code-warning').text('Short code already Used');
                $('#txt_oz_shortcode').addClass('inp_error');
                return false;
            }

            return true;
        }
<?php echo '</script'; ?>
><?php }
}
