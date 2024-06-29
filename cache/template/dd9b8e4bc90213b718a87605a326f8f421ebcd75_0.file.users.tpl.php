<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-25 11:15:40
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\users.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667a598478a3b0_74824663',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'dd9b8e4bc90213b718a87605a326f8f421ebcd75' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\users.tpl',
      1 => 1719294309,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667a598478a3b0_74824663 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Users</h3> 
    <span class="align-right">
        <button class="btn btn-default" onclick="exportUserExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="showUserCommissions()">Commissions</button>
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-EDIT'] > 0 || $_smarty_tpl->tpl_vars['is_super_namespace']->value == 1) {?><button class="btn btn-primary" onclick="importBitsUsers()">Import Bits Users</button><?php }?>
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-ADD-HIDE'] > 0) {?>
            <a href="javascript:;" class="btn btn-success  btn-sm" onclick="saveDialogUser();">Add New User</a> 
        <?php }?>
    </span>
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

                                    <div id="user-result-panel">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-3">
                                                    <ul class="user_list" id="usr_lst_ul">

                                                        <?php if (count($_smarty_tpl->tpl_vars['users']->value) > 0) {?>
                                                            <div class="well well-sm">
                                                                <input type="text" class="form-control" placeholder="Find User..." id="list_search" >
                                                            </div>  
                                                            <div class="user_list_action bt_27">
                                                                <ul class="user_list " id="user_list_search">
                                                                    <div id="usr_scroll">
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['users']->value, 'ugroup', false, 'ugrpname', 'ow', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ugrpname']->value => $_smarty_tpl->tpl_vars['ugroup']->value) {
?> 
                                                                            <li class="rt_8">
                                                                                <div class="bold">
                                                                                    <?php echo $_smarty_tpl->tpl_vars['ugrpname']->value;?>

                                                                                </div>
                                                                            </li>
                                                                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ugroup']->value, 'row', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?> 
                                                                            <li id="usr-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
">
                                                                                <div class="" style="padding-left:10px;">
                                                                                    <a href="javascript:;" id="usr-viw-<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" onclick="userView('<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
')" data-uname="<?php echo $_smarty_tpl->tpl_vars['row']->value->username;?>
" data-toggle="tooltip"  title="Click to view user details">
                                                                                        <?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>


                                                                                        <?php if ($_smarty_tpl->tpl_vars['is_super_namespace']->value == 1) {?>
                                                                                            <?php if (isset($_smarty_tpl->tpl_vars['row']->value->integrationType)) {?>
                                                                                                <span class="label label-default"><?php echo $_smarty_tpl->tpl_vars['row']->value->integrationType->name;?>
</span>
                                                                                            <?php }?>
                                                                                        <?php }?>
                                                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->activeFlag == 0) {?>
                                                                                            <span class="label label-warning pull-right">Disabled</span>
                                                                                        <?php }?>
                                                                                    </a>
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
                                                                </ul>
                                                            </div>
                                                        <?php } else { ?>
                                                            <li class="er_msg"><div class="well well-large "> No user found!</div></li>
                                                        <?php }?>   
                                                    </ul>

                                                </div>
                                                    
                                                <form id='trans_form' name="trans_form" method="post"  onsubmit="return false">
                                                </form>
                                                <iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe> 
                                                <div class="col-md-9" id="usr-viw-rslt">
                                                    <?php if (count($_smarty_tpl->tpl_vars['users']->value) > 0) {?>
                                                        <div class="p_t_100">
                                                            <div class="well well-large "> Click any of the user name to view more details.</div>
                                                        </div>
                                                    <?php }?> 
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
</div>  

<div id="cargo-user-dialog" class="dialog-content-page" style="display: none">
    <form class="form-horizontal " action="#">
        <div class="ov_fl_290--">
            <div class="col-lg-6 p_l_n">
                <div>
                    <label class="req">Employee Code</label>
                    <input type="text" id="txt_employee_code" class="form-control" placeholder="Employee Code">
                </div>
            </div>
            <div class="col-lg-6 p_l_n">
                <div>
                    <label class="req">Name</label>

                    <input type="text" id="txt_name" class="form-control" placeholder="Name">
                </div>
            </div>
            <div class="clear_fix_both"></div><br />  

            <div class="col-lg-6 p_l_n">
                <div>
                    <label class="req">Father name</label>

                    <input type="text" id="txt_lname" class="form-control" placeholder="Father name">
                </div>
            </div>  
            <div class="col-lg-6 p_l_n">
                <div><label class="req">Email</label>

                    <input type="text" id="txt_email" class="form-control" placeholder="Email">
                </div>
            </div>
            <div class="clear_fix_both"></div><br />  

            <div class="col-lg-6 p_l_n">
                <div><label class="req">Mobile</label>

                    <input type="text" id="txt_mobile" class="form-control" placeholder="Mobile">
                    <span class='note text-muted'>&nbsp;<i class='fa fa-info-circle'></i> Verified mobile number not allowed to edit.</span>
                </div>
            </div>  
            <div class="col-lg-6 p_l_n edt_hide">
                <div>
                    <label class="req">User name</label>
                    <input type="text" onblur="checkUsernameAvailablity(this);" id="txt_usr_name" class="form-control" placeholder="User name">
                </div>
                <div id="user_availablity_state" style="margin-top:5px;">

                </div> 
            </div>
            <div class="clear_fix_both"></div><br />  

            <div class="col-lg-6 p_l_n edt_hide">
                <div>
                    <label class="req">Group</label>

                    <select class="form-control" id="grp_list" >
                        <option value="">Select a Group</option>   
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'grp');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grp']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['grp']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['grp']->value->name;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>    
                    </select>
                </div>
            </div> 
            <div class="col-lg-6 p_l_n edt_hide">
                <div>
                    <label class="req">Organization</label>

                    <select class="form-control" id="org_list" >
                        <option value="">Select a Organization</option>   
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'org');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['org']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['org']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['org']->value->name;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>    
                    </select>
                </div>
            </div>
            <div class="clear_fix_both"></div><br />   

            <div class="col-lg-6 p_l_n">
                <div>
                    <label class="req">Payment Type</label>

                    <select class="form-control" id="pay_mode" >
                        <option value="">Select Type</option>   
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['users_pay_type']->value, 'utname', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['utname']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['utname']->value;?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>                                             
                    </select>
                </div>
            </div> 
        </div>       
        <div class="clear_fix_both"></div><br>
        
        <input type="hidden" id="usr_status" name="usr_status" value="1" />
        <input type="hidden" id="hid_usr_code" />
        <div id="ur-form-loading" style="display:none"></div>
        <div class="align-center alert alert-danger pull-left rt_15" style="display: none;" id="usr-action-state"></div>
        <div class="align-right lt_15" id="form-buttons">
            <button type="button" id="btn-user-save" class="btn btn-success" onclick="saveUser()">Update</button>
            <button type="button" class="btn btn-default" onclick="cancelUser()">Cancel</button>
        </div>

    </form>
</div>

