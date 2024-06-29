{if $action_rights['SCH-DISCOUNT']==1}
<span class="align-right"><a href="javascript:;" class="btn btn-success  btn-sm" onclick="showDiscountDialog()">Add Discount</a></span>
{/if}

<br><br><br>

{if $discount|@count > 0}
    <table class="table table-design tab-wid-100">
        <tr style="border-bottom: 1px dashed #000000">
            <!--<td align="center" width="10%" class="bold">Name</td>-->
            <td align="center" width="20%" class="bold">Date Range</td>            
            <td align="center" width="20%" class="bold">Group</td> 
            <td align="center" width="20%" class="bold" >Device Medium</td>
            <td align="center" width="10%" class="bold">Discount</td>
            <td align="center" width="20%" class="bold" >Days</td>
            <td align="center" width="10%"> </td
        </tr> 



        {foreach key=key from=$discount item=disc}
            <tr  class="del-station-sch-{$disc->code}"  >
                <td colspan="6" width="100%">
                    <table class="table table table-design tab-wid-100">
                        <!--<td align="center" width="10%" >
                            {$disc->name}
                        </td> -->
                        <td align="left" width="20%">
                            {$disc->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$disc->activeTo|date_format:$ns_date_format}
                            <br>
                            <span class="text-muted">
                            {if $disc->dateType == 'TXN'}
                                Transaction Date
                            {else}
                                Travel Date
                            {/if}
                            </span>
                        </td >                       
                        <td align="left" width="20%">
                            <i class="fa fa-users"></i> &nbsp;{if $disc->group->name==''}All Group{else}{$disc->group->name}{/if}
                            <br>
                            <span class="text-muted">
                                {if $disc->authenticationType->code=="ALL" || $disc->authenticationType->code==""}
                                    All Users
                                {else if $disc->authenticationType->code=="ARU"}
                                    Registred Users Only
                                {/if}
                            </span>
                        </td>
                         <td align="center" width="20%">
                            {if $disc->deviceMedium->code=="ALL" || $disc->deviceMedium->code==""}
                                All Medium
                            {else if $disc->deviceMedium->code=="WEB"}
                                Website
                            {else if $disc->deviceMedium->code=="MOB"}
                                Mobile Website
                            {else if $disc->deviceMedium->code=="APP"}
                                Mobile APP
                            {/if}
                        </td>
                        
                        <td align="center" width="10%">
                            {if $disc->percentageFlag == 1}
                                {$disc->discountValue}&nbsp;%
                            {else}
                                <i class="fa fa-rupee"></i>&nbsp;{$disc->discountValue}
                            {/if}
                            
                        </td>
                        <td align="center" width="20%" >
                            {if $disc->dayOfWeek!=''}
                                {assign var=bday value=$disc->dayOfWeek} 
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
                        <td align="center" width="10%">
                            
                            {if $action_rights['SCH-DISCOUNT']==1}
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showDiscountDialog('{$disc->code}', '{$disc->name}', '{$disc->discountValue}', '{$disc->percentageFlag}', '{$disc->group->code}', '{$disc->dateType}', '{$disc->activeFrom}', '{$disc->activeTo}', '{$disc->dayOfWeek}', '{$disc->deviceMedium->code}', '{$disc->authenticationType->code}')">
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            {/if}
                            
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteScheduleDiscount('{$disc->code}')">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Add exception" href="javascript:;" onclick="ExceptionDialog('{$disc->code}')">
                                <i class="fa fa-exclamation-circle fa-lg"></i>
                            </a>
                        </td> 
            </tr>   
            {if count($disc->overrideList) > 0}
                <tr>
                    <td class="bold text-danger" colspan="8">
                        Exception
                    </td>
                </tr>
                {foreach key=key1 from=$disc->overrideList item=override}                                 
                    <tr>
                        <!--<td align="center" width="10%" class="fn-wg-n">
                            {$override->name}
                        </td> -->
                        <td align="center" width="20%" class="fn-wg-n">
                            {$override->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$override->activeTo|date_format:$ns_date_format}
                        </td>                                                
                        <td width="20%" class="fn-wg-n">
                        </td>
                        <td width="20%" class="fn-wg-n">
                        </td> 
                        <td width="10%" class="fn-wg-n">
                        </td>                                              
                        <td align="center" width="20%" class="fn-wg-n">
                            {if $disc->dayOfWeek!=''}
                                {assign var=bday value=$override->dayOfWeek} 
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
                        <td align="center" width="10%">
                            <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="ExceptionDialog('{$disc->code}', '{$override->code}', '{$override->name}', '{$override->activeFrom}', '{$override->activeTo}', '{$override->dayOfWeek}')">
                                <i class="fa fa-pencil fa-lg"></i>
                            </a>&nbsp;
                            <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteDiscountException('{$disc->code}', '{$override->code}')">
                                <i class="fa fa-trash-o fa-lg"></i>
                            </a>
                        </td>
                    </tr>
                {/foreach}
            {/if}
        </table>
        <hr style="border-bottom: dashed 1px;margin-top:auto" /> 
        </td>
