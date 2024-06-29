<div class="clear_fix_both"></div><br />
<div class="seat-map-over">
    <div class="seat-map-over-all">
        <div class="col-lg-1">
            <div class="seat-map-driver">&nbsp;
            </div>
            <div class="seat-map-selayer">
                <p class="vertical-text">Lower</p>
            </div>
        </div>
        <div class="col-lg-9" style="width:auto;height: auto;">

            {for $r=$xminl1 to $xmaxl1}
                {for $c=$yminl1 to $ymaxl1}
                    <div class="seat-lay-visibility" id="laye1-{$r}{$c}">
                        &nbsp;
                    </div>
                {/for}
                <div class="clear_fix_both"></div>
            {/for}
        </div>

    </div>

    <div class="col-md-1"></div>        

    <div class="col-md-11 br_2 buslayer2">
        <div class="">
            <div class="col-lg-1 wwd_151">
                <!--<div class="seat-lay-visibility"></div>-->
                <p class="vertical-text">Upper</p>
            </div>
            <div class="col-lg-12" style="width:auto;height: auto;">
                {for $r=$xminl2 to $xmaxl2}
                    {for $c=$yminl2 to $ymaxl2}
                        <div class="seat-lay-visibility" id="laye2-{$r}{$c}">
                            &nbsp;
                        </div>
                    {/for}
                    <div style="clear:both"></div>
                {/for}
            </div>
        </div>
        <div class="clear_fix_both"></div>
    </div>
    <div class="col-md-2 col-md-offset-2" >
        <div id="seat-selection-list">
        </div>
    </div>
    <div class="clear_fix_both"></div>
</div>
<div class="clear_fix_both"></div>
<br />

<div class="clear_fix_both"></div>
</div>
<div class="clear_fix_both"></div><br />
<a class="pTip_top" title="Add seat auto release" href="javascript:;" id="toggle-seat2"><i class="fa fa-plus"></i>&nbsp;Add New Rule</a>

