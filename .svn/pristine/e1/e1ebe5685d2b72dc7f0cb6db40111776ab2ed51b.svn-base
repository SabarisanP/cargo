<div class="brand_top">
    <h3>Privileges</h3> 

</div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content1" class="col-lg-12">
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group">
                                            <div class="col-md-offset-1 col-md-10">
                                                <div class="col-md-10">
                                                    <div class="pull-left">
                                                        Access Permissions
                                                    </div>
                                                    <div class="pull-right">
                                                        &nbsp;
                                                        {if $action_rights['PRVGE-NS']>0}  
                                                        <a href="javascript:;" class="btn btn-default btn-xs" title="Name Space" onclick='privilegeDialog("NS")'>
                                                            <i class="fa fa-bars" title="Click to disable"></i> &nbsp;Namespace
                                                        </a>&nbsp;
                                                        {/if}    
                                                        {if $action_rights['PRVGE-GRP']>0} 
                                                        <a href="javascript:;" class="btn btn-default btn-xs" title="Group" onclick='privilegeDialog("GR")'>
                                                            <i class="fa fa-users"></i> &nbsp; Group
                                                        </a>&nbsp;
                                                        {/if}  
                                                        {if $action_rights['PRVGE-USR']>0}
                                                        <a href="javascript:;" class="btn btn-default btn-xs" title="User" onclick='privilegeDialog("UR")'>
                                                            <i class="fa fa-user"></i>&nbsp; User
                                                        </a>
                                                        {/if}  
                                                    </div>  
                                                    <br />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="clear_fix_both"></div>
                                        <br>
                                        <div>
                                            <div id="pri_menu" style="display: none"  class="dialog-content-page mnu_border ">
                                                <form role="form" id="form1" class="form-horizontal">
                                                    <input type="hidden" name="role_name" id="role_name" value="" />
                                                    <div id="menu-privilege-drop"></div>          
                                                    <div id="menu-privilege" class="ov_flw_none">
                                                    </div>

                                                    <div class="alert fl" style="display: none;" id="privilege-action-state"></div>

                                                    <div class="align-right top_25" id="privilege-button" >

                                                        <input type="hidden" name="id_mnu_code" id="id_mnu_code" value="" />
                                                        <button type="button" id="btn-save" class="btn btn-success" onclick="savePrivilege()">Save</button>
                                                        <button class="btn btn-default" type="button" onclick="cancelprivilege();">Cancel</button>
                                                    </div>


                                                </form>
                                            </div>
                                            <div class="align-left top_25" id="privilege-loading" style="width:100px"></div>
                                        </div>
                                    </div><!--panel Body end-->
                                </div><!--panel end-->
                            </div>
                        </div><!--row end-->
                    </div><!--content end-->
                </div>
            </div>
        </div>
    </div>
</div>         
<script>
    var parentmenulist = {$p_parent|json_encode}
    var eventList = {$eventList|json_encode}
    var submenulist = {$p_sub_menu|json_encode}
    var groupsoption = {$groups|json_encode}
    var usersoption = {$users|json_encode}
    var parentmenulistGroup = {$grp_parent|json_encode}
    var submenulistGroup = {$grp_sub_menu|json_encode}


</script>