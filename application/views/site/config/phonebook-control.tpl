<div class="brand_top">
    <h3>Phonebook Control</h3> 
    
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
                                    
                                    
                                    <div class="row">
                                        <div class="col-lg-12">
                                            
                                            <ul class="nav nav-tabs" id="tabs_a">
                                                <li class="active"><a data-toggle="tab" href="#time-control">Time Control</a></li>
                                                <li><a data-toggle="tab" id="active" href="#limit-control" >Limit Control</a></li>                                                
                                            </ul>
                                            
                                            <div class="tab-content" id="tabs_content_a">
                                                <div id="time-control" class="tab-pane fade in active">
                                                    
                                                    <div class="text-right">
                                                        <a href="javascript:;" class="btn btn-success btn-xs" onclick="openTimePolicyDialog();">New Time Control</a>
                                                    </div>
                                                    <br>
                                                    <table class="table table-hover">
                                                        <tr>
                                                            <th>Date Range</th>
                                                            <th>Days</th>
                                                            <th>Group</th>
                                                            <th>Open Days</th>
                                                            <th>Close before</th>
                                                            <th></th>
                                                        </tr>

                                                        {foreach item=row from=$pbc->data}
                                                        <tr id="pbc-{$row->code}">
                                                            <td>{$row->activeFrom|date_format:$ns_date_format} - {$row->activeTo|date_format:$ns_date_format}</td>
                                                            <td>
                                                                {if $row->dayOfWeek!=''}
                                                                {assign var=bday value=$row->dayOfWeek} 
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
                                                                {if $row->group->name==""}
                                                                    All Group
                                                                {else}
                                                                    {$row->group->name}
                                                                {/if}    
                                                            </td>
                                                            <td>
                                                                {assign var=t value=$row->allowMinutes/60}
                                                                {assign var=t1 value=$t/24}
                                                                {$t1} days before
                                                            </td>
                                                            <td> 
                                                                {math equation="floor(x/60)" x=$row->blockMinutes assign=hr}
                                                                {math equation="(x%60)" x=$row->blockMinutes assign=min}
                                                                {if $hr>0} {$hr} hours {/if}
                                                                {if $min>0}{$min} minutes {/if} before
                                                            </td>
                                                            <td align="center" width="10%">
                                                                <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="openTimePolicyDialog('{$row->code}')">
                                                                    <i class="fa fa-pencil fa-lg"></i>
                                                                </a>&nbsp;
                                                                <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deletePhoneBookPolicy('{$row->code}')">
                                                                    <i class="fa fa-trash-o fa-lg"></i>
                                                                </a>
                                                            </td> 
                                                        </tr>
                                                        {/foreach}

                                                        </table>
                                                </div>
                                                <div id="limit-control" class="tab-pane fade">
                                                    <div class="text-right">
                                                        <a href="javascript:;" class="btn btn-success btn-xs" onclick="openLimitPolicyDialog();">New Limit Control</a>
                                                    </div>
                                                    <br>
                                                    
                                                    <table class="table table-hover">
                                                    <tbody>  
                                                        <tr>
                                                            <th>Schedules</th>
                                                            <th>Routes</th>
                                                            <th>Date From</th>
                                                            <th>Date To</th>
                                                            <th>Day Of Week</th>
                                                            <th>Date Type</th>
                                                            <th>Calendar Mode</th>
                                                            <th>Calendar Type</th>
                                                            <th>Group / User</th>
                                                            <th>Allowed Seats</th>  
                                                            <th>Ticket Status</th>                                                          
                                                            <th>Actions</th>
                                                        </tr>

                                                        {foreach key=key from=$pbc_limit->data item=limit}
                                                        <tr class="slab-row" id="pbc-limit-{$limit->code}">
                                                            <td>
                                                                {if $limit->scheduleList|count >0}
                                                                    {foreach from=$limit->scheduleList item=sch key=i}
                                                                        {if $i == 0}
                                                                            {$sch->name}
                                                                        {else}
                                                                            {break}
                                                                        {/if}
                                                                    {/foreach}
                                                                    {if $limit->scheduleList|@count >1}
                                                                    <a href="javascript:;" data-toggle="popover" class="has-popover" data-content="
                                                                        {foreach from=$limit->scheduleList item=sch key=i}
                                                                            {$sch->name} <br/>
                                                                        {/foreach}
                                                                        "><span class="label label-success"> {$limit->scheduleList|count} </span></a>
                                                                    {/if}
                                                                {else}
                                                                    All Schedules
                                                                {/if}
                                                            </td>
                                                            <td>
                                                                {if $limit->routeList|count > 0}
                                                                    {foreach from=$limit->routeList item=routesList key=i}
                                                                        {if $i == 0}
                                                                            {$routesList->fromStation->name} - {$routesList->toStation->name}
                                                                        {else}
                                                                            {break}
                                                                        {/if}
                                                                    {/foreach}
                                                                    {if $limit->routeList|count > 1}
                                                                        <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                                                                        {foreach from=$limit->routeList item=routesList key=i}
                                                                            {$routesList->fromStation->name} - {$routesList->toStation->name} <br/>
                                                                        {/foreach}   
                                                                        "><span class="label label-success"> {$limit->routeList|count}</span></a>
                                                                    {/if}
                                                                {else}
                                                                    All Routes
                                                                {/if}
                                                            </td>
                                                            <td>{$limit->activeFrom}</td>
                                                            <td>{$limit->activeTo}</td>
                                                            <td>
                                                                {if $limit->dayOfWeek!=''}
                                                                <div class="btn-group btn-group-days-display">
                                                                    {assign var=sday value=$limit->dayOfWeek}        
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
                                                                {if $limit->dateType=="TRP"} 
                                                                    Travel Date
                                                                {else}
                                                                    Transaction Date
                                                                {/if}    
                                                            </td>
                                                            <td>{$limit->slabCalenderMode}</td>
                                                            <td>{$limit->slabCalenderType}</td>
                                                            <td>
                                                                {if $limit->refferenceType =='UR'} 
                                                                    {if $limit->user->code != ''} 
                                                                        {$limit->user->name}
                                                                    {else}  
                                                                        All Users
                                                                    {/if}
                                                                {else}
                                                                    {if $limit->group->code != ''} 
                                                                        {$limit->group->name}
                                                                    {else}  
                                                                        All Groups
                                                                    {/if}
                                                                {/if}    
                                                            </td>
                                                            <td>{$limit->maxSlabValueLimit}</td>
                                                            <td>{$limit->ticketStatus->name}</td>
                                                            <td>
                                                                <a href="javascript:;" onclick="openLimitPolicyDialog('{$limit->code}')" title="edit" class="btn btn-default btn-xs"><i class="fa fa fa-pencil"></i></a>
                                                                <a href="javascript:;" onclick="deletePhonebookLimitControl('{$limit->code}')" title="delete" class="btn btn-default btn-xs"><i class="fa fa fa-trash"></i></a>
                                                            </td>
                                                        </tr>    
                                                        {/foreach} 

                                                    </tbody>
                                                </table>
                                                    
                                                </div>
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


