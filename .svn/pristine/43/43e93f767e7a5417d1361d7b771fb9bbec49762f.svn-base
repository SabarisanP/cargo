<div class="brand_top">
    <h3>Offline Discount</h3> 
    <span class="align-right">
        <a href="javascript:;" class="btn btn-success  btn-sm" onclick="showOfflineDiscountDialog('');">Add New Rule</a> &nbsp;      
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
                            <table class="table table-design tab-wid-100">
                            {if $discounts|@count > 0}
                                <tr style="border-bottom: 1px dashed #000000">
                                    <td align="center" width="10%" class="bold">Name</td>
                                    <td align="center" width="10%" class="bold">Date Range</td>            
                                    <td align="center" width="10%" class="bold">Group</td> 
                                    <td align="center" width="5%" class="bold">Discount</td>
                                    <td align="center" width="5%" class="bold">Min Seats</td>
                                    <td align="center" width="10%" class="bold">Max Discount</td>
                                    <td align="center" width="5%" class="bold">Min Fare</td>
                                    <td align="center" width="5%" class="bold">Schedules</td>
                                    <td align="center" width="5%" class="bold">Routes</td>
                                    <td align="center" width="10%" class="bold">Days</td>
                                    <td align="center" width="10%"> </td
                                </tr>
                                
                                {foreach key=key from=$discounts item=disc}
                                <tr  class=""  >
                                    
                                            <td align="left">
                                                {$disc->name}
                                            </td> 
                                            <td align="left">
                                                {$disc->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$disc->activeTo|date_format:$ns_date_format}
                                                <br>
                                                <span class="text-muted">
                                                {if $disc->travelDateFlag == false}
                                                    Transaction Date
                                                {else}
                                                    Travel Date
                                                {/if}
                                                </span>
                                            </td >                       
                                            <td align="center">
                                                {if $disc->groupCode|@count > 0}
                                                    <a href="javascript:;" data-code="{$disc->code}" class="xtr_groups" data-toggle="popover" data-content=""><i class="fa fa-info-circle fa-lg"></i> </a>
                                                {/if}
                                            </td>                                           

                                            <td align="center" >
                                                {if $disc->percentageFlag == 1}
                                                    {$disc->value}&nbsp;%
                                                {else}
                                                    <i class="fa fa-rupee"></i>&nbsp;{$disc->value}
                                                {/if}
                                            </td>
                                            <td align="center" >
                                                {$disc->minSeatCount}
                                            </td> 
                                            <td align="center" >
                                                {$disc->maxDiscountAmount}
                                            </td> 
                                            <td align="center" >
                                                {$disc->minTicketFare}
                                            </td> 
                                            <td align="center" >
                                                {if $disc->scheduleCode|@count > 0}
                                                    <a href="javascript:;" data-code="{$disc->code}" class="xtr_schedule" data-toggle="popover" data-content=""><i class="fa fa-info-circle fa-lg"></i> </a>
                                                {/if}
                                            </td>
                                            <td align="center" >
                                                {if $disc->routeCode|@count > 0}
                                                    <a href="javascript:;" data-code="{$disc->code}" class="xtr_route" data-toggle="popover" data-content=""><i class="fa fa-info-circle fa-lg"></i> </a>
                                                {/if}
                                            </td>
                                            <td align="center" >
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
                                            <td align="center" >
                                                <a class="edit pTip_top" title="Edit" href="javascript:;" onclick="showOfflineDiscountDialog('{$disc->code}')">
                                                    <i class="fa fa-pencil fa-lg"></i>
                                                </a>&nbsp;
                                                <a class="delete pTip_top" title="Delete" href="javascript:;" onclick="deleteOfflineDiscount('{$disc->code}')">
                                                    <i class="fa fa-trash-o fa-lg"></i>
                                                </a>&nbsp;
                                            </td> 
                                </tr> 
                                {/foreach}
                                
                            
                        {else}
                            <tr>
                                <td align="center"> No discounts found</td>
                            </tr>
                        {/if}    
                        </table>    
                        </div><!--panel Body end-->
                    </div><!--panel end-->
                </div>
            </div><!--row end-->
        </div><!--content end-->
    </div>
</div>

<!-- Discount Popup -->

