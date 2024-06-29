<div class="brand_top"><h3> Profile</h3></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12" >
                    <br>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="tabbable">
                                <ul class="nav nav-tabs" id="tabs_a">
                                    <li class="active">
                                        <a data-toggle="tab" href="#profile_pane">Profile</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#password_setting">Change Password</a>
                                    </li>
                                </ul>
                                <div class="tab-content" id="tabs_content_a">
                                    <div id="profile_pane" class="tab-pane fade in active">
                                        <div class="row">
                                            <div class="col-md-6"> 

                                                <ul class="user_list">
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-2 bold">Name</div>
                                                            <div class="col-md-6">{$pro_usr->name}</div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-2 bold">Email</div>
                                                            <div class="col-md-6">{$pro_usr->email}</div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-2 bold">Mobile</div>
                                                            <div class="col-md-2">
                                                                {$pro_usr->mobile}
                                                            </div>
                                                            <div class="col-md-6">
                                                                {if $pro_usr->mobileVerifiedFlag==1 }
                                                                    <span class="label label-success">Verified</span>
                                                                {else}
                                                                    <span class="label label-warning">Yet to Verify</span>
                                                                    <a href="javascript:;" onclick="showVerifyMobileDialog();" class="bold p_l_15" >Verify</a>
                                                                    <a href="javascript:;"  onclick="showVerifyMobileDialog();" class="bold p_l_15" >Change</a>
                                                                {/if}
                                                                
                                                            </div>                                                            
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-2 bold">Group</div>
                                                            <div class="col-md-6">{$pro_usr->group->name}</div>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="row">
                                                            <div class="col-md-2 bold">Payment Type</div>
                                                            <div class="col-md-6">{$pro_usr->paymentType->name}</div>
                                                        </div>
                                                    </li>
                                                    <input type='hidden' value='{$pro_usr->paymentType->code}' id='pg_code'>
                                                    <input type='hidden' value='{$pro_usr->code}' id='usr_code'>
                                                </ul>  
                                            </div>
                                                
                                            <!--right start-->
                                            <div class="col-md-6"> 
                                                <form id="change-profile" role="form" class="pd_tp_20 form-horizontal">

                                                    {if $smarty.request.status!=''} 
                                                        <div class="text-center" style="margin-left: 10px; margin-right: 5px;">                                                            
                                                            {if $smarty.request.status=='confirm'}
                                                                <div class="alert alert-success">Your recharge success.</div>
                                                            {else if $smarty.request.status=='fail'}    
                                                                <div class="alert alert-danger">Sorry! your recharge failed. Transaction code : {$smarty.request.code} </div>
                                                            {else if $smarty.request.status=='invalid'}    
                                                                <div class="alert alert-danger">Invalid transaction</div>    
                                                            {/if}
                                                        </div>
                                                    {/if}

                                                    <div class="form-group">
                                                        <label class="col-xs-3 control-label" for="name">Current Balance</label>
                                                        <label class="col-xs-6 mob control-label" for="group" style="text-align:justify"><span class="light-txt"> <i class="fa fa-inr"></i>&nbsp;{$balance}</span> 
                                                        {if $pro_usr->paymentType->name == 'Payment Pre Paid'}
                                                            <a href="javascript:;" onclick='rechargeUsr()' class="profilerech"> Recharge Now </a></label >
                                                        {/if}
                                                    </div>    
                                                    <div class="form-group">
                                                        <label class="col-xs-3 control-label api-tk" for="name" >API Token</label>
                                                        <div class="col-xs-6">
                                                            <label class="col-xs-4 mob control-label lab_tkn" for="group" style="text-align:justify"><span class="light-txt" id="tkn_txt">{$pro_usr->apiToken}</span></label>
                                                            <input type="text" placeholder="New API Token" id="token" class="form-control" value="" maxlength="15">
                                                        </div>
                                                        {if $action_rights['CRE-TKN']>0}
                                                        <div class="col-xs-3" id="edit-token-bttons">
                                                            <a href="javascript:;" class="btn btn-default btn-sm edat" data-toggle="tooltip" id="tkn_edt" title="Edit" onclick='tknEdit()'><i class="fa fa-pencil igreen"></i></a>
                                                            <button class="btn btn-success token_btn" type="button" onclick="UpdateToken();">Update Token</button>
                                                        </div>
                                                        {/if}
                                                    </div>

                                                    <input type='hidden' value='{$pro_usr->code}' id='usr_code'>
                                                    <div class="pull-left" id="ur-token-loading"></div>
                                                    <div class="align-center alert alert-danger pull-left" style="display:none;" id="usr-token-state"></div>
                                                </form>     
                                            </div>
                                                    
                                        </div>
                                    </div>   

                                        <div id="password_setting" class="tab-pane fade">
                                            <div>
                                                <div class="clear_fix_both"></div><br>
                                                <form id="change-password" role="form" class="pro_edt form-horizontal">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label req" for="old-password">Old Password</label>
                                                        <div class="col-sm-5">
                                                            <input type="password" placeholder="Old Password" id="old-password" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label req" for="new-password">New Password</label>
                                                        <div class="col-sm-5">
                                                            <input type="password" placeholder="New Password" id="new-password" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label req" for="confirm-password">Confirm Password</label>
                                                        <div class="col-sm-5">
                                                            <input type="password" placeholder="Confirm Password" id="confirm-password" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="pull-left" id="pwd-rps-loading"></div>
                                                    <div class="alert pull-left" id="pwd-action-state"></div>
                                                    {if $action_rights['PRF-CHG-PWD']>0}   
                                                    <div class="align-right" id="pwd-form-bttons">
                                                        <button class="btn btn-success" type="button" data-hash="{$token}" {if $action_rights['PRF-CHG-PWD']==1}onclick="changePassword();{/if}">Save</button>
                                                    </div>
                                                    {/if}
                                                    </form>
                                                </div>
                                            </div> 
                                </div>
                        </div>
                        <div class="clear_fix_both"></div>
                    </div><!--panel Body end-->
                </div><!--panel end-->

                {if $action_rights['ALRT-SUBS']>0} 
                <div class="panel panel-default col-md-7"  id="subscribe-panel">
                    <div class="heading_b">Other Apps</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="w-auto pull-left">&emsp;&emsp;
                                <img src="assets/img/ezeebot.png" alt="Ezeebot">
                            </div>
                            <div class="col-md-7 pt10">
                                <h5>EzeeBot</h5>
                                <p>Manage & Receive all your alert notifications in one place from various<br/>Ezeeinfo Products</p>

                                {if $subscription['EZBOT']|count}
                                    <br>
                                    <p class="bold">Active Devices</p>
                                    <div class="row">
                                        {foreach from= $subscription['EZBOT'] item=subs}
                                            <div class="col-md-6 m-t-5" data-udid="{$subs->udid}" data-gcmtoken="{$subs->gcmToken}">
                                                {$subs->model} {if $subs->os}({$subs->os}){/if}
                                            </div>
                                            <div class="col-md-6 m-t-5">
                                                <a href="javascript:;" class="text-danger bold" onclick="revokeAuthToken('EZBOT', '{$subs->code}')">
                                                    <i class="fa fa-ban" aria-hidden="true"></i> Unubscribe
                                                </a>
                                            </div>
                                        {/foreach}
                                    </div>
                                {/if}
                            </div>
                            <div class="col-md-1">
                                <br>
                                <br>
                                <button class="btn btn-success" onclick="generateAuthToken('EZBOT')">Subscribe</button>
                                <a href="https://play.google.com/store/apps/details?id=com.ezee.bot" target="_blank">
                                    <img src="assets/img/google-play-badge.png" alt="Ezeebot">
                                </a>
                            </div>
                        </div>
                    </div><!--panel Body end-->
                </div><!--panel end-->
                <div class="panel panel-default col-md-5 pull-right usr-notification-panel">
                    <div class="heading_b">Event Notifications</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="ov_fl_m_150">
                                    {foreach from=$notification item=row}
                                        <label class="">
                                    <input type="checkbox"  class="he_25 form-check-input usr-notify" data-code="{$row->code}" id="{$row->code}" {if $row->activeFlag == 1}checked{/if}> {$row->name}
                                        </label>
                                    {/foreach}
                                </div>
                                <br/><br/>
                                {if $subscription['EZBOT']|count} 
                                    <button class="btn btn-success" onclick="updateEventNotifications();">Update</button>
                                {/if}
                           </div>
                        </div>
                    </div>
                </div>
                {/if}

                {if $is_super_namespace==1}
                <div class="panel panel-default col-md-7"  id="subscribe-panel">
                    <div class="heading_b">Other Apps</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="w-auto pull-left">&emsp;&emsp;
                                {* <img src="assets/img/ezeebot.png" alt="Ezeebot"> *}
                            </div>
                            <div class="col-md-7 pt10">
                                <h5>APP</h5>
                                {* <p>Manage & Receive all your alert notifications in one place from various<br/>Ezeeinfo Products</p>

                                {if $subscription['EZBOT']|count}
                                    <br>
                                    <p class="bold">Active Devices</p>
                                    <div class="row">
                                        {foreach from= $subscription['EZBOT'] item=subs}
                                            <div class="col-md-6 m-t-5" data-udid="{$subs->udid}" data-gcmtoken="{$subs->gcmToken}">
                                                {$subs->model} {if $subs->os}({$subs->os}){/if}
                                            </div>
                                            <div class="col-md-6 m-t-5">
                                                <a href="javascript:;" class="text-danger bold" onclick="revokeAuthToken('EZBOT', '{$subs->code}')">
                                                    <i class="fa fa-ban" aria-hidden="true"></i> Unubscribe
                                                </a>
                                            </div>
                                        {/foreach}
                                    </div>
                                {/if} *}
                            </div>
                            <div class="col-md-1">
                                <br>
                                <br>
                                <button class="btn btn-success" onclick="generateCargoAppOTP()">Subscribe</button>
                                {* <a href="https://play.google.com/store/apps/details?id=com.ezee.bot" target="_blank">
                                    <img src="assets/img/google-play-badge.png" alt="Ezeebot">
                                </a> *}
                            </div>
                        </div>
                    </div><!--panel Body end-->
                </div><!--panel end-->
                {/if}
                
            </div>
        </div>
    </div>
