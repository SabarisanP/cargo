<div class="brand_top">
    <h3>Permissions</h3> 
    <!--<span class="align-right hidden" id="tc-back-per">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="backToSelectRole();"> <i class="fa fa-arrow-left"></i> Back</a>
    </span>-->
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">                        


                        <div class="col-md-3"> 
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div>
                                        {if $action_rights['PRVGE-NS']>0}
                                            <button class='btn btn-success btn-block' onclick="menuPermissionDialog('NS')">Namespace</button>
                                        {/if}
                                    </div>
                                    <br>
                                    <div>
                                        {if $action_rights['PRVGE-GRP']>0}
                                            <button class='btn btn-success btn-block' onclick="switchGroup()">Groups</button>
                                        {/if}
                                        <div id="per-table-list-grp" style="display:none">
                                            <div >
                                                 <ul class="user_list " id="user_list_search">
                                                    {foreach name=o item=row from=$groups}
                                                        <li id="{$row->code}">
                                                            <span class="sp_name col-xs-10"><a href="javascript:;" onclick="menuPermissionDialog('GR', '{$row->code}')">{$row->name}</a></span>
                                                        </li> 
                                                    {/foreach}   
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <br>            
                                    <div>
                                        {if $action_rights['PRVGE-USR']>0}
                                            <button class='btn btn-success btn-block' onclick="switchhUser()">Users</button>
                                        {/if}

                                        <div id="per-table-list-usr" style="display:none">
                                            <div style="max-height:300px; overflow-y: auto;">
                                                <ul class="user_list " id="user_list_search">
                                                    
                                                    {foreach name=ol key=grpname item=user from=$users}
                                                        <li>
                                                            <div class="bold">
                                                                {$grpname}
                                                            </div>
                                                        </li>
                                                        {foreach item=row from=$user}
                                                        <li id="{$row->code}" style="padding-left:10px;">
                                                            <span class="sp_name col-xs-10"><a href="javascript:;" onclick="menuPermissionDialog('UR', '{$row->code}')">{$row->name}</a></span>
                                                        </li> 
                                                        {/foreach}  
                                                    {/foreach}  
                                                    
                                                </ul> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                        <div class="col-md-9">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="menupermissions">
                                        <div class="container ">
                                            <div class="row">
                                                <div id="permission" >                                                           
                                                    <div class="heading_b" id='cur-info'>Permissions</div>
                                                    
                                                    <div id="menu-permissions">
                                                        <div class="well text-center">
                                                            Please select an option in left panel to view menu settings.
                                                        </div>    
                                                    </div>      
                                                   
                                                </div>    
                                                <input type="hidden" id="code">
                                                <script>
                                                        var parentmenulist = {$p_parent|json_encode}
                                                        var eventList = {$eventList|json_encode}
                                                        var submenulist = {$p_sub_menu|json_encode}
                                                        var groupsoption = {$groups|json_encode}
                                                        var usersoption = {$users|json_encode}
                                                </script>
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