<div id="policy-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal ">
        
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_oz_name" class="req">Group</label>
                <select id="pbc_group" class="form-control col-md-6">
                    <option value="all">All Groups</option>
                    {foreach name=o item=row from=$groups}
                        <option value="{$row['code']}">{$row['name']}</option>
                    {/foreach}   
                </select>
            </div>
        </div>
                
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="pbc_date_range" class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="pbc_date_range" id="pbc_date_range" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                </div>
            </div>
        </div>
                
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="pbc-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="pbc-weekdays" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" value="1" name="pbc-weekdays">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc-weekdays" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc-weekdays" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="pbc-weekdays" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc-weekdays" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc-weekdays" value="1">S</label>
                </div> 
            </div>
        </div>
        
        
        
        
                               
        <div class="clear_fix_both"></div>
        <br />           
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Booking open from</label>
            <select id="pbc_open_day_booking" class="form-control">
                <option value="">Days</option>
                {for $d=1 to 90}
                    <option value="{$d*60*24}">{$d} day(s)</option>    
                {/for}   
            </select>
        </div>
                        
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Booking close before</label>
            <select id="pbc_close_hour_booking" class="form-control">
                <option value="">Hours</option>
                <option value="15">15 minutes</option>
                <option value="30">30 minutes</option>
                <option value="60">1 hour</option>
                <option value="90">1.30 hours</option>
                <option value="120">2 hours</option>
                <option value="150">2.30 hours</option>
                <option value="180">3 hours</option>
                <option value="210">3.30 hours</option>
                <option value="240">4 hours</option>
                <option value="270">4.30 hours</option>
                <option value="300">5 hours</option>
                <option value="330">5.30 hours</option>
                <option value="360">6 hours</option>
                <option value="390">6.30 hours</option>
                <option value="420">7 hours</option>
                <option value="450">7.30 hours</option>
                <option value="480">8 hours</option>
                <option value="510">8.30 hours</option>
                <option value="540">9 hours</option>
                <option value="570">9.30 hours</option>
                <option value="600">10 hours</option>
                <option value="630">10.30 hours</option>
                <option value="660">11 hours</option>
                <option value="690">11.30 hours</option>
                <option value="720">12 hours</option>
                <option value="1440">24 hours</option>
                <option value="2160">36 hours</option>
                <option value="2880">48 hours</option>
            </select>
        </div>
        
        <div class="clear_fix_both"></div>
    </form>
    <br>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="pbc-form-action-state"></div>
        <div class="align-right cre_sve" id="disc-form-buttons">
            <input type="hidden" name="pbc_code" id="pbc_code" value="" />
            <button class="btn btn-success" type="button" onclick="savePhoneBookTimeControl();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelPhoneBookTimeControlDialog();">Cancel</button>
        </div>
    </div> 