</tr>


{/foreach}
{else}
    <div class="well well-large "> No discounts found!</div>
{/if}


<!-- Discount Popup -->

<div id="discount-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Name</label>
                <input  placeholder="Name" id="name" name="name"  class="form-control">
            </div>
        </div>
        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="exp-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="station-point-weeks" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" value="1" name="station-point-weeks">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="station-point-weeks" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="station-point-weeks" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="station-point-weeks" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="station-point-weeks" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="station-point-weeks" value="1">S</label>
                </div> 
            </div>
        </div>

        <div class="clear_fix_both"></div>
        <br />

        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_oz_name" class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="date_disc" id="date_disc" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                </div>
            </div>
        </div>  

        <div class="col-lg-6 p_l_n">
            <div>
                <label for="txt_oz_name" class="req">Group</label>
                <select id="group" class="form-control col-md-6">
                    <option value="all">All Groups</option>
                    {foreach name=o item=row from=$groups}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}   
                </select>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        <br />           
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Discount Value</label>
            <input  placeholder="Discount Value" id="disc_value" name="disc_value"  class="form-control">
        </div>
        <div class="col-lg-2 p_l_n">
            <label for="txt_l_name">&nbsp;</label>
            <input style="position:relative;top:5px" type="checkbox" id="disc_type" name="disc_type"> <span style="position:relative;top:5px">&nbsp;<b>%</b></span>
        </div>
        <div class="col-lg-6 p_l_n">
            <label for="txt_l_name" class="req">Date Type</label>
            <input type="radio" name="disc_data" id="disc_data" value="TXN" class="grp_radio" checked> Transaction Date &nbsp;
            <input type="radio" name="disc_data" id="disc_data" value="TRP" class="grp_radio"> Travel Date 
        </div>
        
        <div class="clear_fix_both"></div>
        <br />           
        <div class="col-lg-6 p_l_n">
            <label for="txt_l_name" class="req">Device Medium</label>
            <select id="dis_device_medium" class="form-control col-md-6">
                <option value="ALL">All</option>
                <option value="WEB">Website</option>
                <option value="MOB">Mobile Website</option>
                <option value="APP">Mobile APP</option>
            </select>
        </div>
        
        <div class="col-lg-6 p_l_n">
            <label for="txt_l_name" class="req">User Type</label>
            <select id="dis_user_type" class="form-control col-md-6">
                <option value="ALL">All User</option>
                <!--<option value="GUEST">Guest Only</option>-->
                <option value="ARU">Registered Only</option>
            </select> 
        </div>

        <div class="clear_fix_both"></div>
    </form>
    <br>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="disc-form-action-state"></div>
        <div class="align-right cre_sve" id="disc-form-buttons">
            <input type="hidden" name="discount_code" id="discount_code" value="" />
            <button class="btn btn-success" type="button" onclick="saveDiscount();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelDiscountDialog();">Cancel</button>
        </div>
    </div> 
</div>

<!-- Exception Popup --> 


<div id="exception-dialog" class="dialog-content-page" style="display: none">
    <form role="form" id="basic-sch" class="form-horizontal">
        <div class="clear_fix_both"></div><br />
        <div class="form-group">
            <label class="req col-md-3" for="basic_except_description">Name</label>
            <div class="col-md-9">
                <input type="text" value="" id="exp_disc_name" name="exp_disc_name" class="form-control">
            </div>
        </div>
        <div class="clear_fix_both"></div>
<br>
        <div class="form-group">
            <label  class="req col-md-3" for="exp-weekdays" class="req">Day of week</label>
            <div class="col-md-5">
                <div class="btn-group btn-group-days" id="exp-disc-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="exp-week" value="1">S</label>
                </div> 
            </div>
        </div>   
        <div class="clear_fix_both"></div>
<br>
        <div class="clear_fix_both"></div>
        <div class="form-group">
            <label class="col-md-3 req" for="basic_except" class="req">Date</label>
            <div class="col-md-9"> 
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="exp_disc_date" id="exp_disc_date" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>


        <div class="clear_fix_both"></div><br />
        <input type="hidden" id="exp_code">
        <div class="alert fl suc_cre" style="display: none;" id="exp-form-action-state"></div>
        <div class="pull-right" id="exp-form-buttons">
            <button class="btn btn-success" type="button" onclick="saveDiscountException()">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelExceptionDialog();">Cancel</button>
        </div>
    </form>
</div>


<!-- exception ends -->


<script>
    $('input[name="date_disc"],input[name="exp_disc_date"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
</script>
