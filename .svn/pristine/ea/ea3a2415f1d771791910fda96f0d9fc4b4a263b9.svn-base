<div class="brand_top">
    <h3>Extra Commission</h3> 
    <span class="align-rights">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="editCommission();">Add New Commission</a> &nbsp;      
        {if $action_rights['XTRA-COM-SLAB']>0}
        <a href="#config/extra-commission-slab" class="btn btn-success" > Slabs</a>
        {/if}
    </span>
</div>

<div id="main_wrapper">
    <div class="page_content" style="min-height:500px">
        <div id="container-fluid">
            <div class="row">
                <div style="clear: both;"></div><br>
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            
                            <table class="table table-design-topless">
                                <tbody>        
                                    {foreach key=key from=$extra item=sta}
                                        <tr class="del-station-sch-{$sta->code} {if count($sta->overrideList) > 0} trhover {/if}" onclick="viewCommissionExceptionOverride(event, '{$sta->code}')">
                                            <td class="bold">{$sta->name}</td>
                                            <td>
                                                {if $sta->group->name !=''} <i class="fa fa-users"></i> &nbsp; {$sta->group->name} {else if $sta->user->name !=''}<i class="fa fa-user"></i> &nbsp; {$sta->user->name}  {else}<i class="fa fa-users"></i> &nbsp;All Groups {/if}
                                            </td>
                                            <td>
                                                {if $sta->dateType == 'TXN'}Transaction Date{else}Travel Date{/if}
                                            </td>
                                            <td>
                                                {if $sta->commissionValueType->code == "PER"}
                                                    {$sta->commissionValue}&nbsp; %
                                                {else}
                                                    <i class="fa fa-rupee"></i>&nbsp;{$sta->commissionValue}
                                                {/if}
                                            </td>
                                            <td> {if $sta->activeFrom!='' &&  $sta->activeTo!=''}
                                                {$sta->activeFrom|date_format:$ns_date_format}&nbsp;&nbsp;to&nbsp;&nbsp;{$sta->activeTo|date_format:$ns_date_format}
                                                {/if}   
                                            </td>
                                            
                                            <td> 
                                                {if $sta->dayOfWeek!=''}
                                                <div class="btn-group btn-group-days-display">
                                                    {assign var=sday value=$sta->dayOfWeek}        
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:0:1==1}active{/if}">S</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:1:1==1}active{/if}">M</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:2:1==1}active{/if}">T</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:3:1==1}active{/if}">W</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:4:1==1}active{/if}">T</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:5:1==1}active{/if}">F</label>
                                                    <label class="btn btn-success-list btn-xs chk-btn {if $sday|substr:6 ==1}active{/if}">S</label>
                                                </div> 
                                                {/if}   
                                            </td>
                                            <td>
                                                <a href="javascript:;" data-code="{$sta->code}" class="xtr_more" data-toggle="popover" data-content="">more details</a>
                                            </td>
                                            <td>
                                                <a class="edit pTip_top" title="Edit extra commission" href="javascript:;" onclick='editCommission({$sta|@json_encode})'>
                                                    <i class="fa fa-pencil fa-lg"></i>
                                                </a>&nbsp;
                                                <a class="delete pTip_top" title="Delete extra commission" href="javascript:;" onclick='deleteCommission({$sta|@json_encode})'>
                                                    <i class="fa fa-trash-o fa-lg"></i>
                                                </a>&nbsp;
                                                <a class="delete pTip_top" title="Add exception / override" href="javascript:;" data-code='{$sta->code}' onclick="CommExceptionDialog('{$sta->code}')">
                                                    <i class="fa fa-exclamation-circle fa-lg"></i>
                                                </a>&nbsp;
                                            </td>
                                            </tr>
                                            {if count($sta->overrideList) > 0}
                                                <tr id="stationExcTab-{$sta->code}" style="display: none;" class="border_bottom"><td width="5%" class="bold">
                                                        <span style="color:red">Exception</span>
                                                    </td></tr>
                                                    {foreach key=key1 from=$sta->overrideList item=override}
                                                    <tr class="station-sch-ove-{$sta->code} sta-exp-ovr-lst-hide" style="display:none">
                                                        <td colspan="8">
                                                            <table class="table table table-design tab-wid-95">
                                                                <td width="25%" class="fn-wg-n">
                                                                    {$override->name}
                                                                </td>
                                                                <td width="16%" class="fn-wg-n">
                                                                   
                                                                </td>
                                                                <td width="13%" class="fn-wg-n">
                                                                </td>
                                                                <td width="12%" class="fn-wg-n">
                                                                </td>
                                                                <td width="15%" class="fn-wg-n">
                                                                     {$override->activeFrom|date_format:$ns_date_format} to {$override->activeTo|date_format:$ns_date_format}
                                                                </td>
                                                                <td width="15%" class="fn-wg-n">
                                                                    {if $sta->dayOfWeek!=''}
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
                                                                <td width="10%">
                                                                    <a class="edit pTip_top" title="Edit Exception" href="javascript:;" onclick="CommExceptionDialog('{$sta->code}', '{$override->code}', '{$override->name}', '{$override->activeFrom}', '{$override->activeTo}', '{$override->dayOfWeek}')">
                                                                        <i class="fa fa-pencil fa-lg"></i>
                                                                    </a>&nbsp;
                                                                    <a class="delete pTip_top" title="Delete Exception" href="javascript:;" onclick="deleteCommExceptionDialog('{$sta->code}', '{$override->code}')">
                                                                        <i class="fa fa-trash-o fa-lg"></i>
                                                                    </a></td>
                                                            </table></td>

                                                    </tr>             
                                                {/foreach}
                                            {/if}
                                            </tr>
                                            {/foreach}
                                                </tbody>
                                            </table></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="clear_fix_both"></div>

                    <div id="commission-dialog" class="hide dialog-content-page">
                        <div class="">
                            <form role="form" id="form1" class="form-horizontal ">


                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_oz_name" class="req">Name</label>
                                        <input  placeholder="Name" id="name" name="name"  class="form-control">
                                    </div>
                                </div>  
                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_m_name" >Schedule</label> 
                                        <select id="schedule" multiple="multiple" class="form-control">
                                            <option value="NA" >All Schedules</option>
                                            {foreach name=o item=row from=$schedules}
                                                <option value="{$row->code}">{$row->name} ({$row->serviceNumber})</option>
                                            {/foreach}   
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_m_name" >Route</label> 
                                        <select id="route" multiple="multiple" class="form-control">
                                            <option value="NA" >All Routes</option>
                                            {foreach name=o item=row from=$routes}
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/foreach}   
                                        </select>
                                    </div>
                                </div>        
                                
                                <div class="clear_fix_both"></div>
                                <br />   
                                <div class="col-lg-3 p_l_n">
                                    <div>
                                        <label for="txt_oz_name" >Min Seat Count</label>
                                        <input  placeholder="Min Seat Count" id="ec_min_seat_count" maxlength="2" name="name"  class="form-control">
                                    </div>
                                </div>     
                                
                                <div class="col-lg-3 p_l_n">
                                    <div>
                                        <label for="txt_oz_name" >Min Ticket Fare</label>
                                        <input  placeholder="Min Ticket Value" id="ec_min_ticket_fare" maxlength="4" name="name"  class="form-control">
                                    </div>
                                </div> 
                                
                                <div class="col-lg-3 p_l_n">
                                    <div>
                                        <label for="txt_oz_name">Max Commission Limit </label>
                                        <input  placeholder="Max Commission limit" id="max_comission_limit" maxlength="2" name="name"  class="form-control">
                                    </div>
                                </div> 
                                
                                <div class="col-lg-3 p_l_n">
                                    <div>
                                        <label for="txt_oz_name">Max Extra Commission Amount </label>
                                        <input  placeholder="Max Extra Commission Amount" id="max_xtr_comm_amt" maxlength="4" name="name"  class="form-control">
                                    </div>
                                </div>         
                                        
                                <div class="clear_fix_both"></div>
                                <br />
                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_oz_name" class="req">Active From & To</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                            <input type="text" name="date_comm" id="date_comm" class="form-control" readonly="true" value="">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_m_name" class="req">Date Type</label>
                                        <input type="radio" name="comm_date" id="comm_date" value="TXN" class="grp_radio" checked> Transaction Date &nbsp;
                                        <input type="radio" name="comm_date" id="comm_date" value="TRP" class="grp_radio"> Travel Date 
                                    </div>
                                </div>
                                
                                <div class="col-lg-4 p_l_n">
                                    <div>

                                        <label for="txt_m_name" class="req">Day of Week</label>
                                        <div class="btn-group btn-group-days" id="exp-weekdays" data-toggle="buttons">
                                            <label class="btn btn-success btn-xs chk-btn active">
                                                <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">S</label>
                                            <label class="btn btn-success btn-xs chk-btn active">
                                                <input type="checkbox" checked="checked" value="1" name="station-point-weeks-comm">M</label>
                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">T</label>
                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">W</label>
                                            <label class="btn btn-success btn-xs chk-btn active">
                                                <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">T</label>
                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">F</label>
                                            <label class="btn btn-success btn-xs chk-btn  active">
                                                <input type="checkbox" checked="checked" name="station-point-weeks-comm" value="1">S</label>
                                        </div> 
                                    </div>
                                </div>
                                
                                <div class="clear_fix_both"></div>
                                <br />    
                                
                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_m_name" class="req">Role Type</label>
                                        <select id="role" class="form-control col-md-6">
                                            <option value="GR">Group</option>
                                            <option value="UR">User</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="col-lg-4 p_l_n">
                                    <div>
                                        <label for="txt_m_name">&nbsp;</label>
                                        <span id="select">
                                            <select id="group" class="form-control col-md-6">
                                                <option value="all">All Groups</option>
                                                {foreach name=o item=row from=$groups}
                                                    <option value="{$row->code}">{$row->name}</option>
                                                {/foreach}
                                            </select>
                                        </span>
                                        <span id="select_usr" style="display:none">
                                            <select id="user" class="form-control col-md-6">
                                                <option value="">Select User</option>
                                                {foreach name=o item=row from=$users}
                                                    <option value="{$row->code}">{$row->name}</option>
                                                {/foreach} 
                                            </select>
                                        </span>

                                    </div>
                                </div>
                                
                                <div class="col-lg-3 p_l_n">
                                    <label for="txt_l_name" class="req">Commission Value</label>
                                    <input  placeholder="Commission Value" id="comm_value" name="comm_value"  class="form-control" value='1'>
                                </div>
                                <div class="col-lg-1 p_l_n">
                                    <label for="txt_l_name">&nbsp;</label>
                                    <input style="position:relative;top:5px" type="checkbox" id="disc_type" name="disc_type"> <span id="per" style="position:relative;top:5px">&nbsp;<b>%</b></span><span id="rs" style="display:none;position:relative;top:5px">&nbsp;<b><i class="fa fa-rupee"></i></b></span>
                                </div>       
                                            
                                
                                
                                <div class="clear_fix_both"></div>
                                <br />   
                                
                                <div class="col-lg-4 p_l_n {if $action_rights['XTRA-COM-SLAB']<=0} hide {/if}">
                                    <div>
                                        <label for="txt_oz_name" >Slab</label>
                                        <select id="slab_id" class="form-control">
                                            <option value="">Select a slab</option>
                                            {foreach name=o item=row from=$slabs}
                                                <option value="{$row->code}">{$row->name}</option>
                                            {/foreach} 
                                        </select>                                            
                                    </div>
                                </div>                                        
                                
                                <div class="col-lg-4 p_l_n">
                                    <label for="txt_oz_name" >&nbsp;</label>
                                    <label for="over-base-comm">
                                        <input type="checkbox" id="over-base-comm" name="over-base-comm">
                                        Override Base Commission
                                    </label>
                                </div>  
                                
                                <div class="col-lg-8 p_l_n" id="slab-preview">
                                   
                                </div> 
                                
                                
                            </form>
                        </div>
                        <div class="clear_fix_both"></div>
                        <br />

                        <div class="clear_fix_both"></div>
                        <div class="clear_fix_both">                       
                            <div class="alert fl suc_cre" style="display: none;" id="comm-form-action-state"></div>
                            <div class="align-right cre_sve" id="comm-form-bttons">
                                <input type="hidden" name="icode" id="code" value="" />

                                <button class="btn btn-success" type="button" onclick="saveCommission();">Save</button>
                                <button class="btn btn-default" type="button" onclick="cancelCommission();">Cancel</button>
                            </div>
                        </div> 
                    </div>


                    <!-- Exception Popup --> 


                    <div id="comm-exception-dialog" class="dialog-content-page" style="display: none">
                        <form role="form" id="basic-sch" class="form-horizontal">
                            <div class="clear_fix_both"></div><br />
                            <div class="form-group">
                                <label class="req col-md-3" for="basic_except_description">Name</label>
                                <div class="col-md-9">
                                    <input type="text" value="" id="comm_exp_disc_name" name="comm_exp_disc_name" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label  class="req col-md-3" for="exp-weekdays" class="req">Day of week</label>
                                <div class="col-md-5">
                                    <div class="btn-group btn-group-days" id="exp-disc-weekdays" data-toggle="buttons">
                                        <label class="btn btn-success btn-xs chk-btn active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">S</label>
                                        <label class="btn btn-success btn-xs chk-btn active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">M</label>
                                        <label class="btn btn-success btn-xs chk-btn  active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">T</label>
                                        <label class="btn btn-success btn-xs chk-btn  active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">W</label>
                                        <label class="btn btn-success btn-xs chk-btn active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">T</label>
                                        <label class="btn btn-success btn-xs chk-btn  active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">F</label>
                                        <label class="btn btn-success btn-xs chk-btn  active">
                                            <input type="checkbox" checked="checked" name="exp-week-comm" value="1">S</label>
                                    </div> 
                                </div>
                            </div>   
                            <div class="clear_fix_both"></div>
                            <div class="form-group">
                                <label class="col-md-3 req" for="basic_except" class="req">Date</label>
                                <div class="col-md-9"> 
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        <input type="text" name="comm_exp_disc_date" id="comm_exp_disc_date" class="form-control" readonly="true" value="">
                                    </div>
                                </div>
                            </div>


                            <div class="clear_fix_both"></div><br />
                            <input type="hidden" id="commission_code">
                            <input type="hidden" id="comm_exp_code">
                            <div class="alert fl suc_cre" style="display: none;" id="comm-exp-form-action-state"></div>
                            <div class="pull-right" id="comm-exp-form-buttons">
                                <button class="btn btn-success" type="button" onclick="saveCommissionException()">Save</button>
                                <button class="btn btn-default" type="button" onclick="cancelCommissionExceptionDialog();">Cancel</button>
                            </div>
                        </form>
                    </div>


                    <!-- exception ends -->



                </div><!--panel Body end-->
            </div><!--panel end-->

        </div>

    </div><!--row end-->