<?php echo '<script'; ?>
 type="text/template" id="user_detail_view">

    <div class="">
    <div class="btn-group pull-right">
							<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-DISABLE'] > 0) {?>
							<a class="btn btn-default edt_stu" href="javascript:;" onclick='editUserStatus()'>
								<i class="fa fa-times" data-status="0" title="Click to disable" data-toggle="tooltip"></i>
							</a>
							<?php }?>
							
							<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-EDIT'] > 0) {?>
							<a href="javascript:;" class="btn btn-default edt" title="Edit details" data-toggle="tooltip" onclick="saveDialogUser()">
								<i class="fa fa-pencil igreen"></i>
							</a>
							<?php }?>
							
							<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-MAP-GRP'] > 0) {?>
							<a title="Edit user group" data-toggle="tooltip" class="btn btn-default grp" href="javascript:;"  onclick='groupDialogUser()'>
								<i class="fa fa-users"></i>
							</a>
							<?php }?>
														
							<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-REST-PWD'] > 0) {?> 
							<a title="Reset password" data-toggle="tooltip" class="btn btn-default rspa" href="javascript:;" onclick='deleteNamespaceMapping()'>
								<i class="fa fa-lock"></i>
							</a>
                        	<?php }?>
							
							<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-ADD-CMISN'] > 0) {?> 
                            <a title="Add commissions" data-toggle="tooltip" class="btn btn-default urctr" href="javascript:;" onclick='commissionsDialog()'>
                            	<i class="fa fa-inr"></i>
                            </a>
							<?php }?>
                            
							<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-DELETE'] > 0) {?>
                            <a title="Delete" data-toggle="tooltip" class="btn btn-default del" href="javascript:;" onclick='deleteUser()'>
							<i class="fa fa-trash-o"></i>
							</a>
							<?php }?>
								
                                </div>
                                    <div class="btn-group pull-left"><h4>Personal Details</h4></div>         
                                </div>
                                <div class="clear_fix_both"></div><br />

                                <div class="box_content">
                                    <div class="row border-bottom" >
                                        <label class="col-md-3">Employee Code:</label>
                                        <div class="col-md-3 viw_employee_code"></div>
                                        <label class="col-md-3">Name:</label>
                                        <div class="col-md-3 viw_name"></div>
                                    </div>
                                    <div class="row border-bottom">
                                        <label class="col-md-3">User Code:</label>
                                        <div class="col-md-3 usrcode"></div>
                                        <label class="col-md-3">User Name:</label>
                                        <div class="col-md-3 usr_name"></div>
                                    </div>
                                    <div class="row">
                                        <label class="col-md-3">Father Name:</label>
                                        <div class="col-md-3 lst_name"></div>
                                        <label class="col-md-3">Email:</label>
                                        <div class="col-md-3 email"></div>
                                    </div>  
                                    <div class="row">
                                        <label class="col-md-3">Organization:</label>
                                        <div class="col-md-3 org_name"></div>
                                        <label class="col-md-3">Group:</label>
                                        <div class="col-md-3 grp_name"></div>
                                    </div>
                                    <div class="row">
                                        <label class="col-md-3">Payment Type:</label>
                                        <div class="col-md-3 type_name"></div>
                                        <label class="col-md-3">Mobile Number:</label>
                                        <div class="col-md-3 mob_no"></div>
                                    </div>  
                                </div>
                                <br />    
                            <?php echo '</script'; ?>
>
                
        
<?php echo '<script'; ?>
 type="text/html" id="cargo_commission">
    <div>
        <div class="row">
            <div class="col-sm-6">
                <h4>Cargo Commissions</h4>
            </div>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-ADD-CMISN'] > 0) {?> 
                <div class="col-sm-1 text-left" style="padding-top:13px;">
                    <button class="btn btn-default btn-xs" onclick="commissionsDialog()" title="Add commissions"><i class="fa fa-plus"></i>Add</button>
                </div>
            <?php }?>
        </div>
        <div class="clear_fix_both"></div>
        <div id="user_commisions_cont"></div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 type="text/html" id="cargo_station_commission">
    <div>
        <div class="row">
            <div class="col-sm-6">
                <h4>Cargo Station Commissions</h4>
            </div>
            <div class="col-sm-1 text-left" style="padding-top:13px;">
                <button class="btn btn-default btn-xs" onclick="stationCommissionsDialog()" title="Add commissions"><i class="fa fa-plus"></i>Add</button>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <div id="user_station_commisions_cont"></div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 type="text/html" id="user_branches_tpl">
    <div class="col-sm-6 p_l_n" id="cargo_user_branches">
        <div class="row"> 
            <div class="col-sm-8">
                <h4>Branches Assigned</h4>
            </div>
            <div class="col-sm-4 text-center" style="padding-top:13px;">
                <button class="btn btn-default btn-xs" onclick="showUserBranchDialog()"><i class="fa fa-plus"></i>Add</button>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <div id="user_assigned_branches">
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 type="text/html" id="user_paymenttypes_tpl">
    <div class="col-sm-6 p_l_n" id="user_paymenttypes_panel">
        <div class="row"> 
            <div class="col-sm-8">
                <h4>Payment Types</h4>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <div>
            <select class="form-control" id="book_pay_type" multiple>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargo_payment_status']->value, 'name', false, 'code');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['name']->value) {
?>
                    <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['name']->value;?>
</option>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </select>
        </div>
        <div style="display: none;" id="user-paymenttypes-state"></div>
        <div id="user-paymenttypes-bttons">
            <button type="button" class="btn btn-success" onclick="updateUserPaymentTypes()">Save</button>
        </div>
    </div>
<?php echo '</script'; ?>
>

<?php echo '<script'; ?>
 type="text/html" id="cargo_tds_tpl">
    <div id="cargo_tds">
        <div class="row" > 
            <div class="col-sm-6"> 
                <h4>TDS Deduction Details</h4>
            </div>
            <div class="col-sm-6 text-left" style="padding-top:10px;">
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['USR-ADD-CMISN'] > 0) {?>
                <button class="btn btn-default btn-xs addtds" onclick="addTdsDialog();"><i class="fa fa-plus"></i>Add</button>
                <?php }?>
            </div>
        </div>       
        <div class="clear_fix_both"></div>
        <div id="cargo_tds_list">
        </div>
    </div>
<?php echo '</script'; ?>
>

<div id="user-branch-dialog" class="dialog-content-page" style="display: none">
    <form action="#">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="req">Branches</label>
                    <select class="form-control" id="user-branch" multiple>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['userAssignedBranches']->value, 'row');
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

            <div class="col-md-12">
                <div class="align-center alert alert-danger" style="display: none;" id="user-branch-state"></div>
            </div>

            <div class="col-md-12 text-right">
                <button type="button" id="btn-save" class="btn btn-success" onclick="saveUserBranch()">Save</button>
                <button type="button" class="btn btn-default" onclick="cancelUserBranch()">Cancel</button>
            </div>
        </div>
    </form>
</div>

<div id="edit-user-rps" class="dialog-content-page" style="display: none">
    <form class="form-horizontal " action="#">
        <div class="form-group">
            <div>
                <label class="req">New Password</label>
                <input type="password" id="txt_nw_pass" class="form-control" placeholder="New Password">
            </div>
        </div>
        <div class="form-group">
            <div>
                <label class="req">Confirm Password</label>
                <input type="password" id="txt_cnf_pass" class="form-control" placeholder="Confirm Password">
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>
        <input type="hidden" id="hid_code" />
        <div id="ur-rps-loading" style="display:none"></div>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-rps-state"></div>
        <div class="align-right" id="form-rps-bttons">
            <button type="button" id="btn-save" class="btn btn-success" onclick="restPassword()">Update</button>
            <button type="button" class="btn btn-default" onclick="cancelResetDialog()">Cancel</button>
        </div>
    </form>
</div>
                
<div id="cargo-commission-diolog" class="dialog-content-page" style="display: none">
    <form class="form pt10" action="#">
        <div class="row">
            <div class="col-md-12 bold">Booking</div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Paid <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="paid_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="paid_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">ToPay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="topay_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="topay_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">AccPay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="accpay_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="accpay_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Door Pickup Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="door_pick_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="door_pick_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">Loading Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="loading_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="loading_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <hr style="margin: 10px 0;">
        <div class="row">
            <div class="col-md-12 bold">Delivery</div>
        </div>
        <br>
        <div class="row">     
            <div class="col-md-4 form-group">
                <label class="req">Paid <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="delivary_paid_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="delivary_paid_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">Topay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="delivary_topay_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="delivary_topay_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            
            <div class="col-md-4 form-group">
                <label class="req">Accpay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="delivary_accpay_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="delivary_accpay_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Door Delivery Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="door_delivery_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="door_delivery_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-4 form-group">
                <label class="req">Unloading Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="unloading_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="unloading_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <hr style="margin: 10px 0;">
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Credit Limit</label>
                <div class="input-group">
                    <span class="input-group-addon"> <i class="fa fa-inr"></i></span>
                    <input type="text" id="credit_limit" class="form-control" placeholder="Value"> 
                </div>
            </div>  
            <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->captureStateWiseCommissionFlag) {?>
                <div class="col-md-4 form-group">
                    <label class="req">State</label>
                    <select id="commission_state" class="form-control">
                        <option value=""></option>
                        <option value="NA">Default</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value, 'row');
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
            <?php }?>
        </div>       
        
        <input type="hidden" id="hid-comm-code">
        <input type="hidden" id="hid-user-code">
        <div class="clearfix"></div>
        <div id="ur-cms-loading" style="display:none"></div>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-comissions-state"></div>
        <div class="align-right" id="form-cargo-comm-bttons">
            <button type="button" class="btn btn-success" onclick="saveCargoCommissions()">Update</button>
            <button type="button" class="btn btn-default" onclick="cancelCommissionsDialog()">Cancel</button>
        </div>

    </form>