</div>



<div id="recharge-usr-dialog" class="hide dialog-content-page">
    <div class="ov_fl_100">
        <form role="form" id="form1" class="form-horizontal ">

            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="txt_m_name" class="req">Amount</label>
                    <input  placeholder="Amount" id="amount" name="amount"  class="form-control">
                    <span id='amt-note'>&nbsp;<i class='fa fa-info-circle'></i>&nbsp;Note :&nbsp;Minimum recharge amount Rs 100.</span>
                                                                        
                </div>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label for="sel_gateway" class="req">Payment Gateway</label>
                    <select id="sel_gateway" class="form-control col-md-6">
                        <option value="">Select</option>
                        {foreach name=o item=row from=$providers}
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach}   
                    </select>
                </div>
            </div>   
            <div class="clear_fix_both"></div>


        </form>
    </div>
    <div class="clear_fix_both"></div>
    <div id="payment-form"></div>

    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="recharge-usr-action-state"></div>
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="usrRecharge();">Proceed to payment</button>
            <button class="btn btn-default" type="button" onclick="cancelRecharge();">Cancel</button>
        </div>
    </div> 

</div>


<div id="mobile-dialog" class="hide dialog-content-page">
        <div class="row">
            <div class="col-md-12">
                <div class="heading_b">Verify Mobile Number</div>                       
            </div>
        </div>

        <div >
            <form role="form" id="frmnewmobile" class="form-horizontal "> 
                
                <div class="row">                    
                    <div class="col-md-12">
                        <label for="txt_m_name" class="req">Mobile Number</label>
                        <input  placeholder="Mobile Number" value="{$pro_usr->mobile}" id="mobilenumber" name="mobilenumber"  class="form-control">
                        <span class='note text-muted'>&nbsp;<i class='fa fa-info-circle'></i> New number updated upon successfull OTP verification.</span>
                    </div>

                    <div class="col-md-12 p_t_20" id="otpbox">
                        <label for="txt_m_name" class="req">OTP</label>
                        <input  placeholder="OTP" id="mobileotp" name="mobileotp"  class="form-control">  
                        <span class='note text-muted'>&nbsp;<i class='fa fa-info-circle'></i> OTP sent to <span id="mnotes"></span>.</span>                      
                    </div>

                    <div class="col-md-12" id="divnewmobile">                       
                        <div class="alert" style="display: none;" id="mobile-otp-action-state"></div>
                        <div class="align-right cre_sve" id="send-otpform-bttons">
                            <button class="btn btn-success" type="button" onclick="sendMobileVerifyOTP();">Send OTP</button>&nbsp;
                            <button class="btn btn-default" type="button" onclick="cancelMobileDialog();">Cancel</button>
                        </div>
                    </div>

                    <div class="col-md-12" id="divverifyotp">                       
                        <div class="alert" style="display: none;" id="otp-verify-action-state"></div>
                        <div class="col-md-2">                            
                            <button class="btn btn-success disabled" id='btn-resend' type="button" onclick="sendMobileVerifyOTP();" >Resend</button>
                        </div>
                        <div class="align-right cre_sve" id="verify-otpform-bttons">
                            <button class="btn btn-success" type="button" onclick="verifyMobileOTP();">Verify</button>&nbsp;
                            <button class="btn btn-default" type="button" onclick="cancelMobileDialog();">Cancel</button>
                        </div>
                    </div> 

                </div>

            </form>
        </div>
