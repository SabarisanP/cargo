<div class="brand_top"><h3>Payment Credentials</h3> <span class="align-rights">{if $action_rights['PG-CR-ADD']>0}<a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['PG-CR-ADD']!=2}onclick="editCredentials();"{/if}>Add New Credential</a>{/if}</span></div>
<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="content" class="col-lg-12">
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
                                                            <a href="javascript:;" class="btn btn-default btn-sm est" onclick="editStatusCredentials()" data-status="1"><i class="fa fa-times"  title="Click to disable"></i></a>
                                                            <a href="javascript:;" title="edit" class="btn btn-default btn-sm edat" onclick='editCredentials()'><i class="fa fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" onclick="deleteCredentials()"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </h3>    
                                                </div>  
                                            </div>

                                            {if count($credential) > 0}
                                                {foreach name=o item=row from=$credential}
                                                    <div class="panel panel-info" id="oz-{$row->code}">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title"> 
                                                                <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}"> <span id="usr_cnt_{$row->code}">{$row->gatewayProvider->name}</span> </a>
                                                                <div class="btn-group btn-group-xs ac_bu">
                                                                    {if $action_rights['PG-CR-DISABLE']>0} <a href="javascript:;" class="btn btn-default btn-sm est" {if $action_rights['PG-MO-DISABLE']!=2}onclick='editStatusCredentials({$row|@json_encode}, this)'{/if} data-status="{$row->activeFlag}">
                                                                            {if $row->activeFlag==1}
                                                                                <i class="fa fa-times" title="Click to disable"></i>
                                                                            {else}
                                                                                <i class="fa fa-check" title="Click to enable"></i>
                                                                            {/if}
                                                                        </a>{/if}
                                                                        {if $action_rights['PG-CR-EDIT']>0} 
                                                                            <a href="javascript:;" title="edit" class="btn btn-default btn-sm edat" {if $row->activeFlag==0}style='display:none' {/if}  id='cre_edt_{$row->code}' {if $action_rights['PG-CR-EDIT']!=2}onclick='editCredentials({$row|@json_encode})'{/if}><i class="fa fa fa-pencil igreen"></i></a>
                                                                            {/if} 
                                                                            {if $action_rights['PG-CR-DELETE']>0}
                                                                            <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" {if $action_rights['PG-CR-DELETE']!=2}onclick='deleteCredentials({$row|@json_encode})'{/if}><i class="fa fa-trash-o ired"></i></a>
                                                                            {/if}
                                                                    </div>
                                                                </h3>
                                                            </div> 
                                                            <div id="collapse-{$row->code}" class="panel-collapse collapse">
                                                                <div class="panel-body"> 
                                                                    <div class="col-md-10 ">
                                                                        <label  class="col-xs-3">Return URL </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add1">{$row->returnUrl}</div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <label  class="col-xs-3">Access Code </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add2"> {$row->accessCode}</div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <label  class="col-xs-3">Access Key </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add1">{$row->accessKey}</div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <label  class="col-xs-3">Attribute </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add1">{$row->attr1}</div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <label  class="col-xs-3">Properties Filename </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add2">{$row->propertiesFileName}</div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <!--<label  class="col-xs-3">Service Charge Value </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add1">{if $row->percentageFlag==1}{$row->serviceChargeValue} % {else}Rs. {$row->serviceChargeValue}{/if}</div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <label  class="col-xs-3">Customer Bare </label>
                                                                        <label class='col-xs-1'> : </label>
                                                                        <div class="add2">Rs. {$row->customerBare}</div>
                                                                        <div class="clear_fix_both"></div> -->


                                                                    </div>


                                                                </div>
                                                            </div>
                                                        </div>
                                                        <script type="text/javascript">
                                                            $(document).ready(function($) {
                                                                $("#org_scroll_{$row->code}").css({
                                                                    'max-height': '220px',
                                                                }).perfectScrollbar({
                                                                    wheelSpeed: 20,
                                                                    wheelPropagation: false
                                                                });
                                                            });
                                                        </script>
                                                        {/foreach} 
                                                            {else}
                                                                <div class="well well-large ">No Credential found!</div>
                                                                {/if}
                                                                </div>
                                                            </div>
                                                            <div class="clear_fix_both"></div>

                                                            <div id="pg-organization-dialog" class="hide dialog-content-page">
                                                                <div >
                                                                    <form role="form" id="form1" class="form-horizontal ">


                                                                        <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_oz_name" class="req">Gateway Provider</label>
                                                                                <select id="gateway" class="form-control col-md-6">
                                                                                    <option value="">Select</option>
                                                                                    {foreach name=o item=row from=$provider}
                                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                                    {/foreach}   
                                                                                </select>
                                                                            </div>
                                                                        </div>    
                                                                        <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_m_name" class="req pull-left">Return URL &nbsp; </label> <a title=" URL should start like http:// (or) https://" class="pull-left"><span class="fa fa-question-circle "></span></a>
                                                                                 <div class="clear_fix_both"></div>
                                                                                <input  placeholder="URL" id="url" name="url"  class="form-control">
                                                                            </div>
                                                                       </div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <br />
                                                                         <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_m_name" class="req">Access Code</label>
                                                                                <input  placeholder="Access Code" id="Accesscode" name="Accesscode"  class="form-control">
                                                                            </div>
                                                                        </div>
                                                                         <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_m_name" class="req">Access Key</label>
                                                                                <input  placeholder="Access Key" id="key" name="key"  class="form-control">
                                                                            </div>
                                                                        </div>
                                                                        

                                                                        <div class="clear_fix_both"></div>
                                                                        <br />    

                                                                        <input type="hidden" id="code_edit">


                                                                        <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_l_name" class="req">Properties Filename</label>
                                                                                <input  placeholder="Properties Filename" id="filename" name="filename"  class="form-control">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_m_name">Attribute</label>
                                                                                <input  placeholder="Attribute" id="Attribute" name="Attribute"  class="form-control">
                                                                            </div>
                                                                        </div>
                                                                        <div class="clear_fix_both"></div>
                                                                        <br />


                                                                        {*<div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_l_name" class="req">Customer Bare</label>
                                                                                <input  placeholder="Customer Bare" id="Customer" name="Customer"  class="form-control">
                                                                            </div>
                                                                        </div> 
                                                                      <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <label for="txt_m_name" class="req">Service Charge Value</label>
                                                                                <input  placeholder="Service Charge Value" id="service" name="service"  class="form-control">
                                                                            </div>
                                                                        </div>

                                                                        <div class="clear_fix_both"></div>
                                                                        <br />



                                                                        <div class="col-lg-6 p_l_n">
                                                                            <div>
                                                                                <input type="checkbox" id="flag" name="flag"  class="col-md-1"> <label for="txt_l_name" class='tp_2 fl'> &nbsp;&nbsp;Percentage Flag</label>

                                                                            </div>
                                                                        </div>  

                                                                        <div class="clear_fix_both"></div> *}

                                                                    </form>
                                                                </div>


                                                                <div class="clear_fix_both"></div>
                                                                <div class="clear_fix_both">                       
                                                                    <div class="alert fl suc_cre" style="display: none;" id="org-form-action-state"></div>
                                                                    <div class="align-right cre_sve" id="form-bttons">
                                                                        <input type="hidden" name="id_oz_code" id="id_oz_code" value="" />

                                                                        <button class="btn btn-success" type="button" onclick="saveCredential();">Save</button>
                                                                        <button class="btn btn-default" type="button" onclick="cancelOrganization();">Cancel</button>
                                                                    </div>
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

                                                        </div><!--panel Body end-->
                                                    </div><!--panel end-->

                                                </div>

                                            </div><!--row end-->
                                        </div><!--content end-->
                                    </div>
                                </div>
                            </div>

                        </div>


