<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-11 16:23:39
  from 'E:\xampp\htdocs\cargo\application\views\site\profile\edit.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66682cb3349f80_13071065',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'e1d6aaa4dd42b078b79b35c484397b3d7d88b47d' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\profile\\edit.tpl',
      1 => 1716451521,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66682cb3349f80_13071065 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top"><h3> Namespace Settings</h3></div>
<div id="main_wrapper">
    <div class="page_content" style="min-height: 350px;">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12" >
                    <br>
                    <div class="panel panel-default">
                        <div class="panel-body">

                            <div class="tabbable">
                                <ul class="nav nav-tabs" id="tabs_a">
                                    <li class="active">
                                        <a data-toggle="tab" href="#account_setting">Namespace Settings</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#notification_setting">Namespace Alert</a>
                                    </li>
                                </ul>
                                <div class="tab-content" id="tabs_content_a">
                                    <div id="account_setting" class="tab-pane in active">
                                        <form role="form" id="form1" class="form-horizontal p_l_15">

                                            <div class="row">
                                                <h5 class="b_b_d">Namespace Details</h5>

                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">Name</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->name;?>
' class="he_25 form-control" id="e_name" >
                                                </div>

                                                <div class="col-sm-1">
                                                    <h4 class="heading_a req">Pin</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->pin;?>
' class="he_25 form-control" id="e_pin">
                                                </div>
                                                
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Code</h4>
                                                    <input type="text" readonly value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->code;?>