</div>
            
<div id="limit-policy-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal ">
        
        <div class="col-lg-4">
            <div class="form-group text-left">
                <label for="pbc_schedules" class="req">Schedules</label>
                <select id='pbc_schedules' class="form-control" multiple="multiple">
                    <option value="">All Schedules</option>
                    {foreach item=row from=$schedules}
                        <option value="{$row->code}">{$row->name}{if $row->serviceNumber != ''}&nbsp;-&nbsp;{$row->serviceNumber}{/if}</option>
                    {/foreach}   
                </select>  
            </div>
        </div>
        <div class="col-lg-4">
            <div class="form-group text-left">
                <label for="pbc_routes" class="req">Routes</label>
                <select id="pbc_routes" class="form-control" multiple="multiple">
                    <option value="">All Routes</option>
                    {foreach item=row from=$routes}
                        <option value="{$row->fromStation->code}-{$row->toStation->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="form-group text-left">
                <label for="pbc_tktstatus" class="req">Ticket status</label>
                <select id="pbc_tktstatus" class="form-control">
                    <option value="BO">Booked</option>
                    <option value="PBL">Phone Booked</option>
                </select>
            </div>
        </div>
        <div class="clear_fix_both"></div>
        
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_oz_name" class="req">Role</label>
                <select id="pbc_l_role" class="form-control col-md-6" onchange="setPBCrole(this.value)">
                    <option value="GR">Group</option>
                    <option value="UR">User</option>
                </select>
            </div>
        </div>
        <div class="col-lg-4 p_l_n">
            <div id="role-type-ur" style="display:none;">
                <label for="txt_oz_name" class="req">User</label>
                <select id="pbc_l_user" class="form-control col-md-6">
                    <option value="NA">All User</option>
                    {foreach name=o item=row from=$entity}
                        <optgroup label="{$row['groupname']}">
                            {foreach name=o item=usr from=$row["users"]}
                                <option value='{$usr->code}'>{$usr->name}</option>
                            {/foreach}
                        </optgroup>
                    {/foreach} 
                </select>
            </div>
            <div id="role-type-gr">
                <label for="txt_oz_name" class="req">Group</label>
                <select id="pbc_l_group" class="form-control col-md-6">
                    <option value="NA">All Groups</option>
                    {foreach name=o item=row from=$groups}
                        <option value="{$row['code']}">{$row['name']}</option>
                    {/foreach}   
                </select>
            </div>
        </div>
        
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="pbc_l_weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="pbc_l_weekdays" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" value="1" name="pbc_l_weekdays">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc_l_weekdays" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc_l_weekdays" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="pbc_l_weekdays" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc_l_weekdays" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="pbc_l_weekdays" value="1">S</label>
                </div> 
            </div>
        </div>
        
        <div class="clear_fix_both"></div>
        <br />    
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="pbc_date_range" class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="pbc_limit_date_range" id="pbc_limit_date_range" class="form-control" readonly="true" value="">
                </div>
            </div>
        </div>
                    
              
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Date Type</label>
            <select class="form-control" id="pbc_l_date_type">
                <option value="TRP">Travel Date</option>
                <option value="TXN">Transaction Type</option>                                                        
            </select>
        </div>
                        
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Calendar Interval</label>
            <select class="form-control" id="pbc_l_cal_interval">
                <option value="DAY" >Day</option>
                <option value="WEEK" >Week</option>
                <option value="MONTH" >Month</option>
            </select>
        </div>
        
        <div class="clear_fix_both"></div>
        <br />  
        
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Calender Type</label>
            <select class="form-control" id="pbc_l_cal_type">
                <option value="STRICT" >Strict</option> 
                <option value="FLEXI" >Flexi</option>                
            </select>
        </div> 
            
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name">Seat Count</label>
            <input type="text" placeholder="Seat Count" value="" maxlength="2" id="pbc_l_seat_count" class="form-control">
        </div>
        
        <div class="custom-control custom-checkbox col-lg-4 p_l_n">
            <label  for="rsflag">Respective Schedule Seat Count</label>
            <input type="checkbox" class="custom-control-input" id="rsflag">
        </div>
        
        <div class="clear_fix_both"></div>
    </form>
    <br>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="pbc-l-form-action-state"></div>
        <div class="align-right cre_sve" id="disc-l-form-buttons">
            <input type="hidden" name="pbc_limit_code" id="pbc_limit_code" value="" />
            <button class="btn btn-success" type="button" onclick="savePhoneBookLimitControl();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelPhoneBookLimitControlDialog();">Cancel</button>
        </div>
    </div> 