</div>

<div id="cargo-station-commission-diolog" class="dialog-content-page-s" style="display: none">
    <form class="form pt10" action="#">
        <div class="row">
            <div class="col-md-12 bold">Booking</div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Paid <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="paid_station_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="paid_station_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">ToPay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="topay_station_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="topay_station_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">AccPay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="accpay_station_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="accpay_station_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Door Pickup Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="door_pick_station_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="door_pick_station_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">Loading Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="loading_station_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="loading_station_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <hr style="margin: 10px 0;">
        <div class="row">
            <div class="col-md-12 bold">Delivery</div>
        </div>
        <br>
        <div class="row">     
            <div class="col-md-4 form-group">
                <label class="req">Paid <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="delivary_paid_station_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="delivary_paid_station_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            <div class="col-md-4 form-group">
                <label class="req">Topay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="delivary_station_topay_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="delivary_topay_station_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
            
            <div class="col-md-4 form-group">
                <label class="req">Accpay <?php echo lang('lr');?>
 Commission</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="delivary_accpay_station_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="delivary_accpay_station_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Door Delivery Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="door_delivery_station_comm" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="door_delivery_station_comm_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-4 form-group">
                <label class="req">Unloading Share</label>
                <div class="row">
                    <div class="col-sm-6 p_r_n">
                        <input type="text" id="unloading_station_commission" class="form-control" placeholder="Value" required> 
                    </div>
                    <div class="col-sm-6 p_l_n">
                        <select id="unloading_station_commission_type" class="form-control">
                            <option value="PER">Percentage</option>
                            <option value="FLT">Rupees</option>
                        </select>
                    </div>
                </div>
            </div> 
        </div>
        <hr style="margin: 10px 0;">
        <div class="row">
            <div class="col-md-4 form-group">
                <label class="req">Credit Limit</label>
                <div class="input-group">
                    <span class="input-group-addon"> <i class="fa fa-inr"></i></span>
                    <input type="text" id="credit_station_limit" class="form-control" placeholder="Value"> 
                </div>
            </div>  
            <div class="col-lg-6 p_l_n">
                <div>
                    <label class="req">Station</label>
                    <select id="station_commission" class="form-control" multiple>
                        <option value="NA">All Station</option>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value['name'];?>
</option>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </select>
                </div>
            </div>

        </div>       
        
        <input type="hidden" id="hid-comm-code">
        <input type="hidden" id="hid-user-code">
        <div class="clearfix"></div>
        <div id="ur-cms-loading" style="display:none"></div>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-comissions-state"></div>
        <div class="align-right" id="form-cargo-comm-bttons"><br>
            <button type="button" class="btn btn-success" onclick="saveCargoCommissionsStation()">Update</button>
            <button type="button" class="btn btn-default" onclick="cancelStationCommissionsDialog()">Cancel</button>
        </div>

    </form>
</div>