' class="he_25 form-control" id="e_code">
                                                </div>
                                                
                                                </div>
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">City</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->city;?>
' class="he_25 form-control" id="e_city">
                                                    <h4 class="req heading_a">State</h4>
                                                    <select class="form-control" id="ecs_state">
                                                        <option value="">Select a state</option>
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value, 'st', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['st']->value) {
?>
                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['st']->value->code;?>
" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->state->code == $_smarty_tpl->tpl_vars['st']->value->code) {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['st']->value->name;?>
</option>    
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>                                                        
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Pincode</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->pincode;?>
' class="he_25 form-control" id="e_pincode">
                                                    <h4 class="req heading_a">Support Number</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->supportNumber;?>
' class="he_25 form-control" id="e_supportno">
                                                </div>
                                                <div class="col-sm-3">
                                                    <h4 class="heading_a">Address</h4>
                                                    <textarea class="form-control" id="e_address" rows="5" maxlength="250"><?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->address;?>
</textarea>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <h5 class="b_b_d">Whatsapp Notification</h5>
                                                <div class="col-sm-4">
                                                    <h4 class="heading_a">Whatsapp</h4>
                                                    <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->whatsappNotificationFlagCode == '') {?>
                                                        <?php $_smarty_tpl->_assignInScope('whatsappNotificationFlagCode', '000000');?>
                                                    <?php } else { ?>
                                                        <?php $_smarty_tpl->_assignInScope('whatsappNotificationFlagCode', $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->whatsappNotificationFlagCode);?>
                                                    <?php }?>
                                                    <div class="btn-group btn-group-days" id="whatsappNotificationFlagCode" data-toggle="buttons">
                                                        <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,0,1) == 1) {?>active<?php }?>" title="Cargo Booking To <?php echo lang('booking_sender_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,0,1) == 1) {?>checked="checked" <?php }?> name="week" value="1">CBF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,1,1) == 1) {?>active<?php }?>" title="Cargo Booking To <?php echo lang('booking_receiver_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,1,1) == 1) {?>checked="checked" <?php }?> name="week" value="1">CBT
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,2,1) == 1) {?>active<?php }?>" title="Cargo Delivery To <?php echo lang('booking_sender_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,2,1) == 1) {?>checked="checked" <?php }?> name="week" value="1">CDF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,3,1) == 1) {?>active<?php }?>" title="Cargo Delivery To <?php echo lang('booking_receiver_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,3,1) == 1) {?>checked="checked" <?php }?> name="week" value="1">CDT
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,4,1) == 1) {?>active<?php }?>" title="Cargo Unload From">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,4,1) == 1) {?>checked="checked" <?php }?> name="week" value="1">CUF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,5,1) == 1) {?>active<?php }?>" title="Cargo Unload To">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['whatsappNotificationFlagCode']->value,5,1) == 1) {?>checked="checked" <?php }?> name="week" value="1">CUT
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">Whatsapp Provider</h4>
                                                    <select id="e_whatsappProviderCode" name="e_whatsappProviderCode" class="form-control">
                                                        <option value="NA" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->whatsappProviderCode == 'NA') {?>selected<?php }?>>Not Available</option>
                                                        <option value="QIKBRY" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->whatsappProviderCode == 'QIKBRY') {?>selected<?php }?>>Qikberry</option>
                                                        <option value="KLYAEB" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->whatsappProviderCode == 'KLYAEB') {?>selected<?php }?>>Kaleyra</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a  req">Notification Type</h4>
                                                    <select id="notification_mode" class="he_29 form-control" name='notificationPreferences'>
                                                        <option value="SMS" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->notificationPreferences->code == 'SMS') {?>selected<?php }?>>SMS</option>
                                                        <option value="WTSAPP" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->notificationPreferences->code == 'WTSAPP') {?>selected<?php }?>>WhatsApp</option>
                                                        <option value="WASMS" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->notificationPreferences->code == 'WASMS') {?>selected<?php }?>>Both</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-3 hide">
                                                    <h4 class="heading_a req">Whatsapp Url</h4>
                                                    <input type="text" value='' class="he_25 form-control col-sm-3" id="e_whatsappUrl" data-size="small" maxlength="20">
                                                </div>
                                                <div class="col-sm-2 hide">
                                                    <h4 class="req heading_a">whatsappNumber</h4>
                                                    <input type="text" value='' class="he_25 form-control" id="e_whatsappNumber">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <h5 class="b_b_d">SMS & Email Notification</h5>
                                                <!--<div class="col-sm-2">
                                                    <h4 class="heading_a">Phone booking</h4>
                                                    <input type="checkbox" id="ph_bkg" name ='ph_bkg' class="bs_switch" data-size="small" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->phoneBookingflag == 1) {?>checked='checked'<?php }?>>
                                                </div> -->
                                                
                                                <div class="col-sm-4">
                                                    <h4 class="heading_a">SMS</h4>
                                                    <!--<input type="checkbox" id="sms_chk"  name="sms_chk" class="bs_switch" data-size="small" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->smsNotificationFlag == 1) {?>checked='checked'<?php }?>>-->
                                                    
                                                    <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->smsNotificationFlagCode == '') {?>
                                                        <?php $_smarty_tpl->_assignInScope('day', '00000000');?>
                                                    <?php } else { ?>
                                                        <?php $_smarty_tpl->_assignInScope('day', $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->smsNotificationFlagCode);?>
                                                    <?php }?>
                                                    <div class="btn-group btn-group-days" id="smsnotification" data-toggle="buttons">
                                                        <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['day']->value,0,1) == 1) {?>active<?php }?>" title="Cargo Booking To <?php echo lang('booking_sender_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,0,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CBS
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,1,1) == 1) {?>active<?php }?>" title="Cargo Booking To <?php echo lang('booking_receiver_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,1,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CBR
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,2,1) == 1) {?>active<?php }?>" title="Cargo Delivery To <?php echo lang('booking_sender_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,2,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CDS
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,3,1) == 1) {?>active<?php }?>" title="Cargo Delivery To <?php echo lang('booking_receiver_term');?>
">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,3,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CDR
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,4,1) == 1) {?>active<?php }?>" title="Cargo Unload From">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,4,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CUF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,5,1) == 1) {?>active<?php }?>" title="Cargo Unload To">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,5,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CUT
                                                        </label>
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,6,1) == 1) {?>active<?php }?>" title="Cargo Cancel">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,6,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CCL
                                                        </label>
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  <?php if (substr($_smarty_tpl->tpl_vars['day']->value,7,1) == 1) {?>active<?php }?>" title="Cargo Edit">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['day']->value,7,1) == 1) {?>checked="checked"<?php }?> name="week" value="1">CED
                                                        </label>
                                                    </div> 
                                                    
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">SMS Header Name</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->smsSenderCode;?>
' class="he_25 form-control col-sm-3" id="sms_code" data-size="small" maxlength="6">
                                                </div>
                                                <div class="col-sm-2" >
                                                    <h4 class="heading_a req">SMS Provider</h4>
                                                    <select id="sms_provider" name="sms_provider" class="form-control"> 
                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['smsprovider']->value, 'provider', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['provider']->value) {
?>
                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['provider']->value->code;?>
" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->smsProviderCode == $_smarty_tpl->tpl_vars['provider']->value->code) {?>selected<?php }?>><?php echo $_smarty_tpl->tpl_vars['provider']->value->code;?>
</option>    
                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?> 
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Email</h4>
                                                    <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->emailNotificationFlagCode == '') {?>
                                                        <?php $_smarty_tpl->_assignInScope('email', '00000000');?>
                                                    <?php } else { ?>
                                                        <?php $_smarty_tpl->_assignInScope('email', $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->emailNotificationFlagCode);?>
                                                    <?php }?>
                                                    <div class="btn-group btn-group-days" id="emailnotification" data-toggle="buttons">
                                                        <label class="btn btn-success btn-xs chk-btn <?php if (substr($_smarty_tpl->tpl_vars['email']->value,0,1) == 1) {?>active<?php }?>" title="Cargo Booking Vendor ">
                                                            <input type="checkbox" <?php if (substr($_smarty_tpl->tpl_vars['email']->value,0,1) == 1) {?>checked="checked"<?php }?> name="email" value="1">CBV
                                                        </label>
                                                    </div> 

                                                </div>
                                            </div>

                                            <div class="row">
                                                                
                                                <h5 class="b_b_d">Date & Time Format</h5>
                                                
                                                <div class="col-sm-2">

                                                    <h4 class="heading_a  req">Date Format</h4>
                                                <!--<input type="text" value='<?php echo $_smarty_tpl->tpl_vars['profile']->value->dateFormate;?>