<div class="clear_fix_both"></div><br />
<div class="box_content toggle-seat-list2">
    <div class="row">
        <div class="col-md-3"  style="position:relative;top:14px"> 
            <label class="req" for="seat-sch-date" class="req">Date</label>
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                <input type="text" name="seat-sch-date-rel" id="seat-sch-date-rel" class="form-control" readonly="true" value="">
            </div>
        </div>
        <div class="group"> 
            <div class="form-group">
                <div class="col-md-2"> 
                    <label class="req" for="seat-sch-grp" class="req">Group</label>
                    <select id='group' class="form-control">                    
                        <option value="NA">All Group</option>
                        {foreach from=$groups item=grp}
                            {if $grp['name']!='' && $grp['name']!='code'}
                                <option value='{$grp['code']}'>{$grp['name']}</option>
                            {/if}
                        {/foreach} 
                    </select>
                </div>
            </div>
        </div>

        <div class="col-md-2"> 
            <label class="req" for="seat-sch-date" class="req">Release Time</label>
            <select name="release-minute" id="release-minute" class="form-control">
                    <option value="">Options</option>
                    <option value="60">1</option>
                    <option value="90">1:30 </option>
                    <option value="120">2 </option>
                    <option value="150">2:30 </option>
                    <option value="180">3 </option>
                    <option value="210">3:30 </option>
                    <option value="240">4 </option>
                    <option value="270">4:30 </option>
                    <option value="300">5 </option>
                    <option value="330">5:30 </option>
                    <option value="360">6 </option>
                    <option value="390">6:30 </option>
                    <option value="420">7 </option>
                    <option value="450">7:30 </option>
                    <option value="480">8 </option>
                    <option value="510">8:30 </option>
                    <option value="540">9 </option>
                    <option value="570">9:30 </option>
                    <option value="600">10 </option>
                    <option value="630">10:30 </option>
                    <option value="660">11 </option>
                    <option value="690">11:30 </option>
                    <option value="720">12</option>
                </select>
        </div>
        <div class="col-md-2"> 
            <label class="req" for="seat-sch-date" class="req">Time Type</label>
            <select id='minute-type' class="form-control">
                <option value="" selected="selected">Select</option>
                <!--<option value="MIN">Minutes</option>-->
                <option value="MIN">Hours Before</option>
                <option value="AM">AM</option>
                <option value="PM">PM</option>
            </select>
        </div>
    </div>
    <br>                
    <div class="row">
        <div class="col-md-3"> 
            <label class="req" for="seat-sch-date" class="req">Release / Confirm Type</label>
            <select id='release-type' class="form-control">
                <option value="" selected="selected">Select</option>
                <option value="ACAT">Release Allocated Seats</option>
                <option value="HIDE">Release Blocked Seats</option>
                <option value="RLSPHTCK">Release Phone Booked Seats</option>
                <option value="CNFPHTCK">Confirm Phone Booking Seats</option>
            </select>
        </div>
        <div class="col-md-3"> 
            <label class="req" for="seat-sch-date" class="req">Release Mode</label>
            <select id='release-mode' class="form-control">
                <option value="" selected="selected">Select</option>
                <option value="SCH">Schedule</option>
                <option value="STG">Stage</option>
            </select>
        </div>           

        <div class="col-md-3">
            <label class="req"  class="req">Day of week</label>
            <div class="btn-group btn-group-days" id="busTypeweekdaysrel" data-toggle="buttons">
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">S</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">M</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">T</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">W</label>
                <label class="btn btn-success btn-xs chk-btn active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">T</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">F</label>
                <label class="btn btn-success btn-xs chk-btn  active">
                    <input type="checkbox" checked="checked" name="busweeks" value="1">S</label>
            </div> 
        </div>
        <div class="col-md-2">
            <label>&nbsp;</label>
            <button class="btn btn-success btn-xs" type="button" onclick="saveSeatAutoRelease()"><i class="fa fa-plus"></i>&nbsp;Save</button>
            <button  type="button" class="btn btn-default btn-xs" onclick="clearSeatAutoRelease()">&nbsp;Clear</button>
        </div>
    </div>
</div>

