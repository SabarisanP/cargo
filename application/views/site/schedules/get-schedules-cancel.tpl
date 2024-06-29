<div class="col-md-9">
    <div class='cancel-schedules-list'>
        {foreach item=row from=$cancellationTerm}
            <div class="panel panel-info" id="cancel-{$row->code}">
                <div class="panel-heading pos_rel" style="background:none repeat scroll 0 0 #4fbeba;color:white">
                    <h3 class="panel-title"> 
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapse-{$row->code}"><span class="col-md-4"><i class="fa fa-list"></i>&nbsp;{$row->cancellationTerm->name}</span><span class="m-l-90"><i class="fa fa-users grp-seat"></i>&nbsp;{if $row->group->name!=""}{$row->group->name}{else} All Group{/if}</span></a>
                        <div id="sta_can" class="btn-group btn-group-xs btn-acc" >
                            <a href="javascript:;" title="Delete" class="btn btn-default btn-sm del" onclick="deleteCancelschedules('{$row->code}', '{$row->cancellationTerm->code}')"><i class="fa fa-trash-o ired"></i></a>
                            <a href="javascript:;" title="Add exception" class="btn btn-default btn-sm del" onclick="CancelExceptionschedules('{$row->code}', '{$row->group->code}')"><i class="fa fa-exclamation-circle"></i></a>
                        </div>
                    </h3>
                </div>  
                         <!--<li>Between {$f} {$p} {if $terms->toValue!=0}- {$t} {$p}{/if} - {$ds} % Deducation</li>--> 
                <div id="collapse-{$row->code}" class="panel-collapse collapse">
                    <div class="panel-body"> 

                        <ul class="list-unstyled">
                            {assign var='pp' value=''}
                            {foreach item=terms name=x from=$policyList[$row->cancellationTerm->code]}
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
                        {if count($row->overrideList) > 0}
                            <div class="pull-left"><span class="text-danger"> Override List </span></div>
                            <table class="table ">
                                {foreach item=crw from=$row->overrideList}
                                    <tr class="cnl-ovr-del-{$crw->code}">
                                        <td>{$crw->activeFrom}&nbsp;&nbsp;to&nbsp;&nbsp;{$crw->activeTo} </td>
                                        <td>
                                            {if $crw->dayOfWeek!=''}
                                                <div class="btn-group btn-group-days-display">
                                                    {assign var=sxday value=$crw->dayOfWeek}        
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:0:1==1}active{/if}">S</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:1:1==1}active{/if}">M</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:2:1==1}active{/if}">T</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:3:1==1}active{/if}">W</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:4:1==1}active{/if}">T</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:5:1==1}active{/if}">F</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sxday|substr:6 ==1}active{/if}">S</label>
                                                </div> 
                                            {/if}   
                                        </td>
                                        <td>{$crw->cancellationTerm->name}</td>
                                        <td> 
                                            <a href="javascript:;" title='View override' class="btn btn btn-default btn-xs" onclick="viewCancelOvr('{$crw->code}')"><i class="fa fa-folder-open "></i></a>
                                            &nbsp;
                                            <a href="javascript:;" title='Delete override' class="btn btn btn-default btn-xs" onclick="deleteCancelOvr('{$crw->code}', '{$row->code}')"><i class="fa fa-trash-o ired"></i></a>
                                        </td>
                                    </tr>
                                    <tr class="cnl-ovr-{$crw->code} cnl-ovr-del-{$crw->code} cnl-ovr-hide">
                                        <td colspan="4"> <div class="col-xs-offset-1"><ul class="list-unstyled">
                                                    {assign var='pp' value=''}
                                                    {foreach item=terms name=x from=$policyList[$crw->cancellationTerm->code]}

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
                                                </ul></div></td></tr>
                                            {/foreach}    
                            </table>
                        {/if}
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
    <br />
    <div id="sta_can">
        <a  href="javascript:;" class="pTip_top" title="Add new policy" id="toggle-1"><i class="fa fa-plus"></i>&nbsp;Add Policy</a>
        <div class="clear_fix_both"></div>
        <br /></div>
    <div class="hgt-50">
        <div class="toggle-cancel-list box_content">
            <form role="form" class="form-horizontal">
                <div class="pull-left">

                    <select id="cancel-schedules" class="form-control">
                        <option value="">Select Policy</option>
                        {foreach item=row from=$cancel} 
                            <option value="{$row->code}">{$row->name}</option>
                        {/foreach}
                    </select>

                </div>&nbsp;&nbsp;
                <div class="col-md-1"></div>
                <div class="pull-left">

                    <select id="cancel-group-schedules" class="form-control">
                        <option value="">All Group</option>
                        {foreach item=row from=$groups} 
                            {if $row['name']!='' && $row['name']!='code'}
                                <option value="{$row['code']}">{$row['name']}</option>
                            {/if} 
                        {/foreach}
                    </select>

                </div>
                &nbsp;&nbsp;
                <div class="pull-left"> &nbsp;&nbsp;</div>
                <div class="pull-left m-t-5">

                    <button class="btn btn-success btn-xs" type="button" onclick="savePolicyFareSchedules()"><i class="fa fa-plus"></i>&nbsp;Add</button>

                </div>
            </form>
            <div class="clear_fix_both"></div>
        </div>
    </div>