'  class="he_25 form-control col-sm-3" id="date_for" data-size="small">-->
                                                    <select id="date_for" class="he_29 form-control" style="font-size:10px !important" name='date_for'>
                                                        <option value="Y-m-d" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->dateFormate == 'Y-m-d') {?>selected<?php }?> >Y-m-d</option>
                                                        <option value="d-m-Y" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->dateFormate == 'd-m-Y') {?>selected<?php }?>>d-m-y</option>
                                                        <option value="e/b/Y" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->dateFormate == 'e/b/Y') {?>selected<?php }?>>e/b/Y</option>
                                                        <option value="D" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->dateFormate == 'D') {?>selected<?php }?>>D</option>
                                                        <option value="d-b-y" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->dateFormate == 'd-b-y') {?>selected<?php }?>>d-b-y</option>
                                                    </select>
                                                </div>

                                                <div class="col-sm-2">
                                                    <h4 class="heading_a  req">Time format</h4>
                                                <!-- <input type="text"  value='<?php echo $_smarty_tpl->tpl_vars['profile']->value->timeFormat;?>
' class="he_25 form-control" id="tme_for" data-size="small" maxlength="3">-->
                                                    <select id="tme_for" class="he_29 form-control" style="font-size:10px !important" name='tme_for'>
                                                        <option value="12" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->timeFormat == '12') {?>selected<?php }?>>12</option>
                                                        <option value="24" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->timeFormat == '24') {?>selected<?php }?>>24</option>
                                                    </select>
                                                </div>
                                                    
                                                <div class="col-sm-2 hide">
                                                    <h4 class="heading_a">DP Flag</h4>
                                                    <input type="checkbox" id="drop" name="drop" class="bs_switch" data-size="small" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->droppingPointRequriedFlag == 1) {?>checked='checked'<?php }?>>
                                                </div>   

                                            </div>
                                            
                                            <div class="row">
                                                                
                                                <h5 class="b_b_d">E-Way Bill</h5>

                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">E-Way Bill Vendor</h4>
                                                    <select class="he_29 form-control" id="ewaybill-vendor">
                                                        <option value="NA" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->ewayBillVendorCode == 'NA') {?>selected<?php }?>>Not Available</option>
                                                        <option value="ADAEQUARE" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->ewayBillVendorCode == 'ADAEQUARE') {?>selected<?php }?>>Default</option>
                                                    </select>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <h5 class="b_b_d">Others</h5>
                                                
                                                <div class="col-sm-2" >
                                                    <h4 class="heading_a req">Instant Cancellation (Mins)</h4>
                                                    <input type="number" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->instantCancellationMinitues;?>
