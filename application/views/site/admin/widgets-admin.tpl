<div class="brand_top">
    <h3>Manage Widgets</h3> 
    <span class="align-right">
        {if $action_rights['AMNTY-ADD']>0}
            <a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['AMNTY-ADD']!=2}onclick="editWidgets();"{/if}>Add New Widget</a>
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
                                    <div class="col-md-offset-3 col-md-6 ">
                                        <ul class="user_list " id="user_list_search">
                                            <li class="hide amt-db"  >
                                                <span class="sp_name col-xs-3"></span>
                                                <span class="sp_status col-xs-3">
                                                    <span class="label label-success" id="lb">Active</span>
                                                </span>
                                                <span  class="sp_action col-xs-6">
                                                    <div class="btn-group btn-group-xs">
                                                        <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editWidgetStatus()">
                                                            <i class="fa fa-times" id="sta" data-status="0"  title="Click to disable"></i>
                                                        </a> 
                                                        <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='editWidgets()'><i class="fa fa-pencil igreen"></i></a>
                                                        <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteWidgets()"><i class="fa fa-trash-o ired"></i></a>
                                                    </div>
                                                </span>
                                            </li> 


                                            {if count($entity) > 0}
                                                {foreach name=o item=row from=$entity} 

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
                                                                {if $action_rights['AMNTY-DISABLE']>0}
                                                                    <a href="javascript:;" class="btn btn-default btn-sm" {if $action_rights['AMNTY-DISABLE']!=2}  onclick="editWidgetStatus('{$row->code}', '{$row->name}')"{/if}>

                                                                        {if $row->activeFlag==1}
                                                                            <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                        {else}
                                                                            <i class="fa fa-check" id="sta-{$row->code}" data-status="1" title="Click to enable"></i>
                                                                        {/if} 

                                                                    </a> 
                                                                {/if}  
                                                                
                                                                {if $action_rights['AMNTY-EDIT']>0}
                                                                    <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='at_edt_{$row->code}' {if $action_rights['AMNTY-EDIT']!=2} onclick='editWidgets({$row|@json_encode})'{/if}><i class="fa fa-pencil igreen"></i></a>
                                                                {/if}
                                                                {if $action_rights['AMNTY-DELETE']>0}
                                                                    <a href="javascript:;" class="btn btn-default btn-sm" title="View / Edit Groups Assigned"  {if $action_rights['AMNTY-DELETE']!=2} onclick="assignWidgets1('{$row->code}')" {/if}><i class="fa fa-group ired"></i></a>
                                                                {/if}
                                                                {if $action_rights['AMNTY-DELETE']>0}
                                                                    <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"  {if $action_rights['AMNTY-DELETE']!=2} onclick="deleteWidgets('{$row->code}', '{$row->name}')" {/if}><i class="fa fa-trash-o ired"></i></a>
                                                                {/if}
                                                                </div>
                                                            </span>
                                                        </li> 
                                                        {/foreach}
                                                    {else}
                                                        <li class="er_msg"><div class="well well-large "> No Widget Found!</div></li>
                                                    {/if}  
                                                </ul>
                                        </div>
                                        <div class="clear_fix_both"></div>

                                    </div><!--panel Body end-->
                                </div><!--panel end-->

                            </div>

                        </div><!--row end-->
                    </div><!--content end-->
                </div>
            </div>
        </div>

    </div>
                                                                
<div id="amenit-dialog" class="hide dialog-content-page" >
   <form role="form" id="form1" class="form-horizontal ">
        <div class="form-group">
            <div>
                <label for="txt_g_name" class="req">Name</label>
                <input type="text" placeholder="Name" id="txt_am_name" class="form-control">
            </div>
        </div> 

        <div class="form-group">
            <div>
                <label for="txt_am_calback" class="req">Callback Function</label>
                <input type="text" placeholder="JS Function Name" id="txt_am_calback" class="form-control">
            </div>
        </div>   
        
        <input type="hidden" id="sel_am_status" value="1">
        <input type="hidden" id="aid_am_code" value="" />
        <input type="hidden" id="new_amenities" value="" />
    </form>
    

    <div class="align-center alert alert-danger pull-left" style="display:none" id="usr-action-state"></div>
    <div class="align-right" id="amt-form-bttons">
        <button class="btn btn-success" type="button" onclick="saveWidgets();">Save</button>
        <button class="btn btn-default" type="button" onclick="cancelAmAddEdit();">Cancel</button>
    </div>

</div>