<div id="import-bits-users" class="dialog-content-page" style="display: none">
    <form class="form-horizontal " action="#">

        <div class="form-group">
            <div>
                <label class="req">Bits Users</label>
                <select class="form-control" id="bits-users" multiple></select>
            </div>
        </div>
        <div class="form-group">
            <div>
                <label class="req">Group</label>
                <select class="form-control" id="bits-users-group" >
                    <option value="">Select a Group</option>   
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'grp');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['grp']->value) {
?>
                        <option value="<?php echo $_smarty_tpl->tpl_vars['grp']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['grp']->value->name;?>
</option>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?> 
                </select>
            </div>
        </div>

        <div class="clear_fix_both"></div><br/>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="import-bits-users-state"></div>
        <div class="align-right">
            <button type="button" id="btn-save" class="btn btn-success" onclick="saveBitsUsers()">Save</button>
            <button type="button" class="btn btn-default" onclick="cancelBitsUsers()">Cancel</button>
        </div>
    </form>
</div>

<!--TDS dialog-->                 
<div id="edit-user-tds" class="dialog-content-page" style="display: none">
    <form class="form-horizontal" action="#">
        
        <div class="form-group">
            <h5>TDS Deduction Details</h5>
        </div>
        
        <div class="form-group">                                        
            <label class="req">TDS Charges</label>
            <div class="input-group">
                <span class="input-group-addon">%</span>
                <input type="text" id="usr_tds_value" class="form-control" placeholder="0"  maxlength="4" autocomplete="off">
            </div>                                       
        </div>
        
        <div class="form-group">                                        
            <label class="req">Effective date from</label>                                        
            <input type="text" id="usr_tds_date" class="form-control">                                                                              
        </div>
        
        <div class="form-group">                                        
            <label class="req">PAN Number</label>                                        
            <input type="text" id="usr_tds_pan" class="form-control">  
        </div>   
                                                                                
        <div class="clear_fix_both"></div><br/>
        
        <input type="hidden" id="hid_urs_tds_code"  value="" />
        <input type="hidden" id="hid_tds_code" value="" />
        
        <div id="ur-tds-loading" style="display:none"></div>
        <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-tds-state"></div>
        <div class="align-right" id="form-tds-bttons">
            <button type="button" id="btn-save" class="btn btn-success" onclick="saveUserTds()">Update</button>
            <button type="button" class="btn btn-default" onclick="cancelUserTdsDialog()">Cancel</button>
        </div>

    </form>
</div>
<!--TDS dialog end-->

<div id="user-commissions-dialog"  class="dialog-content-page" style="display: none;">
    <div class="popup_top sticky-row-top" style="z-index: 99;">
        <div class="row">
            <div class="col-md-10 ft_14">
                <span class="bold">User Commissions</span>
            </div>
            <div class="col-md-2">
                <a class="align-right" onclick="closeUserCommissions()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    <div id="user-commissions-panel"></div>
</div>

<style>
    .multiselect-item.multiselect-all label {
        font-weight: bold!important;
    }
</style>

<?php echo '<script'; ?>
>
    var userlist = <?php echo json_encode($_smarty_tpl->tpl_vars['users_raw']->value);?>
;
    var cargoSetting = <?php echo json_encode($_smarty_tpl->tpl_vars['cargo_setting']->value);?>
;
    var bitsuserlist = [];


           
    $(document).ready(function() {
        $('input#list_search').quicksearch('#user_list_search #usr_scroll > li');
    });
    // Slim Scroll
    $("#usr_scroll").css({
        'max-height': '350px',
    }).perfectScrollbar({
        wheelSpeed: 20,
        wheelPropagation: false
    });
    $('#list_search').focus();

    $('#station_commission').select2({
        placeholder: 'Select Transactions'
    });

    $('#bits-users').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropLeft: true,
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        buttonClass: 'btn btn-default bits-users',
        buttonContainer: '<div id="bits-users-list-container" class="custom-cb multiselect-inline bits-users"></div>',
        templates: {
            button: '',
            ul: '<ul class="multiselect-container bits-users-list" style="width: 100%;"></ul>',
            li: '<li><label></label></li>',
        }
    });

    $('#user-branch').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        dropLeft: true,
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        includeSelectAllOption: true,
        selectAllText: 'Select All Branches',
        buttonClass: 'btn btn-default user-branch',
        buttonContainer: '<div id="user-branch-list-container" class="custom-cb multiselect-inline user-branch" style="height: 200px;position: relative;"></div>',
        templates: {
            button: '',
            ul: '<ul class="multiselect-container user-branch-list" style="width: 100%;"></ul>',
            li: '<li><label></label></li>',
        }
    });

    if (cargoSetting.captureStateWiseCommissionFlag) {
        $('#commission_state').select2();
    }



    function exportUserExcel(){
        document.trans_form.action = "config/export-user-excel";
        document.trans_form.target = "irm_downloader";
        document.trans_form.submit();
        return;
    }
    
    function saveDialogUser(code) {

        $('#form-buttons').show();
        $('.inp_error').removeClass('inp_error');
        $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger').hide();
        $('#user_availablity_state').removeClass('alert').removeClass('alert-success').removeClass('alert-danger');
        $('#user_availablity_state').html('');
        $('.edt_hide').show();
        $('#btn-user-save').removeClass('hide');

        var heig = 650;
        $('#txt_employee_code,#txt_name,#txt_lname,#txt_email,#txt_mobile,#grp_list,#org_list,#hid_usr_code,#txt_usr_name').val('');
        $('#btn-user-save').attr("onclick", "saveUser('"+code+"')");
        $('.edt_hide').show();
        if (_isdefined(code)) {
            $.each(userlist, function(keys, values) {
                if (values.code == code) {
                    $('#txt_employee_code').val(values.aliasCode);
                    $('#txt_name').val(values.name);
                    $('#txt_lname').val(values.lastname);
                    $('#txt_email').val(values.email);
                    $('#txt_mobile').val(values.mobile);
                    $('#txt_usr_name').val(values.username);
                    $('#pay_mode').val(values.paymentType.code);
                    $('#hid_usr_code').val(code);
                    $('#usr_statu').val(values.activeFlag);
                    $('.edt_hide').hide();
                    $('#grp_list').val('');
                    $('#org_list').val('');
                    $('#btn-save').attr("onclick", "saveUser('" + code + "')");
                }
            });
            heig = 500;
        } else {
            $('#pay_mode').val('');
            heig = 500;
        }

        $('#cargo-user-dialog').dialog({
            autoOpen: true,
            height: heig,
            width: 700,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
    }
    function cancelUser() {
        $('#cargo-user-dialog').dialog('destroy');
        $('#cargo-user-dialog').hide();
    }
    function checkUsernameAvailablity(ele) {
        var n = $.trim( $(ele).val() );
        var data = {};
        data.username = n;
        $('#user_availablity_state').removeClass('alert').removeClass('alert-success').removeClass('alert-danger');
        $('#user_availablity_state').html(loading_popup+' checking availablity');
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/user-availablity",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#user_availablity_state').addClass('alert').addClass('alert-success').html('Username available to use');
                    $('#btn-user-save').removeClass('hide');
                } else {
                    $('#user_availablity_state').addClass('alert').addClass('alert-danger').html('Sorry! Username already taken');
                    $('#btn-user-save').addClass('hide');
                }
            }
        });
    }
    
    function saveUser(code) {
        var data = {};
        data.activeFlag = $('#usr_status').val();
        data.name = $('#txt_name').val();
        data.code = $('#hid_usr_code').val();
        data.lastname = $('#txt_lname').val();
        data.email = $('#txt_email').val();
        data.group = $('#grp_list').val();
        data.username = $('#txt_usr_name').val();
        data.organization = $('#org_list').val();
        data.mobile = $('#txt_mobile').val();
        data.pay_mode = $('#pay_mode').val();
        data.mode = $("#pay_mode option:selected").text();
        data.aliasCode = $.trim($('#txt_employee_code').val());

        var err = 0;
        $('.inp_error').removeClass('inp_error');
        if ($('#txt_name').val() == '') {
            $('#txt_name').addClass('inp_error');
            err++;
        }

        if (data.aliasCode == '') {
            $('#txt_employee_code').addClass('inp_error');
            err++;
        }
        
        if ($('#txt_lname').val() == '') {
            $('#txt_lname').addClass('inp_error');
            err++;
        }

        if ($('#txt_usr_name').val() == '' && (code == '' || code == undefined)) {
            $('#txt_usr_name').addClass('inp_error');
            err++;
        }
        
        if ($('#txt_email').val() == '') {
            $('#txt_email').addClass('inp_error');
            err++;
        }
        
        if ($('#grp_list').val() == '' && (code == '' || code == undefined)) {
            $('#grp_list').addClass('inp_error');
            err++;
        }
        
        if ($('#org_list').val() == '' && (code == '' || code == undefined)) {
            $('#org_list').addClass('inp_error');
            err++;
        }
        
        if ($('#txt_mobile').val() == '') {
            $('#txt_mobile').addClass('inp_error');
            err++;
        }
        
        if ($('#pay_mode').val() == '') {
            $('#pay_mode').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#usr-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#usr-action-state').show();
            return false;
        } else {
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
        }
        var filter = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        if (!filter.test(data.email) && (code == '' || code == undefined)) {
            $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#usr-action-state').html('Please enter valid email.');
            $('#usr-action-state').show();
            $('#txt_email').addClass('inp_error');
            return false;
        } else {
            $('#txt_email').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
        }
        if (isNaN(data.mobile))
        {
            $('#usr-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#usr-action-state').html('Please enter valid mobile number');
            $('#usr-action-state').show();
            return false;
        } else {
            $('#txt_mobile').removeClass('inp_error');
            $('#usr-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-action-state').html('');
            $('#usr-action-state').hide();
        }
        $('#form-bttons').hide();
        $('#ur-form-loading').html(loading_popup);
        $('#ur-form-loading').show();
        $('#form-buttons').hide();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/add-user",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ur-form-loading').html('');
                    $('#ur-form-loading').hide();
                    $('#usr-action-state').removeClass('alert-danger').addClass('alert-success');
                    $('#usr-action-state').show();
                    $('#usr-action-state').html('Your request has been completed successfully');
                    if (code == 'undefined' || code == '') {
                        response.data.organization.name = $('#org_list').find(":selected").text();
                        response.data.group.name = $('#grp_list').find(":selected").text();
                        userlist.push(response.data);

                        var usr = $('#user_list_view').html();
                        usr = $('<div>').html(usr).clone();
                        usr.find('a').html(data.name);//id="usr-viw-{$row->code}" //onclick="userView('{$row->code}')"
                        usr.find('a').attr("id", "usr-viw-" + response.data.code);
                        usr.find('a').attr("onclick", "userView('" + response.data.code + "')");

                        $('#usr_scroll').append(usr);
                        window.setTimeout(function() {
                            cancelUser();
                            checkURL();
                        }, 3000);
                    } else if (code != '') {
                        $.each(userlist, function(keys, values) {
                            if (values.code == code) {
                                userlist[keys].aliasCode = data.aliasCode;
                                userlist[keys].name = data.name;
                                userlist[keys].lastname = data.lastname;
                                userlist[keys].email = data.email;
                                userlist[keys].mobile = data.mobile;
                                userlist[keys].paymentType.name = data.mode;
                                userlist[keys].paymentType.code = data.pay_mode;
                            }
                        });
                        $('#usr-viw-' + code).html(data.name);
                        $('#usr-viw-' + code).trigger("click");
                        window.setTimeout(function() {
                            cancelUser();
                        }, 3000);

                    }

                } else {

                    $('#ur-form-loading').html('');
                    $('#ur-form-loading').hide();
                    $('#usr-action-state').removeClass('alert-success').addClass('alert-danger');
                    $('#usr-action-state').html(response.errorDesc);
                    $('#usr-action-state').show();
                    $('#form-buttons').show();
                }
            }
        });
    }
    
    function userView(code) {
        $('#usr-viw-rslt').html('<div align="left">' + loading_big + '</div>');

        $.each(userlist, function(keys, values) {
            if (values.code == code) {
                var data = {};
                data.code = code;   
                
                
                var usr = $('#user_detail_view').html();
                usr = $('<div>').html(usr).clone();
                usr.find('.viw_employee_code').text(values.aliasCode || '-');
                usr.find('.viw_name').text(values.name);
                usr.find('.lst_name').text(values.lastname);
                usr.find('.usr_name').text(values.username);
                usr.find('.email').text(values.email);
                usr.find('.org_name').text(values.organization.name);
                usr.find('.usrcode').text(values.code);
                usr.find('.grp_name').text(values.group.name);
                usr.find('.type_name').text(values.paymentType.name);
                
                var mverified = ' <span class="label label-warning">Yet to Verify</span>';
                if(values.mobileVerifiedFlag==1) {
                    mverified = ' <span class="label label-success">Verified</span>';
                }
                if( _isdefined(values.mobile) ) {
                    usr.find('.mob_no').html(values.mobile +' '+mverified);
                }    
                
                usr.find('.edt').attr("onclick", "saveDialogUser('" + code + "')");
                usr.find('.edt_stu').attr("onclick", "editUserStatus('" + code + "',this)");
                usr.find('.del').attr("onclick", "deleteUser('" + code + "')");
                if (values.activeFlag == 1) {
                    usr.find('.edt_stu').find("i").removeClass("fa-check").addClass('fa-times');
                    usr.find('.edt_stu').attr('data-status', values.activeFlag);
                    usr.find('.edt_stu').attr('title', 'Click to disable');
                } else if (values.activeFlag == 0) {
                    usr.find('.edt').hide();
                    usr.find('.edt_stu').find("i").removeClass("fa-times").addClass('fa-check');
                    usr.find('.edt_stu').attr('data-status', values.activeFlag);
                    usr.find('.edt_stu').attr('title', 'Click to enable');
                }
                usr.find('.rspa').attr("onclick", "resetDialogUser('" + code + "')").toggle(values.integrationType == null || values.integrationType.code == null);
                //usr.find('.urctr').attr("onclick", "commissionsDialog('" + code + "')");
                
                $('#usr-viw-rslt').html(usr);
                $('#hid_usr_code').val(code); 

                loadUserCommissions(code)
                loadstationCommissions(code);
                loadUserTDS(code)
                loadUserBranches(code)
                loadUserPaymentTypes(code)
            }
        });
    }
    
    function deleteUser(code) {
        if (confirm('Do you want to delete this user?')) {
            var user = _.find(userlist || [], i => i.code == code);
            var data = {};
            data.code = code;
            data.username = user.username;

            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/delete-user",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        $('#usr-' + code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                            $(this).remove()
                        });
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        $('#usr-viw-rslt').html('<div class="p_t_100"><div class="well well-large "> Click any of the user name to view more details.</div></div>');
                    } else {
                        alert(response.errorDesc);
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                }
            })
        }
    }
    
    function editUserStatus(code, obj) {
        var user = _.find(userlist || [], i => i.code == code);
        var data = {};
        data.code = code;
        data.username = user.username;
        data.activeFlag = $(obj).attr('data-status') == 1 ? 0 : 1;
        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/edit-status-user",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $(obj).attr('data-status', data.activeFlag);
                    if (data.activeFlag == 0) {
                        $('.edt').hide();
                        $(obj).find('.fa').removeClass('fa-times').addClass('fa-check').attr('title', 'Click to enable');//0
                    } else {    
                        $('.edt').show();
                        $(obj).find('.fa').removeClass('fa-check').addClass('fa-times').attr('title', 'Click to disable');//1
                    }
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
    function resetDialogUser(code) {
        $('.inp_error').removeClass('inp_error');
        $('#usr-rps-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
        $('#form-rps-bttons').show();
        $('#hid_code').val(code);
        $("#txt_nw_pass,#txt_cnf_pass").val('');

        $('#edit-user-rps').dialog({
            autoOpen: true,
            height: 300,
            width: 600,
            modal: true,
            resizable: false
        });

        $(".ui-dialog-titlebar").hide();
    }
    function cancelResetDialog() {
        $('#edit-user-rps').dialog('destroy');
        $('#edit-user-rps').hide();
    }
    function restPassword() {
        var data = {};
        data.code = $('#hid_code').val();
        data.password = $("#txt_nw_pass").val();
        var err = 0;

        if ($("#txt_nw_pass").val() == '') {
            $("#txt_nw_pass").addClass('inp_error');
            err++;
        } else {
            $("#txt_nw_pass").removeClass('inp_error');
        }

        if ($("#txt_cnf_pass").val() == '') {
            $("#txt_cnf_pass").addClass('inp_error');
            err++;
        } else {
            $("#txt_cnf_pass").removeClass('inp_error');
        }

        if (err > 0) {
            $('#ur-rps-loading').html('');
            $('#ur-rps-loading').hide();
            $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
            $('#usr-rps-state').html('Please enter the values in the field that are marked in red');
            $('#usr-rps-state').show();
            return false;
        }
        if (data.password.length < 6) {
            $("#txt_nw_pass").addClass('inp_error');
            $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
            $('#usr-rps-state').html('Password should be minimum 6 charactors.');
            $('#usr-rps-state').show();
            return false;

        } else {
            $("#txt_nw_pass").removeClass('inp_error');
            $('#usr-rps-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-rps-state').html('');
            $('#usr-rps-state').hide();
        }
        if ($("#txt_nw_pass").val() != $("#txt_cnf_pass").val()) {
            $('#ur-rps-loading').html('');
            $('#ur-rps-loading').hide();
            $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
            $('#txt_cnf_pass').addClass('inp_error');
            $('#usr-rps-state').show();
            $('#usr-rps-state').html('Please enter the same password as above.');
            return false;
        } else {
            $('#usr-rps-state').removeClass('alert-success').removeClass('alert-danger');
            $('#txt_cnf_pass').removeClass('inp_error');
            $('#usr-rps-state').html('');
            $('#usr-rps-state').hide();
        }
        $('#form-rps-bttons').hide();
        $('#ur-rps-loading').html(loading_popup);
        $('#ur-rps-loading').show();


        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/edit-user-password",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ur-rps-loading').html('');
                    $('#ur-rps-loading').hide();
                    $('#usr-rps-state').removeClass('alert-danger').addClass('alert-success');
                    $('#usr-rps-state').show();
                    $('#usr-rps-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelResetDialog();
                    }, 3000);
                } else {
                    $('#ur-rps-loading').html('');
                    $('#ur-rps-loading').hide();
                    $('#usr-rps-state').removeClass('alert-success').addClass('alert-danger');
                    $('#usr-rps-state').html(response.errorDesc);
                    $('#usr-rps-state').show();
                    $('#form-rps-bttons').show();
                }
            }
        });
    }
    
    function commissionsDialog(code){
        $('.inp_error').removeClass('inp_error');
        
        $('#cargo-commission-diolog').dialog({
            autoOpen: true,
            height: 600,
            width: 675,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        
        $('#usr-comissions-state').html('').hide();
        $('#form-cargo-comm-bttons').show();
        
        if (_isdefined(code)) {
            $('#hid-comm-code').val(code.code);
            $('#paid_commission').val(code.paidCommissionValue);
            $('#topay_commission').val(code.toPayCommissionValue);
            $('#accpay_commission').val(code.accPayCommissionValue);
            $('#loading_commission').val(code.loadingCommissionValue);
            $('#unloading_commission').val(code.unloadingCommissionValue);
            $('#delivary_topay_comm').val(code.delivaryTopayCommissionValue);
            $('#delivary_paid_comm').val(code.delivaryPaidCommissionValue);
            $('#delivary_accpay_comm').val(code.delivaryAccpayCommissionValue);
            $('#credit_limit').val(code.creditLimit);
            $('#door_pick_comm').val(code.doorPickupCommissionValue);
            $('#door_delivery_comm').val(code.doorDeliveryCommissionValue);             

            $('#paid_commission_type').val(code.paidCommissionTypeCode || 'PER');
            $('#topay_commission_type').val(code.toPayCommissionTypeCode || 'PER');
            $('#accpay_commission_type').val(code.accPayCommissionTypeCode || 'PER');
            $('#loading_commission_type').val(code.loadingCommissionTypeCode || 'PER');
            $('#unloading_commission_type').val(code.unloadingCommissionTypeCode || 'PER');
            $('#delivary_topay_comm_type').val(code.deliveryTopayCommissionTypeCode || 'PER');
            $('#delivary_paid_comm_type').val(code.deliveryPaidCommissionTypeCode || 'PER');
            $('#delivary_accpay_comm_type').val(code.deliveryAccpayCommissionTypeCode || 'PER');
            $('#door_pick_comm_type').val(code.doorPickupCommissionTypeCode || 'PER');
            $('#door_delivery_comm_type').val(code.doorDeliveryCommissionTypeCode || 'PER');
            $('#commission_state').val(code.state.code || 'NA').trigger('change');
        } else {
            $('#cargo-commission-diolog input').val('');
            $('#cargo-commission-diolog select').prop('selectedIndex', 0);

            $('#commission_state').val('').trigger('change');
        }
    }

   function stationCommissionsDialog(code){
        $('.inp_error').removeClass('inp_error');
            
        $('#cargo-station-commission-diolog').dialog({
            autoOpen: true,
            height: 600,
            width: 675,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        
        $('#usr-comissions-state').html('').hide();
        $('#form-cargo-comm-bttons').show();
        
        if (_isdefined(code)) {
            $('#hid-comm-code').val(code.code);
            $('#paid_commission').val(code.paidCommissionValue);
            $('#topay_commission').val(code.toPayCommissionValue);
            $('#accpay_commission').val(code.accPayCommissionValue);
            $('#loading_commission').val(code.loadingCommissionValue);
            $('#unloading_commission').val(code.unloadingCommissionValue);
            $('#delivary_topay_comm').val(code.delivaryTopayCommissionValue);
            $('#delivary_paid_comm').val(code.delivaryPaidCommissionValue);
            $('#delivary_accpay_comm').val(code.delivaryAccpayCommissionValue);
            $('#credit_limit').val(code.creditLimit);
            $('#door_pick_comm').val(code.doorPickupCommissionValue);
            $('#door_delivery_comm').val(code.doorDeliveryCommissionValue);             

            $('#paid_commission_type').val(code.paidCommissionTypeCode || 'PER');
            $('#topay_commission_type').val(code.toPayCommissionTypeCode || 'PER');
            $('#accpay_commission_type').val(code.accPayCommissionTypeCode || 'PER');
            $('#loading_commission_type').val(code.loadingCommissionTypeCode || 'PER');
            $('#unloading_commission_type').val(code.unloadingCommissionTypeCode || 'PER');
            $('#delivary_topay_comm_type').val(code.deliveryTopayCommissionTypeCode || 'PER');
            $('#delivary_paid_comm_type').val(code.deliveryPaidCommissionTypeCode || 'PER');
            $('#delivary_accpay_comm_type').val(code.deliveryAccpayCommissionTypeCode || 'PER');
            $('#door_pick_comm_type').val(code.doorPickupCommissionTypeCode || 'PER');
            $('#door_delivery_comm_type').val(code.doorDeliveryCommissionTypeCode || 'PER');
            $('#commission_state').val(code.state.code || 'NA').trigger('change');
        } else {
            $('#cargo-station-commission-diolog input').val('');
            $('#cargo-station-commission-diolog select').prop('selectedIndex', 0);

            $('#commission_state').val('').trigger('change');
        }
    }
    
    function cancelStationCommissionsDialog() {
        $('.inp_error').removeClass('inp_error');
        $('#cargo-station-commission-diologg').dialog('destroy');
        $('#cargo-station-commission-diolog').hide();
    }

    function cancelCommissionsDialog() {
        $('.inp_error').removeClass('inp_error');
        $('#cargo-commission-diolog').dialog('destroy');
        $('#cargo-commission-diolog').hide();
    }
    
    function saveCargoCommissions(){
        var data = {};  
        data.userCode = $('#hid_usr_code').val();
        data.code = $('#hid-comm-code').val();
        data.paidCommissionValue = $('#paid_commission').val();
        data.toPayCommissionValue = $('#topay_commission').val();
        data.accPayCommissionValue = $('#accpay_commission').val();
        data.loadingCommissionValue = $('#loading_commission').val();
        data.unloadingCommissionValue = $('#unloading_commission').val();
        data.delivaryTopayCommissionValue = $('#delivary_topay_comm').val();
        data.delivaryPaidCommissionValue = $('#delivary_paid_comm').val();
        data.delivaryAccpayCommissionValue = $('#delivary_accpay_comm').val();
        data.doorPickupCommissionValue = $('#door_pick_comm').val();
        data.doorDeliveryCommissionValue = $('#door_delivery_comm').val();
        data.paidCommissionTypeCode = $('#paid_commission_type').val();
        data.toPayCommissionTypeCode = $('#topay_commission_type').val();
        data.accPayCommissionTypeCode = $('#accpay_commission_type').val();
        data.loadingCommissionTypeCode = $('#loading_commission_type').val();
        data.unloadingCommissionTypeCode = $('#unloading_commission_type').val();
        data.deliveryTopayCommissionTypeCode = $('#delivary_topay_comm_type').val();
        data.deliveryPaidCommissionTypeCode = $('#delivary_paid_comm_type').val();
        data.deliveryAccpayCommissionTypeCode = $('#delivary_accpay_comm_type').val();
        data.doorPickupCommissionTypeCode = $('#door_pick_comm_type').val();
        data.doorDeliveryCommissionTypeCode = $('#door_delivery_comm_type').val();
        data.creditLimit = $('#credit_limit').val();
        data.state = {};
        data.state.code = $('#commission_state').val()?$('#commission_state').val():0;
        data.captureCommissionFlag = 1;
        data.station = $.map($('#station_commission').val() || [], (station) => ({ code: station }));
       

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.paidCommissionValue == '') {
            $('#paid_commission').addClass('inp_error');
            err++;
        }

        if (data.toPayCommissionValue == '') {
            $('#topay_commission').addClass('inp_error');
            err++;
        }

        if (data.accPayCommissionValue == '') {
            $('#accpay_commission').addClass('inp_error');
            err++;
        }

        if (data.loadingCommissionValue == '') {
            $('#loading_commission').addClass('inp_error');
            err++;
        }

        if (data.delivaryPaidCommissionValue == '') {
            $('#delivary_paid_comm').addClass('inp_error');
            err++;
        }

        if (data.delivaryTopayCommissionValue == '') {
            $('#delivary_topay_comm').addClass('inp_error');
            err++;
        }

        if (data.delivaryAccpayCommissionValue == '') {
            $('#delivary_accpay_comm').addClass('inp_error');
            err++;
        }

        if (data.unloadingCommissionValue == '') {
            $('#unloading_commission').addClass('inp_error');
            err++;
        }

        if (data.creditLimit == '') {
            $('#credit_limit').addClass('inp_error');
            err++;
        }

        if (data.doorPickupCommissionValue == '') {
            $('#door_pick_comm').addClass('inp_error');
            err++;
        }

        if (data.doorDeliveryCommissionValue == '') {
            $('#door_delivery_comm').addClass('inp_error');
            err++;
        }

        if (cargoSetting.captureStateWiseCommissionFlag && data.state.code == '') {
            $('#commission_state').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#usr-comissions-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#usr-comissions-state').html('Please enter the values in the field that are marked in red');
            $('#usr-comissions-state').show();
            return false;
        } else {
            $('#usr-comissions-state').removeClass('alert-success').removeClass('alert-danger');
            $('#usr-comissions-state').html('');
            $('#usr-comissions-state').hide();
        }
        
        $('#form-cargo-comm-bttons').hide();
        $('#ur-cms-loading').html(loading_popup);
        $('#ur-cms-loading').show();
        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-cargo-user-commissions",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ur-cms-loading').html('');
                    $('#ur-cms-loading').hide();
                    $('#usr-comissions-state').removeClass('alert-danger').addClass('alert-success');
                    $('#usr-comissions-state').show();
                    $('#usr-comissions-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelCommissionsDialog();
                        userView(data.userCode);
                    }, 3000);
                } else {
                    $('#ur-cms-loading').html('');
                    $('#ur-cms-loading').hide();
                    $('#usr-comissions-state').removeClass('alert-success').addClass('alert-danger');
                    $('#usr-comissions-state').html(response.errorDesc);
                    $('#usr-comissions-state').show();
                    $('#form-cargo-comm-bttons').show();
                }
            }
        });
    }
    
    function saveCargoCommissionsStation(){
        var data = {};  
        data.userCode = $('#hid_usr_code').val();
        data.code = $('#hid-comm-code').val();
        data.paidCommissionValue = $('#paid_commission').val();
        data.toPayCommissionValue = $('#topay_commission').val();
        data.accPayCommissionValue = $('#accpay_commission').val();
        data.loadingCommissionValue = $('#loading_commission').val();
        data.unloadingCommissionValue = $('#unloading_commission').val();
        data.delivaryTopayCommissionValue = $('#delivary_topay_comm').val();
        data.delivaryPaidCommissionValue = $('#delivary_paid_comm').val();
        data.delivaryAccpayCommissionValue = $('#delivary_accpay_comm').val();
        data.doorPickupCommissionValue = $('#door_pick_comm').val();
        data.doorDeliveryCommissionValue = $('#door_delivery_comm').val();
        data.paidCommissionTypeCode = $('#paid_commission_type').val();
        data.toPayCommissionTypeCode = $('#topay_commission_type').val();
        data.accPayCommissionTypeCode = $('#accpay_commission_type').val();
        data.loadingCommissionTypeCode = $('#loading_commission_type').val();
        data.unloadingCommissionTypeCode = $('#unloading_commission_type').val();
        data.deliveryTopayCommissionTypeCode = $('#delivary_topay_comm_type').val();
        data.deliveryPaidCommissionTypeCode = $('#delivary_paid_comm_type').val();
        data.deliveryAccpayCommissionTypeCode = $('#delivary_accpay_comm_type').val();
        data.doorPickupCommissionTypeCode = $('#door_pick_comm_type').val();
        data.doorDeliveryCommissionTypeCode = $('#door_delivery_comm_type').val();
        data.creditLimit = $('#credit_limit').val();
        data.state = {};
        data.state.code = $('#commission_state').val()?$('#commission_state').val():0;
        data.captureCommissionFlag = 1;
        data.toStations = $.map($('#station_commission').val() || [], (station) => ({ code: station }));
        console.log(data);

        
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/update-cargo-station-user-commissions",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ur-cms-loading').html('');
                    $('#ur-cms-loading').hide();
                    $('#usr-comissions-state').removeClass('alert-danger').addClass('alert-success');
                    $('#usr-comissions-state').show();
                    $('#usr-comissions-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelCommissionsDialog();
                        userView(data.userCode);
                    }, 3000);
                } else {
                    $('#ur-cms-loading').html('');
                    $('#ur-cms-loading').hide();
                    $('#usr-comissions-state').removeClass('alert-success').addClass('alert-danger');
                    $('#usr-comissions-state').html(response.errorDesc);
                    $('#usr-comissions-state').show();
                    $('#form-cargo-comm-bttons').show();
                }
            }
        });
    }

    function deleteUserCommissions(code , userCode){
        if (confirm('Do you want to delete this user Commissions?')) {
            var data = code;
            data.activeFlag = 2;
            data.userCode = userCode;
            
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "cargo/update-cargo-user-commissions",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                    } else {
                        alert(response.errorDesc);
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function() {
                        loading_overlay.hide();
                        userView(userCode);
                    }, 2000);
                }
            })
        }
    }

    function importBitsUsers() {
        $('.inp_error').removeClass('inp_error');
        $('#bits-users-list-container ul').html($('<li/>').html(loading_popup));
        $('#import-bits-users-state').hide();

        $('#import-bits-users').dialog({
            autoOpen: true,
            height: 500,
            width: 600,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/import-bits-users",
            success: function(response) {
                if (response.status == 1) {
                    bitsuserlist = response.data;
                    var options = [];
                    $.each(response.data || [], function (i, v) {
                        if (!$('[data-uname="' + v.username + '"]').length) {
                            options.push(new Option(v.name + ' ' + v.lastname, v.code));
                        }
                    });
                    if(options.length == 0) {
                        $('#bits-users-list-container ul').html('<li><div class="well well-large">No Users Found</div></li>');
                    } else {
                        $('#bits-users').html(options).multiselect('rebuild');
                    }
                } else {
                    $('#import-bits-users-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-users-state').html(response.errorDesc);
                    $('#import-bits-users-state').show();                    
                }
            }
        })
    }

    function cancelBitsUsers() {
        $('#import-bits-users').dialog('destroy');
        $('#import-bits-users').hide();
    }

    function saveBitsUsers() {        
        var err = 0;
        var data = {};
        data.groupCode = $('#bits-users-group').val();
        data.usersList = [];

        $.each(bitsuserlist || [], function (i, v) {
            if($('#bits-users [value="' + v.code + '"]').is(':selected')) {
                data.usersList.push(v);
            }
        });

        $('.inp_error').removeClass('inp_error');
        if (data.groupCode == '') {
            $('#bits-users-group').addClass('inp_error');
            err++;
        }

        if ((data.usersList || []).length == 0) {
            $("ul.bits-users-list").addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#import-bits-users-state').removeClass('alert-success').addClass('alert-danger');
            $('#import-bits-users-state').html('Please enter the values in the field that are marked in red');
            $('#import-bits-users-state').show();
            return false;
        }
        $('#import-bits-users-state').removeClass('alert-success alert-danger');
        $('#import-bits-users-state').html(loading_popup);
        $('#import-bits-users-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "cargo/save-bits-user",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#import-bits-users-state').removeClass('alert-danger').addClass('alert-success');
                    $('#import-bits-users-state').show();
                    $('#import-bits-users-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelBitsUsers();
                        checkURL();
                    }, 2000);
                } else {
                    $('#import-bits-users-state').removeClass('alert-success').addClass('alert-danger');
                    $('#import-bits-users-state').html(response.errorDesc);
                    $('#import-bits-users-state').show();
                }
            }
        });
    }

    function showUserBranchDialog(code){
        $('#user-branch').val([]).multiselect('refresh');
        $('.inp_error').removeClass('inp_error');
        $('#user-branch-state').html('').hide();
        
        $('#user-branch-dialog').dialog({
            autoOpen: true,
            height: 400,
            width: 500,
            modal: true,
            resizable: false
        });
    }
    
    function cancelUserBranch() {
        $('#user-branch-dialog').dialog('destroy');
        $('#user-branch-dialog').hide();
    }
    
    function saveUserBranch() {
        var err = 0;
        var data = {};
        data.userCode = $('#hid_usr_code').val();
        data.branchesList = $('#user-branch').val() || [];

        if (data.branchesList.length == 0) {
            $("ul.user-branch-list").addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#user-branch-state').removeClass('alert-success').addClass('alert-danger');
            $('#user-branch-state').html('Please enter the values in the field that are marked in red');
            $('#user-branch-state').show();
            return false;
        }
        $('#user-branch-state').removeClass('alert-success alert-danger');
        $('#user-branch-state').html(loading_popup);
        $('#user-branch-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "user/save-user-branches",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#user-branch-state').removeClass('alert-danger').addClass('alert-success');
                    $('#user-branch-state').show();
                    $('#user-branch-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelUserBranch();
                        loadUserBranches(data.userCode);
                    }, 2000);
                } else {
                    $('#user-branch-state').removeClass('alert-success').addClass('alert-danger');
                    $('#user-branch-state').html(response.errorDesc);
                    $('#user-branch-state').show();
                }
            }
        });
    }

    function removeUserBranch(branch) {
        var err = 0;
        var data = {};
        data.userCode = $('#hid_usr_code').val();
        data.branch = branch;

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "user/remove-user-branches",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                    loadUserBranches(data.userCode);
                } else {
                    alert(response.errorDesc);
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                }, 2000);
            }
        })
    }
    function loadUserBranches(userCode) {
        var data = {};
        data.userCode = userCode;

        $('#cargo_user_branches').remove();
        $('#usr-viw-rslt').append($('#user_branches_tpl').html());

        $('#user_assigned_branches').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "user/cargo-user-branches-list",
            data: data,
            success: function(response) {
                $('#user_assigned_branches').html(response);
            }
        });
    }

    function loadUserPaymentTypes(userCode) {
        $('#user_paymenttypes_panel').remove();
        $('#usr-viw-rslt').append($('#user_paymenttypes_tpl').html());

        var user = _.find(userlist || [], i => i.code == userCode);
        if (user) {
            $('#book_pay_type').val(user.bookingPaymentType.map(e => e.code));
        }

        $('#book_pay_type').multiselect({
            maxHeight: 350,
            numberDisplayed: 1,
            dropLeft: true,
            enableFiltering: false,
            enableCaseInsensitiveFiltering: false,
            includeSelectAllOption: true,
            selectAllText: 'Select All Payment Types',
            buttonClass: 'btn btn-default book_pay_type',
            buttonContainer: '<div id="user-payment-list-container" class="custom-cb multiselect-inline user-branch"></div>',
            templates: {
                button: '',
                ul: '<ul class="multiselect-container user-payment-list" style="position: relative; width: 100%;"></ul>',
                li: '<li><label></label></li>',
            }
        });
    }
    
    function loadUserCommissions(userCode) {
        var data = {};
        data.userCode = userCode;

        $('#cargo_tds').remove();
        $('#usr-viw-rslt').append($('#cargo_commission').html());

        $('#user_commisions_cont').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/cargo-user-commissions",
            data: data,
            success: function(response) {
                $('#user_commisions_cont').html(response);
            }
        });
    }

    function loadstationCommissions(userCode) {
        var data = {};
        data.userCode = userCode;

        $('#cargo_tds').remove();
        $('#usr-viw-rslt').append($('#cargo_station_commission').html());

        $('#user_station_commisions_cont').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/cargo-station-commissions",
            data: data,
            success: function(response) {
                $('#user_station_commisions_cont').html(response);
            }
        });
    }
    
    function loadUserTDS(userCode) {
        var data = {};
        data.userCode = userCode;

        $('#cargo_tds').remove();
        $('#usr-viw-rslt').append($('#cargo_tds_tpl').html());

        $('#cargo_tds_list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "config/user-tds",
            data: data,
            success: function(response) {
                $('#cargo_tds_list').html(response);
            }
        });
    }

    function addTdsDialog(code, tdscode) {
        $('.inp_error').removeClass('inp_error');
        $('#usr-tds-state').removeClass('alert-success').removeClass('alert-danger').hide().html('');
        $('#form-tds-bttons').show();
        
        $('#hid_urs_tds_code').val(code);
        $('#hid_tds_code').val(tdscode);

        $('#edit-user-tds').dialog({
            autoOpen: true,
            height: 550,
            width: 500,
            modal: true,
            resizable: false
        });
        
        $('#usr_tds_date').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-0D',
            endDate: '+12m',
            changeMonth: true,
        })

        $(".ui-dialog-titlebar").hide();
    }

    function cancelUserTdsDialog() {
        $('#edit-user-tds').dialog('destroy');
        $('#edit-user-tds').hide();
    }

    function saveUserTds() {
        var data = {}
        data.tdsvalue = $('#usr_tds_value').val();
        data.effectivedate = $('#usr_tds_date').val();    
        data.pan = $('#usr_tds_pan').val();
        
        data.code = $('#hid_tds_code').val();
        data.userCode = $('#hid_usr_code').val();

        $("#usr_tds_value, #usr_tds_date, #usr_tds_pan").removeClass('inp_error');
        $('#usr-tds-state').html('');
        $('#usr-tds-state').hide();
        
        var err = 0;
        if (Number(data.tdsvalue) <=0 ) {
            $("#usr_tds_value").addClass('inp_error');
            err++;
        } else if (isNaN(data.tdsvalue)) {
            $("#usr_tds_value").addClass('inp_error');
            err++;
        }
        
        if (data.effectivedate == '') {
            $("#usr_tds_date").addClass('inp_error');
            err++;
        }
        
        if (data.pan == '') {
            $('#usr_tds_pan').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#ur-tds-loading').html('');
            $('#ur-tds-loading').hide();
            $('#usr-tds-state').removeClass('alert-success').addClass('alert-danger');
            $('#usr-tds-state').html('Please enter the values in the field that are marked in red');
            $('#usr-tds-state').show();
            return false;
        }
        
        $('#form-tds-bttons').hide();
        $('#ur-tds-loading').html(loading_popup);
        $('#ur-tds-loading').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-user-tds",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('#ur-tds-loading').html('');
                    $('#ur-tds-loading').hide();
                    $('#usr-tds-state').removeClass('alert-danger').addClass('alert-success');
                    $('#usr-tds-state').show();
                    $('#usr-tds-state').html('Your request has been completed successfully');
                    
                    window.setTimeout(function() {
                        cancelUserTdsDialog();
                        loadUserTDS(data.userCode);
                    }, 3000);
                } else {
                    $('#ur-tds-loading').html('');
                    $('#ur-tds-loading').hide();
                    $('#usr-tds-state').removeClass('alert-success').addClass('alert-danger');
                    $('#usr-tds-state').show();
                    $('#usr-tds-state').html(response.errorDesc);
                }
            }
        });
    }

    function deleteUserTds(usercode) {
        var data = {};
        data.options = userTDSData;
        if(confirm('Do you want to delete this TDS deduction?')) {                
            var loading_overlay = iosOverlay({
                text: "Loading",
                icon: "fa fa-spinner fa-spin"
            });
            
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/delete-user-tds",
                data: data,
                success: function(response) {
                    if (response.status == 1) {
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });
                        loadUserTDS(usercode);
                    } else {
                    loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        }); 
                    }                
                    window.setTimeout(function() {
                        loading_overlay.hide();
                    }, 2000);
                
                }
            });
        }    
    }

    function showUserCommissions() {
        $('#user-commissions-dialog').dialog({
            autoOpen: true,
            height: $(window).height() - 120,
            width: $(window).width() - 50,
            modal: true,
            resizable: false
        });
        $('#user-commissions-panel').html(loading_small);

        var data = {};

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/user-commission-list",
            data: data,
            success: function (response) {
                $('#user-commissions-panel').html(response);
            }
        });
    }

    function closeUserCommissions() {
        $('#user-commissions-dialog').dialog('destroy');
        $('#user-commissions-dialog').hide();
    }

    function updateUserPaymentTypes() {
        var data = {}
        data.userCode = $('#hid_usr_code').val();
        data.bookingPaymentType = [];
        
        var bookingPaymentType = $('#book_pay_type').val() || [];
        $.each(bookingPaymentType, function (i, val) {
            data.bookingPaymentType.push({ code: val });
        });

        $('#user-paymenttypes-bttons').hide();
        $('#user-paymenttypes-state').removeClass('alert alert-danger alert-success');
        $('#user-paymenttypes-state').html(loading_popup);
        $('#user-paymenttypes-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-user-payment-type",
            data: data,
            success: function(response) {
                $('#user-paymenttypes-bttons').show();
                if (response.status == 1) {
                    $('#user-paymenttypes-state').removeClass('alert-danger').addClass('alert alert-success');
                    $('#user-paymenttypes-state').html('Your request has been completed successfully');
                    $('#user-paymenttypes-state').show();

                    var user = _.find(userlist || [], i => i.code == data.userCode);
                    if (user) {
                        user.bookingPaymentType = data.bookingPaymentType;
                    }
                    
                    window.setTimeout(function() {
                        $('#user-paymenttypes-state').hide();
                    }, 3000);
                } else {
                    $('#user-paymenttypes-state').removeClass('alert-success').addClass('alert alert-danger');
                    $('#user-paymenttypes-state').html(response.errorDesc);
                    $('#user-paymenttypes-state').show();
                }
            }
        });
    }
     
<?php echo '</script'; ?>
>







<?php }
}
