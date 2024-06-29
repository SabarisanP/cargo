<div class="brand_top">
    <h3>Menu</h3> 
    <span class="align-right">
        {if $action_rights['MNU-ADD']>0}  
            <a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['MNU-ADD']!=2}onclick="menuDialog()"{/if}>Add New Menu</a>
        {/if}
    </span>
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
                                    <div class="col-md-offset-3 col-md-6" id="menu-list-pannel">
                                        <div class="panel-group">

                                            <div class="col-md-offset-1 col-md-10">
                                                {if count($f_menus) > 0}
                                                    <div class="cf nestable-lists">
                                                        <div class="dd" id="nestable2">
                                                            {function name=menu level=0}          {* short-hand *}
                                                                    <ol class="dd-list">
                                                                        {foreach $data as $entry}
                                                                            <li class="dd-item dd3-item" id="mnu_{$entry['code']}" data-id="{$entry['code']}">
                                                                                <div class="dd-handle dd3-handle"></div>
                                                                                <div class="dd3-content"> 
                                                                                    <a href="javascript:;" onclick="getAssignedUsers('{$entry['code']}', this);" data-name="{$entry['name']}">{$entry['name']}</a>
                                                                                    <div class="pull-right">
                                                                                        {if $entry["severity"]->code != 'NA'}
                                                                                            {if $entry["severity"]->code == 'DEFAULT'}
                                                                                                <span class="badge badge-secondary">{$perrmission_severity[$entry["severity"]->code]}</span>
                                                                                            {else if $entry["severity"]->code == 'MAJOR'}
                                                                                                <span class="badge badge-primary">{$perrmission_severity[$entry["severity"]->code]}</span>
                                                                                            {else if $entry["severity"]->code == 'CRITICAL'}
                                                                                                <span class="badge badge-danger">{$perrmission_severity[$entry["severity"]->code]}</span>
                                                                                            {else if $entry["severity"]->code == 'BLOCKER'}
                                                                                                <span class="badge badge-warning">{$perrmission_severity[$entry["severity"]->code]}</span>
                                                                                            {/if}
                                                                                            &nbsp;
                                                                                        {/if}
                                                                                        {if $action_rights['MNU-DISABLE']>0} <a href="javascript:;" title="edit" {if $action_rights['MNU-DISABLE']!=2}onclick='editStatusMenu("{$entry['code']}", this)'{/if} data-status="{$entry["activeFlag"]}">
                                                                                                {if $entry["activeFlag"]==1}
                                                                                                    <i class="fa fa-times" title="Click to disable"></i>
                                                                                                {else}
                                                                                                    <i class="fa fa-check" title="Click to enable"></i>
                                                                                                {/if}
                                                                                            </a>&nbsp;{/if}

                                                                                            {if $action_rights['MNU-EDIT']>0}<a href="javascript:;" title="edit"  {if $entry["activeFlag"]==0}style='display:none'{/if} id='mnu_edt_{$entry['code']}'  {if $action_rights['MNU-EDIT']!=2}onclick='menuDialog("{$entry['code']}")'{/if}>
                                                                                                    <i class="fa fa-pencil igreen"></i>
                                                                                                </a>&nbsp;{/if}

                                                                                                {if $action_rights['MNU-DELETE']>0} <a href="javascript:;" title="Delete" {if $action_rights['MNU-DELETE']!=2}onclick='deleteMenu("{$entry['code']}")'{/if}>
                                                                                                        <i class="fa fa-trash-o ired"></i>
                                                                                                    </a>{/if}
                                                                                                </div>
                                                                                            </div>
                                                                                            {if count($f_sub_menu[$entry['code']]) > 0}
                                                                                                {if is_array($f_sub_menu[$entry['code']])}
                                                                                                    {menu data=$f_sub_menu[$entry['code']]}		
                                                                                                {/if}

                                                                                            {/if}
                                                                                        </li>
                                                                                        {/foreach}
                                                                                        </ol>
                                                                                        {/function}
                                                                                            {menu data=$f_parent}
                                                                                        </div>
                                                                                    </div>
                                                                                    {else}
                                                                                        <div class="well well-large ">No Menu found!</div>
                                                                                        {/if}
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="clear_fix_both"></div>
                                                                                    <div id="menu-dialog" style="display: none;"  class="dialog-content-page">
                                                                                        <form role="form" id="form1" class="form-horizontal ">
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="product_code">Product</label>
                                                                                                    <select  class="form-control" id="product_code">
                                                                                                        <option value="">Select</option>
                                                                                                        {foreach $products as $product}
                                                                                                            <option value="{$product->code}">{$product->name}</option>
                                                                                                        {/foreach}
                                                                                                    </select>
                                                                                                    <input  placeholder="Action" id="txt_c_name" name="txt_c_name"  class="form-control hide">
                                                                                                </div>
                                                                                            </div>   
                                                                                            
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="parentmenu" class="">Parent Menu</label>
                                                                                                    <select  class="form-control" id="parentmenu">
                                                                                                        <option value="">Select</option>
                                                                                                        {function name=option level=0} 
                                                                                                            {foreach $data as $entry}
                                                                                                                <option value="{$entry['code']}">
                                                                                                                    {if $level!=0}
                                                                                                                        {section name=l loop=$level}
                                                                                                                            -
                                                                                                                        {/section}
                                                                                                                    {/if}
                                                                                                                    {$entry['name']}
                                                                                                                </option>
                                                                                                                {if count($f_sub_menu[$entry['code']]) > 0}
                                                                                                                    {if is_array($f_sub_menu[$entry['code']])}
                                                                                                                        {option data=$f_sub_menu[$entry['code']] level=$level+1}		
                                                                                                                    {/if}

                                                                                                                {/if}
                                                                                                            {/foreach}

                                                                                                        {/function}
                                                                                                        {option data=$f_parent}
                                                                                                    </select>
                                                                                                </div>
                                                                                            </div>


                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="txt_m_name" class="req">Name</label>
                                                                                                    <input  placeholder="Name" id="txt_m_name" name="txt_m_name"  class="form-control">
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="txt_l_name" class="req">Link</label>
                                                                                                    <input  placeholder="Link" id="txt_l_name" name="txt_l_name"  class="form-control">
                                                                                                </div>
                                                                                            </div>

                                                                                            <div class="clear_fix_both"></div>
                                                                                            <br />
                                                                                            <div class="col-lg-3 p_l_n">
                                                                                                <div>
                                                                                                <label for="">Tag</label>
                                                                                                <select class="form-control" name="menu_tag" id="menu_tag" multiple>
                                                                                                    <option value="New">New</option>
                                                                                                    <option value="Updated">Updated</option>
                                                                                                </select>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-md-3 p_l_n">
                                                                                                <div>
                                                                                                    <label for="">Severity</label>
                                                                                                    <select id="menu_severity" class="form-control" name="menu_severity">
                                                                                                        <option value="NA">Select</option>
                                                                                                        {foreach from=$perrmission_severity item=val key=k}
                                                                                                            <option value="{$k}">{$val}</option>
                                                                                                        {/foreach}
                                                                                                    </select>
                                                                                                </div>
                                                                                            </div>  
                                                                                            <div class="clear_fix_both"></div><br>

                                                                                            <div class="table-responsive ov_fl">
                                                                                                <table class="table table-striped" id="tbl_list">
                                                                                                    <tr class="tr-head">
                                                                                                        <td>Name</td>
                                                                                                        <td>Permission Type</td>
                                                                                                        <td>Severity</td>
                                                                                                        <td>Operation Code</td>
                                                                                                        <td>Attribute</td>
                                                                                                        <td>Active</td>
                                                                                                        <td></td>
                                                                                                    </tr>
                                                                                                    <tr class="def-tr">
                                                                                                        <td>
                                                                                                            <input type="text" name="evt_name" id="evt_name" class="form-control" /></td>
                                                                                                        <td>

                                                                                                            <select  class="form-control" name="evt_permis">
                                                                                                                <option value="ACT">Active</option>
                                                                                                                <option value="IDL">Ideal</option>

                                                                                                            </select>

                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <select id="event_severity" class="form-control" name="event_severity">
                                                                                                                <option value="NA">Select</option>
                                                                                                                {foreach from=$perrmission_severity item=val key=k}
                                                                                                                    <option value="{$k}">{$val}</option>
                                                                                                                {/foreach}
                                                                                                            </select>
                                                                                                        </td>
                                                                                                        <td><input type="text" name="evt_key" id="evt_key"  class="form-control" /></td>
                                                                                                        <td><input type="text" name="evt_attr" id="evt_attr"  class="form-control" /></td>
                                                                                                        <td>
                                                                                                            <input type="checkbox" name="evt_act" id="evt_act" checked value="1" />
                                                                                                        </td>
                                                                                                        <td><a href="javascript:;" class="btn btn-sm btn-default tr_remove"><i class="fa fa-times"></i></a></td>
                                                                                                    </tr>
                                                                                                    <tr id="clo" class="hide">
                                                                                                        <td><input type="text" name="evt_name" id="evt_name" class="form-control" /></td>
                                                                                                        <td>

                                                                                                            <select  class="form-control" name="evt_permis">
                                                                                                                <option value="ACT">Active</option>
                                                                                                                <option value="IDL">Ideal</option>

                                                                                                            </select>

                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <select id="event_severity" class="form-control" name="event_severity">
                                                                                                                <option value="NA">Select</option>
                                                                                                                {foreach from=$perrmission_severity item=val key=k}
                                                                                                                    <option value="{$k}">{$val}</option>
                                                                                                                {/foreach}
                                                                                                            </select>
                                                                                                        </td>
                                                                                                        <td><input type="text" name="evt_key" id="evt_key" class="form-control" /></td>
                                                                                                        <td><input type="text" name="evt_attr" id="evt_attr"  class="form-control" /></td>
                                                                                                        <td>
                                                                                                            <input type="checkbox" name="evt_act" value="1" checked id="evt_act" class="de-ck" />
                                                                                                        </td>
                                                                                                        <td><a href="javascript:;" class="btn btn-sm btn-default tr_remove"><i class="fa fa-times"></i></a></td>

                                                                                                    </tr>
                                                                                                    <tr id="tr_add">
                                                                                                        <td colspan="7" align="right">                                                                          
                                                                                                            <button class="btn btn-sm btn-primary" type="button" onclick="addEvents();">Add Event</button>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                            <input type="hidden" name="menu_code" id="menu_code" value="" />
                                                                                            <input type="hidden"  name="menu_status" id="menu_status" value="1" />

                                                                                            <div class="clear_fix_both"></div><br />
                                                                                            <div class="fl" id="mnu-loading"></div>
                                                                                            <div class="alert fl" style="display: none;" id="mnu-action-state"></div>
                                                                                            <div class="align-right" id="mnu-button">
                                                                                                <input type="hidden" name="id_mnu_code" id="id_mnu_code" value="" />
                                                                                                <button class="btn btn-success" type="button" onclick="saveMenu();">Save</button>
                                                                                                <button class="btn btn-default" type="button" onclick="cancelMenu();">Cancel</button>
                                                                                            </div>
                                                                                        </form>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-6 hide" id="assigned-users-pannel-loading"></div>
                                                                                <div class="col-md-6 hide" id="assigned-users-pannel">
                                                                                    <div class="heading_b" id="cur-info">Permission setup for <b></b></div>
                                                                                    <input type="hidden" id="selected-menu">
                                                                                    <div class="col-md-12 m-b-4 p_l_n pb10">
                                                                                        <label class="checkbox-inline">
                                                                                            <input type="checkbox" id="ns-{$namespace_code}" class="assigned-cb {$namespace_code}" data-role="NS" value="{$namespace_code}">&nbsp;<b class="h5 bold">Namespace</b>
                                                                                        </label>
                                                                                    </div>
                                                                                    {foreach from=$groupusers['groups'] item=group}
                                                                                        {if $groupusers['groupusers'][$group->name]}                                                                                            
                                                                                            <div class="pt10 pb5">
                                                                                                <div class="col-md-12 m-b-4">
                                                                                                    <label class="checkbox-inline">
                                                                                                        <input type="checkbox" id="group-{$group->code}" class="assigned-cb {$group->code}" data-role="GR" value="{$group->code}">&nbsp;<b>{$group->name}</b>
                                                                                                    </label>
                                                                                                </div>
                                                                                                <div class="col-md-12">
                                                                                                    {foreach from=$groupusers['groupusers'][$group->name] item=user}
                                                                                                        {if $user['activeFlag'] == 1}
                                                                                                            <div class="col-md-4 m-b-4">
                                                                                                                <label class="checkbox-inline">
                                                                                                                    <input type="checkbox" id="usr-{$user['code']}" class="assigned-cb {$user['code']}" data-role="UR" value="{$user['code']}">&nbsp;{$user['name']}
                                                                                                                </label>
                                                                                                            </div>
                                                                                                        {/if}
                                                                                                    {/foreach}
                                                                                                </div>
                                                                                                <div class="clear_fix_both"></div>
                                                                                            </div>
                                                                                        {/if}
                                                                                    {/foreach}
                                                                                </div>
                                                                                <!--panel Body end-->
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
                    var menulist = {$f_menus|json_encode}
                    $(document).ready(function ()
                    {

                        /*  var updateOutput = function(e)
                         {
                         var list   = e.length ? e : $(e.target),
                         output = list.data('output');
                         if (window.JSON) {
                         output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
                         } else {
                         output.val('JSON browser support required for this demo.');
                         }
                         };*/



                        $('#nestable2').nestable({
                            group: 1
                        })
                                .on('change');

                    });
                    $('#menu_tag').select2();
                    $('.assigned-cb').on('change', function() {
                        var menu = $('#selected-menu').val();
                        var flag = +$(this).is(':checked');
                        var role = $(this).data('role');
                        var code = $(this).val();
                        assignPermission(menu, flag, role, code);
                    });
                                            </script>