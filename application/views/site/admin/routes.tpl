<div class="brand_top">
    <h3>Routes</h3> 
    
    <span class="align-right">
        {if $is_super_namespace==1}
            <a href="javascript:;" class="btn btn-default  btn-sm" onclick="exportRoutes();">Export</a> &nbsp;&nbsp;
        {/if}
        {if $action_rights['ROTE-ADD']>0}
            <a href="javascript:;" class="btn btn-success  btn-sm" onclick="allRoutesDialog('',1);">Add New Route</a>
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
                                    <div class="col-md-offset-0 col-md-7">
                                        <ul class="user_list " id="user_list_search">
                                            <li class="hide amt-db"  >
                                                <span class="sp_name col-xs-5"></span>
                                                <span class="sp_status col-xs-2">
                                                    <span class="label label-success" id="lb">Active</span>
                                                </span>
                                                <span  class="sp_action col-xs-5">
                                                    <div class="btn-group btn-group-xs">
                                                        <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editRouteStatus('{$row->code}', '{$row->name}')">
                                                            <i class="fa fa-times" id="sta" data-status="9"  title="Click to disable"></i>
                                                        </a> 
                                                        <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='allRoutesDialog({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                        <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteRoutes('{$row->code}', '{$row->name}')"><i class="fa fa-trash-o ired"></i></a>
                                                    </div>
                                                </span>
                                            </li>
                                            <li class="bold">
                                                <span class="sp_name col-xs-5 rt_23">Route</span>
                                                <span class="sp_status col-xs-2 rt_12 p_r_n">Status</span>
                                                <span class="sp_min_fare col-xs-1 rt_12 p_l_n p_r_n">Min Fare</span>
                                                <span class="sp_max_fare col-xs-2 rt_12 p_l_n p_r_n">Max Fare</span>
                                                <span class="sp_action col-xs-2"></span>
                                            </li>
                                           {if count($route) > 0}
                                            {foreach name=o item=row from=$route} 
						<li id="am-{$row->code}"  >
						    <span class="sp_name col-xs-5 rt_23">{$row->name}</span>
						    <span class="sp_status col-xs-2 rt_12 p_r_n">
							{if $row->activeFlag==1}
							    <span class="label label-success" id="lb-{$row->code}">Active</span>
							{else}
							    <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
							{/if}    
						    </span>
                                                    <span class="sp_min_fare col-xs-1 rt_12 p_l_n p_r_n">{$row->minFare}</span>
                                                    <span class="sp_max_fare col-xs-1 rt_12 p_l_n p_r_n">{$row->maxFare}</span>
						    <span  class="sp_action col-xs-2 p_l_n p_r_n text-center">
							<div class="btn-group btn-group-xs">
                                                            {if $action_rights['ROTE-EDIT']>0}
                                                                <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='allRoutesDialog({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                            {/if}
							    {if $action_rights['ROTE-DISABLE']>0}
							    <a href="javascript:;" class="btn btn-default btn-sm" {if $action_rights['ROTE-DISABLE']!=2}onclick="editRouteStatus('{$row->code}', '{$row->name}','{$row->fromStation->code}','{$row->toStation->code}')"{/if}>
								{if $row->activeFlag==1}
								    <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
								{else}
								    <i class="fa fa-check" id="sta-{$row->code}" data-status="9" title="Click to enable"></i>
								{/if} 
							    </a> 
                                                            {/if}
							    {if $action_rights['ROTE-DELETE']>0}<a href="javascript:;" class="btn btn-default btn-sm" title="Delete" {if $action_rights['ROTE-DELETE']!=2}onclick="deleteRoutes('{$row->code}', '{$row->name}')"{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
							</div>
						    </span>

						</li> 
                                            {/foreach}
                                            {else}
                                                            <li class="er_msg"><div class="well well-large "> No Routes Found!</div></li>
                                                            {/if}  
                                        </ul>
                                    </div>
                                    <input id='chk_new' type='hidden'>
                                    <input type="hidden" id="test" value="">
                                    <input type="hidden" id="set_id" value="">
                                    <input type="hidden" id="sel_am_status" value="1">
                                    <input type="hidden" id="aid_am_code" value="" />
                                    <input type="hidden" id="new_amenities" value="" />
                                                                      

                                </div>
                            </div><!--panel Body end-->
                        </div><!--panel end-->

                    </div>

                </div><!--row end-->
            </div><!--content end-->
        </div>
    </div>
</div>
<form id='export-routes' name="export_routes" method="post" onsubmit="return false"></form>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> 
</div>
{include file='site/admin/routes-dialog.tpl'}
<script>
    
    var routes = {$route|json_encode}; 
   
   
     
    </script>