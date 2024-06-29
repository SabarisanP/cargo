<div class="brand_top">
    <h3>Payment Modes</h3> 
    <span class="align-right">
        {if $action_rights['PG-MO-ADD']>0} <a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['PG-MO-ADD']!=2}onclick="saveModes(1);"{/if}>Add New Mode</a>{/if}
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
                                            <div class="col-md-offset-3 col-md-6">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-13">
                                                    <ul class="user_list " id="user_list_search">
                                                        <li class="hide amt-db"  >
                                                            <span class="sp_name col-xs-3"></span>
                                                            <span class="sp_status col-xs-3">
                                                                <span class="label label-success" id="lb">Active</span>
                                                            </span>
                                                            <span  class="sp_action col-xs-6">
                                                                <div class="btn-group btn-group-xs">
                                                                    <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editModeStatus('{$row->code}', '{$row->name}')">
                                                                        <i class="fa fa-times" id="sta" data-status="0"  title="Click to disable"></i>
                                                                    </a> 
                                                                    <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='saveModes({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                                    <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteMode('{$row->code}', '{$row->name}')"><i class="fa fa-trash-o ired"></i></a>
                                                                </div>
                                                            </span>
                                                        </li> 
                                                        {if count($modes) > 0}
                                                            {foreach name=o item=row from=$modes} 

                                                                <li id="am-{$row->code}"  >
                                                                    <span class="sp_name col-xs-3">{$row->name}</span>
                                                                    <span class="sp_status col-xs-3">
                                                                        {if $row->activeFlag==1}
                                                                            <span class="label label-success" id="lb-{$row->code}">Active</span>
                                                                        {else}
                                                                            <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
                                                                        {/if}    
                                                                    </span>
                                                                    <span  class="sp_action col-xs-6">
                                                                        <div class="btn-group btn-group-xs">
                                                                            {if $action_rights['PG-MO-DISABLE']>0}  <a href="javascript:;" class="btn btn-default btn-sm" {if $action_rights['PG-MO-DISABLE']!=2}onclick="editModeStatus('{$row->code}', '{$row->name}')"{/if}>
                                                                                    {if $row->activeFlag==1}
                                                                                        <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                                    {else}
                                                                                        <i class="fa fa-check" id="sta-{$row->code}" data-status="1" title="Click to enable"></i>
                                                                                    {/if} 
                                                                                </a> {/if}
                                                                                {if $action_rights['PG-MO-EDIT']>0} <a href="javascript:;" id='edt_mod_{$row->code}' {if $row->activeFlag==0}style='display:none'{/if}  class="btn btn-default btn-sm" title="Edit" {if $action_rights['PG-MO-EDIT']!=2}onclick='saveModes({$row|@json_encode}, 3)'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}
                                                                                {if $action_rights['PG-MO-DELETE']>0}  <a href="javascript:;" class="btn btn-default btn-sm" title="Delete" {if $action_rights['PG-MO-DELETE']!=2}onclick="deleteMode('{$row->code}', '{$row->name}')"{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
                                                                            </div>
                                                                        </span>
                                                                    </li> 
                                                                    {/foreach} 

                                                                        {else}
                                                                            <li class="er_msg"><div class="well well-large "> No Payment Modes found!</div></li>
                                                                                {/if}  
                                                                            </ul>

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

                                                                        <input type="text" id="name" class="form-control" placeholder="Name">
                                                                    </div>
                                                                </div>

                                                                <input type="hidden" id="usr_status" name="usr_status" value="1" />
                                                                <input type="hidden" id="hid_provider_code" />
                                                                <div id="ur-form-loading" style="display:none"></div>
                                                                <div class="align-center alert alert-danger pull-left err_prov" id="usr-action-state"></div>
                                                                <div class="align-right prov_btn" id="form-buttons">
                                                                    <button type="button" id="btn-save" class="btn btn-success" onclick="saveMode()">Save</button>
                                                                    <button type="button" class="btn btn-default" onclick="cancelMode()">Cancel</button>
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

                    </div>

                    <script type="text/template" id="user_list_view">
                        <li class="usr_lst">
                        <div class="fl">
                        <a href="javascript:;" id="" onclick="ProviderView()" title="Click to view user details">

                        </a>
                        </div>
                        </li>
                    </script>