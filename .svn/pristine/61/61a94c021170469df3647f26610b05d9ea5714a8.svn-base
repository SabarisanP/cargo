<link rel="stylesheet" href="assets/lib/bootstrap-star-rating/css/star-rating.min.css?{$asset_ver}" media="screen">
<div class="brand_top"><h3>Group/Role</h3> 
    <span class="align-right">
        {if $action_rights['GRP-ADD']>0}
            <a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['GRP-ADD']!=2}onclick="editGroup();"{/if}>Add New Group/Roles</a>
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
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group" id="accordion">
                                            {if count($entity) > 0}
                                                {foreach name=o item=row from=$entity}

                                                    <div class="panel panel-info" id="grp-{$row['code']}">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title"> 
                                                                <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row['code']}">
                                                                    {$row['name']} - (<span id="usr_cnt_{$row["code"]}">{$row["userCount"]}</span>)
                                                                </a>
                                                                
                                                                <div style="left: 300px; position: absolute; top: 10px; color:#fff">
                                                                    {for $foo=1 to $row["level"]}
                                                                        <i class="fa fa-star"></i> 
                                                                    {/for}                                                                                                                                      
                                                                </div>
                                                                   
                                                                <div class="btn-group btn-group-xs ac_bu">
                                                                    
                                                                    {if $action_rights['GRP-DISABLE']>0}
                                                                        <a href="javascript:;" class="btn btn-default btn-sm est"  {if $action_rights['GRP-DISABLE']!=2}onclick="editStatusGroup('{$row['code']}', '{$row['name']}', this)"{/if} data-status="{$row['activeFlag']}">
                                                                            {if $row['activeFlag']==1} 
                                                                                <i class="fa fa-times" title="Click to disable group" data-toggle="tooltip"></i>
                                                                            {else}
                                                                                <i class="fa fa-check" title="Click to enable group" data-toggle="tooltip"></i>
                                                                            {/if}
                                                                        </a>
                                                                    {/if}
                                                                    {if $action_rights['GRP-EDIT']>0}<a href="javascript:;" title="Edit Group" id='gp_edt_{$row['code']}'  {if $row['activeFlag']==0}style='display:none'{/if} data-toggle="tooltip" class="btn btn-default btn-sm edat" {if $action_rights['GRP-EDIT']!=2}onclick='editGroup({$row|@json_encode})'{/if}><i class="fa fa fa-pencil igreen"></i></a>{/if}
                                                                    {if $action_rights['GRP-DELETE']>0}  <a href="javascript:;" title="Delete Group" data-toggle="tooltip" class="btn btn-default btn-sm del" {if $action_rights['GRP-DELETE']!=2}onclick="deleteGroup('{$row['code']}', '{$row['name']}')"{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
                                                                    
                                                                </div>
                                                            </h3>
                                                        </div>  
                                                        <div id="collapse-{$row['code']}" class="panel-collapse collapse">
                                                                <div class="panel-body"> 
                                                                    {assign var="usr_det" value=""}
                                                                    <!-- <div class="col-md-6  p_l_n b_r"> -->
                                                                    <div class="row">
                                                                        <!-- <div class="col-lg-2"> Users </div> -->
                                                                        <div class="col-sm-10 col-xs-10">                                                                           
                                                                            <input type="text" class="form-control" placeholder="Find User..." id="list_search_{$row["code"]}" >                                                                            
                                                                        </div>
                                                                        <div class="col-sm-2 col-xs-2">    
                                                                        {if $action_rights['GRP-ADD-USER']>0}
                                                                            <a href="javascript:;" title="Add user"  data-toggle="tooltip" class="btn btn-default btn-xs pull-right" {if $action_rights['GRP-ADD-USER']!=2}onclick="allUserGroup('{$row["code"]}')"{/if}>
                                                                                <i class="fa fa-plus"></i>
                                                                            </a>
                                                                        {/if}
                                                                        </div>
                                                                    </div>
                                                                    <div class="clear_fix_both"></div> <br>
                                                                    {if count($row["userlist"]) > 0}
                                                                        <ul class="user_list rmv-tp-br" id="grp_usr_{$row["code"]}">                                                                           
                                                                            <div class="user_list_action bt_16">
                                                                                <ul class="user_list " id="user_list_search">
                                                                                    <div id="scroll_{$row["code"]}" class="grp">
                                                                                        {foreach name=o item=usr from=$row["userlist"]}
                                                                                            <li class="p_l_n p_r_n" id="usr_{$usr->code}">
                                                                                                <div class="pull-left lt_2">{$usr->name}</div>
                                                                                                <div class="pull-right">{if $action_rights['GRP-CHANGE-MAP']>0}<a title="Change group"  href="javascript:;" data-toggle="tooltip" class="btn btn-default btn-xs" {if $action_rights['GRP-CHANGE-MAP']!=2}onclick="groupDialogUser('{$usr->code}', '{$row["code"]}', 'grp')"{/if}><i class="fa fa-refresh"></i>{/if}</a></div>
                                                                                            </li>
                                                                                            {$usr_det="`$usr_det`,`$usr->code`"}
                                                                                        {/foreach}
                                                                                    </div>
                                                                                </ul>

                                                                                <input type="hidden" id="alr_grp_usr_{$row["code"]}" value="{$usr_det}" />
                                                                            </div>
                                                                        </ul>
                                                                    {else}
                                                                        No user in the group
                                                                    {/if}

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <script type="text/javascript">
                                                             $(document).ready(function($) {
                                                                $('input#list_search_{$row["code"]}').quicksearch('#user_list_search #scroll_{$row["code"]}   > li');
                                                                $("#scroll_{$row["code"]}").css('max-height', '220px').perfectScrollbar({
                                                                    wheelSpeed: 20,
                                                                    wheelPropagation: false
                                                                });
                                                            });
                                                        </script>
                                                        {/foreach} 
                                                            {else}
                                                                <div class="well well-large ">No group found!</div>
                                                                {/if}
                                                                </div>
                                                            </div>
                                                            <div class="clear_fix_both"></div>

                                                            <div id="pg-group-dialog" class="hide dialog-content-page">
                                                                <form role="form" id="form1" class="form-horizontal ">
                                                                    <div class="form-group">
                                                                        <div>
                                                                            <label for="txt_g_name" class="req">Group name</label>
                                                                            <input  placeholder="Group name" id="txt_g_name" name="txt_g_name"  class="form-control">
                                                                        </div>
                                                                    </div> 
                                                                    
                                                                    <div class="form-group">
                                                                        <div>
                                                                            <label for="txt_level" class="req">Group Level</label>
                                                                            <input id="txt_level" name="txt_level" class="form-control">
                                                                        </div>
                                                                    </div>
                                                                    
                                                                    <!--<div class="form-group">
                                                                        <label for="txt_g_decription">Description</label>
                                                                        <div>
                                                                            <textarea  placeholder="Description" id="txt_g_decription" name="txt_g_decription"  class="form-control rs_no"></textarea>
                                                                        </div>
                                                                    </div> -->
                                                                </form>

                                                                <div class="clear_fix_both"></div>
                                                                <div class="clear_fix_both">                       
                                                                    <div class="alert fl" style="display: none;" id="form-loading"></div>
                                                                    <div class="alert fl" style="display: none;" id="grp-form-action-state"></div>
                                                                    <div class="align-right" id="form-bttons">
                                                                        <input type="hidden" name="aid_g_code" id="aid_g_code" value="" />
                                                                        <input type="hidden" name="sel_g_status" id="sel_g_status" value="1" />
                                                                        <input type='hidden' id='grp_disable' value={$action_rights['GRP-DISABLE']}>
                                                                        <input type='hidden' id='grp_edit' value={$action_rights['GRP-EDIT']}>
                                                                        <input type='hidden' id='grp_del' value={$action_rights['GRP-DELETE']}>
                                                                        <input type='hidden' id='grp_add_usr' value={$action_rights['GRP-ADD-USER']}>
                                                                        <input type='hidden' id='grp_change_map' value={$action_rights['GRP-CHANGE-MAP']}>
                                                                        <button class="btn btn-success" type="button" onclick="saveGroup();">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelGroup();">Cancel</button>
                                                                    </div>
                                                                </div> 
                                                            </div>

                                                            <!-- All user Dialog-->
                                                            <div id="all_usr_grp" class="hide dialog-content-page">
                                                                <form role="form" id="form_org" class="form-horizontal ">
                                                                    <label>Please select user</label>
                                                                    <div class="ov_fl_230">
                                                                        <ul class="user_list">
                                                                            {foreach item=usr from=$users}
                                                                                <li>
                                                                                    <div style="padding-left: 10px;"> 
                                                                                        <div class="radio">
                                                                                            <input type="checkbox" id="usr_grp_{$usr->code}" value="{$usr->code}" class="grp_usr_all" data-name="{$usr->name}"  name="usr_grp_all">
                                                                                            <lable for="usr_org_{$usr->code}">{$usr->name}</lable>
                                                                                        </div>
                                                                                    </div> 
                                                                                </li>
                                                                            {/foreach}   
                                                                        </ul>
                                                                    </div>

                                                                    <div class="clear_fix_both">      <br/>         
                                                                        <div class="fl" id="all-grp-form-loading"></div>
                                                                        <div class="alert fl" style="display: none;" id="all-grp-state"></div>
                                                                        <div class="align-right" id="all-grp-form-bttons">
                                                                            <input type="hidden" name="id_grp_code" id="id_grp_code" value="" />
                                                                            <button class="btn btn-success" type="button" onclick="saveallUserGroup();">Save</button>
                                                                            <button class="btn btn-default" type="button" onclick="cancelUserGroup();">Cancel</button>
                                                                        </div>
                                                                    </div> 
                                                                </form>
                                                            </div>
                                                            <!-- All user Dialog end-->
                                                        </div><!--panel Body end-->
                                                    </div><!--panel end-->

                                                </div>

                                            </div><!--row end-->
                                        </div><!--content end-->
                                    </div>
                                </div>
                            </div>

                        </div>

                        {include file='site/template/group-dialog.tpl'}