' class="he_25 form-control col-sm-3 no-spin" id="ins_can_min" data-size="small">
                                                </div>
                                                
                                                <div class="col-sm-2" >
                                                    <label for="auto_gen_voucher">&nbsp;</label>
                                                    <input type="checkbox" id="auto_gen_voucher" name="auto_gen_voucher" class="he_25 col-sm-3" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->autoGenerateVoucherFlag == 1) {?> checked='checked' <?php }?> data-size="small"/> 
                                                    <label  for="auto_gen_voucher" style="display: inline;font-weight: normal;">&nbsp;&nbsp;Auto Generate Voucher</label>
                                                </div>

                                                <div class="col-sm-2" >
                                                    <label for="allow_direct_login">&nbsp;</label>
                                                    <input type="checkbox" id="allow_direct_login" name="allow_direct_login" class="he_25 col-sm-3" <?php if ($_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->allowDirectLogin == 1) {?> checked='checked' <?php }?> data-size="small"/> 
                                                    <label  for="allow_direct_login" style="display: inline;font-weight: normal;">&nbsp;&nbsp;Allow Direct EzeeCargo Login</label>
                                                </div>

                                                <div class="col-sm-2" >
                                                    <label for="allow_direct_login">&nbsp;</label>
                                                    <a class="align-right" onclick="reportDaysGroupWiseDialog()" href="javascript:;" title="click to link"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>Report Days For Groupwise</a>
                                                </div>
                                            </div> 
                                            <div class="row">
                                                
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">Start code</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->shortCode;?>
' class="he_25 form-control col-sm-3" id="shortcode" data-size="small" maxlength="6">
                                                </div>  
                                                <div class="col-sm-3">
                                                    <h4 class="heading_a req">Website</h4>
                                                    <input type="text" value='<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->domainURL;?>
' class="he_25 form-control col-sm-3" id="url" data-size="small" >
                                                </div>
                                            </div>  
                                            
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <h4 class="heading_a">Manage Expense Balance Exception</h4>
                                                    <select id="nsp_balanceOnManageExpense" name="nsp_balanceOnManageExpense" multiple  class="form-control" >
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row', false, 'grp', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grp']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                            <option value='<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
'><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                    </select>
                                                </div>  
                                            </div>  
                                                  
                                            <div class="row">
                                                <h5 class="b_b_d">Two Factor Authentication</h5>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">OTP Verify Group</h4>
                                                    <select id="otp_verify_grp" name="otp_verify_grp" multiple  class="form-control" >                                               
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row', false, 'grp', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grp']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                            <option value='<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
'><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Expire Password Group</h4>
                                                    <select id="exp_pwd_grp" name="exp_pwd_grp" multiple  class="form-control" >  
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row', false, 'grp', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grp']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                            <option value='<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
'><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                    </select>
                                                </div>
                                                
                                            </div>

                                            <div class="clearfix"></div>
                                            <br/>

                                            <div class="row">
                                                <h5 class="b_b_d">Readonly</h5>
                                                <div class="col-sm-2 form-check-inline pb10">
                                                    <label title="<?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->dayOfHour;?>
">
                                                        Reporting Days - <?php echo $_smarty_tpl->tpl_vars['nsprofile']->value->namespaceProfile->reportingDays;?>
 days
                                                    </label>
                                                </div>
                                            </div>

                                            <br>
                                            <div class="row">
                                                <div id="ur-org-loading"></div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none" id="usr-org-state"></div>
                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-EDIT'] > 0) {?>
                                                    <div  id="form-org-bttons">
                                                        <button type="button" id="btn-save" class="btn btn-success" style="margin-left:600px" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-EDIT'] == 1) {?>onclick="saveProfile()"<?php }?>>Save</button>
                                                    </div>
                                                <?php }?>
                                        </form>
                                    </div>

                                </div>
                                <div id="notification_setting" class="tab-pane fade">
                                    <form onsubmit="return false;">
                                        <div class="">
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label for="alert-event-types">Alert Event Types</label>
                                                    <select class="form-control" id="alert-event-types" multiple>
                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['eventTypes']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                            <option value='<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