</div>

<div id="cancel-override-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="bus-sch" class="form-horizontal">
        <div class="form-group">
            <label class='req col-md-3' for="group">Policy</label>
            <div class="col-md-9"> 
                <select id="cancel-ovr-scl" class="form-control">
                    <option value="">Select Policy</option>
                    {foreach item=row from=$cancel} 
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class='req col-md-3' for="group">Group</label>
            <div class="col-md-9"> 
                <select id="cal-group-ovr" class="form-control" disabled >
                    <option value="" selected="selected">All Group</option>
                    {foreach item=row from=$groups} 
                        {if $row['name']!='' && $row['name']!='code'}
                            <option value="{$row['code']}">{$row['name']}</option>
                        {/if}
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="col-md-3 req" class="req">Date</label>
            <div class="col-md-9"> 
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="cancel-exp-date" id="cancel-exp-date" class="form-control" readonly="true" value="{if $busschedule[0]->bus->lookup->activeFrom!='' && $busschedule[0]->bus->lookup->activeTo!='' }{$busschedule[0]->bus->lookup->activeFrom} | {$busschedule[0]->bus->lookup->activeTo}{/if}">
                </div>
            </div>
        </div>
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label  class="req col-md-3" >Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="cnl-ovr-week-days" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn">
                        <input type="checkbox" name="cnl-ovr-week" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn">
                        <input type="checkbox" name="cnl-ovr-week" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn ">
                        <input type="checkbox" name="cnl-ovr-week" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn ">
                        <input type="checkbox" name="cnl-ovr-week" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn">
                        <input type="checkbox" name="cnl-ovr-week" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn">
                        <input type="checkbox" name="cnl-ovr-week" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn">
                        <input type="checkbox" name="cnl-ovr-week" value="1">S</label>
                </div> 
            </div>
        </div> 
        <div class="clear_fix_both"></div><br />

        <input type="hidden" name="can-ovr-code" id="can-ovr-code" value="" />
        <div class="pull-left" id="cnl-ovr-sch-loading"></div>
        <div class="pull-right" id="bus-except-sch-button">
            <button class="btn btn-success" type="button" onclick="saveCancelException()">Save</button>
            <button class="btn btn-default" type="button" onclick="closeCancelExceptionschedules();">Cancel</button>
        </div>
    </form>
</div>

<script>
    //$('.pTip_top').powerTip({ placement: 'n' });
    $('input[name="cancel-exp-date"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | '
    });
    $('.cnl-ovr-hide').hide();
</script>    
