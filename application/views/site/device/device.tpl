<div class="brand_top">
    <h3>Auth Devices</h3> 
    <span class="align-rights">
        {if $action_rights['AD-ADD-NEW']>0} 
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="saveDeviceDialog(1);">Add New Device</a>
        {/if}
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
                            <div class="panel panel-default" style="min-height:300px;">

                                <div class="panel-body">

                                    <div id="user-result-panel">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-6">
                                                    <ul class="user_list " id="user_list_search">                                                        
                                                        {if count($devices) > 0}
                                                            {foreach name=o item=row from=$devices} 
                                                                <li id="am-{$row->code}"  >
                                                                    <span class="col-xs-2">{$row->code}</span>
                                                                    <span class="col-xs-1">
                                                                        <div class="btn-group btn-group-xs">
                                                                            <a href="javascript:;" class="btn btn-default btn-sm" title="Generate Otp" onclick="generateDeviceOtp('{$row->code}')"><i class="fa fa-paper-plane" aria-hidden="true"></i></a>
                                                                        </div>
                                                                    </span>
                                                                    <span class="sp_name col-xs-3"><a href="javascript:;" id="pro-viw-{$row->code}" class="pro" onclick="getAuthList('{$row->code}')" title="Click to view details">{$row->name}</a></span>
                                                                    <span class="sp_name1 col-xs-3 hide">{$row->remarks}</span>
                                                                    <span class="sp_token1 col-xs-3 hide">{$row->token}</span>
                                                                    <span class="sp_status col-xs-1">
                                                                        {if $row->activeFlag==1}
                                                                            <span class="label label-success" id="lb-{$row->code}">Active</span>
                                                                        {else}
                                                                            <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
                                                                        {/if}    
                                                                    </span>
                                                                    <span class="sp_last_used col-xs-3">{$row->lastUsedAt|date_format:$ns_datetime_format}</span>
                                                                    <span  class="sp_action col-xs-2" style="padding-right: 0;">
                                                                        <div class="btn-group btn-group-xs">
                                                                            {if $row->latitude != ''}
                                                                                <a title="Map" class="btn btn-default btn-sm" id='dev-map-{$row->code}'  href="https://maps.google.com/?q={$row->latitude},{$row->longitude}" target="_blank"><i class="fa fa-map-marker"></i></a>
                                                                            {/if}
                                                                            {if $action_rights['AD-DISABLE']>0} 
                                                                                <a href="javascript:;" class="btn btn-default btn-sm" onclick="editDeviceStatus('{$row->code}', '{$row->name}')">
                                                                                    {if $row->activeFlag==1}
                                                                                        <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                                    {else}
                                                                                        <i class="fa fa-check" id="sta-{$row->code}" data-status="1" title="Click to enable"></i>
                                                                                    {/if} 
                                                                                </a> 
                                                                            {/if}
                                                                            {if $action_rights['AD-EDIT']>0}
                                                                                <a href="javascript:;" class="btn btn-default btn-sm" {if $row->activeFlag==0} style='display:none'{/if} id='edt_pro_{$row->code}' title="Edit" onclick='saveDeviceDialog({$row|@json_encode}, 3)'><i class="fa fa-pencil igreen"></i></a>
                                                                            {/if}
                                                                            {if $action_rights['AD-DELETE']>0}
                                                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" onclick="deleteDevice('{$row->code}', '{$row->name}')"><i class="fa fa-trash-o ired"></i></a>
                                                                            {/if}
                                                                        </div>
                                                                    </span>
                                                                </li> 
                                                            {/foreach} 
                                                        {else}
                                                            <li class="er_msg"><div class="well well-large "> No devices found!</div></li>
                                                        {/if}   
                                                    </ul>
                                                </div>
                                                <div class="col-md-6" id="usr-viw-rslt">
                                                    {if count($devices) > 0}
                                                        <div class="p_t_100">
                                                            <div class="well well-large "> Click any of the device name to view more details.</div>
                                                        </div>
                                                    {/if} 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                        <div class="warning-text" id="useer-search-status"></div>
                                        <div id="provider-dialog" class="dialog-content-page" style="display: none">
                                            <form class="form-horizontal " action="#">
                                                <div class="form-group">
                                                    <div>
                                                        <label class="req">Name</label>
                                                        <input type="text" id="name" class="form-control" placeholder="Name" maxlength="40">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div>
                                                        <label>Token</label>
                                                        <input type="text" id="token" class="form-control" placeholder="Token" maxlength="40">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div>
                                                        <label>Remarks</label>
                                                        <input type="text" id="service" name ="service" class="form-control" placeholder="Remarks" maxlength="60">                                                                        
                                                    </div>
                                                </div>

                                                <input type="hidden" id="usr_status" name="usr_status" value="1" />
                                                <input type="hidden" id="hid_provider_code" />
                                                <div id="ur-form-loadings" style="display:none"></div>
                                                <div class="align-center alert alert-danger pull-left err_prov" id="usr-action-state"></div>
                                                <div class="align-right prov_btn" id="form-buttons">
                                                    <button type="button" id="btn-save" class="btn btn-success" onclick="saveDevice()">Save</button>
                                                    <button type="button" class="btn btn-default" onclick="cancelDeviceDialog()">Cancel</button>
                                                </div>

                                            </form>
                                        </div>


                                        <!--Partner Dialog -->

                                        <div id="partner-dialog" class="dialog-content-page" style="display: none">
                                            <form class="form-horizontal " action="#">

                                                <div class="form-group">                                
                                                    <div class="" >
                                                        <label class="req">Auth Type</label>
                                                        <select class="form-control" id="part_mode" name ='part_mode' onchange="setAuthType(this.value)" >
                                                            <option value='UR'>User</option>
                                                            <option value='GR'>Group</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group pane_user">                                
                                                    <div class="" >
                                                        <label class="req">User</label>
                                                        <select class="form-control" id="part_user" name ='part_user' >                                                                            
                                                            <option value=''>Select a user</option>
                                                            {foreach name=o item=row from=$groupusers.users}                                                                        
                                                                <option  value="{$row.code}">{$row.name}</option>                                                                      
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="form-group pane_group hide">                                
                                                    <div class="" >
                                                        <label class="req">Group</label>
                                                        <select class="form-control" id="part_group" name ='part_group' >
                                                            <option value=''>Select a group</option>
                                                            {foreach name=o item=row from=$groupusers.groups}                                                                    
                                                                <option  value="{$row->code}">{$row->name}</option>                                                                    
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>

                                                <input type="hidden" id="usr_status" name="usr_status" value="1" />
                                                <input type="hidden" id="hid_device_code" />                                                                

                                                <div id="ur-form-loading" style="display:none"></div>
                                                <div class="align-center alert alert-danger pull-left err_prov" id="usr-action-state1"></div>
                                                <div class="align-right prov_btn" id="form-buttonss">
                                                    <button type="button" id="btn-save" class="btn btn-success" onclick="saveAuth()">Save</button>
                                                    <button type="button" class="btn btn-default" onclick="cancelPartner()">Cancel</button>
                                                </div>

                                            </form>
                                        </div>

                                        <!--Commission dialog end-->   

                            </div><!--panel Body end-->
                        </div><!--panel end-->
                    </div>
                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>
<div id="device-otp-dialog" class="hide dialog-content-page">
    <div class="row">
        <div class="align-center alert alert-danger col-sm-12" style="display:none" id="dev-otp-action-state"></div>
    </div>
    <div id="dev-otp-form" style="display: none;">
        <br/><br/>
        <div class="row">
            <div class="col-md-12 text-center">Device One Time Password</div>
        </div>
        <br>
        <div class="row" style="padding-top: 10px;">
            <div class="col-md-12 text-center">
                <h2 id="dev-otp-code"></h2>
            </div>
        </div>
        <div class="row">
            <div class="text-right col-sm-12">
                <button class="btn btn-default" type="button" onclick="closeDevOtp();">Close</button>
            </div>
        </div>
    </div>
</div>


    <script type="text/template" id="user_list_view">
        <li class="usr_lst">
        <div class="fl">
        <a href="javascript:;" id="" onclick="getAuthList()" title="Click to view user details">
        </a>
        </div>
        </li>
    </script>
    <script>
        var userlist = {$devices|json_encode};
    </script>


                    