'><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <div class="col-md-6">
                                                <div class="clear_fix_both"></div>
                                                <div class="alert" style="display:none" id="alert-noti-state"></div>
                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-EDIT'] > 0) {?>
                                                    <button type="button" id="btn-save" class="btn btn-success" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['NSCE-EDIT'] == 1) {?>onclick="saveNotiStatus()"<?php }?>>Save</button>
                                                <?php }?>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                </div>
                                <div class="clear_fix_both"></div>
                        </div><!--panel Body end-->
                    </div><!--panel end-->
                </div>
            </div>
        </div>
    </div>


    <div id="rpt-days-groupwise-dialog" class="hide dialog-content-page">
        <span><b>Allow Max Days By Groupwise</b></span>
        <div class="row">
            <div class="col-md-6">
                <label class="req">Group</label>
            </div>
            <div class="col-md-6">
                <label class="req">Max Days</label>
            </div>
        </div>
        <div id="grp-rpt-day-list"></div>
        <div>
            <button class="btn btn-xs btn-primary m-t-5" onclick="addRptDays()"><i class="fa fa-plus"></i> Add</button>
        </div>
        <br>
        <div class="align-center alert alert-danger pull-left" style="display:none" id="rpt-days-groupwise-action-state"></div>
        <div class="align-right" id="ie-head-buttons">
            <button class="btn btn-success" type="button" onclick="saveReportDaysGropwise();">Save</button>
            <button class="btn btn-default" type="button" onclick="closeRptDaysDialog();">Cancel</button>
        </div>
    </div>

    <?php echo '<script'; ?>
 type="text/html" id="row-rpt-days-tpl">
        <div class="row grp-rpt-days-row">
            <div class="col-md-6">
                <div class="form-group">
                    <select multiple class="form-control nsp-rpt-grps" name="nsp-rpt-grps">
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row', false, 'grp', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grp']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <option value='<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
'><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                </div>
            </div>
            <div class="col-md-5">
                <div class="form-group">
                    <input type="number" class="form-control nsp-grp-days" placeholder="Days" min="1" max="30">
                </div>
            </div>
            <div class="col-md-1">
                <button class="btn btn-xs m-t-5" onclick="removeRptDays(this)"><i class="fa fa-times"></i></button>
            </div>
        </div>
    <?php echo '</script'; ?>
>
    <?php echo '<script'; ?>
>

        $('.bs_switch').bootstrapSwitch('size', 'mini');
        
        var pro = <?php echo json_encode($_smarty_tpl->tpl_vars['nsprofile']->value);?>
;
        var nsAlerts = <?php echo json_encode($_smarty_tpl->tpl_vars['nsAlerts']->value);?>
