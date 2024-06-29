<div class="brand_top">
    <h3>Users</h3> 
    <span class="align-right">
        <button class="btn btn-default" onclick="exportUserExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        {if $action_rights['USR-ADD']>0}  <a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['USR-ADD']!=2}onclick="saveDialogUser();"{/if}>Add New User</a>
        {/if} </span>
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

                                                        {if count($users) > 0}
                                                            <div class="well well-sm">
                                                                <input type="text" class="form-control" placeholder="Find User..." id="list_search" >
                                                            </div>  
                                                            <div class="user_list_action bt_27">
                                                                <ul class="user_list " id="user_list_search">
                                                                    <div id="usr_scroll">
                                                                        {foreach name=ow key=ugrpname item=ugroup from=$users} 
                                                                            <li class="rt_8">
                                                                                <div class="bold">
                                                                                    {$ugrpname}
                                                                                </div>
                                                                            </li>
                                                                            {foreach name=o item=row from=$ugroup} 
                                                                            <li id="usr-{$row->code}">
                                                                                <div class="" style="padding-left:10px;">
                                                                                    <a href="javascript:;" id="usr-viw-{$row->code}" onclick="userView('{$row->code}')" data-toggle="tooltip"  title="Click to view user details">
                                                                                        {$row->name}
                                                                                    </a>
                                                                                </div>
                                                                            </li>
                                                                            {/foreach}
                                                                            
                                                                        {/foreach}
                                                                    </div>
                                                                </ul>
                                                            </div>
                                                        {else}
                                                            <li class="er_msg"><div class="well well-large "> No user found!</div></li>
                                                            {/if}   
                                                    </ul>

                                                </div>
                                                    
                                                <form id='trans_form' name="trans_form" method="post"  onsubmit="return false">
                                                </form>
                                                <iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe> 
                                                <div class="col-md-9" id="usr-viw-rslt">
                                                    {if count($users) > 0}
                                                        <div class="p_t_100">
                                                            <div class="well well-large "> Click any of the user name to view more details.</div>
                                                        </div>
                                                    {/if} 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                  
                                <div class="warning-text" id="useer-search-status"></div>
                                <div id="user-dialog" class="dialog-content-page" style="display: none">
                                    
                                    <form class="form-horizontal " action="#">
                                         <div class="ov_fl_290--">
                                        <div class="col-lg-6 p_l_n">
                                            <div>
                                                <label class="req">Name</label>

                                                <input type="text" id="txt_name" class="form-control" placeholder="Name">
                                            </div>
                                        </div>
                                        <div class="col-lg-6 p_l_n">
                                            <div>
                                                <label class="req">Father name</label>

                                                <input type="text" id="txt_lname" class="form-control" placeholder="Father name">
                                            </div>
                                        </div>
                                
                                <div class="clear_fix_both"></div>
                                <br />    

                                <div class="col-lg-6 p_l_n">
                                    <div><label class="req">Email</label>

                                        <input type="text" id="txt_email" class="form-control" placeholder="Email">
                                    </div>
                                </div>
                                <div class="col-lg-6 p_l_n">
                                    <div><label class="req">Mobile</label>

                                        <input type="text" id="txt_mobile" class="form-control" placeholder="Mobile">
                                    </div>
                                </div>
                                <div class="clear_fix_both"></div>
                                <br />    
                                
                                 <div class="col-lg-6 p_l_n edt_hide">
                                    <div>
                                        <label class="req">User name</label>
                                        <input type="text" onblur="checkUsernameAvailablity(this);" id="txt_usr_name" class="form-control" placeholder="User name">
                                    </div>
                                    <div id="user_availablity_state" style="margin-top:5px;">
                                         
                                    </div> 
                                </div>
                                <div class="col-lg-6 p_l_n edt_hide">
                                    <div>
                                        <label class="req">Group</label>

                                        <select class="form-control" id="grp_list" >
                                            <option value="">Select a Group</option>   
                                            {foreach item=grp from=$groups}
                                                <option value="{$grp->code}">{$grp->name}</option>
                                            {/foreach}    
                                        </select>
                                    </div>
                                </div>
                                          <div class="clear_fix_both"></div>
                                <br />    
                                <div class="col-lg-6 p_l_n edt_hide">
                                    <div>
                                        <label class="req">Organization</label>

                                        <select class="form-control" id="org_list" >
                                            <option value="">Select a Organization</option>   
                                            {foreach item=org from=$organization}
                                                <option value="{$org->code}">{$org->name}</option>
                                            {/foreach}    
                                        </select>
                                    </div>
                                </div>

                                <div class="col-lg-6 p_l_n">
                                    <div>
                                        <label class="req">Payment Type</label>

                                        <select class="form-control" id="pay_mode" >
                                            <option value="">Select Type</option>   
                                            {foreach item=ut key=k item=utname from=$users_pay_type}
                                                <option value="{$k}">{$utname}</option>
                                            {/foreach}                                             
                                        </select>
                                    </div>
                                </div> 
                                <div class="clear_fix_both"></div>
                                <br />    
                                <div class="col-lg-6 p_l_n">
                                    <div>
                                        <label>Tags</label>
                                        <select class="form-control" id="usr_tags" multiple>
                                            {foreach key=code item=name from=$user_tags}
                                                <option value="{$code}">{$name}</option>
                                            {/foreach}
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
                            <!--Password dialog-->                 
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
                            <!--Password dialog end-->   


                            <!--Commission dialog-->                 
                            <div id="edit-user-cms" class="dialog-content-page" style="display: none">
                                <form class="form-horizontal " action="#">
                                    <div class="form-group">                                        
                                        <label class="req">Credit Limit</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                                            <input type="text" id="txt_cl" class="form-control" placeholder="Credit Limit" size="10">                                            
                                        </div>                                       
                                        <p class="note text-muted"><i class="fa fa-info-circle"> </i> &nbsp; Use -1 for Unlimited Payment type.</p>
                                    </div>
                                    <!--<div class="form-group">
                                        <label class="req">Active From:</label>
                                        <div class="input-group">
                                            <input class="form-control" type="text" placeholder="Active From" id="dpStart" data-date-format="dd-mm-yyyy" data-date-autoclose="true">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="req">Active To:</label>
                                        <div class="input-group">
                                            <input class="form-control" type="text" placeholder="Active To" id="dpEnd" data-date-format="dd-mm-yyyy" data-date-autoclose="true">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div> -->
                                    <div class="row">
                                        <div class="col-md-5">         
                                            <div class="form-group">                                     
                                                <label class="req">Commission</label>
                                                <input type="text" id="txt_vlu" class="form-control" placeholder="Value">                                                 
                                                
                                            </div>  
                                        </div>  

                                        <div class="col-md-4">      
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="form-control col-md-12" id="usr_comm_type">
                                                    <option value="PER" selected>Percentage</option> 
                                                    <option value="FLT">Rupees per seat</option> 
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-5">         
                                            <div class="form-group">                                     
                                                <label class="req">GST on Commission</label>
                                                <input type="text" id="txt_bogst" class="form-control" placeholder="Value">
                                            </div>  
                                        </div>  

                                        <div class="col-md-4">      
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="form-control col-md-12">
                                                    <option value="PER" selected>Percentage</option> 
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clear_fix_both"></div><br/>
                                    <input type='hidden' id='comm_edit' value={$action_rights['USR-EDIT-CMISN']}>
                                    <input type='hidden' id='comm_dis' value={$action_rights['USR-DISABLE-CMISN']}>
                                    <input type='hidden' id='comm_del' value={$action_rights['USR-DELETE-CMISN']}>

                                    <input type="hidden" id="hid_urs_cms_code"  value="" />
                                    <input type="hidden" id="hid_cms_code" value="" />
                                    <input type="hidden" id="hid_cms_status" value="1" />
                                    <div id="ur-cms-loading" style="display:none"></div>
                                    <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-cms-state"></div>
                                    <div class="align-right" id="form-cms-bttons">
                                        <button type="button" id="btn-save" class="btn btn-success" onclick="saveCommission()">Update</button>
                                        <button type="button" class="btn btn-default" onclick="cancelCommissionDialog()">Cancel</button>
                                    </div>

                                </form>
                            </div>
                            <!--Commission dialog end--> 
                            
                            <!--stationpoint dialog-->                 
                            <div id="edit-user-stationpoint" class="dialog-content-page" style="display: none">
                                <form class="form-horizontal" action="#">
                                    
                                    <div class="form-group">
                                        <h5>Choose boading points to be allow</h5>
                                    </div>
                                    
                                    <div class="form-group">                                        
                                        <label class="req">Station</label>
                                        
                                        <select id="user_stations" class="form-control" onchange="loadUserStationPointsByStation(this.value)">
                                            <option value="">Select a station</option>
                                            {foreach from=$stations item=station}
                                                <option value="{$station->code}">{$station->name}</option>
                                            {/foreach}
                                        </select>    
                                                                            
                                    </div>
                                    
                                    <div class="form-group">                                        
                                        <label class="req">Station Point</label>
                                        
                                        <select id="user_stations_point" class="form-control" >
                                            <option value="">Select a station point</option>                                            
                                        </select> 
                                        
                                    </div>    
                                    <hr/>
                                    
                                    <div class="form-group">                                        
                                        <label>Boarding Charges</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                                            <input type="text" id="brdg_comm" class="form-control numeric" placeholder="0"  maxlength="4" autocomplete="off">
                                        </div>                                       
                                    </div>
                                    
                                    <div class="form-group">
                                        <label  for="user_group">User Group</label>
                                        <div class="input-group col-md-12">
                                            <select id="user_group" name="group_code"  class="form-control" multiple="multiple">
                                                {foreach name=o item=row from=$groupusers.groups}                                                                    
                                                    <option  value="{$row->code}">{$row->name}</option>                                                                    
                                                {/foreach}
                                            </select> 
                                        </div>
                                    </div>
                                    
                                    <div class="clear_fix_both"></div><br/>
                                    
                                    <input type="hidden" id="hid_urs_sp_code"  value="" />
                                    <input type="hidden" id="hid_sp_code" value="" />
                                    
                                    <div id="ur-sp-loading" style="display:none"></div>
                                    <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-sp-state"></div>
                                    <div class="align-right" id="form-sp-bttons">
                                        <button type="button" id="btn-save" class="btn btn-success" onclick="saveUserStationpoint()">Update</button>
                                        <button type="button" class="btn btn-default" onclick="cancelUserStationpointDialog()">Cancel</button>
                                    </div>

                                </form>
                            </div>
                            <!--stationpoint dialog end-->
                            
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
                            
                            
                            <!--Cancel share dialog-->                 
                            <div id="edit-user-ctr" class="dialog-content-page" style="display: none">
                                <form class="form-horizontal " action="#">
                                    <div class="form-group hidden">
                                        <div>
                                            <label class="req">Credit Limit</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                                                <input type="text" id="txt_ctr" class="form-control" value="0" placeholder="Credit Limit">
                                            </div>
                                        </div>
                                    </div>
                                    <!--<div class="form-group">
                                        <label class="req">Active From:</label>
                                        <div class="input-group">
                                            <input class="form-control" type="text" placeholder="Active From" id="dpStart" data-date-format="dd-mm-yyyy" data-date-autoclose="true">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="req">Active To:</label>
                                        <div class="input-group">
                                            <input class="form-control" type="text" placeholder="Active To" id="dpEnd" data-date-format="dd-mm-yyyy" data-date-autoclose="true">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div> -->
                                    <div class="form-group">
                                        <div class="col-md-8">
                                            <label class="req">Agent share from cancel charges</label>
                                            <div class="input-group col-md-12">
                                                <input type="text" id="txt_ctr_vlu" class="form-control" placeholder="Value"> 
                                            </div>
                                        </div>
                                        <div class="col-md-4 p_l_n">      
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="form-control col-md-12" id="txt_ctr_comm_type">
                                                    <option value="PER" selected>Percentage</option> 
                                                    <option value="FLT">Rupees per seat</option> 
                                                </select>
                                            </div>
                                        </div>  
                                    </div> 
                                    
                                    <div class="">
                                        <div class="col-md-8">         
                                            <div class="form-group">                                     
                                                <label class="req">GST on Share Amount</label>
                                                <input type="text" id="txt_agsgst" class="form-control" placeholder="Value">
                                            </div>  
                                        </div>  

                                        <div class="col-md-4">      
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="form-control col-md-12">
                                                    <option value="PER" selected>Percentage</option> 
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clear_fix_both"></div><br/>
                                    <input type='hidden' id='ctr_edit' value={$action_rights['USR-EDIT-CMISN']}>
                                    <input type='hidden' id='ctr_dis' value={$action_rights['USR-DISABLE-CMISN']}>
                                    <input type='hidden' id='ctr_del' value={$action_rights['USR-DELETE-CMISN']}>

                                    <input type="hidden" id="hid_urs_ctr_code"  value="" />
                                    <input type="hidden" id="hid_ctr_code" value="" />
                                    <input type="hidden" id="hid_ctr_status" value="1" />
                                    <div id="ur-ctr-loading" style="display:none"></div>
                                    <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-ctr-state"></div>
                                    <div class="align-right" id="form-ctr-bttons">
                                        <button type="button" id="btn-save" class="btn btn-success" onclick="saveCancellation()">Update</button>
                                        <button type="button" class="btn btn-default" onclick="cancelCancellationDialog()">Cancel</button>
                                    </div>

                                </form>
                            </div>
                            <!--Cancel share dialog end-->
                            
                            <!--Cancellation commission dialog-->                 
                            <div id="edit-user-cancom" class="dialog-content-page" style="display: none">
                                <form class="form-horizontal " action="#">
                                    <div class="form-group hidden">
                                        <div>
                                            <label class="req">Credit Limit</label>
                                            <div class="input-group">
                                                <span class="input-group-addon"><i class="fa fa-rupee"></i></span>
                                                <input type="text" id="txt_cancom" class="form-control" value="0" placeholder="Credit Limit">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-md-8">
                                            <label class="req">Commission for cancelled tickets</label>
                                            <div class="input-group col-md-12">
                                                <input type="text" id="txt_cancom_vlu" class="form-control" placeholder="Value"> 
                                            </div>
                                        </div>
                                        <div class="col-md-4 p_l_n">      
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="form-control col-md-12" id="txt_cancom_comm_type">
                                                    <option value="PER" selected>Percentage</option> 
                                                    <option value="FLT">Rupees per seat</option> 
                                                </select>
                                            </div>
                                        </div>  
                                    </div> 
                                    
                                    <div class="">
                                        <div class="col-md-8">         
                                            <div class="form-group">                                     
                                                <label class="req">GST on Commission</label>
                                                <input type="text" id="txt_acancom_gst" class="form-control" placeholder="Value">
                                            </div>  
                                        </div>  

                                        <div class="col-md-4">      
                                            <div class="form-group">
                                                <label>&nbsp;</label>
                                                <select class="form-control col-md-12">
                                                    <option value="PER" selected>Percentage</option> 
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clear_fix_both"></div><br/>
                                    <input type='hidden' id='cancom_edit' value={$action_rights['USR-EDIT-CMISN']}>
                                    <input type='hidden' id='cancom_dis' value={$action_rights['USR-DISABLE-CMISN']}>
                                    <input type='hidden' id='cancom_del' value={$action_rights['USR-DELETE-CMISN']}>

                                    <input type="hidden" id="hid_urs_cancom_code"  value="" />
                                    <input type="hidden" id="hid_cancom_code" value="" />
                                    <input type="hidden" id="hid_cancom_status" value="1" />
                                    <div id="ur-cancom-loading" style="display:none"></div>
                                    <div class="align-center alert alert-danger pull-left" style="display: none;" id="usr-cancom-state"></div>
                                    <div class="align-right" id="form-cancom-bttons">
                                        <button type="button" id="btn-save" class="btn btn-success" onclick="saveCancellationCommission()">Update</button>
                                        <button type="button" class="btn btn-default" onclick="cancelCancellationCommissionDialog()">Cancel</button>
                                    </div>

                                </form>
                            </div>
                            <!--Cancellation commission dialog end-->
                            
                        </div><!--panel Body end-->
                    </div><!--panel end-->
                </div>
            </div><!--row end-->
        </div><!--content end-->
    </div>