<div class="col-md-12" id="toggle-seat_header2">
    <table class="table seat-visibilty-list2">
        <tr>
            <th></th>
            <th>Date Range</th>
            <th>Group</th>
            <th>Seats</th>
            <th>Days</th>
            <th nowrap="">Release Time</th>
            <th nowrap="">Release Mode</th>
            <th></th>
        </tr>

        {foreach item=sv from=$seatvisiblelists}
            <tr class="del-seat-{$sv->code} trhover" onclick="toogleAutoExceptionOverrideList(this, '{$sv->code}')">
                <td><div class="wid-hig-15" id="seat-assign-{$sv->code}">&nbsp;</div></td>
                <td>{$sv->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$sv->activeTo|date_format:$ns_date_format}</td>
                <td>{if $sv->group->code!=''}{$sv->group->name}{else if $sv->user->code!=''}{$sv->user->name}{else}All Group{/if}</td>
                <td style="width:300px;">
                    {foreach item=bs from=$sv->busSeatLayout}
                        {$bs->seatName},
                    {/foreach}    
                </td>
                <td nowrap="">

                    {if $sv->dayOfWeek!=''}
                        {assign var=bday value=$sv->dayOfWeek}                       
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
                <td width="5%">

                    {math equation="floor(x/60)" x=$sv->releaseMinutes assign=hr}
                    {math equation="(x%60)" x=$sv->releaseMinutes assign=min}
                    {if $sv->minutesType=='MIN'}
                        {if $hr>=1}
                            {$hr} : {$min} Hours
                        {else}
                            {$hr} : {$min} Minutes
                        {/if}    
                    {else}
                        {$hr} : {$min} {$sv->minutesType}
                    {/if}    
                    
                </td>
                <td width="5%">
                    {if $sv->releaseMode=='SCH'} Schedule
                    {else} Stage {/if} <br>
                    <span class="text-muted">
                        {if $sv->releaseType=="ACAT"} Release Allocated Seats
                        {else if $sv->releaseType=="HIDE"} Release Blocked Seats
                        {else if $sv->releaseType=="RLSPHTCK"} Release Phone Book Seats
                        {else if $sv->releaseType=="CNFPHTCK"} Confirm Phone Book Seats
                        {/if}    
                    </span>
                </td>
                <td>
                    <a class="pTip_top" title="Edit" href="javascript:;" onclick="editSeatAutoRelease('{$sv->code}')">
                        <i class="fa fa-pencil fa-lg"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Delete" href="javascript:;"  onclick="deleteSeatAutoRelease('{$sv->code}')">
                        <i class="fa fa-trash-o fa-lg"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Add exception / override" href="javascript:;" data-auto="{$sv->code}"  onclick="seatReleaseException(this)">
                        <i class="fa fa-exclamation-circle fa-lg"></i>
                    </a><input type="hidden" value="{$sv->bus->code}" id="bus-sch-code">
                </td>
            </tr>
            {if count($sv->overrideList) > 0}
                <tr class="seat-visibility-tab-{$sv->code}  sta-exp-ovr-lst-hide release-exp-{$sv->code}" style="display:none">
                    <td></td>
                    <td colspan="7" align="left" class="text-danger">Exception List</td>
                </tr>
                {foreach key=key from=$sv->overrideList item=svo}

                    {if count($svo->busSeatLayout)<=0}
                        <tr class="seat-visibility-tab-{$sv->code} sta-exp-ovr-lst-hide release-exp-row-{$sv->code}" id="stv-eo-del-{$svo->code}" style="display:none">
                            <td></td>
                            <td>{$svo->activeFrom|date_format:$ns_date_format} <span class="glyphicon glyphicon-resize-horizontal"></span> {$svo->activeTo|date_format:$ns_date_format}</td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                {if $svo->dayOfWeek!=''}
                                    <div class="btn-group btn-group-days-display">
                                        {assign var=bday value=$svo->dayOfWeek}        
                                        <div class="btn-group btn-group-days-display">
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:0:1==1}active{/if}">S</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:1:1==1}active{/if}">M</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:2:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:3:1==1}active{/if}">W</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:4:1==1}active{/if}">T</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:5:1==1}active{/if}">F</label>
                                            <label class="btn btn-success-list btn-xs chk-btn {if $bday|substr:6 ==1}active{/if}">S</label>
                                        </div>
                                    </div> 
                                {/if}   
                            </td>
                            <td width="10%">                                
                            </td>
                            <td>
                                <!--<a class="edit pTip_top" title="Edit exception" href="javascript:;" data-viscode="{$sv->code}" data-expcode="{$svo->code}" data-tab="#stv-exp" onclick="seatVisiblityExceptionOverride(this)">
                                    <i class="fa fa-pencil"></i>
                                </a>&nbsp; -->
                                <a class="delete pTip_top" title="Delete exception" href="javascript:;"  data-viscode="{$sv->code}" data-expcode="{$svo->code}" onclick="deleteSeatAutoRelease('{$svo->code}')">
                                    <i class="fa fa-trash-o fa-lg"></i>
                                </a>&nbsp;
                            </td>
                        </tr>
                    {/if}
                {/foreach} 
            {/if}
        {/foreach}    
    </table>
    <div class="clear_fix_both"></div><br />
    <div id="rel-exception-dialog" class="dialog-content-page" style="display: none">
        <br>
        <div class="col-xs-12">
            <form role="form" id="visexp" class="form-horizontal">
                
                <div class="form-group">
                    <label  class="req col-md-3" >Day of week</label>
                    <div class="col-md-5">
                        <div class="btn-group btn-group-days" id="rel-except-week-days" data-toggle="buttons">
                            <label class="btn btn-success btn-xs chk-btn">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">S</label>
                            <label class="btn btn-success btn-xs chk-btn">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">M</label>
                            <label class="btn btn-success btn-xs chk-btn ">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn ">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">W</label>
                            <label class="btn btn-success btn-xs chk-btn">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">T</label>
                            <label class="btn btn-success btn-xs chk-btn">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">F</label>
                            <label class="btn btn-success btn-xs chk-btn">
                                <input type="checkbox" name="rel-except-week" class="rel-ovr-exp-days" value="1">S</label>
                        </div> 
                    </div>

                </div>  
                <div class="form-group">
                    <label class='req col-md-3' for="rel-exp-scd-date">Date</label>
                    <div class="col-md-9"> 
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="rel-exp-scd-date" id="rel-exp-scd-date" class="rel-exp-date form-control" readonly="true" value="{*if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if*}">
                        </div>
                    </div>
                </div>

                <div class="clear_fix_both"></div>

                <div class="alert fl suc_cre" style="display: none;" id="rel-exp-form-action-state"></div>
                <div class="pull-right" id="rel-exp-form-buttons">
                    <button class="btn btn-success" type="button" onclick="saveReleaseExceptionDialog()">Save</button>
                    <button class="btn btn-default" type="button" onclick="cancelReleaseExceptionDialog()">Cancel</button>
                </div>
            </form>
        </div>
    </div>   
