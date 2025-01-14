<style>
    .fav-color {
        height: 30px;
        width: 29px;
        border-radius: 50%;
        border: none;
    }

    .fav-color {
        border-style: none;

    }

    #Appearance-btn .form-control:not(select):not(.select2-container) {
        padding: 0px 0px;
    }
</style>
<div class="brand_top"><h3> Namespace Settings</h3></div>
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
                                    {* <li>
                                        <a data-toggle="tab" href="#Appearance-btn">Appearance</a>
                                    </li> *}
                                </ul>
                                <div class="tab-content" id="tabs_content_a">
                                    <div id="account_setting" class="tab-pane in active">
                                        <form role="form" id="form1" class="form-horizontal p_l_15">

                                            <div class="row">
                                                <h5 class="b_b_d">Namespace Details</h5>

                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">Name</h4>
                                                    <input type="text" value='{$nsprofile->name}' class="he_25 form-control" id="e_name" >
                                                </div>

                                                <div class="col-sm-1">
                                                    <h4 class="heading_a req">Pin</h4>
                                                    <input type="text" value='{$nsprofile->pin}' class="he_25 form-control" id="e_pin">
                                                </div>
                                                
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Code</h4>
                                                    <input type="text" readonly value='{$nsprofile->code}' class="he_25 form-control" id="e_code">
                                                </div>
                                                
                                                </div>
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">City</h4>
                                                    <input type="text" value='{$nsprofile->namespaceProfile->city}' class="he_25 form-control" id="e_city">
                                                    <h4 class="req heading_a">State</h4>
                                                    <select class="form-control" id="ecs_state">
                                                        <option value="">Select a state</option>
                                                        {foreach key=key from=$states item=st}
                                                        <option value="{$st->code}" {if $nsprofile->namespaceProfile->state->code == $st->code}selected{/if}>{$st->name}</option>    
                                                        {/foreach}                                                        
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Pincode</h4>
                                                    <input type="text" value='{$nsprofile->namespaceProfile->pincode}' class="he_25 form-control" id="e_pincode">
                                                    <h4 class="req heading_a">Support Number</h4>
                                                    <input type="text" value='{$nsprofile->namespaceProfile->supportNumber}' class="he_25 form-control" id="e_supportno">
                                                </div>
                                                <div class="col-sm-3">
                                                    <h4 class="heading_a">Address</h4>
                                                    <textarea class="form-control" id="e_address" rows="5" maxlength="250">{$nsprofile->namespaceProfile->address}</textarea>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <h5 class="b_b_d">Whatsapp Notification</h5>
                                                <div class="col-sm-4">
                                                    <h4 class="heading_a">Whatsapp</h4>
                                                    {if $nsprofile->namespaceProfile->whatsappNotificationFlagCode == ""}
                                                        {assign var=whatsappNotificationFlagCode value='000000'}
                                                    {else}
                                                        {assign var=whatsappNotificationFlagCode value=$nsprofile->namespaceProfile->whatsappNotificationFlagCode}
                                                    {/if}
                                                    <div class="btn-group btn-group-days" id="whatsappNotificationFlagCode" data-toggle="buttons">
                                                        <label class="btn btn-success btn-xs chk-btn {if $whatsappNotificationFlagCode|substr:0:1==1}active{/if}" title="Cargo Booking To {lang('booking_sender_term')}">
                                                            <input type="checkbox" {if $whatsappNotificationFlagCode|substr:0:1==1}checked="checked" {/if} name="week" value="1">CBF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $whatsappNotificationFlagCode|substr:1:1==1}active{/if}" title="Cargo Booking To {lang('booking_receiver_term')}">
                                                            <input type="checkbox" {if $whatsappNotificationFlagCode|substr:1:1==1}checked="checked" {/if} name="week" value="1">CBT
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $whatsappNotificationFlagCode|substr:2:1==1}active{/if}" title="Cargo Delivery To {lang('booking_sender_term')}">
                                                            <input type="checkbox" {if $whatsappNotificationFlagCode|substr:2:1==1}checked="checked" {/if} name="week" value="1">CDF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $whatsappNotificationFlagCode|substr:3:1==1}active{/if}" title="Cargo Delivery To {lang('booking_receiver_term')}">
                                                            <input type="checkbox" {if $whatsappNotificationFlagCode|substr:3:1==1}checked="checked" {/if} name="week" value="1">CDT
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $whatsappNotificationFlagCode|substr:4:1==1}active{/if}" title="Cargo Unload From">
                                                            <input type="checkbox" {if $whatsappNotificationFlagCode|substr:4:1==1}checked="checked" {/if} name="week" value="1">CUF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $whatsappNotificationFlagCode|substr:5:1==1}active{/if}" title="Cargo Unload To">
                                                            <input type="checkbox" {if $whatsappNotificationFlagCode|substr:5:1==1}checked="checked" {/if} name="week" value="1">CUT
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">Whatsapp Provider</h4>
                                                    <select id="e_whatsappProviderCode" name="e_whatsappProviderCode" class="form-control">
                                                        <option value="NA" {if $nsprofile->namespaceProfile->whatsappProviderCode=='NA'}selected{/if}>Not Available</option>
                                                        <option value="QIKBRY" {if $nsprofile->namespaceProfile->whatsappProviderCode=='QIKBRY'}selected{/if}>Qikberry</option>
                                                        <option value="KLYAEB" {if $nsprofile->namespaceProfile->whatsappProviderCode=='KLYAEB'}selected{/if}>Kaleyra</option>
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a  req">Notification Type</h4>
                                                    <select id="notification_mode" class="he_29 form-control" name='notificationPreferences'>
                                                        <option value="SMS" {if $nsprofile->namespaceProfile->notificationPreferences->code == 'SMS'}selected{/if}>SMS</option>
                                                        <option value="WTSAPP" {if $nsprofile->namespaceProfile->notificationPreferences->code == 'WTSAPP'}selected{/if}>WhatsApp</option>
                                                        <option value="WASMS" {if $nsprofile->namespaceProfile->notificationPreferences->code == 'WASMS'}selected{/if}>Both</option>
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
                                                    <input type="checkbox" id="ph_bkg" name ='ph_bkg' class="bs_switch" data-size="small" {if $nsprofile->namespaceProfile->phoneBookingflag==1}checked='checked'{/if}>
                                                </div> -->
                                                
                                                <div class="col-sm-4">
                                                    <h4 class="heading_a">SMS</h4>
                                                    <!--<input type="checkbox" id="sms_chk"  name="sms_chk" class="bs_switch" data-size="small" {if $nsprofile->namespaceProfile->smsNotificationFlag==1}checked='checked'{/if}>-->
                                                    
                                                    {if $nsprofile->namespaceProfile->smsNotificationFlagCode==""}
                                                        {assign var=day value='00000000'}
                                                    {else}
                                                        {assign var=day value=$nsprofile->namespaceProfile->smsNotificationFlagCode}
                                                    {/if}
                                                    <div class="btn-group btn-group-days" id="smsnotification" data-toggle="buttons">
                                                        <label class="btn btn-success btn-xs chk-btn {if $day|substr:0:1==1}active{/if}" title="Cargo Booking To {lang('booking_sender_term')}">
                                                            <input type="checkbox" {if $day|substr:0:1==1}checked="checked"{/if} name="week" value="1">CBS
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:1:1==1}active{/if}" title="Cargo Booking To {lang('booking_receiver_term')}">
                                                            <input type="checkbox" {if $day|substr:1:1==1}checked="checked"{/if} name="week" value="1">CBR
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:2:1==1}active{/if}" title="Cargo Delivery To {lang('booking_sender_term')}">
                                                            <input type="checkbox" {if $day|substr:2:1==1}checked="checked"{/if} name="week" value="1">CDS
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:3:1==1}active{/if}" title="Cargo Delivery To {lang('booking_receiver_term')}">
                                                            <input type="checkbox" {if $day|substr:3:1==1}checked="checked"{/if} name="week" value="1">CDR
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:4:1==1}active{/if}" title="Cargo Unload From">
                                                            <input type="checkbox" {if $day|substr:4:1==1}checked="checked"{/if} name="week" value="1">CUF
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:5:1==1}active{/if}" title="Cargo Unload To">
                                                            <input type="checkbox" {if $day|substr:5:1==1}checked="checked"{/if} name="week" value="1">CUT
                                                        </label>
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:6:1==1}active{/if}" title="Cargo Cancel">
                                                            <input type="checkbox" {if $day|substr:6:1==1}checked="checked"{/if} name="week" value="1">CCL
                                                        </label>
                                                        </label>
                                                        <label class="btn btn-success btn-xs chk-btn  {if $day|substr:7:1==1}active{/if}" title="Cargo Edit">
                                                            <input type="checkbox" {if $day|substr:7:1==1}checked="checked"{/if} name="week" value="1">CED
                                                        </label>
                                                    </div> 
                                                    
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">SMS Header Name</h4>
                                                    <input type="text" value='{$nsprofile->namespaceProfile->smsSenderCode}' class="he_25 form-control col-sm-3" id="sms_code" data-size="small" maxlength="6">
                                                </div>
                                                <div class="col-sm-2" >
                                                    <h4 class="heading_a req">SMS Provider</h4>
                                                    <select id="sms_provider" name="sms_provider" class="form-control"> 
                                                    {foreach key=key from=$smsprovider item=provider}
                                                    <option value="{$provider->code}" {if $nsprofile->namespaceProfile->smsProviderCode== $provider->code}selected{/if}>{$provider->code}</option>    
                                                    {/foreach} 
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Email</h4>
                                                    {if $nsprofile->namespaceProfile->emailNotificationFlagCode==""}
                                                        {assign var=email value='00000000'}
                                                    {else}
                                                        {assign var=email value=$nsprofile->namespaceProfile->emailNotificationFlagCode}
                                                    {/if}
                                                    <div class="btn-group btn-group-days" id="emailnotification" data-toggle="buttons">
                                                        <label class="btn btn-success btn-xs chk-btn {if $email|substr:0:1==1}active{/if}" title="Cargo Booking Vendor ">
                                                            <input type="checkbox" {if $email|substr:0:1==1}checked="checked"{/if} name="email" value="1">CBV
                                                        </label>
                                                    </div> 

                                                </div>
                                            </div>

                                            <div class="row">
                                                                
                                                <h5 class="b_b_d">Date & Time Format</h5>
                                                
                                                <div class="col-sm-2">

                                                    <h4 class="heading_a  req">Date Format</h4>
                                                <!--<input type="text" value='{$profile->dateFormate}'  class="he_25 form-control col-sm-3" id="date_for" data-size="small">-->
                                                    <select id="date_for" class="he_29 form-control" style="font-size:10px !important" name='date_for'>
                                                        <option value="Y-m-d" {if $nsprofile->namespaceProfile->dateFormate=='Y-m-d'}selected{/if} >Y-m-d</option>
                                                        <option value="d-m-Y" {if $nsprofile->namespaceProfile->dateFormate=='d-m-Y'}selected{/if}>d-m-y</option>
                                                        <option value="e/b/Y" {if $nsprofile->namespaceProfile->dateFormate=='e/b/Y'}selected{/if}>e/b/Y</option>
                                                        <option value="D" {if $nsprofile->namespaceProfile->dateFormate=='D'}selected{/if}>D</option>
                                                        <option value="d-b-y" {if $nsprofile->namespaceProfile->dateFormate=='d-b-y'}selected{/if}>d-b-y</option>
                                                    </select>
                                                </div>

                                                <div class="col-sm-2">
                                                    <h4 class="heading_a  req">Time format</h4>
                                                <!-- <input type="text"  value='{$profile->timeFormat}' class="he_25 form-control" id="tme_for" data-size="small" maxlength="3">-->
                                                    <select id="tme_for" class="he_29 form-control" style="font-size:10px !important" name='tme_for'>
                                                        <option value="12" {if $nsprofile->namespaceProfile->timeFormat=='12'}selected{/if}>12</option>
                                                        <option value="24" {if $nsprofile->namespaceProfile->timeFormat=='24'}selected{/if}>24</option>
                                                    </select>
                                                </div>
                                                    
                                                <div class="col-sm-2 hide">
                                                    <h4 class="heading_a">DP Flag</h4>
                                                    <input type="checkbox" id="drop" name="drop" class="bs_switch" data-size="small" {if $nsprofile->namespaceProfile->droppingPointRequriedFlag==1}checked='checked'{/if}>
                                                </div>   

                                            </div>
                                            
                                            <div class="row">
                                                                
                                                <h5 class="b_b_d">E-Way Bill</h5>

                                                <div class="col-sm-2">
                                                    <h4 class="heading_a req">E-Way Bill Vendor</h4>
                                                    <select class="he_29 form-control" id="ewaybill-vendor">
                                                        <option value="NA" {if $nsprofile->namespaceProfile->ewayBillVendorCode=='NA'}selected{/if}>Not Available</option>
                                                        <option value="ADAEQUARE" {if $nsprofile->namespaceProfile->ewayBillVendorCode=='ADAEQUARE'}selected{/if}>Default</option>
                                                    </select>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <h5 class="b_b_d">Others</h5>
                                                
                                                <div class="col-sm-2" >
                                                    <h4 class="heading_a req">Instant Cancellation (Mins)</h4>
                                                    <input type="number" value='{$nsprofile->namespaceProfile->instantCancellationMinitues}' class="he_25 form-control col-sm-3 no-spin" id="ins_can_min" data-size="small">
                                                </div>
                                                
                                                <div class="col-sm-2" >
                                                    <label for="auto_gen_voucher">&nbsp;</label>
                                                    <input type="checkbox" id="auto_gen_voucher" name="auto_gen_voucher" class="he_25 col-sm-3" {if $nsprofile->namespaceProfile->autoGenerateVoucherFlag==1} checked='checked' {/if} data-size="small"/> 
                                                    <label  for="auto_gen_voucher" style="display: inline;font-weight: normal;">&nbsp;&nbsp;Auto Generate Voucher</label>
                                                </div>

                                                <div class="col-sm-2" >
                                                    <label for="allow_direct_login">&nbsp;</label>
                                                    <input type="checkbox" id="allow_direct_login" name="allow_direct_login" class="he_25 col-sm-3" {if $nsprofile->namespaceProfile->allowDirectLogin==1} checked='checked' {/if} data-size="small"/> 
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
                                                    <input type="text" value='{$nsprofile->namespaceProfile->shortCode}' class="he_25 form-control col-sm-3" id="shortcode" data-size="small" maxlength="6">
                                                </div>  
                                                <div class="col-sm-3">
                                                    <h4 class="heading_a req">Website</h4>
                                                    <input type="text" value='{$nsprofile->namespaceProfile->domainURL}' class="he_25 form-control col-sm-3" id="url" data-size="small" >
                                                </div>
                                            </div>  
                                            
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <h4 class="heading_a">Manage Expense Balance Exception</h4>
                                                    <select id="nsp_balanceOnManageExpense" name="nsp_balanceOnManageExpense" multiple  class="form-control" >
                                                        {foreach name=o item=row key=grp from=$groups}
                                                            <option value='{$row->code}'>{$row->name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>  
                                            </div>  
                                                  
                                            <div class="row">
                                                <h5 class="b_b_d">Two Factor Authentication</h5>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">OTP Verify Group</h4>
                                                    <select id="otp_verify_grp" name="otp_verify_grp" multiple  class="form-control" >                                               
                                                        {foreach name=o item=row key=grp from=$groups}
                                                            <option value='{$row->code}'>{$row->name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                                <div class="col-sm-2">
                                                    <h4 class="heading_a">Expire Password Group</h4>
                                                    <select id="exp_pwd_grp" name="exp_pwd_grp" multiple  class="form-control" >  
                                                        {foreach name=o item=row key=grp from=$groups}
                                                            <option value='{$row->code}'>{$row->name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                                
                                            </div>

                                            <div class="clearfix"></div>
                                            <br/>

                                            <div class="row">
                                                <h5 class="b_b_d">Readonly</h5>
                                                <div class="col-sm-2 form-check-inline pb10">
                                                    <label title="{$nsprofile->namespaceProfile->dayOfHour}">
                                                        Reporting Days - {$nsprofile->namespaceProfile->reportingDays} days
                                                    </label>
                                                </div>
                                            </div>

                                            <br>
                                            <div class="row">
                                                <div id="ur-org-loading"></div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none" id="usr-org-state"></div>
                                                {if $action_rights['NSCE-EDIT']>0}
                                                    <div  id="form-org-bttons">
                                                        <button type="button" id="btn-save" class="btn btn-success" style="margin-left:600px" {if $action_rights['NSCE-EDIT'] == 1}onclick="saveProfile()"{/if}>Save</button>
                                                    </div>
                                                {/if}
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
                                                        {foreach item=row from=$eventTypes}
                                                            <option value='{$row->code}'>{$row->name}</option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="clear_fix_both"></div>
                                            <div class="col-md-6">
                                                <div class="clear_fix_both"></div>
                                                <div class="alert" style="display:none" id="alert-noti-state"></div>
                                                {if $action_rights['NSCE-EDIT']>0}
                                                    <button type="button" id="btn-save" class="btn btn-success" {if $action_rights['NSCE-EDIT']==1}onclick="saveNotiStatus()"{/if}>Save</button>
                                                {/if}
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div id="Appearance-btn" class="tab-pane">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <label for="primaryColor" class="d-inline">Primary Color</label><br>
                                            <input type="color" id="primaryColorPicker" name="primaryColor"
                                                value="#0078d7" class="form-control fav-color"
                                                onchange="updateColorPicker(this.value)" style="margin-top:5px;">
                                            <input type="text" id="primaryColorText" name="primary-Color"
                                                class="form-control" oninput="updateColorPicker(this.value)"
                                                style="margin-top: -36px; margin-left: 36px;">
                                        </div>

                                        <div class="col-md-2" style="margin-left:20px;">
                                            <label for="secondaryColor" class="d-inline">Secondary Color</label><br>
                                            <input type="color" id="secondaryColorPicker" name="secondaryColor"
                                                value="#0078d7" class="form-control fav-color"
                                                onchange="updateColorPickers(this.value)" style="margin-top:5px;">
                                            <input type="text" id="secondaryColorText" name="secondary-Color"
                                                class="form-control" oninput="updateColorPickers(this.value)"
                                                style="margin-top: -36px; margin-left: 36px;">
                                        </div>

                                        <div class="col-md-2" style="margin-left:20px;">
                                            <label for="font-size">Font Size</label>
                                            <select id="font-size" name="font-size" class="form-control">
                                                <option value="12" selected>Medium</option>
                                                <option value="14">Large</option>
                                                <option value="16">Extra Large</option>
                                            </select>
                                        </div>
                                        <div class="col-md-1">
                                            <button type="button" class="btn btn-info bottom"
                                                style="margin-bottom: -58px;" onclick="saveAppearance()">Save</button>
                                        </div>
                                        <div class="col-md-1">
                                            <button class="btn btn-default" type="button"
                                                style="margin-bottom: -58px; margin-left: -45px;"
                                                onclick="clearAppearance();">Clear</button>

                                        </div>
                                    </div>
                                    <br><br>
                                    <div class="align-center alert alert-danger pull-left" style="display:none"
                                        id="namespc-app-state"></div>
                                    {literal}
                                        <script>
                                            const settingsData = {/literal}{_namespace_nav_logo_change_()}{literal};
                                            let primaryColor = settingsData.primaryColor == 'NA' ? '#FA9008' : settingsData.primaryColor;
                                            let secondaryColor = settingsData.secondaryColor == 'NA' ? '#FA9008' : settingsData.secondaryColor;
                                            $('#primaryColorPicker, #primaryColorText').val(primaryColor);
                                            $('#secondaryColorPicker, #secondaryColorText').val(secondaryColor);
                                            $('#font-size').val(settingsData.fontSize);
                                        </script>
                                    {/literal}
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

    <script type="text/html" id="row-rpt-days-tpl">
        <div class="row grp-rpt-days-row">
            <div class="col-md-6">
                <div class="form-group">
                    <select multiple class="form-control nsp-rpt-grps" name="nsp-rpt-grps">
                        {foreach name=o item=row key=grp from=$groups}
                            <option value='{$row->code}'>{$row->name}</option>
                        {/foreach}
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
    </script>
    <script>

        $('.bs_switch').bootstrapSwitch('size', 'mini');
        
        var pro = {$nsprofile|json_encode};
        var nsAlerts = {$nsAlerts|json_encode};

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
        function updateColorPicker(color) {
        document.getElementById('primaryColorPicker').value = color;
        document.getElementById('primaryColorText').value = color;
    }

    function updateColorPickers(color) {
        document.getElementById('secondaryColorPicker').value = color;
        document.getElementById('secondaryColorText').value = color;
    }


    function saveAppearance() {
        var data = {
            primaryColor: $('#primaryColorPicker').val(),
            secondaryColor: $('#secondaryColorPicker').val(),
            fontSize: $('#font-size').val(),
        };
        $.ajax({
            type: "POST",
            dataType: "json",
            url: base_url + "profile/appearance",
            data: data,
            success: function(response) {
                if (response.status) {
                    $('#namespc-app-state').removeClass("alert-danger").addClass('alert-success').html(
                        "Your request for appearance has been completed successfully").show();
                    setTimeout(() => {
                        location.reload();
                    }, 3000);
                } else {
                    $('#namespc-app-state').html("Your request is unable to completed")
                    setTimeout(() => {
                        $('#namespc-app-state').empty().hide();
                    }, 3000);
                }
            },
            error: function(error) {
                console.error("Error in AJAX request:", error);
            }
        });
    }

    function clearAppearance() {
        $('#font-size').val(settingsData.fontSize);
        $('#primaryColorText').val(primaryColor);
        $('#primaryColorPicker').val(primaryColor);    
        $('#secondaryColorText').val(secondaryColor);
        $('#secondaryColorPicker').val(secondaryColor);
    }
    </script>


