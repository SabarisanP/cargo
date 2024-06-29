<div class="brand_top"><h3>Name Space</h3> <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="editNamespace();">Add Name Space</a>
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
                                    <div class="col-md-offset-3 col-md-6">
                                        <div class="panel-group">
                                         
                                            <div class="col-md-offset-1 col-md-10">
                                                
                                            {if count($namespace_list) > 0}
                                                <div class="well well-sm">
							<input type="text" class="form-control" placeholder="Find Namespace..." id="list_search" >
						</div>
                                                <div class="user_list_action">
                                                <ul class="user_list " id="user_list_search">
                                                    {foreach name=o item=row from=$namespace_list}
                                                        <li id="nsp-{$row->code}"  >
                                                            
                                                            <div class="list_content">
                                                                    <span class="user_actions text-muted">
                                                                              <a href="javascript:;" title="edit" class="btn btn-default btn-xs" onclick='editNamespace("{$row->code}")'><i class="fa fa fa-pencil igreen"></i></a>
                                                                    </span>
                                                                    <h5>{$row->name}</h5>
                                                                    <p class="text-muted">
                                                                            <small>{$row->pin},{$row->mode}</small><br>
                                                                            
                                                                    </p>
							    </div>
                                                        </li>

                                                    {/foreach} 
                                                </ul>
                                               </div>
                                            {else}
                                                <div class="well well-large ">No Namespace found!</div>
                                            {/if}
                                        </div>
                                    </div>
                                    <div class="clear_fix_both"></div>

                                        <div id="pro-dialog" class="hide dialog-content-page" >
                                                <form role="form" class="form-horizontal">
                                                    <div class="form-group ">
                                                        <label class="col-sm-2 control-label" for="e_code">Code<span class="required">*</span></label>
                                                        <div class="col-sm-7 np-code">
                                                            <input type="text" placeholder="Code" id="e_code" class="form-control">
                                                        </div>
                                                        <div class="col-sm-7 display-code">
                                                            
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="e_name">Name<span class="required">*</span></label>
                                                        <div class="col-sm-7">
                                                            <input type="text" placeholder="Name" id="e_name" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label" for="e_pin">Pin<span class="required">*</span></label>
                                                        <div class="col-sm-7">
                                                            <input type="text" placeholder="Pin" id="e_pin" class="form-control">
                                                        </div>
                                                    </div>
                                                </form>

                                                <input type="hidden" id="flag"  > 
                                                <div class="pull-left"  id="pwd-action-loading" ></div>
                                                <div class="alert alert-danger pull-left"  id="pwd-action-state" ></div>
                                                <div class="align-right" id="amt-form-bttons" style="position:relative;top:8px">
                                                    <button class="btn btn-success" type="button" onclick="saveNamespace();">Save</button>
                                                    <button class="btn btn-default" type="button" onclick="cancelProAddEdit();">Cancel</button>
                                                </div>
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
var namespae = {$namespace_list|json_encode};            

</script>

<script  type="text/template" id="namespace_view">
<li>
                                                            
        <div class="list_content">
                <span class="user_actions text-muted">
                          <a href="javascript:;" title="edit" class="btn btn-default btn-xs" onclick='editNamespace("")'><i class="fa fa fa-pencil igreen"></i></a>
                </span>
                <h5></h5>
                <p class="text-muted">
                        <small></small>

                </p>
        </div>
</li>
</script>