<div class="brand_top">
    <h3>Payment Gateway Provider</h3> 
    <span class="align-rights">
        {* {if $action_rights['PG-PROVI-ADD']>0} *}<a href="javascript:;" class="btn btn-success  btn-sm" {*{if $action_rights['PG-PROVI-ADD']!=2}*}onclick="saveGatewayProvider(1);"{*{/if}*}>Add New Provider</a>{*{/if}*}
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
                                            <div class="col-md-12">
                                                <div class="align-center" id="user-action-status"></div>
                                                <div id="user-address-book" class="col-md-4">
                                                    <ul class="user_list " id="user_list_search">
                                                        <li class="hide amt-db"  >
                                                            <span class="sp_name col-xs-4"><a href="javascript:;" ></a></span>
                                                            <span class="sp_name1 col-xs-3" style='display:none'></span>
                                                            <span class="sp_status col-xs-2">
                                                                <span class="label label-success" id="lb">Active</span>
                                                            </span>
                                                            <span  class="sp_action col-md-6">
                                                                <div class="btn-group btn-group-xs">
                                                                    <a href="javascript:;" class="btn btn-default btn-sm edsts" title="Status" onclick="editProviderStatus('{$row->code}', '{$row->name}')">
                                                                        <i class="fa fa-times" id="sta" data-status="0"  title="Click to disable"></i>
                                                                    </a> 
                                                                    <a href="javascript:;" class="btn btn-default btn-sm edat" title="Edit" onclick='saveGatewayProvider({$row|@json_encode})'><i class="fa fa-pencil igreen"></i></a>
                                                                    <a href="javascript:;" class="btn btn-default btn-sm delam" title="Delete" onclick="deleteProvider('{$row->code}', '{$row->name}')"><i class="fa fa-trash-o ired"></i></a>
                                                                </div>
                                                            </span>
                                                        </li> 
                                                        {if count($provider) > 0}
                                                            {foreach name=o item=row from=$provider} 
                                                                <li id="am-{$row->code}"  >
                                                                    <span class="sp_name col-xs-4"><a href="javascript:;" id="pro-viw-{$row->code}" class="pro" onclick="providerView('{$row->code}')" title="Click to view user details">{$row->name}</a></span>
                                                                    <span class="sp_name1 col-xs-3" style='display:none'>{$row->serviceName}</span>
                                                                    <span class="sp_status col-xs-2">
                                                                        {if $row->activeFlag==1}
                                                                            <span class="label label-success" id="lb-{$row->code}">Active</span>
                                                                        {else}
                                                                            <span class="label label-danger" id="lb-{$row->code}">Disabled</span>    
                                                                        {/if}    
                                                                    </span>
                                                                    <span  class="sp_action col-xs-6">
                                                                        <div class="btn-group btn-group-xs">
                                                                            {if $action_rights['PG-PROVI-DISABLE']>0} <a href="javascript:;" class="btn btn-default btn-sm" {if $action_rights['PG-PROVI-DISABLE']!=2}onclick="editProviderStatus('{$row->code}', '{$row->name}')"{/if}>
                                                                                    {if $row->activeFlag==1}
                                                                                        <i class="fa fa-times" id="sta-{$row->code}" data-status="0" title="Click to disable"></i>
                                                                                    {else}
                                                                                        <i class="fa fa-check" id="sta-{$row->code}" data-status="1" title="Click to enable"></i>
                                                                                    {/if} 
                                                                                </a> {/if}
                                                                                {if $action_rights['PG-PROVI-EDIT']>0}<a href="javascript:;" class="btn btn-default btn-sm" {if $row->activeFlag==0} style='display:none'{/if} id='edt_pro_{$row->code}' title="Edit" {if $action_rights['PG-PROVI-EDIT']!=2}onclick='saveGatewayProvider({$row|@json_encode}, 3)'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}
                                                                                {if $action_rights['PG-PROVI-DELETE']>0}<a href="javascript:;" class="btn btn-default btn-sm" title="Delete" {if $action_rights['PG-PROVI-DELETE']!=2}onclick="deleteProvider('{$row->code}', '{$row->name}')"{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
                                                                            </div>
                                                                        </span>
                                                                    </li> 
                                                                    {/foreach} 
                                                                        {else}
                                                                            <li class="er_msg"><div class="well well-large "> No Gateway provider found!</div></li>
                                                                                {/if}   
                                                                            </ul>

                                                                        </div>
                                                                        <div class="col-md-8" id="usr-viw-rslt">
                                                                            {if count($provider) > 0}
                                                                                <div class="p_t_100">
                                                                                    <div class="well well-large "> Click any of the provider name to view more details.</div>
                                                                                </div>
                                                                            {/if} 
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
                                                                <div class="form-group">
                                                                    <div>
                                                                        <label class="req">Service name</label>

                                                                        <input type="text" id="service" name ="service" class="form-control" placeholder="Service name">
                                                                        <small class="text-muted">  <font color='#00ACEC'>Note:</font> Service name accepts only a-z and 0-9.
                                                                        </small>
                                                                    </div>
                                                                </div>

                                                                <input type="hidden" id="usr_status" name="usr_status" value="1" />
                                                                <input type="hidden" id="hid_provider_code" />
                                                                <div id="ur-form-loadings" style="display:none"></div>
                                                                <div class="align-center alert alert-danger pull-left err_prov" id="usr-action-state"></div>
                                                                <div class="align-right prov_btn" id="form-buttons">
                                                                    <button type="button" id="btn-save" class="btn btn-success" onclick="saveProvider()">Save</button>
                                                                    <button type="button" class="btn btn-default" onclick="cancelProvider()">Cancel</button>
                                                                </div>

                                                            </form>
                                                        </div>


                                                        <!--Partner Dialog -->

                                                        <div id="partner-dialog" class="dialog-content-page" style="display:none;overflow-y: hidden;">
                                                            <form class="form-horizontal" action="#">
                                                                <div class="row">
                                                                    <div class="col-lg-6">
                                                                        <div class="form-group">
                                                                            <div>
                                                                                <label class='fl'>Provider Name : </label>
                                                                                <div id="am" class='fl prov_name'><div class="pro_name"></div></div>  
                                                                                <input type="hidden" id="partner" >
                                                                                <input type="hidden" id='partner_code'>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <div>
                                                                                <label class="req">Partner Name</label>

                                                                                <input type="text" id="part_name" class="form-control" placeholder="Partner Name">
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group">                                
                                                                            <div class="" >
                                                                                <label class="req">Payment Mode</label>
                                                                                <select class="form-control" id="part_mode" name ='part_mode' >
                                                                                    <option value=''>Select</option>
                                                                                    {foreach item=rte from=$modes}
                                                                                        <option value="{$rte->code}">{$rte->name}</option>

                                                                                    {/foreach}
                                                                                </select>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <div>
                                                                                <label class="req">API Provider code</label>

                                                                                <input type="text" id="pro_code" class="form-control" placeholder="API Provider code" maxlength="50">
                                                                                <small class="text-muted">  <font color='#00ACEC'>Note:</font> API Provider code accepts only a-z and 0-9.
                                                                                </small>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <div>
                                                                                <label class="req">Offer Notes</label>

                                                                                <input type="text" id="ofr_note" class="form-control">
                                                                            </div>
                                                                        </div>        

                                                                        <input type="hidden" id="usr_status" name="usr_status" value="1" />
                                                                        <input type="hidden" id="hid_provider_code" />
                                                                        <input type='hidden' id='pg_gp_disable' value={$action_rights['PG-GP-DISABLE']}>
                                                                        <input type='hidden' id='pg_gp_edit' value={$action_rights['PG-GP-EDIT']}>
                                                                        <input type='hidden' id='pg_gp_del' value={$action_rights['PG-GP-DELETE']}>
                                                                        <div id="ur-form-loading" style="display:none"></div>
                                                                        <div class="align-center alert alert-danger pull-left err_prov" id="usr-action-state1"></div>
                                                                        <div class="align-right prov_btn" id="form-buttonss">
                                                                            <button type="button" id="btn-save" class="btn btn-success" onclick="savePartner()">Save</button>
                                                                            <button type="button" class="btn btn-default" onclick="cancelPartner()">Cancel</button>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-6">
                                                                        <h4>Terms List</h4>
                                                                        <div style="max-height:400px;overflow-y: auto;">
                                                                            <table class="table table-striped terms"  id="terms">
                                                                                <thead>
                                                                                    <tr>

                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <tr id="tr_add">
                                                                                        <td><div class="alert" style="" id="tms-form-action-state"></div></td>
                                                                                        <td>
                                                                                            <a href="javascript:;" class="btn btn-sm btn-primary addrow" id="tr_add_btn" onclick="add_row({});" >Add </a>
                                                                                        </td>
                                                                                    </tr>

                                                                                </tbody>                                                   
                                                                            </table>
                                                                        </div>

                                                                    </div>
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

                        <script id="template-row" type="text/template">
                            <tr id="terms_row">
                            <td class="tms_name" width="80%">
                            <input type="text" id="name" name="tms_name" class="form-control tms_name" value="">
                            </td>
                            </tr>
                        </script>

                        <script type="text/template" id="user_list_view">
                            <li class="usr_lst">
                            <div class="fl">
                            <a href="javascript:;" id="" onclick="providerView()" title="Click to view user details">

                            </a>
                            </div>
                            </li>
                        </script>
                        <script>
                            var userlist = {$provider|json_encode};
                        </script>

                        <script type="text/template" id="user_detail_view">

                            <div class="btn-group pull-left"><h4>Gateway Partners</h4>
                            </div> <span class="align-right">
                            {if $action_rights['PG-GP-ADD']>0} <a href="javascript:;" class="btn btn-success  btn-sm"   {if $action_rights['PG-GP-ADD']!=2}onclick="saveGatewayPartner();"{/if}>Add New Gateway Partner</a>
                            {/if}</span>

                        </script>
                        <script  type="text/template" id="user_commission_view">
                            <div>


                            <div class="clear_fix_both"></div>
                            <div class="table-responsive">
                            <table id="usr_com_table" class="table table-striped">
                            <thead>
                            <tr>
                            <th>Id</th>
                            <th>Partner Name</th>
                            <th>Payment Mode</th>
                            <th>Gateway Provider</th>
                            <th>Status</th>
                            <th>Partner Action</th>
                            <th></th>
                            </tr>

                            </thead>
                            <tbody class="body_table">

                            </tbody>
                            </table>
                            </div>
                            </div>
                        </script>