<div id="offline-discount-dialog"  class="dialog-content-page hide">
    <form role="form" id="form1" class="form-horizontal ">

        <div class="col-lg-4 p_l_n">
            <div>
                <label for="od_name" class="req">Name</label>
                <input  placeholder="Name" id="od_name" name="name"  class="form-control">
            </div>
        </div>
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_oz_name" class="req">Active From & To</label>
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                    <input type="text" name="od_date_range" id="od_date_range" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                </div>
            </div>
        </div>  
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_m_name" class="req">Day of Week</label>
                <div class="btn-group btn-group-days" id="od-weekdays" data-toggle="buttons">
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="od_day_of_weeks" value="1">S</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" value="1" name="od_day_of_weeks">M</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="od_day_of_weeks" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="od_day_of_weeks" value="1">W</label>
                    <label class="btn btn-success btn-xs chk-btn active">
                        <input type="checkbox" checked="checked" name="od_day_of_weeks" value="1">T</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="od_day_of_weeks" value="1">F</label>
                    <label class="btn btn-success btn-xs chk-btn  active">
                        <input type="checkbox" checked="checked" name="od_day_of_weeks" value="1">S</label>
                </div> 
            </div>
        </div>
                
        <div class="clear_fix_both"></div>        
        <br />
        
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name" class="req">Discount Per Seat</label>
            <input  placeholder="Discount Value" id="od_disc_value" name="od_disc_value"  class="form-control">
        </div>
        <div class="col-lg-2 p_l_n">
            <label for="txt_l_name">&nbsp;</label>
            <input style="position:relative;top:5px" type="checkbox" id="od_disc_type" name="od_disc_type"> <span style="position:relative;top:5px">&nbsp;<b>%</b></span>
        </div>
        <div class="col-lg-6 p_l_n">
            <label for="txt_l_name" class="req">Date Type</label>
            <input type="radio" name="od_date_type" id="od_date_type" value="false" class="grp_radio" checked> Transaction Date &nbsp;
            <input type="radio" name="od_date_type" id="od_date_type" value="true" class="grp_radio"> Travel Date 
        </div>

        <div class="clear_fix_both"></div>
        <br />

        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_oz_name" class="req">Group</label>
                <select id="od_groups" multiple="multiple" class="form-control col-md-6">
                    {foreach name=o item=row from=$groups}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}   
                </select>
            </div>
        </div>
                
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_oz_name">Routes</label>
                <select id="od_routes" multiple="multiple" class="form-control col-md-6">
                    {foreach name=o item=row from=$routes}
                        <option value="{$row->fromStation->code}-{$row->toStation->code}">{$row->name}</option>
                    {/foreach}    
                </select>
            </div>
        </div>
                
        <div class="col-lg-4 p_l_n">
            <div>
                <label for="txt_oz_name">Schedules</label>
                <select id="od_schedules" multiple="multiple" class="form-control col-md-6">
                    {foreach name=o item=row from=$schedules}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}     
                </select>
            </div>
        </div>
                
        
        <div class="clear_fix_both"></div>
        <br />           
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name">Min Ticket Fare</label>
            <input  placeholder="Leave empty if not set" id="od_ticket_fare" name="od_ticket_fare"  class="form-control">
        </div>
        
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name">Min Seat Count</label>
            <input  placeholder="Leave empty if not set" id="od_min_seat_count" name="od_min_seat_count"  class="form-control">
        </div>
        
        <div class="col-lg-4 p_l_n">
            <label for="txt_l_name">Max Discount Amount</label>
            <input  placeholder="Leave empty if not set" id="od_max_discount_amount" name="od_max_discount_amount"  class="form-control">
        </div>

        <div class="clear_fix_both"></div>
    </form>
    <br>
    <div class="clear_fix_both"></div>
    <div class="clear_fix_both">                       
        <div class="alert fl suc_cre" style="display: none;" id="od-disc-form-action-state"></div>
        <div class="align-right cre_sve" id="od-disc-form-buttons">
            <input type="hidden" name="od_code" id="od_code" value="" />
            <button class="btn btn-success" type="button" onclick="saveOfflineDiscount();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelOfflineDiscountDialog();">Cancel</button>
        </div>
    </div> 
</div>


<script>
    var discounts = {$discounts|json_encode};
    var groups = {$groups|json_encode};
    var routes = {$routes|json_encode};
    var schedules = {$schedules|json_encode};
    
    $('input[name="od_date_range"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
    
    function init_od_page() {
        init_offline_discount_page();
    }
</script>