</div>
<input name="auto" id="auto" type="hidden" value="" />
<input name="seat-auto-code" id="seat-auto-code" type="hidden" value="" />
<input name="release-code" id="release-code" type="hidden" value="" />
</div>
<script>
    var buslayers = {$busseatlayers|json_encode};
    var seatAssigns = {$seatvisiblelists|json_encode};
    var type = new Array();
    type["ALL"] = "Default";
    type["SS"] = "Semi Sleeper";
    type["SL"] = "Sleeper";
    type["ST"] = "Seater";
    type["USL"] = "Upper Sleeper";
    type["LSL"] = "Lower Sleeper";
    type["SUSL"] = "Single Upper Sleeper";
    type["SLSL"] = "Single Lower Sleeper";

    $(document).ready(function () {
        $('input[name="seat-sch-date-rel"],input[name="rel-exp-scd-date"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | '
        });
        var lay = 0;
        $('.buslayer2,.seat-map-selayer').hide();

        $.each(buslayers, function (key1, bval) {
            if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                $('#laye' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility2').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codes', bval.code).attr('data-container', 'body');
                $('#laye' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);

                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility2').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codes', bval.code).attr('data-container', 'body');
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);            
            } else {
                $('#laye' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#laye' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
                
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
            }
            
            //data-placement="top" data-title="A Title" data-trigger="hover"
            $('[data-toggle=popover]').popover({
                container: "body",
                html: true
            });

            if (bval.layer == 2) {
                lay = 1;
            }
        });
        $.each(seatAssigns, function (k, sval) {
            var color = radmonColors();
            $('#seat-assign-' + sval.code).css('background', color);
            //busSeatLayout
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (bsval.code != '') {
                    if ($('div[data-codes="' + bsval.code + '"]').hasClass("seat-visible")) {
                        if (!$('div[data-codes="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                            $('div[data-codes="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                        }
                    } else {
                        $('div[data-codes="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                    }
                }
            });
        });
        if (lay > 0) {
            $('.buslayer2,.seat-map-selayer').show();
        }

        $('.seat-select-visibility2').click(function () {
            $(this).toggleClass("schedule-seat-visibility");
        });

        $('.bs_switch').bootstrapSwitch('size', 'mini');
    });
    function radmonColors() {
        var color = '#' + Math.floor(Math.random() * 16777215).toString(16);
        if (color == '#27AE60' || color == '#FFFFFF')
            radmonColor();
        return color
    }

    $('input[name="assignOption"]').click(function () {
        $('.assignee').hide();
        if ($(this).is(':checked')) {
            $('.' + $(this).attr('data-view')).show();
        }
    });
//$('.pTip_top').powerTip({ placement: 'n' });

</script>
