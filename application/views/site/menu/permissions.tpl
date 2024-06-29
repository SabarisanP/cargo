<div class="brand_top">
    <h3>Permissions</h3> 
    <span class="align-right hidden" id="tc-back-per">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="backToSelectRole();"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>
</div>

<div id="main-content">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div class="clear_fix_both"></div>
                <br />
                <div id="contents" class="col-lg-12">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="col-md-12">
                                    <div class="per-list-form-control col-md-offset-2 col-md-7">
                                        <div class="col-xs-offset-4 wid-250" >Select any one role set menu access </div>
                                        <br>
                                        {if $action_rights['PRVGE-NS']>0}
                                        <button class='btn btn-success btn-block col-xs-offset-4 wid-250' onclick="menuPermissionDialog('NS')">Namespace</button>
                                        {/if}
                                        {if $action_rights['PRVGE-GRP']>0}
                                        <button class='btn btn-success btn-block col-xs-offset-4 wid-250' onclick="searchGroup('GR')">Groups</button>
                                        {/if}
                                        {if $action_rights['PRVGE-USR']>0}
                                        <button class='btn btn-success btn-block col-xs-offset-4 wid-250' onclick="searchUser('UR')">Users</button>
                                        {/if}
                                        </div>
                                    <div id="per-table-list-usr" style="display:none">
                                        
                                        <div class="col-md-offset-3 col-md-4 ">
                                            <div class="">Select a user to set menu access</div>
                                            <ul class="user_list " id="user_list_search">
                                                {foreach name=o item=row from=$users}
                                                    <li>
                                                        <span class="sp_name col-xs-10"><a href="javascript:;" onclick="menuPermissionDialog('UR', '{$row->code}')">{$row->name}</a></span>
                                                    </li> 
                                                {/foreach}   
                                        </div>
                                    </div>
                                    <div id="per-table-list-grp" style="display:none">
                                        <div class="col-md-offset-3 col-md-4 ">
                                            <div class="">Select a group to set menu access</div>
                                            <ul class="user_list " id="user_list_search">
                                                {foreach name=o item=row from=$groups}
                                                    <li>
                                                        <span class="sp_name col-xs-10"><a href="javascript:;" onclick="menuPermissionDialog('GR', '{$row->code}')">{$row->name}</a></span>
                                                    </li> 
                                                {/foreach}   
                                        </div>
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="permission-dialog" class="dialog-content-page hide">
        <div class="clear_fix_both"></div>
        <br />
        <form>
            <div id="menu-permissions" class="fl">
            </div>    
            <div class="align-right prov_btn" id="form-buttons">
                <span class="load_success" style="position: relative;right:15px"></span>
                <button type="button" style="position: relative;right:13px" class="btn btn-default" onclick="cancelMenuPermission()">Close</button>
            </div>
        </form> 
        <div class="clear_fix_both"></div>
        <br />
    </div>    
    <input type="hidden" id="code">
    <script>
        var parentmenulist = {$p_parent|json_encode}
        var eventList = {$eventList|json_encode}
        var submenulist = {$p_sub_menu|json_encode}
        var groupsoption = {$groups|json_encode}
        var usersoption = {$users|json_encode}
    </script>