</div><!--content end-->
</div>


<script>
    var xtrlist = {$extra|json_encode};
    var slablist = {$slabs|json_encode};
    
    $('input[name="date_comm"],input[name="comm_exp_disc_date"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
    
    $(function() {

        $(".xtr_more").popover({
          placement : 'bottom', 
          html: 'true',
          trigger : "hover",
          content : function() {
                var c = $(this).attr('data-code');
                var html = '<table width="300">';
                $.each(xtrlist, function(keys, values) {
                    if (values.code == c) {

                        html += '<tr> <td width="65%">Max Commission Limit</td>    <td width="35%">'+values.maxCommissionLimit+'</td>';
                        html += '<tr> <td width="65%">Min Ticket Fare</td>    <td width="35%">'+values.minTicketFare+'</td>';
                        html += '<tr> <td width="65%">Max Extra Commission Amount</td>    <td width="35%">'+values.maxExtraCommissionAmount+'</td>';
                        html += '<tr> <td width="65%">Min Seat Count</td>    <td width="35%">'+values.minSeatCount+'</td>';                    
                        html += '<tr> <td width="65%">Override Base Commission</td>    <td width="35%">'+(values.overrideCommissionFlag == 1 ? 'Yes' : 'No')+'</td>';                    

                        if(_isdefined(values.commissionSlab)) {
                            html += '<tr> <td colspan="2" align="center" class="bold" >Slab Details</td>';
                            $.each(slablist, function(key, slab){
                                if (slab.code == values.commissionSlab.code) {
                                    html += '<tr> <td width="65%">Name</td>    <td width="35%">'+slab.name+'</td>';
                                    html += '<tr> <td width="65%">Calender Type</td>    <td width="35%">'+slab.slabCalenderType.code+'</td>';
                                    html += '<tr> <td width="65%">Calender Mode</td>    <td width="35%">'+slab.slabCalenderMode.name+'</td>';
                                    html += '<tr> <td width="65%">Slab Mode</td>    <td width="35%">'+slab.slabMode.name+'</td>';
                                    html += '<tr> <td width="65%">Slab From Value</td>    <td width="35%">'+slab.slabFromValue+'</td>';
                                    html += '<tr> <td width="65%">Slab To Value</td>    <td width="35%">'+slab.slabToValue+'</td>';
                                }
                            });
                        }
                    }
                });
                html += '</table>'; 
                return html;
            }    
        });
    
    }); 

</script>
