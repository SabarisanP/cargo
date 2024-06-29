<div>
    <span class="pull-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" title="Add new Bus Override" onclick="toggleBusOverride();">Add Bus Type Override</a>
    </span>
    <span class="pull-left">
        <span class="bold">Change bus layout for certain days.</span>
    </span>
</div>
<div class="clear_fix_both"></div><br/>

<div class="box_content toggle-bus-override" style="display:none">
    <div class="col-md-5 p_l_n">
        <div class="col-md-7">
            <label class="req" for="sch-bus-over-date" class="req">Date Range</label>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                <input type="text" name="sch-bus-over-date" id="sch-bus-over-date" class="form-control" readonly="true" value="">
            </div>
        </div>
        <div class="col-md-5">
            <label class="req">Day of week</label>
            <div class="btn-group btn-group-days" id="sch-bus-over-day" data-toggle="buttons">
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">S</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">M</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">T</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">W</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">T</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">F</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="sch-bus-over-day" value="1">S</label>
            </div>
        </div>
        <div class="clear_fix_both"></div><br>
        <div class="col-lg-11">
            <label for="sch-bus-over-type" class="req">Bus Type</label>
            <select id="sch-bus-over-type" class="form-control" onchange="loadBusPreview();">
                <option value="">Select a Bus Type</option>
                {foreach name=b_type item=bus from=$buses}
                    <option value="{$bus->code}">{$bus->name} - ({$bus->seatCount} - seats) - {$bus->code} </option>
                {/foreach}
            </select>
            <span class="help-block"> <i class="fa fa-info-circle"> </i> &nbsp; Upon changing bus type, kindly migrate all the booked seats to new bus layout to avoid duplicate booking.</span>
        </div>
        <div class="clear_fix_both"></div><br>
        <div class="col-md-11">
            <div class="alert" id="sch-bus-over-action" style="display: none;"></div>
        </div>        
        <div class="clear_fix_both"></div>
        <div class="col-md-5 col-md-offset-6 text-right">
            <input type="hidden" id="sch-bus-over-code">
            <button  type="button" class="btn btn-success" onclick="saveBusTypeOverride();">Save</button>
            <button  type="button" class="btn btn-default" onclick="clearBusTypeOverride();">&nbsp;Clear</button>
        </div>
    </div>
    <div class="col-lg-7" id="sch-bus-over-seat-map"></div> 
    <div class="clear_fix_both"></div>
</div>
<div class="clear_fix_both"></div><br/>

<div class="col-md-12" >
    <table class="table" width="100%">
        <tr>
            <th width="1%" align="center"></th>
            <th width="15%" align="center">Date Range</th>
            <th width="15%"align="center" >Days</th>
            <th width="25%"align="center" >Bus Type</th>
            <th width="7%"align="center"></th>
        </tr>
        {foreach key=key from=$result item=row}
            <tr {if count($row->overrideList) > 0} class="trhover" onclick="viewBusTypeException('{$row->code}');"{/if}>
                <td>{if count($row->overrideList) > 0}<span class="caret"></span>{/if}</td>
                <td>{$row->activeFrom|date_format:$ns_date_format} - {$row->activeTo|date_format:$ns_date_format}</td>
                <td>
                    {if $row->dayOfWeek!=''}
                        {assign var=bday value=$row->dayOfWeek} 
                        <div class="btn-group btn-group-days-display">
                            {if $bday|substr:0:1==1 && $bday|substr:1:1==1 && $bday|substr:2:1==1 && $bday|substr:3:1==1 && $bday|substr:4:1==1 && $bday|substr:5:1==1 && $bday|substr:6 ==1}All Days
                            {else}
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                            {/if}
                        </div> 
                    {/if}
                </td>
                <td>{$row->bus->name} - ({$row->bus->seatCount} - seats) - {$row->bus->code}</td>
                <td align="right">
                    <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="toggleBusOverride('{$row->code}');">
                        <i class="fa fa-pencil fa-lg"></i>
                    </a>&nbsp;
                    <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteBusOverride('{$row->code}');">
                        <i class="fa fa-trash-o fa-lg"></i>
                    </a>&nbsp;
                    <a href="javascript:;" title="Add Exception" onclick="busOverrideException('{$row->code}');">
                        <i class="fa fa-exclamation-circle fa-lg"></i>
                    </a>&nbsp;
                </td>
            </tr>
            {foreach from=$row->overrideList item=ovr}
                <tr class="{$row->code} exp-list" style="display:none">
                    <td colspan="2" class="text-center text-danger">Exception List</td>
                    <td nowrap="nowrap">
                        {$ovr->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$ovr->activeTo|date_format:$ns_date_format}
                    </td>
                    <td>
                        {if $ovr->dayOfWeek!=''}
                            {assign var=bday value=$ovr->dayOfWeek} 
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
                    <td colspan="4" nowrap="nowrap">
                        <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="busOverrideException('{$row->code}','{$ovr->code}');">
                            <i class="fa fa-pencil fa-lg"></i>
                        </a>&nbsp;
                        <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteBusTypeException('{$row->code}','{$ovr->code}');">
                            <i class="fa fa-trash-o fa-lg"></i>
                        </a>&nbsp;
                    </td>
                </tr>
            {/foreach}
        {/foreach}
    </table>
</div>
        
<div id="bus-type-over-exp" class="dialog-content-page hide">
    <div class="row pf_15">
        <div class="col-lg-6"> 
            <div class="form-group">
                <label for="bus-type-exp-date" class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                    <input type="text" name="bus-type-exp-date" id="bus-type-exp-date" class="form-control" readonly="true" value="">
                </div>  
            </div>
        </div>  
        <div class="col-lg-6">     
            <div class="form-group">
                <label for="bus-type-exp-day" class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="bus-type-exp-day" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">M</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="bus-type-exp-day" value="1">S</label>
                </div>
            </div>
        </div>        

        <div class="row pf_15">
            <div class="clear_fix_both">                       
                <div class="alert fl suc_cre" style="display: none;" id="bus-type-exp-action"></div>
                <div class="clear_fix_both"></div>
                <div class="align-right cre_sve" id="bus-type-exp-buttons">
                    <input type="hidden" id="bus-type-ovr-code">
                    <input type="hidden" id="bus-type-exp-code">
                    <button class="btn btn-success" type="button" onclick="saveBusTypeException();">Save</button>
                    <button class="btn btn-default" type="button" onclick="cancelBusTypeException();">Cancel</button>
                </div>
            </div> 
        </div>
    </div>            
</div> 

<script>
    var sch_bus_type_override = {$result|json_encode};
    $('#sch-bus-over-date,#bus-type-exp-date').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
</script>