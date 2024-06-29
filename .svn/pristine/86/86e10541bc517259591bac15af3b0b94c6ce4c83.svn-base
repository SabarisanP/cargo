<div class="brand_top">
    <h3>Add / Edit Schedule</h3>
    <span class="align-right">
        <a {if $smarty.get.type == ''}href="#schedules"{else}href="#schedules?type={$smarty.get.type}"{/if} class="btn btn-success btn-sm">
            <i class="fa fa-arrow-left"></i>&nbsp;Back To Schedules
        </a>
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
                                    <div class="col-md-offset-1">

                                        <div class="panel-group col-md-11">

                                            <div class="clear_fix_both"></div>
                                            {if $smarty.request.c==1}
                                            <div class="alert alert-warning text-center">
                                                <i class="fa fa-info-circle"></i> Save As notes  <br>
                                                Review all the schedule details and click <span class="bold">"Finished"</span> button under "Booking" tab to open booking for this schedule.
                                            </div>
                                            {/if}
                                            <form  role="form" id="form1" class="form-horizontal" >
                                                <div id="wizard_form">
                                                    <h3>Basic</h3>
                                                    <section>

                                                        <div class="form-group">
                                                            <label class="col-md-2 control-label req" class="req">Name</label>
                                                            <div class="col-md-6">
                                                                <input type="text" class="form-control" id="name_sch" name="name_sch" data-parsley-required="true" value="{$schedules[0]->name}">
                                                                <span id="sch_tmp_code">Code : {$schedules[0]->code}</span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="col-md-2 control-label req" for="date_sch" class="req">Date</label>
                                                            <div class="col-md-6"> 
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                    <input type="text" name="date_sch" id="date_sch" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                                                                </div>
                                                                <div class="input-group hide" style="padding-top:5px" id="adv-book-link">
                                                                    <div class="alert alert-danger">
                                                                        Sorry! Advance bookings available after the choosed end date. 
                                                                        <a href="javascript:;" onclick="getScheduleAdvanceBookingGraph('{$schedules[0]->code}', '{$schedules[0]->name}')" style="color:#fff; text-decoration: underline;" >View Advance Booking</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <label  class="col-md-2 control-label" for="display_sch">Display name</label>
                                                            <div class="col-md-6"><input type="text" class="form-control" id="display_sch" maxlength="120" name="display_sch" data-parsley-required="true" value="{$schedules[0]->displayName}"></div>
                                                        </div>
                                                        
                                                        <div class="form-group">
                                                            <label  class="col-md-2 control-label" for="service_sch">Service Number</label>
                                                            <div class="col-md-2">  <input type="text" class="form-control" id="service_sch" maxlength="25" name="service_sch" data-parsley-required="true" value="{$schedules[0]->serviceNumber}"></div>
                                                            
                                                            <label  class="col-md-1 control-label req" for="service_tax">GST</label>
                                                            <div class="col-md-3"> 
                                                                <select id="tax" class="form-control" value="{$schedules[0]->tax->code}">
                                                                    <option value="">Select a apllicable GST</option>
                                                                    <option {if $schedules[0]->tax->code==0} selected="selected" {/if} value="NA" >No GST</option>
                                                                    {foreach from=$taxlist item=tm}
                                                                        <option value="{$tm->code}" {if $schedules[0]->tax->code==$tm->code} selected="selected" {/if} >{$tm->name} / CGST : {$tm->cgstValue}% / SGST : {$tm->sgstValue}% / UGST : {$tm->ugstValue}%</option>
                                                                    {/foreach}
                                                                </select>
                                                                <div class="input-group hide">
                                                                    <span class="input-group-addon"> % </span>
                                                                    <input type="text" class="form-control" id="service_tax" name="service_tax"  value="{if $schedules[0]->serviceTax!='' }{$schedules[0]->serviceTax}{else}0.0{/if}">
                                                                </div>
                                                                
                                                            </div>
                                                        </div>
                                                        
                                                        
                                                                
                                                        
                                                        <a href="javascript:;" id="toggle-l" class="pTip_top" alt="Add additional details" data-title="Add additional details"><i class="fa fa-plus"></i>&nbsp;Additional Details</a>


                                                        <div class="clear_fix_both"></div>

                                                        <div class="col-md-offset-2">
                                                            <div class="toggle-list">
                                                                <div class="form-group"> 
                                                                    <div class="col-md-3">
                                                                        <label  class="req" for="wizard_fname">API Display Name</label>
                                                                        <input type="text" class="form-control" id="API_dn" name="API_dn" data-parsley-required="true" value="{if $schedules[0]->apiDisplayName!='' }{$schedules[0]->apiDisplayName}{else}{$profile->apiDisplayName}{/if}">
                                                                    </div>   
                                                                    <div class="col-md-3">
                                                                        <label for="wizard_fname">Category</label>                                                                         
                                                                        <input type="text" class="form-control" id="RTB_tag" name="RTB_tag" value="{$schedules[0]->category->name}">
                                                                        <input type="hidden" class="form-control" id="RTB_tag_code" name="RTB_tag_code" value="{$schedules[0]->category->code}">
                                                                    </div>
                                                                    
                                                                    <div class="col-md-3">
                                                                        <label  class="req" for="wizard_fname" class="req">Report time before</label>
                                                                        <input type="text" class="form-control" id="RTB_sch" name="RTB_sch" data-parsley-required="true" value="{if $schedules[0]->boardingReportingMinitues!='' }{$schedules[0]->boardingReportingMinitues}{else}{$profile->boardingReportingMinitues}{/if}">
                                                                    </div>
                                                                </div>
                                                                
                                                                <div class="form-group">
                                                                    <div class="col-md-6">
                                                                        <label for="taglist_sch">Tags</label>                                                                        
                                                                        <select id="sch-basic-tag" multiple class="form-control" onchange="ua_record(3);">
                                                                            {foreach item=tag from=$taglist}
                                                                                <option {if $busbasictags[$tag->code]}selected="selected"{/if} value="{$tag->code}">{$tag->name}</option>
                                                                            {/foreach}
                                                                        </select>                                                                        
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <label {if $action_rights['USR-APLY-SECTOR']==1}class="req"{/if} for="wizard_fname">Sector</label>
                                                                        <select id="sch-basic-sector" multiple class="form-control"></select>
                                                                        <input type="hidden" id="sch-basic-sector-val" data-value="{$schedules[0]->sectorList|json_encode|escape}"/>
                                                                    </div>
                                                                </div>    
                                                                    
                                                                <div class="form-group">
                                                                    <div class="col-md-3">
                                                                        <label  class="req" for="wizard_fname" class="req">PNR start code</label>
                                                                        <input type="text" class="form-control" id="PNR_sch" name="PNR_sch" data-parsley-required="true" value="{if $schedules[0]->pnrStartCode!='' }{$schedules[0]->pnrStartCode}{else}{$profile->pnrStartCode}{/if}">
                                                                    </div>

                                                                    <div class="col-md-3">
                                                                        <label  class="req" for="wizard_fname" class="req">Day of week</label>
                                                                        {if $schedules[0]->code==""}
                                                                            {assign var=day value='1111111'}
                                                                        {else}
                                                                            {assign var=day value=$schedules[0]->dayOfWeek}
                                                                        {/if}
                                                                        <div class="btn-group btn-group-days" id="weekdays" data-toggle="buttons">
                                                                            <label class="btn btn-success btn-xs chk-btn {if $day|substr:0:1==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:0:1==1}checked="checked"{/if} name="week" value="1">S</label>
                                                                            <label class="btn btn-success btn-xs chk-btn {if $day|substr:1:1==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:1:1==1}checked="checked"{/if} name="week" value="1">M</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  {if $day|substr:2:1==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:2:1==1}checked="checked"{/if} name="week" value="1">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  {if $day|substr:3:1==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:3:1==1}checked="checked"{/if} name="week" value="1">W</label>
                                                                            <label class="btn btn-success btn-xs chk-btn {if $day|substr:4:1==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:4:1==1}checked="checked"{/if} name="week" value="1">T</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  {if $day|substr:5:1==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:5:1==1}checked="checked"{/if} name="week" value="1">F</label>
                                                                            <label class="btn btn-success btn-xs chk-btn  {if $day|substr:6==1}active{/if}">
                                                                                <input type="checkbox" {if $day|substr:6==1}checked="checked"{/if} name="week" value="1">S</label>
                                                                        </div> 
                                                                    </div>
                                                                    
                                                                </div>
                                                            </div>
                                                        </div>  
                                                        <br />
                                                        {if $schedules[0]->code!=''}
                                                            <a href="javascript:;" alt="Add exception" onclick="basicExceptionDialog()" title="Add exception"><i class="fa fa-plus"></i>&nbsp;Add Exception</a>
                                                        {/if}
                                                        
                                                        <div id="load_exp">
                                                        {if count($schedules[0]->overrideList) > 0 }

                                                            <table class="table table-hover table-design" id='schedules-exeption-list' width="50%">
                                                                <tr>
                                                                    <th>
                                                                        From
                                                                    </th>
                                                                    <th>
                                                                        To
                                                                    </th>
                                                                    <th>Day of Week</th>
                                                                    <th>

                                                                    </th>
                                                                </tr>
                                                                {foreach item=sclp from=$schedules[0]->overrideList}
                                                                    <tr class="sch-lok-{$sclp->code}">
                                                                        <td>{$sclp->activeFrom}</td>
                                                                        <td>{$sclp->activeTo}</td>
                                                                        <td>
                                                                            {if $sclp->dayOfWeek!=''}
                                                                                {assign var=bday value=$sclp->dayOfWeek} 
                                                                                <div class="btn-group btn-group-days-display">
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                                                                    <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                                                                                </div> 
                                                                            {/if} 
                                                                        </td>
                                                                        <td>
                                                                            <a href="javascript:;" class="pTip_top" data-date='{$sclp->activeFrom} | {$sclp->activeTo}' data-days='{$sclp->dayOfWeek}' title="Edit exception" onclick="basicExceptionDialog('{$sclp->code}', this)">
                                                                                <i class="fa fa-pencil"></i>
                                                                            </a>
                                                                            <a href="javascript:;" class="pTip_top sch-exp-del" data-datef='{$sclp->activeFrom}' data-datet='{$sclp->activeTo}' data-days='{$sclp->dayOfWeek}' title="Delete exception" onclick="deleteBasicException('{$sclp->code}',this)">
                                                                                <i class="fa fa-trash-o"></i>
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                {/foreach} 
                                                            </table>

                                                        {/if}
                                                    </div>
                                                    </section>
                                                    <h3>Station</h3>
                                                    <section class="min_h_300">                                                            
                                                        <div id="station-schedules-list" class="col-md-11 col-md-offset-0"></div>


                                                    </section>
                                                    <h3>Bus</h3>
                                                    <section>
                                                        <div class="min_h_300 col-md-offset-1">
                                                            <div class="row">
                                                                <div class="col-lg-7">
                                                                    <label for="amenities" class="req">Amenities</label>
                                                                    <select id="amenities" multiple class="form-control amenities ov_fl_height" onchange="ua_record(2);">
                                                                    {foreach item=amt from=$amenities}
                                                                        <option {if count($busamenities) > 0 }{if  in_array($amt->code, $busamenities)}selected="selected"{/if}{/if} value="{$amt->code}">{$amt->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                                </div>
                                                            </div>
                                                            <br>                                                            
                                                            <div class="row">
                                                                <div class="col-lg-7">
                                                                    <label for="bustype" class="req">Bus Type</label>
                                                                    <select id="bustype" class="form-control" onChange="getSeatVisiblitySchedulesByselect(); ua_record(2);" {if $schedules[0]->code!='' && $busschedule[0]->bus->code!=""} style="display:none;" disabled="disabled"{/if}>
                                                                        <option value=""></option>
                                                                        {foreach name=b_type item=bus from=$buses}
                                                                            {if $busschedule[0]->bus->code==$bus['code']}
                                                                                {assign var=c_bus_type value="`$bus['name']` - ( `$bus['seatCount']` - seats ) - `$bus['code']`"}
                                                                            {/if}    
                                                                            <option {if $busschedule[0]->bus->code==$bus['code']}selected="selected"{/if} value="{$bus['code']}">{$bus['name']} - ({$bus['seatCount']} - seats) - {$bus['code']} </option>
                                                                        {/foreach}
                                                                    </select>
                                                                    
                                                                    {if $schedules[0]->code!='' && $busschedule[0]->bus->code!=""}  
                                                                    <div class="" style="margin-top:15px;" id="change_bus_link">
                                                                        <div class="well well-sm text-center">
                                                                            <span class="bold"> {$c_bus_type} </span> - <a title="Please make sure there is no advanced booking available to change bus type." href="javascript:;" onclick="changeBusType()" >edit bus type?</a>                                                                            
                                                                        </div>                                                                        
                                                                    </div>
                                                                    {/if}
                                                                </div>
                                                                
                                                            </div>
                                                            
                                                            <div class="row hide">
                                                                <div class="col-lg-7">
                                                                    <div id="bustype_change_action">Validating...</div>
                                                                </div>
                                                            </div>        
                                                                    
                                                            <div class="row">
                                                                <div class="col-lg-7">
                                                                    <div id="dynamic-seat"></div>
                                                                </div>
                                                            </div>  
                                                            
                                                            
                                                            {if $busschedule[0]->code!=''}
                                                                {*    <a href="javascript:;" alt="Add bus exception" onclick="busExceptionDialog()" title="Add bus exception"><i class="fa fa-plus"></i>&nbsp;Add Exception</a>*}
                                                            {/if}

                                                            <input type="hidden" value="{$busschedule[0]->code}" name='bus-sch-code'  id='bus-sch-code' />
                                                        </div>
                                                    </section>
                                                    <h3>Route & Fare</h3>
                                                    <section  class="min_h_300">
                                                        <div id="rout-list" class="col-md-offset-1"></div>
                                                    </section>
                                                    <h3>Cancellation</h3>
                                                    <section  class="min_h_300">
                                                        <div id="cancel-list" class="col-md-offset-1 "></div>
                                                    </section>
                                                    <!--<h3>Seat Visiblity</h3>
                                                    <section class="min_h_300">
                                                        <div class="col-md-offset-1 hide">
                                                            <label class="col-md-1 req p_l_n" for="bus">Bus</label>

                                                            <div class="col-md-4 p_l_n">
                                                                <select id='bus-type-sch-seat' class='form-control'>
                                                                    <option value=''></option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div id="seat-vis-list" class=""></div>
                                                    </section>-->
                                                    <h3>Booking</h3>
                                                    <section  class="min_h_300">
                                                        <div id="booking-list" class=""></div>
                                                    </section>                                                    
                                                    
                                                </div>
                                                <input type="hidden" name="activeFlag" id="activeFlag" value="{$schedules[0]->activeFlag}" />
                                                <input type="hidden" name="sch_code" id="sch_code" value="{$schedules[0]->code}" />                                               
                                            </form>


                                            <div id="basic-schedule-dialog" class="dialog-content-page" style="display: none">
                                                <form role="form" id="basic-sch" class="form-horizontal">
                                                    <div class="clear_fix_both"></div><br />
                                                    <div class="form-group">
                                                        <label class="req col-md-3" for="basic_except_description">Description</label>
                                                        <div class="col-md-9">
                                                            <textarea id="basic_except_description" class="rs_no form-control"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label  class="req col-md-3" for="exp-weekdays-exp" class="req">Day of week</label>
                                                        <div class="col-md-5">
                                                            <div class="btn-group btn-group-days" id="exp-weekdays-exp" data-toggle="buttons">
                                                                <label class="btn btn-success btn-xs chk-btn active">
                                                                    <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">S</label>
                                                                <label class="btn btn-success btn-xs chk-btn active">
                                                                    <input type="checkbox" checked="checked"  name="exp-weeks-exp" value="1">M</label>
                                                                <label class="btn btn-success btn-xs chk-btn  active">
                                                                    <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">T</label>
                                                                <label class="btn btn-success btn-xs chk-btn  active">
                                                                    <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">W</label>
                                                                <label class="btn btn-success btn-xs chk-btn active">
                                                                    <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">T</label>
                                                                <label class="btn btn-success btn-xs chk-btn  active">
                                                                    <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">F</label>
                                                                <label class="btn btn-success btn-xs chk-btn  active">
                                                                    <input type="checkbox" checked="checked" name="exp-weeks-exp" value="1">S</label>
                                                            </div> 
                                                        </div>
                                                    </div>   
                                                    <div class="clear_fix_both"></div><br />
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label req" for="basic_except" class="req">Date</label>
                                                        <div class="col-md-9"> 
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                <input type="text" name="basic_except" id="basic_except" class="form-control" readonly="true" value="">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    

                                                    <div class="clear_fix_both"></div><br />
                                                    <div class="pull-left" id="basic-except-sch-loading"></div>
                                                    <input type="hidden" id="sc-exp-code" value="" />
                                                    <div class="pull-right" id="basic-except-sch-button">
                                                        <button class="btn btn-success" type="button" onclick="saveBasicException()">Save</button>
                                                        <button class="btn btn-default" type="button" onclick="cancelBasicExceptionDialog();">Cancel</button>
                                                    </div>
                                                </form>
                                            </div>

                                            <div id="bus-schedule-dialog" class="dialog-content-page" style="display: none">
                                                <form role="form" id="bus-sch" class="form-horizontal">
                                                    <div class="form-group">
                                                        <label class="col-md-3 req" for="bus_except" class="req">Date</label>
                                                        <div class="col-md-9">
                                                            <select id="bus-except-type" class="form-control">
                                                                <option value=""></option>
                                                                {foreach name=b_type item=bus from=$buses}
                                                                    {if $busschedule[0]->bus->code!=$bus['code']}
                                                                        <option {if $busschedule[0]->bus->lookup->code==$bus['code']}selected="selected"{/if} value="{$bus['code']}">{$bus['name']} - ({$bus['seatCount']} - seats) </option>
                                                                    {/if}
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 req" for="bus_except" class="req">Date</label>
                                                        <div class="col-md-9"> 
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                                <input type="text" name="bus-exp-date" id="bus_exp-date" class="form-control" readonly="true" value="{if $busschedule[0]->bus->lookup->activeFrom!='' && $busschedule[0]->bus->lookup->activeTo!='' }{$busschedule[0]->bus->lookup->activeFrom} | {$busschedule[0]->bus->lookup->activeTo}{/if}">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="clear_fix_both"></div><br />

                                                    <div class="clear_fix_both"></div><br />
                                                    <div class="pull-left" id="bus-except-sch-loading"></div>
                                                    <div class="pull-right" id="bus-except-sch-button">
                                                        <button class="btn btn-success" type="button" onclick="saveBusException()">Save</button>
                                                        <button class="btn btn-default" type="button" onclick="cancelBusExceptionDialog();">Cancel</button>
                                                    </div>
                                                </form>
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
{*<div class="hide" id="sch-adv-book-graph" style="background-color: #fff;">
    <div class="">
        <div class="pull-right"> 
            <a title="close" href="javascript:;" class="btn-lg" onclick="closeAdvBookPopup()"> <i class="fa fa-times-circle fa-lg"></i> </a>
        </div>
        <div class="pull-left bold" id="trip-setting-head"> 
            Advance Booking Summary
        </div>
    </div>
        
    <div class="clearfix">&nbsp;</div> <br>
    
    <div id="sch-adv-book-graph-loader"></div>
</div>*}
<script  type="text/template" id="station-template">
    <div class="col-md-2 st_nme"></div>
    <div class="col-md-2 st_tie"></div>
    <div class="col-md-2">
    <input type="hidden" class="st-sd-c" name="station-sched-code" id="station-sched-code" value="" />
    <input type="hidden" class="st-sd-t" name="station-sched-time" id="station-sched-time" value="" />
    <a href="javascript:;" title="Edit" class="edit"><i class="fa fa-pencil"></i>&nbsp;</a>&nbsp;
    <a href="javascript:;" title="Add Station Points" class="add"><i class="fa fa-plus"></i>&nbsp;</a>&nbsp;
    <a href="javascript:;" title="Delete" class="delete"><i class="fa fa-trash-o"></i>&nbsp;</a>
    </div>
    <div class="clear_fix_both"></div>
    <div class="col-md-offset-1 stp">

    </div>
</script>
<script  type="text/template" id="station-point-template">
    <div class="row">
    <div class="col-md-2 st-p-n"></div>
    <div class="col-md-2 st-p-t"></div>
    <a href="javascript:;" title="Edit" class="edit"><i class="fa fa-pencil"></i>&nbsp;</a>&nbsp;
    <a href="javascript:;" title="Delete" class="delete"><i class="fa fa-trash-o"></i>&nbsp;</a>
    </div>
    </div>

</script>
<script  type="text/template" id="schedules-exp-template">
    <tr class="">
    <td class="sch-fdate"></td>
    <td class="sch-tdate"></td>
    <td>         
        <div class="btn-group btn-group-days-display">
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
        </div>    
    </td>
    <td>
    <a href="javascript:;" class="pTip_top edt-e-lop"  title="Edit exception" onclick="basicExceptionDialog()">
    <i class="fa fa-pencil"></i>
    </a>
    <a href="javascript:;" class="pTip_top sch-exp-del" title="Delete exception" onclick="deleteBasicException()">
    <i class="fa fa-trash-o"></i>
    </a>
    </td>
    </tr>
</script>
<script>
    function _init_schedule_wizard() {
        init_schedule_wizard();
    }
</script>
 <script>
 	var bustype ={$buses|json_encode}
 	var busseattype = {$seattype|json_encode}       
        var taglist = {$taglist|json_encode}
 </script>
 {literal}
 <script>

     $(document).ready(function() {
    
         var lay = 0;
    
         var type = new Array();
         $.each(busseattype, function(key, vals) {
            type[vals.code] = vals.name;
         });
    
         /*$.each(bustype, function(keys, values) {
         $.each(values.buslayers, function(key1, bval) {
    
         $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).addClass('seat-select').addClass('p_tool').attr('data-toggle', 'popover').attr('data-container', 'body');
         $('#lay' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
    
         $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).addClass('seat-select').addClass('p_tool').attr('data-toggle', 'popover').attr('data-container', 'body');
         $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos + '-' + values.code).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
    
    	//data-placement="top" data-title="A Title" data-trigger="hover"
         $('[data-toggle=popover]').popover({
         container: "body",
         html: true
         });
    
         if (bval.layer == 2) {
         lay = 1;
         }
         });
         if (lay == 0) {
         $('#l2-' + values.code).hide();
         $('#lyr-' + values.code).html('1');
         lay = 0;
         } else {
         $('#lyr-' + values.code).html('2');
         }
         }); */
         $('.p_tool').powerTip({placement: 's'});
     });

 </script>
 {/literal}