;

        $('#otp_verify_grp').select2();
        $('#exp_pwd_grp').select2();

        $('#alert-event-types').multiselect({
            maxHeight: 250,
            numberDisplayed: 1,
            dropLeft: true,
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            buttonClass: 'btn btn-default alert-event-types',
            buttonContainer: '<div id="alert-event-types" class="custom-cb multiselect-inline alert-event-types" style="max-height: 250px; position: relative;"></div>',
            templates: {
                button: '',
                ul: '<ul class="multiselect-container checkbox-list" style="position: relative;"></ul>',
                li: '<li><label></label></li>',
            }
        });

        $('#nsp_balanceOnManageExpense').multiselect({
            maxHeight: 200,
            numberDisplayed: 1,
            buttonWidth: '200px',
            dropLeft: true,
            buttonClass: 'btn btn-default nsp_balanceOnManageExpense',
            nonSelectedText: 'Select Group',
        });
        
        if( _isdefined(nsAlerts) ) {
            $('#alert-event-types').multiselect('select', $.map(nsAlerts || [], function(obj) {
                return obj.code;
            }));
        }
        
        if( _isdefined(pro.namespaceProfile.balanceOnManageExpense) ) {
            $('#nsp_balanceOnManageExpense').multiselect('select', $.map(pro.namespaceProfile.balanceOnManageExpense || [], function(obj) {
                return obj.code;
            }));
        }
        
        if( _isdefined(pro.namespaceProfile.expirePasswordGroup) ) {
            $('#exp_pwd_grp').val(pro.namespaceProfile.expirePasswordGroup.map(function(obj) {
                return obj.code;
            })).trigger('change');
        }
        
        if( _isdefined(pro.namespaceProfile.otpVerifyGroup) ) {
            $('#otp_verify_grp').val(pro.namespaceProfile.otpVerifyGroup.map(function(obj) {
                return obj.code;
            })).trigger('change');
        }
        
        function reportDaysGroupWiseDialog() {
            $('#rpt-days-groupwise-dialog').removeClass('hide');
            $('#rpt-days-groupwise-dialog').dialog({
                autoOpen: true,
                width: 700,
                maxWidth: 600,
                height: 500,
                resizable: false,
                modal: true
            });
        }

        function saveReportDaysGropwise() {
            $('.inp_error').removeClass('inp_error');
            var err = 0;
            var data = {};

            data.allowMaxDaysByGroup = [];
            $('#grp-rpt-day-list .grp-rpt-days-row').each(function(i, row) {
                var $row = $(row);
                var group = $row.find('select[name=nsp-rpt-grps]').val();
                var reportingDays = $row.find('.nsp-grp-days').val();

                $.each(group || [], function(k,code) {
                    var allGrouplist = {};
                    allGrouplist.code = code;
                    allGrouplist.reportingDays = reportingDays;
                    data.allowMaxDaysByGroup.push(allGrouplist);
                });

                if (isNull(group) || isNotNull(group) && group.length == 0) {
                    $row.find('select[name=nsp-rpt-grps]').addClass('inp_error').focus();
                    err++;
                }

                if (isNull(reportingDays) || isNotNull(reportingDays) && reportingDays <= 0) {
                    $row.find('.nsp-grp-days').addClass('inp_error').focus();
                    err++;
                }
            });

            if (err > 0) {
                $('#rpt-days-groupwise-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#rpt-days-groupwise-action-state').html('Please enter/select the values in the field that are marked in red');
                $('#rpt-days-groupwise-action-state').show();
                return false;
            } else {
                $('#rpt-days-groupwise-action-state').removeClass('alert-success').removeClass('alert-danger');
                $('#rpt-days-groupwise-action-state').html('');
                $('#rpt-days-groupwise-action-state').hide();
            }

            $('#rpt-days-groupwise-action-state').html(loading_popup);

            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: base_url + 'profile/update-nsp-rpt-days',
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#rpt-days-groupwise-action-state').show();
                        $('#rpt-days-groupwise-action-state').removeClass('alert-danger');
                        $('#rpt-days-groupwise-action-state').addClass('alert-success');
                        $('#rpt-days-groupwise-action-state').html('Your request has been completed successfully');
                        window.setTimeout(function () {
                            closeRptDaysDialog();
                        }, 3000);
                    } else {
                        $('#rpt-days-groupwise-action-state').show();
                        $('#rpt-days-groupwise-action-state').removeClass('alert-success');
                        $('#rpt-days-groupwise-action-state').addClass('alert-danger');
                        $('#rpt-days-groupwise-action-state').html(response.errorDesc);
                    }
                }
            });
        }

        function closeRptDaysDialog() {
            $('.inp_error').removeClass('inp_error');
            $('.nsp-rpt-grps, .nsp-grp-days').val('').trigger('change');
            $('#rpt-days-groupwise-action-state').removeClass('alert-success').removeClass('alert-danger').html('').hide();
            $('#grp-rpt-day-list .grp-rpt-days-row').not(':first-child').remove();
            
            $('#rpt-days-groupwise-dialog').dialog('destroy');
            $('#rpt-days-groupwise-dialog').hide();
        }

        function addRptDays() {
            var GroupRow = $('#row-rpt-days-tpl').html();
            var $tpl = $(GroupRow);

            $tpl.find('.nsp-rpt-grps').select2();
            return $tpl.appendTo('#grp-rpt-day-list');
        }
        addRptDays();

        function removeRptDays(btn) {
            if($('#grp-rpt-day-list .grp-rpt-days-row').length > 1){
                $(btn).closest('.grp-rpt-days-row').remove();
            }
        }
    <?php echo '</script'; ?>
>


<?php }
}