</div>

<div id="subscription-otp-dialog" class="hide dialog-content-page">
    <div class="row">
        <div class="align-center alert alert-danger col-sm-12" style="display:none" id="sub-otp-action-state"></div>
    </div>
    <div id="view-otp-form" style="display: none;">
        <br/><br/>
        <div class="row">
            <div class="col-md-12 text-center">Subscription Code</div>
        </div>
        <br>
        <div class="row" style="padding-top: 10px;">
            <div class="col-md-12 text-center">
                <h2 id="sub-otp-code"></h2>
            </div>
        </div>
        <div class="row">
            <div class="text-right col-sm-12">
                <button class="btn btn-default" type="button" onclick="closeSubOtp();">Close</button>
            </div>
        </div>
    </div>
</div>
                                                    
{literal}
<script>
    var profileMobile = '';
    $('#token').hide();
    $('.token_btn').hide();
    $(function () {
        $("[data-toggle='tooltip']").tooltip();
        if(menu_permission['ALRT-SUBS']) {
            var s_panel_height = document.getElementById('subscribe-panel').offsetHeight;
            $('.usr-notification-panel').height(Number(s_panel_height)- 20);
        }
    });

    function updateEventNotifications(){
        var data = {};
        data.notification = [];
        
        $('.usr-notify').each(function (index, obj) {
            var selectedNotifications = {};
            selectedNotifications.code = $(this).data('code');
            selectedNotifications.activeFlag = 0;
            if (this.checked === true) {
                selectedNotifications.activeFlag = 1;
            }
            data.notification.push(selectedNotifications);
        });

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/update-event-notification",
            data: data,
            success: function(response) {
                if (response.status == 1) {                
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }

                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 1000);
            }
        })
    }


    function verifyMobileOTP() {
        var data = {};
        profileMobile = $.trim($('#mobilenumber').val());

        data.mobile = profileMobile;
        data.otp = $.trim($('#mobileotp').val());

        var err = 0;
        if (data.otp == '') {
            $('#mobileotp').addClass('inp_error');
            err++;
        }

        if ( isNaN(data.otp) ) {
            $('#mobileotp').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#otp-verify-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#otp-verify-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#otp-verify-action-state').show();
            return false;
        } else {
            $('#otp-verify-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#otp-verify-action-state').hide();
        }

        $('#verify-otpform-bttons').hide();
        $('.inp_error').removeClass('inp_error');
        $('#otp-verify-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#otp-verify-action-state').html(loading_popup);
        $('#otp-verify-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/verify-mobile-otp",
            data: data,
            success: function (response) {
                if (response.status == 1) {                    
                    $('#otp-verify-action-state').removeClass('alert-danger').addClass('alert-success');                   
                    $('#otp-verify-action-state').html('Your request has been completed successfully');
                    ga_track_event('Profile', 'Verify Mobile - Success', '');
                    window.setTimeout(function () {
                        cancelMobileDialog();
                        checkURL();
                    }, 3000);                    
                } else {
                    $('#verify-otpform-bttons').show();
                    $('#otp-verify-action-state').removeClass('alert-success').addClass('alert-danger');                   
                    $('#otp-verify-action-state').html(response.errorDesc);
                    ga_track_event('Profile', 'Verify Mobile - Fail', '');
                    window.setTimeout(function () {
                       $('#otp-verify-action-state').removeClass('alert-success').removeClass('alert-danger').html('');                   
                    }, 3000);                    
                }
            }
        })
    }

    function showVerifyMobileDialog(option) {        

        $('#mobile-dialog').css('background', '#fff');
        $('#mobile-dialog').removeClass('hide');
        $('#mobile-dialog').dialog({
            autoOpen: true,
            height: 400,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#send-otpform-bttons').show();
        $('#verify-otpform-bttons').show();
        $('.inp_error').removeClass('inp_error');
        $('#mobile-otp-action-state').removeClass('alert-success').removeClass('alert-danger').html('');
        $('#otp-verify-action-state').removeClass('alert-success').removeClass('alert-danger').html('');

        $('#divnewmobile').show();
        $('#otpbox').hide();
        $('#divverifyotp').hide();

        ga_track_event('Profile', 'Verify Mobile - Init', '');
        
    }


    function cancelMobileDialog() {
        $('#mobile-dialog').dialog('destroy');
        $('#mobile-dialog').hide();
    }

    function sendMobileVerifyOTP() {
        var data = {};
        profileMobile = $.trim($('#mobilenumber').val());

        data.mobile = $.trim($('#mobilenumber').val());

        var err = 0;
        if (data.mobile == '') {
            $('#mobilenumber').addClass('inp_error');
            err++;
        }

        if ( !isValidPhonenumber(data.mobile) ) {
            $('#mobilenumber').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#mobile-otp-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#mobile-otp-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#mobile-otp-action-state').show();
            return false;
        } else {
            $('#mobile-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#mobile-otp-action-state').hide();
        }

        $('#send-otpform-bttons').hide();
        $('#btn-resend').addClass('disabled');
        $('.inp_error').removeClass('inp_error');
        $('#mobile-otp-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#mobile-otp-action-state').html(loading_popup);
        $('#mobile-otp-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/send-mobile-verify-otp",
            data: data,
            success: function (response) {
                if (response.status == 1) {                    
                    $('#mobile-otp-action-state').removeClass('alert-danger').addClass('alert-success');                   
                    $('#mobile-otp-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        $('#mobile-otp-action-state').removeClass('alert-success').removeClass('alert-danger').html('');
                        $('#mnotes').html(profileMobile);
                        $('#otpbox').show();
                        $('#divverifyotp').show();
                        $('#mobileotp').focus();

                        window.setTimeout(function () { // Activate resend button.
                            $('#btn-resend').removeClass('disabled');
                        }, 60000);

                    }, 2000);                    
                } else {
                    $('#send-otpform-bttons').show();
                    $('#mobile-otp-action-state').removeClass('alert-success').addClass('alert-danger');                   
                    $('#mobile-otp-action-state').html(response.errorDesc);
                    window.setTimeout(function () {
                       $('#mobile-otp-action-state').removeClass('alert-success').removeClass('alert-danger').html('');
                    }, 3000);                    
                }
            }
        })
    }

    


    function tknEdit() {
        $('.pd_lt_31').addClass('pd_lts_31').removeClass('pd_lt_31');
        $('.mr_17').addClass('mr_27').removeClass('mr_17');
        $('#token').show();
        $('#token').focus();
        $('.token_btn').show();
        $('.api-tk').addClass('req');
        $('#tkn_edt').hide();
        $('.lab_tkn').hide();
        $('#edit-token-bttons').show();
    }

    function rechargeUsr(option) {
        $('#recharge-usr-dialog').css('background', '#fff');
        $('#recharge-usr-dialog').removeClass('hide');
        $('#recharge-usr-dialog').dialog({
            autoOpen: true,
            height: 220,
            width: 700,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#form-bttons').show();
        $('#recharge-usr-action-state').html('');
        $('#recharge-usr-action-state').hide();
        $('.inp_error').removeClass('inp_error');
    }


    function cancelRecharge() {
        $('#recharge-usr-dialog').dialog('destroy');
        $('#recharge-usr-dialog').hide();
    }

    function usrRecharge() {
        var data = {};

        data.amount = $.trim($('#amount').val());
        data.gateway = $.trim($('#sel_gateway').val());

        $('#amount').removeClass('inp_error');
        $('#sel_gateway').removeClass('inp_error');
        
        var err = 0;
        if (data.amount == '') {
            $('#amount').addClass('inp_error');
            err++;
        }
        if (data.amount < 100) {
            $('#amount').addClass('inp_error');
            err++;
        }

        if (isNaN(data.amount)) {
            $('#amount').addClass('inp_error');
            err++;
        }

        if (data.gateway == '') {
            $('#sel_gateway').addClass('inp_error');
            err++;
        }


        if (err > 0) {
            $('#recharge-usr-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#recharge-usr-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#recharge-usr-action-state').show();
            return false;
        } else {
            $('#recharge-usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#recharge-usr-action-state').hide();
        }

        //$('#form-bttons').hide();
        $('#recharge-usr-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#recharge-usr-action-state').html(loading_popup);
        $('#recharge-usr-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/get-recharge-payment-meta",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    var formControl = '';
                    $.each(response.data.gatewayInputDetails, function (rekey, reval) {
                        formControl += '<input type="hidden" name="' + rekey + '" id="' + rekey + '" value="' + reval + '" />';
                    });
                    //$('#frm_payment').html(formControl);
                    //$('#frm_payment').attr('action', res.paymentRequestUrl);                
                    $("#payment-form").html('<form action="' + response.data.paymentRequestUrl + '" name="frm_payment" id="frm_payment" method="post" style="display:none;">' + formControl + '</form>');
                    $("#frm_payment").submit();
                } else {
                    $('#recharge-usr-action-state').addClass('alert-danger');
                    $('#recharge-usr-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        })
    }

    function generateAuthToken(deviceMedium) {
        var data = {};
        data.deviceMedium = deviceMedium;

        $('#subscription-otp-dialog').css('background', '#fff');
        $('#subscription-otp-dialog').show();
        $('#subscription-otp-dialog').removeClass('hide');
        $('#subscription-otp-dialog').dialog({
            autoOpen: true,
            width: 500,
            maxWidth: 600,
            height: 300,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();
        
        $('#view-otp-form').hide();
        $('#sub-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#sub-otp-action-state').html(loading_popup);
        $('#sub-otp-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/auth-notification-subscription",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#sub-otp-action-state').hide();

                    $('#view-otp-form').show();
                    $('#generate-otp-form').hide();
                    $('#sub-otp-code').html(response.data.code);
                } else {
                    $('#sub-otp-action-state').show();
                    $('#sub-otp-action-state').addClass('alert-error');
                    $('#sub-otp-action-state').html(response.errorDesc);
                    $('#view-otp-form').hide();
                }
            }
        });
    }

    function closeSubOtp() {
        $('#subscription-otp-dialog').dialog('destroy');
        $('#subscription-otp-dialog').hide();
    }

    function revokeAuthToken(deviceMedium, code) {
        if (!confirm('Do you want to unsubscribe this Device?')) {
            return;
        }
        var data = {};
        data.code = code;
        data.deviceMedium = deviceMedium;

        var loading_overlay = iosOverlay({
            text: "Loading...",
            icon: "fa fa-spinner fa-spin"
        });

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/revoke-notification-subscription",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function () {
                    loading_overlay.hide();
                    response.status == 1 && checkURL();
                }, 2000);
            }
        });
    }

    function generateCargoAppOTP() {
        var data = {};

        $('#subscription-otp-dialog').css('background', '#fff');
        $('#subscription-otp-dialog').show();
        $('#subscription-otp-dialog').removeClass('hide');
        $('#subscription-otp-dialog').dialog({
            autoOpen: true,
            width: 500,
            maxWidth: 600,
            height: 300,
            resizable: false,
            modal: true,
        });
        $(".ui-dialog-titlebar").hide();
        
        $('#view-otp-form').hide();
        $('#sub-otp-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#sub-otp-action-state').html(loading_popup);
        $('#sub-otp-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "profile/generate-cargoapp-otp",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#sub-otp-action-state').hide();

                    $('#view-otp-form').show();
                    $('#generate-otp-form').hide();
                    $('#sub-otp-code').html(response.data.slug);
                } else {
                    $('#sub-otp-action-state').show();
                    $('#sub-otp-action-state').addClass('alert-error');
                    $('#sub-otp-action-state').html(response.errorDesc);
                    $('#view-otp-form').hide();
                }
            }
        });
    }
</script>
{/literal}