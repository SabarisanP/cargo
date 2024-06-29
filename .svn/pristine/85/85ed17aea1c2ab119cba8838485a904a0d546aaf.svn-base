<div class="brand_top">
    <h3>Manage Reports</h3> 
    <span class="align-rights">
        {if $action_rights['RPT-AD-ADD']>0}
            <a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['RPT-AD-ADD']!=2}onclick="editReport();"{/if}>Add New Report</a>
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
                                            <div class="panel panel-info hide" id="oz-dm">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title"> 
                                                        <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-"></a>
                                                        <div class="btn-group btn-group-xs ac_bu">
                                                            <a href="javascript:;" class="btn btn-default btn-sm est" onclick="editStatusReport()" data-status="1"><i class="fa fa-times"  title="Click to disable"></i></a>
                                                            <a href="javascript:;" title="edit" class="btn btn-default btn-sm edat" onclick='editReport()'><i class="fa fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" onclick="deleteReport()"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </h3>    
                                                </div>  
                                            </div>

                                            {if count($schedule) > 0}

                                                {foreach name=o item=row from=$schedule}
                                                    <div class="panel panel-info" id="oz-{$row->code}">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title"> 
                                                                <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}"> <span id="usr_cnt_{$row->code}">{$row->name} - {$row->code}</span> </a>
                                                                <div class="btn-group btn-group-xs ac_bu">
                                                                    {if $action_rights['RPT-AD-DISABLE']>0}  
                                                                        <a href="javascript:;" class="btn btn-default btn-sm est"   {if $action_rights['RPT-AD-DISABLE']!=2} onclick='editStatusReport({$row|@json_encode}, this)'{/if} data-status="{$row->activeFlag}">
                                                                            {if $row->activeFlag==1}
                                                                                <i class="fa fa-times" title="Click to disable"></i>
                                                                            {else}
                                                                                <i class="fa fa-check" title="Click to enable"></i>
                                                                            {/if}
                                                                        </a>{/if}
                                                                        {if $action_rights['RPT-AD-EDIT']>0} <a href="javascript:;" title="edit" {if $row->activeFlag==0}style='display:none'{/if}   class="btn btn-default btn-sm edat" id='edt_sch_{$row->code}'  {if $action_rights['RPT-AD-EDIT']>0} onclick='editReport({$row|@json_encode})'{/if}><i class="fa fa fa-pencil igreen"></i></a>{/if}
                                                                        {if $action_rights['RPT-AD-DELETE']>0}<a href="javascript:;" title="delete" class="btn btn-default btn-sm del"   {if $action_rights['RPT-AD-DELETE']>0} onclick='deleteReport({$row|@json_encode})'{/if}><i class="fa fa-trash-o ired"></i></a>{/if}

                                                                    </div>
                                                                </h3>
                                                            </div> 
                                                            <div id="collapse-{$row->code}" class="panel-collapse collapse">
                                                                <div class="panel-body">
                                                                    <div class="row">
                                                                        <label class="col-xs-2">Report code</label>
                                                                        <div class="col-xs-10">
                                                                            {$row->code}
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <label class="col-xs-2">Days Limit</label>
                                                                        <div class="col-xs-10">
                                                                            {$row->daysLimit} days
                                                                        </div>
                                                                    </div>
                                                                    <div class="row">
                                                                        <label class="col-xs-2">Query</label>
                                                                        <div class="col-xs-10">
                                                                            {$row->query}
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        {/foreach} 
                                                            {else}
                                                                <div class="well well-large ">No Report found!</div>
                                                                {/if}
                                                                </div>
                                                            </div>
                                                            <div class="clear_fix_both"></div>

                                                            <!--panel Body end-->
                                                        </div><!--panel end-->

                                                    </div>

                                                </div><!--row end-->
                                            </div><!--content end-->
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div id="pg-organization-dialog" class="hide dialog-content-page">

                                <form role="form" id="form1" class="form-horizontal ">
                                    <div class="row">
                                        <div class="col-md-9">
                                            <div class="form-group">
                                                <label for="txt_g_name" class="req">Name</label>
                                                <input  placeholder="Report name" id="txt_g_name" name="txt_g_name"  class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group p_l_15">
                                                <label for="txt_g_name" class="req">Days Limit</label>
                                                <input type="number" class="no-spin form-control" placeholder="Days Limit" id="txt_g_days" name="txt_g_days">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="txt_g_decription">Description</label>
                                        <div>
                                            <textarea  placeholder="Short note about this report" id="txt_g_decription" name="txt_g_decription"  class="form-control rs_no"></textarea>
                                        </div>
                                    </div> 
                                    <div class="form-group">
                                        <label for="txt_g_decription" class="req">SQL Query</label>
                                        <div>
                                            <textarea  placeholder="SQL Query" id="txt_g_query" name="txt_g_query"  class="form-control rs_no" rows="7"></textarea>
                                        </div>
                                    </div> 
                                </form>

                                <div class="clear_fix_both"></div>
                                <div class="clear_fix_both">                       
                                    <div class="alert fl suc_cre" style="display: none;" id="org-form-action-state"></div>
                                    <div class="align-right cre_sve" id="form-bttons">
                                        <input type="hidden" name="id_oz_code" id="id_oz_code" value="" />

                                        <button class="btn btn-success" type="button" onclick="saveReport();">Save</button>
                                        <button class="btn btn-default" type="button" onclick="cancelReport();">Cancel</button>
                                    </div>
                                </div> 


                                <div id="all_usr_org" class="hide dialog-content-page">
                                    <form role="form" id="form_org" class="form-horizontal ">
                                        <label>Please select user</label>
                                        <div class="ov_fl_230">
                                            <ul class="user_list">

                                                {foreach item=usr from=$users}
                                                    <li>
                                                        <div style="padding-left: 10px;"> 
                                                            <div class="radio">
                                                                <input type="checkbox" id="usr_org_{$usr->code}" value="{$usr->code}" class="org_usr_all" data-name="{$usr->name}"  name="usr_org_all">
                                                                <lable for="usr_org_{$usr->code}">{$usr->name}</lable>
                                                            </div>
                                                        </div> 
                                                    </li>
                                                {/foreach}   
                                            </ul>
                                        </div>

                                        <div class="clear_fix_both">      <br/>        
                                            <div class="fl" id="all-form-loading"></div>
                                            <div class="alert fl" style="display: none;" id="all-org-state"></div>
                                            <div class="align-right" id="all-form-bttons">
                                                <input type="hidden" name="aid_oz_code" id="aid_oz_code" value="" />
                                                <input type="hidden" name="sel_oz_status" id="sel_oz_status" value="1" />

                                                <button class="btn btn-success" type="button" onclick="saveUserOrganizatio();">Save</button>
                                                <button class="btn btn-default" type="button" onclick="cancelUserOrganization();">Cancel</button>
                                            </div>
                                        </div> 
                                    </form>
                                </div>

                            </div>      

