<div class="brand_top"><h3>Retail Customer Groups</h3> <span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="grpDialog();">Add New Group</a></span></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12">
                    <div class="row">
                        <div style="clear: both;"></div><br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-offset-3 col-md-6 ">
                                        <ul class="user_list " id="user_list_search">
                                            {if count($entity) > 0}
                                                {foreach name=o item=row from=$entity} 
                                                    <li id="grp-{$row->code}"  >
                                                        <span class="sp_name col-xs-3">{$row->name}</span>
                                                        <span class="sp_status col-xs-3">
                                                        </span>
                                                        <span  class="sp_action col-xs-6">
                                                            <div class="btn-group btn-group-xs">
                                                                <a href="javascript:;" class="btn btn-default btn-sm {if $row->activeFlag==0}none{/if}" title="Edit" id='at_edt_{$row->code}' onclick='grpDialog({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                                <a href="javascript:;" class="btn btn-default btn-sm" title="Delete"   onclick="deleteGroup('{$row->code}', '{$row->name}')"><i class="fa fa-trash-o ired"></i></a>
                                                            </div>
                                                        </span>
                                                    </li> 
                                                {/foreach}
                                            {else}
                                                <li class="er_msg"><div class="well well-large "> No Groups Found!</div></li>
                                                {/if}  
                                        </ul>
                                    </div>
                                    <div class="clear_fix_both"></div>
                                    <div id="grp-dialog" class="hide dialog-content-page" >
                                        <form role="form" class="form-horizontal">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="txt_am_name">Name<span class="required">*</span></label>
                                                <div class="col-sm-7">
                                                    <input type="text" placeholder="Name" id="grp_name" class="form-control">
                                                    <input type="hidden" id="grp_code">
                                                </div>
                                            </div>           
                                        </form>
                                        <div class="align-center alert alert-danger pull-left" style="display:none" id="grp-action-state"></div>
                                        <div class="align-right" id="grp-form-bttons">
                                            <button class="btn btn-success" type="button" onclick="saveGroup();">Save</button>
                                            <button class="btn btn-default" type="button" onclick="cancelGroup();">Cancel</button>
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
