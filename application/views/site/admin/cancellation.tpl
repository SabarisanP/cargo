<div class="brand_top"><h3>Cancellation Policy</h3> <span class="align-right">{if $action_rights['CTERMS-ADD']>0}<a href="javascript:;" class="btn btn-success  btn-sm" {if $action_rights['CTERMS-ADD']!=2}onclick="cancellation();"{/if}>Add New Policy</a>{/if}</span></div>
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
                                        <div class="panel-group" id="accordion">
                                            <div class="panel panel-info hide" id="min-dm">
                                                <div class="panel-heading">
                                                    <h3 class="panel-title"> 
                                                        <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-"></a>
                                                        <div class="btn-group btn-group-xs ac_bu">
                                                            <a href="javascript:;" class="btn btn-default btn-sm est" onclick="editStatus_cancellations()" data-status="1"><i class="fa fa-times"  title="Click to disable"></i></a>
                                                            <a href="javascript:;" title="edit" class="btn btn-default btn-sm edat" onclick='cancellation()'><i class="fa fa fa-pencil igreen"></i></a>
                                                            <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" onclick="delete_cancellations()"><i class="fa fa-trash-o ired"></i></a>
                                                        </div>
                                                    </h3>    
                                                </div>  
                                                <div id="" class="panel-collapse collapse ac_bo">
                                                    <div class="panel-body"> 

                                                        <ul class="list-unstyled">
                                                            <li></li>
                                                        </ul>
                                                    </div>
                                                </div>             
                                            </div>

                                            {if count($cancel) > 0}
                                                {foreach item=row from=$cancel} 

                                                    <div class="panel panel-info" id="min-{$row->code}">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title"> 
                                                                <a class="accordion-toggle ac_but" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}">{$row->name} </a>
                                                                <div class="btn-group btn-group-xs ac_bu">
                                                                    {if $action_rights['CTERMS-DISABLE']>0}  <a href="javascript:;" class="btn btn-default btn-sm est" {if $action_rights['CTERMS-DISABLE']!=2}onclick="editStatus_cancellations('{$row->code}', '{$row->name}', this)"{/if} data-status="{$row->activeFlag}">{if $row->activeFlag==1}<i class="fa fa-times" title="Click to disable"></i>{else}<i class="fa fa-check" title="Click to enable"></i>{/if}</a>{/if}
                                                                    {if $action_rights['CTERMS-EDIT']>0}  <a href="javascript:;" title="edit" {if $row->activeFlag==0}style='display:none'{/if} id='cl_edt_{$row->code}' class="btn btn-default btn-sm edat" {if $action_rights['CTERMS-EDIT']!=2}onclick='cancellation({$row|@json_encode})'{/if}><i class="fa fa fa-pencil igreen"></i></a>{/if}
                                                                    {if $action_rights['CTERMS-DELETE']>0}  <a href="javascript:;" title="delete" class="btn btn-default btn-sm del" {if $action_rights['CTERMS-DELETE']!=2}onclick="delete_cancellations('{$row->code}', '{$row->name}')"{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
                                                                </div>
                                                            </h3>
                                                        </div>  
                                                        <div id="collapse-{$row->code}" class="panel-collapse collapse">
                                                            <div class="panel-body"> 

                                                                <ul class="list-unstyled">
                                                                    {assign var='pp' value=''}
                                                                    {foreach item=terms name=x from=$row->policyList}
                                                                        {assign var='p' value=$terms->policyPattern}
                                                                        {assign var='f' value=$terms->fromValue}
                                                                        {assign var='ds' value=$terms->deductionAmount}
                                                                        {if $terms->fromValue < 1440 && $terms->fromValue > 60}
                                                                            {$f = ($terms->fromValue/60)|round}

                                                                        {else if $terms->fromValue >= 1440}
                                                                            {$f = ($terms->fromValue/(24*60))|round}
                                                                        {/if}
                                                                        {assign var='t' value=$terms->toValue}
                                                                        {if $terms->toValue < 1440 && $terms->toValue > 60}
                                                                            {$t = ($terms->toValue/60)|round}
                                                                            {$p = "hour"}
                                                                        {else if $terms->toValue >= 1440}
                                                                            {$t = ($terms->toValue/(24*60))|round}
                                                                            {$p = "days"}
                                                                        {else if $terms->toValue==0}
                                                                            {$t = ""}
                                                                            {$ds = "ANY TIME"}
                                                                        {/if}

                                                                        {if $pp==""} {assign var='pp' value=$p} {/if}
                                                                        {if $ds==-1}
                                                                            <li>Between {$f} {$pp} {if $terms->toValue!=0}- {$t} {$p}{/if}No Cancellation</li> 
                                                                        {else if $ds=='ANY TIME'}
                                                                            <li>Between {$f} {$pp} {if $terms->toValue!=0}- {$t} {$p}{/if} - {$ds} {$terms->deductionAmount}% Deduction</li>
                                                                        {else if $ds==0}
                                                                            <li>Between {$f} {$pp} {if $terms->toValue!=0}- {$t} {$p}{/if} No Deduction</li> 
                                                                        {else}
                                                                            <li>Between {$f} {$pp} {if $terms->toValue!=0}- {$t} {$p}{/if} - {$ds} % Deduction</li> 
                                                                        {/if}
                                                                        {assign var='pp' value=$p}
                                                                    {/foreach} 
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach} 
                                            {else}
                                                <div class="well well-large ">No Cancelation policy found!</div>
                                            {/if}
                                        </div>
                                    </div>
                                    <div class="clear_fix_both"></div>

                                    <div id="pg-cancel-dialog" class="hide dialog-content-page">
                                        <form role="form" id="form1" class="form-horizontal ">
                                            <div class="form-group col-sm-7">
                                                <div>
                                                    <input type="text" placeholder="Cancellation policy name" id="txt_cp_name" name="txt_cp_name"  class="form-control">
                                                </div>
                                            </div>           
                                            <div class="form-group col-md-7 b_r">
                                                <div class="table-responsive ov_fl">
                                                    <table class="table table-striped" id="tbl_list">
                                                        <tr class="tr_st">
                                                            <td class="frm_val"><input type="text" name="fm_val" value="0" disabled="true" class="form-control" /></td>
                                                            <td class="to_val"><input type="text" name="to_val" value="" class="form-control"/></td>
                                                            <td class="plc_val col-md-3">
                                                                <select id="pol_1" name="ps_tye" class="form-control col-md-6">
                                                                    {foreach item=ps from=$policy}
                                                                        <option value="{$ps}">{$ps}</option>
                                                                    {/foreach} 
                                                                </select>
                                                            </td>
                                                            <td class="amt_val"><input type="text" name="amt_val" value="" class="form-control"/></td>
                                                            <td class="rs_val">
                                                                <div class="form-group col-md-1">
                                                                    <label for="chk_rs1" class="checkbox-inline"> 
                                                                        <input type="checkbox" name="chk_amt" value="1" checked="checked">
                                                                        %</label> 
                                                                </div>
                                                            </td>
                                                            <td class="rm_val"></td>
                                                        </tr>
                                                        <tr id="tr_default">
                                                            <td class="frm_val">
                                                                <input type="text" name="ay_fm_val" value="0" disabled="true" class="form-control" />
                                                            </td>
                                                            <td class="to_val" colspan="2">
                                                                <input type="text" name="ay_to_val" value="ANY TIME" disabled="true" class="form-control"/>
                                                                <input type="hidden" name="ay_ps_tye" value="days" class="form-control"/>
                                                            </td>
                                                            <td class="amt_val"><input type="text" name="ay_amt_val" value="" class="form-control"/></td>
                                                            <td class="rs_val">
                                                                <div class="form-group  col-md-1">
                                                                    <label for="chk_rs1" class="checkbox-inline"> 
                                                                        <input type="checkbox" name="ay_chk_amt" value="1" checked="checked">
                                                                        %</label>
                                                                </div>
                                                            </td>
                                                            <td></td>

                                                        </tr>

                                                        <tr id="tr_clone" class="hide">
                                                            <td class="frm_val"><input type="text" name="fm_val"  value="0" disabled="true" class="form-control su_ds" /></td>
                                                            <td class="to_val"><input type="text" name="to_val" value="" class="form-control su_ds"/></td>
                                                            <td class="plc_val col-md-3">
                                                                <select id="pol_1" name="ps_tye" class="form-control col-md-6 su_ds">
                                                                    {foreach item=ps from=$policy}
                                                                        <option value="{$ps}">{$ps}</option>
                                                                    {/foreach} 
                                                                </select>
                                                            </td>
                                                            <td class="amt_val"><input type="text" name="amt_val" value="" class="form-control su_ds"/></td>
                                                            <td class="rs_val">
                                                                <div class="form-group col-md-1">
                                                                    <label for="chk_rs1" class="checkbox-inline"> <input type="checkbox" name="chk_amt" value="1" class="su_ds" checked="checked">
                                                                        %</label>
                                                                </div>
                                                            </td>
                                                            <td class="rm_val"><a href="javascript:;" class="btn btn-sm btn-default tr_remove"><i class="fa fa-times"></i></a></td>
                                                        </tr>
                                                    </table>

                                                </div>
                                                <button class="btn btn-success" style="margin:10px auto auto 200px" type="button" onclick="preview();">Preview</button>&nbsp;<a href="javascript:;" class="btn btn-sm btn-primary" style="margin-top:10px " id="tr_add_btn">Add Policy</a>

                                                <div><p > Note : -1 - No cancellation</p></div>
                                            </div>                     
                                        </form>

                                        <div class="col-md-5" id="pr_viw">
                                            <span class="">Click "Preview" button to get preview of this policy.</span>
                                        </div>                          

                                        <div class="clear_fix_both"></div>
                                        <div class="clear_fix_both">                       
                                            <div class="alert fl" style="display: none;" id="cnl-form-action-state"></div>
                                            <div class="align-right" style="margin: 10px auto 10px" id="form-bttons">
                                                <input type="hidden" name="hid_cn_code" id="hid_cn_code" value="" />
                                                <input type="hidden" name="hid_active_Flag" id="hid_active_Flag" value="1" />

                                                <button class="btn btn-success" type="button" onclick="saveCancel();">Save</button>
                                                <button class="btn btn-default" type="button" onclick="cancelEdit();">Cancel</button>
                                            </div>
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