</div>
</div>

</div>

{include file='site/template/organization-dialog.tpl'}
{include file='site/template/group-dialog.tpl'}

<script type="text/template" id="user_list_view">
    <li class="usr_lst">
    <div class="fl rt_8">
    <a href="javascript:;" id="" onclick="userView()" title="Click to view user details">

    </a>
    </div>
    </li>
</script>

<script type="text/template" id="user_detail_view">

    <div class="">
    <div class="btn-group pull-right">
    {if $action_rights['USR-DISABLE']>0} <a class="btn btn-default edt_stu" href="javascript:;" {if $action_rights['USR-DISABLE']!=2}onclick='editUserStatus()'{/if}>
        <i class="fa fa-times" data-status="0" title="Click to disable" data-toggle="tooltip"></i>
        </a>{/if}
        {if $action_rights['USR-EDIT']>0}<a href="javascript:;" class="btn btn-default edt" title="Edit details" data-toggle="tooltip" {if $action_rights['USR-EDIT']!=2}onclick="saveDialogUser()"{/if}>
            <i class="fa fa-pencil igreen"></i>
            </a>{/if}
            {if $action_rights['USR-MAP-ORG']>0}<a href="javascript:;" title="Edit organization" data-toggle="tooltip" class="btn btn-default org" {if $action_rights['USR-MAP-ORG']!=2}onclick='organtaionDialogUser({$row|@json_encode})'{/if}>
                <i class="fa fa-home"></i>
                </a>{/if}
                {if $action_rights['USR-MAP-GRP']>0}<a title="Edit user group" data-toggle="tooltip" class="btn btn-default grp" href="javascript:;"  {if $action_rights['USR-MAP-GRP']!=2}onclick='groupDialogUser()'{/if}>
                    <i class="fa fa-users"></i>
                    </a>{/if}
                    <!-- <a class="btn btn-default" href="javascript:;" onclick='editMenu()'>
                    <i class="fa fa-bars" data-status="0" title="Edit menu"></i>
                    </a>-->
                    {if $action_rights['USR-REST-PWD']>0}<a title="Reset password" data-toggle="tooltip" class="btn btn-default rspa" href="javascript:;" {if $action_rights['USR-REST-PWD']!=2}onclick='deleteNamespaceMapping()'{/if}>
                        <i class="fa fa-lock"></i>
                        </a>{/if}
                        {if $action_rights['USR-ADD-CMISN']>0} <a title="Add booking commission" data-toggle="tooltip" class="btn btn-default urcms" href="javascript:;"  {if $action_rights['USR-ADD-CMISN']!=2} onclick='commissionDialog()'{/if}>
                            <i class="fa fa-inr"></i>
                            </a>{/if}
                     <a title="Add cancellation commission" data-toggle="tooltip" class="btn btn-default urctr" href="javascript:;" onclick='cancellationDialog()'>
                            <i class="fa fa-tasks"></i>
                            </a>
                            <!--a title="Add cargo commission" data-toggle="tooltip" class="btn btn-default urcargo" href="javascript:;" onclick='cargoDialog()'>
                                <i class="fa fa-truck"></i>
                            </a-->        
                            
                            <a title="Add boading visblity" data-toggle="tooltip" class="btn btn-default usersp" href="javascript:;" onclick='addStationPointDialog()'>
                                <i class="fa fa-level-up"></i>
                            </a>
                            
                            {if $action_rights['USR-DELETE']>0} <a title="Delete" data-toggle="tooltip" class="btn btn-default del" href="javascript:;" {if $action_rights['USR-DELETE']!=2}onclick='deleteUser()'{/if}>
                                <i class="fa fa-trash-o"></i>
                                </a>{/if}
                                
                            <a title="Switch User" data-toggle="tooltip" class="btn btn-default switchuser hide" href="javascript:;" onclick='switchToUser()'>
                                <i class="fa fa-toggle-on"></i>
                            </a>
                            
                                </div>
                                <div class="btn-group pull-left"><h4>Personal Details</h4></div>         
                                </div>

                                
                                <div class="clear_fix_both"></div>

                                <br />

                                <div class="box_content">
                                <div class="row border-bottom" >
                                <label class="col-md-3">Name:</label>
                                <div class="col-md-3 viw_name"></div>
                                <label class="col-md-3">User Code:</label>
                                <div class="col-md-3 usr_code"></div>
                                </div>
                                <div class="row border-bottom">
                                <label class="col-md-3">User Name:</label>
                                <div class="col-md-3 usr_name"></div>
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
                                <div class="row">
                                <label class="col-md-3">Tags:</label>
                                <div class="col-md-9 tags p_l_15"></div>
                                </div> 
                                </div>
                                <br />    

                            </script>
                            <script  type="text/template" id="user_commission_view">
                                <div>

                                <div class="btn-group pull-left"> <h4>Booking Commissions</h4> </div>       
                                <div class="clear_fix_both"></div>
                                <div class="table-responsive">
                                <table id="usr_com_table" class="table table-striped">
                                <thead>
                                <tr>
                                
                                <th>Credit Limit</th>
                                <th>Created</th>
                                <th>Commission</th>
                                <th>GST on Commission</th>
                                <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody class="com body_table">
                                </tbody>
                                </table>
                                </div>
                                </div>
                        
                        
                        
                        
                        
                         <div>
                        <div class="btn-group pull-left"> <h4>Cancel Charges Share</h4> </div>       
                                <div class="clear_fix_both"></div>
                                <div class="table-responsive">
                                <table id="usr_ctr_table" class="table table-striped">
                                <thead>
                                <tr>
                                                               
                                <th>Created</th>
                                <th>Agent Share</th>
                                <th>GST on Agent Share</th>
                                <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody class="ctr body_table">
                                </tbody>
                                </table>
                                </div>
                        </div>
                        
                        <div class="row" > 
                            <div class="col-sm-6"> 
                                <h4>Cancellation Commission</h4>
                            </div>
                            <div class="col-sm-6 text-left" style="padding-top:10px;">
                                {if $action_rights['USR-ADD-CMISN']>0}
                                <button class="btn btn-default btn-xs addcancom" onclick="addCancomDialog();"><i class="fa fa-plus"></i>Add</button>
                                {/if}
                            </div>
                        </div>       
                        <div class="clear_fix_both"></div>
                        <div class="table-responsive">
                            <table id="usr_cancam_table" class="table table-striped">
                                <thead>
                                    <tr>                                        
                                        <th>Created</th>
                                        <th>Commission</th>
                                        <th>GST on Commission</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="cancom body_table">
                                </tbody>
                            </table>                            
                        </div>
                        
                        <div class="row" > 
                            <div class="col-sm-6"> 
                                <h4>TDS Deduction Details</h4>
                            </div>
                            <div class="col-sm-6 text-left" style="padding-top:10px;">
                                {if $action_rights['USR-ADD-CMISN']>0}
                                <button class="btn btn-default btn-xs addtds" onclick="addTdsDialog();"><i class="fa fa-plus"></i>Add</button>
                                {/if}
                            </div>
                        </div>       
                        <div class="clear_fix_both"></div>
                        <div class="table-responsive">
                            <table id="usr_tds_table" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Effective From</th>
                                        <th>TDS</th>
                                        <th>PAN Number</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="tds body_table">

                                </tbody>
                            </table>                            
                        </div>
                        
                        <div class="btn-group pull-left"> <h4>Boarding Points Assinged</h4> </div>       
                            <div class="clear_fix_both"></div>
                            <div class="table-responsive">
                                <table id="usr_staionpoint_table" class="table table-striped">
                                <thead>
                                <tr>                                                                 
                                    <th>Station</th>
                                    <th>Boarding Point</th>
                                    <th>Boarding Charges</th>
                                    <th>User Group</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody class="staionpoints body_table">
                                </tbody>
                                </table>
                            </div>
                        </div>
                        
                            </script>
                            <br><br>
                             <script  type="text/template" id="user_cancellation_view">
                                <div>

                                <div class="btn-group pull-left"> <h4>Cancellation Commissions</h4> </div>       
                                <div class="clear_fix_both"></div>
                                <div class="table-responsive">
                                <table id="usr_ctr_table" class="table table-striped">
                                <thead>
                                <tr>
                                <th>Id</th>                                
                                <th>Created</th>
                                <th>Value</th>
                                <th>Actions</th>
                                </tr>
                                </thead>
                                <tbody class="ctr body_table">b
                                </tbody>
                                </table>
                                </div>
                                </div>
                            </script>
                            
                            <script>
                                var userlist = {$users_raw|json_encode};
                                var allusertags = {$user_tags|json_encode};
                                $(document).ready(function() {
                                $('#dpStart').datepicker({
                                todayHighlight: true,
                                startDate: '-0m',
                                format: 'yyyy-mm-dd'
                                }).on('changeDate', function(e) {
                                var fDate = new Date(e.date);
                                var end = new Date(fDate.setDate(fDate.getDate() + 365));
                                $('#dpEnd').datepicker('setStartDate', e.date);
                                $("#dpEnd").datepicker("setEndDate", end)
                                });
                                $('#dpEnd').datepicker({
                                todayHighlight: true,
                                startDate: '-0m',
                                format: 'yyyy-mm-dd',
                                maxDate: "+365D",
                                }).on('changeDate', function(e) {
                                $('#dpStart').datepicker('setEndDate', e.date)
                                });
                                // Slim Scroll
                                $("#usr_scroll").css({
                                'max-height': '350px',
                                }).perfectScrollbar({
                                wheelSpeed: 20,
                                wheelPropagation: false
                                });
                                $('#list_search').focus();


                                });
                                $('#user_group').multiselect({
                                    maxHeight: 200,
                                    numberDisplayed: 1,
                                    buttonWidth: '200px',
                                    dropLeft: true,
                                    buttonClass: 'btn btn-default user_group'
                                });
                                $('#usr_tags').select2();
                            </script>