</div>
            
<script>
var pbc_time_policy = {$pbc->data|json_encode};
var pbc_limits = {$pbc_limit->data|json_encode}
</script>
{literal}                
<script>
    $('#pbc_date_range').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
    
    $('#pbc_limit_date_range').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
    $('#pbc_schedules').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default pbc_schedules',
        dropLeft: true
    });
    $('#pbc_routes').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        buttonClass: 'btn btn-default pbc_routes',
        dropLeft: true
    });
    $('.has-popover').popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });
    
    function setPBCrole(type) {
        $('#role-type-ur').hide();
        $('#role-type-gr').hide();
        
        if(type=='UR') {
            $('#role-type-ur').show();
        } else {
            $('#role-type-gr').show();
        }
    }
    
    function openLimitPolicyDialog(code) {        
        $('#limit-policy-dialog').css('background', '#fff'); 
        $('#limit-policy-dialog').removeClass('hide');
        $('#limit-policy-dialog').dialog({
             autoOpen: true,
             height: 450,
             width: 800,
             modal: true,
             resizable: false
         });
         $(".ui-dialog-titlebar").hide();
         
         $('#pbc_limit_date_range').val('');
         $('#pbc_l_seat_count').val('');
         $('#pbc_limit_code').val('');
         
        $('#pbc_schedules').val([]).multiselect('refresh');
        $('#pbc_routes').val([]).multiselect('refresh');
        $('#pbc_tktstatus').val('BO');
        $('#rsflag').prop("checked",false); 
         if(code!="" && pbc_limits != null) {
            $.each(pbc_limits, function (k, sval) {
                if (sval.code == code) {
                   
                    $('#pbc_limit_date_range').val(sval.activeFrom+' | '+sval.activeTo);
                    $('#pbc_l_role').val(sval.refferenceType);
                    
                    setPBCrole(sval.refferenceType);
                    
                    if(sval.refferenceType === 'UR') {
                        $('#pbc_l_user').val((sval.user) ? sval.user.code : '');
                    } else if(sval.refferenceType === 'GR'){
                        $('#pbc_l_group').val((sval.group) ? sval.group.code : '');
                    }
                    
                    
                    $('#pbc_l_date_type').val(sval.dateType);
                    $('#pbc_l_cal_interval').val(sval.slabCalenderType);

                    $('#pbc_l_cal_type').val(sval.slabCalenderMode);
                    $('#pbc_l_seat_count').val(sval.maxSlabValueLimit); 
                    
                    $('#pbc_limit_code').val(code);
                    if(sval.respectiveFlag == 1){
                        $('#rsflag').prop("checked",true);
                    }
                    else{
                        $('#rsflag').prop("checked",false);
                    }
                    var str = sval.dayOfWeek;
                    var res = str.split("");
                    $('#pbc_l_weekdays').find('.active').removeClass('active').removeAttr("checked");
                    $("input[name='pbc_l_weekdays']").each(function (i) {
                        if (res[i] == 1) {
                            $(this).attr("checked", "checked");//.addClass('active');
                            $(this).parent().addClass('active');
                        }
                    });
                    
                    var scheduleList = $.map(sval.scheduleList || [], function(val){
                        return val.code;
                    });
                    if(!sval.scheduleList.length) {
                        scheduleList = [''];
                    }
                    $('#pbc_schedules').val(scheduleList).multiselect('refresh');
                    
                    var routeList = $.map(sval.routeList || [], function(val){
                        return val.fromStation.code + '-' + val.toStation.code;
                    });
                    if(!sval.routeList.length) {
                        routeList = [''];
                    }
                    $('#pbc_routes').val(routeList).multiselect('refresh');
                    
                    $('#pbc_tktstatus').val(sval.ticketStatus.code);
                }
            });
        }
    }
    
    function cancelPhoneBookLimitControlDialog() {
        $('#limit-policy-dialog').dialog('destroy');
        $('#limit-policy-dialog').addClass('hide');
    }
    
    function openTimePolicyDialog(code) {
        
        if(code!="" && pbc_time_policy != null) {
            $.each(pbc_time_policy, function (k, sval) {
                if (sval.code == code) {
                    $('#pbc_date_range').val(sval.activeFrom+' | '+sval.activeTo);
                    if(_isdefined(sval.group.code)) {
                        $('#pbc_group').val(sval.group.code);
                    } else {
                        $('#pbc_group').val('all');
                    }
                    $('#pbc_open_day_booking').val(sval.allowMinutes);
                    $('#pbc_close_hour_booking').val(sval.blockMinutes);
                    $('#pbc_code').val(code);
                    
                    var str = sval.dayOfWeek;
                    var res = str.split("");
                    $('#pbc-weekdays').find('.active').removeClass('active').removeAttr("checked");
                    $("input[name='pbc-weekdays']").each(function (i) {
                        if (res[i] == 1) {
                            $(this).attr("checked", "checked");//.addClass('active');
                            $(this).parent().addClass('active');
                        }

                    });
            
                }
            });
        }
        
        $('#policy-dialog').css('background', '#fff'); 
        $('#policy-dialog').removeClass('hide');
        $('#policy-dialog').dialog({
             autoOpen: true,
             height: 400,
             width: 800,
             modal: true,
             resizable: false
         });
         $(".ui-dialog-titlebar").hide();
         $('#pbc_group').focus();
    }
    function cancelPhoneBookTimeControlDialog() {    
        $('#policy-dialog').dialog('destroy');
        $('#policy-dialog').addClass('hide');
    }
    
    function savePhoneBookLimitControl() {
        $('#pbc_limit_date_range, #pbc_l_seat_count').removeClass('inp_error');
        
        var data = {};
        data.role = $.trim( $('#pbc_l_role').val() );
        data.group = $.trim( $('#pbc_l_group').val() );
        data.user = $.trim( $('#pbc_l_user').val() );
        data.daterange = $.trim( $('#pbc_limit_date_range').val() );
        
        data.date_type = $.trim( $('#pbc_l_date_type').val() );
        data.cal_interval = $.trim( $('#pbc_l_cal_interval').val() );
        
        data.cal_type = $.trim( $('#pbc_l_cal_type').val() );
        data.seat_count = $.trim( $('#pbc_l_seat_count').val() );
        
        data.dayofweek = $("#pbc_l_weekdays label").map(function () {
            return +($(this).hasClass("active"));
        }).get();
        
        data.pbc_limit_code = $.trim( $('#pbc_limit_code').val() );
        
        data.scheduleList = $.map($('#pbc_schedules').val() || [], function(val) {
            return {code:val};
        });
        
        if($.inArray('', $('#pbc_schedules').val()) != -1) {
            data.scheduleList = [];
        }
        if($('#rsflag').prop("checked")){
            data.respectiveFlag = 1;
        }else{
            data.respectiveFlag = 0;
        }    
        data.routeList = $.map($('#pbc_routes').val() || [], function(val) {
            val = val.split('-');
            return { 
                fromStation: { code: val[0] },
                toStation: { code: val[1] }
            };
        });
        
        if($.inArray('', $('#pbc_routes').val()) != -1) {
            data.routeList = [];
        }        
        
        data.ticketStatus = {};
        data.ticketStatus.code = $('#pbc_tktstatus').val();
        
        var err = 0;
        
        if (data.daterange == '') {
            $('#pbc_limit_date_range').addClass('inp_error');
            err++;
        }
        
        if (data.seat_count != '' && parseInt(data.seat_count) < 0 ) {
            $('#pbc_l_seat_count').addClass('inp_error');
            err++;
        }
        if (data.seat_count == '') {
            data.seat_count = 0
        }
               
        if ($('#pbc_schedules').val() == null) {
            $('.pbc_schedules').addClass('inp_error');
            err++;
        }
        
        if ($('#pbc_routes').val() == null) {
            $('.pbc_routes').addClass('inp_error');
            err++;
        }

        
        if (err > 0) {
            $('#pbc-l-form-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#pbc-l-form-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#pbc-l-form-action-state').show();
            return false;
        } else {
            $('#pbc-l-form-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#pbc-l-form-action-state').hide();
        }

        $('#form-l-buttons').hide();
        $('#pbc-l-form-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#pbc-l-form-action-state').html(loading_popup);
        $('#pbc-l-form-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-phonebook-limit-policy",
            data: data,
            success: function(response) {

                if (response.status == 1) {
                    $('#pbc-l-form-action-state').removeClass('alert-danger');
                    $('#pbc-l-form-action-state').addClass('alert-success');
                    $('#pbc-l-form-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelPhoneBookLimitControlDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#pbc-l-form-action-state').addClass('alert-danger');
                    $('#pbc-l-form-action-state').html(response.errorDesc);
                    $('#form-l-buttons').show();
                }
            }
        });
    }
    
    function savePhoneBookTimeControl() {
        
        $('#pbc_group, #pbc_open_day_booking, #pbc_close_hour_booking, #pbc_date_range').removeClass('inp_error');
        
        var data = {};
        data.daterange = $.trim( $('#pbc_date_range').val() );
        data.group = $.trim( $('#pbc_group').val() );
        data.open_days = $.trim( $('#pbc_open_day_booking').val() );
        data.close_hours = $.trim( $('#pbc_close_hour_booking').val() );
        data.dayofweek = $("#pbc-weekdays label").map(function () {
            return +($(this).hasClass("active"));
        }).get();
        
        data.pbc_code = $.trim( $('#pbc_code').val() );
        
        var err = 0;
        
        if (data.daterange == '') {
            $('#pbc_date_range').addClass('inp_error');
            err++;
        }
        
        if (data.group == '') {
            $('#pbc_group').addClass('inp_error');
            err++;
        }

        if (data.open_days == '') {
            $('#pbc_open_day_booking').addClass('inp_error');
            err++;
        } 
        
        if (data.close_hours == '') {
            $('#pbc_close_hour_booking').addClass('inp_error');
            err++;
        } 

        
        if (err > 0) {
            $('#pbc-form-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#pbc-form-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#pbc-form-action-state').show();
            return false;
        } else {
            $('#pbc-form-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#pbc-form-action-state').hide();
        }

        $('#form-buttons').hide();
        $('#pbc-form-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#pbc-form-action-state').html(loading_popup);
        $('#pbc-form-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/save-phonebook-policy",
            data: data,
            success: function(response) {

                if (response.status == 1) {
                    $('#pbc-form-action-state').removeClass('alert-danger');
                    $('#pbc-form-action-state').addClass('alert-success');
                    $('#pbc-form-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function() {
                        cancelPhoneBookTimeControlDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#pbc-form-action-state').addClass('alert-error');
                    $('#pbc-form-action-state').html(response.errorDesc);
                    $('#form-buttons').show();
                }
            }
        })
    }
    
    function deletePhonebookLimitControl(code) {
        if (confirm('Do you want to delete this limit policy?')) {
            var data = {};

            data.code = code;

            var loading_overlay = iosOverlay({
                text: "Please wait...",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/delete-phonebook-limit-policy",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#pbc-limit-'+code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                            $(this).remove();
                        });
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });

                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            })
        }
    }
    
    function deletePhoneBookPolicy(code) {
        if (confirm('Do you want to delete this policy?')) {
            var data = {};

            data.code = code;

            var loading_overlay = iosOverlay({
                text: "Please wait...",
                icon: "fa fa-spinner fa-spin"
            });

            $.ajax({
                type: "POST",
                dataType: 'json',
                url: base_url + "config/delete-phonebook-policy",
                data: data,
                success: function (response) {
                    if (response.status == 1) {
                        $('#pbc-'+code).animate({backgroundColor: '#1AA1E1'}, 2000, function () {
                            $(this).remove();
                        });
                        loading_overlay.update({
                            icon: "fa fa-check",
                            text: "Success!"
                        });

                    } else {
                        loading_overlay.update({
                            icon: "fa fa-times",
                            text: "Sorry!"
                        });
                    }
                    window.setTimeout(function () {
                        loading_overlay.hide();
                    }, 2000);
                }
            })
        }
    }
</script>
{/literal}