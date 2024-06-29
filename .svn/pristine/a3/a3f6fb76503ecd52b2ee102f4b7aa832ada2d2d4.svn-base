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
                    <div class="seat-lay-visibility" id="layer1-{$r}{$c}">
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
                        <div class="seat-lay-visibility" id="layer2-{$r}{$c}">
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
<a class="pTip_top" title="Add new preference" href="javascript:;" id="toggle-seat3"><i class="fa fa-plus"></i>&nbsp;Add Preference</a>

<div class="clear_fix_both"></div><br />
<div class="box_content toggle-seat-list3">
    <div class="col-md-3">
        <label class="req" for="seat-sch-date" class="req">Date</label>
        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            <input type="text" name="seat-sch-date-relp" id="seat-sch-date-relp" class="form-control" readonly="true" value="">
        </div>
    </div>
    <div class="col-md-2">
        <label class="req" for="seat-sch-date" class="req">Gender</label>
        <select id='r-gender' class="form-control">
            <option value="" selected="selected">Select</option>
            <option value="M">Male</option>
            <option value="F">Female</option>
        </select>
    </div>
    <div class="col-md-2">
        <label class="req">Group</label>
        <select id="seat-sch-groups" class="form-control" multiple="multiple">
            <option value="ALL">All Groups</option>
            {foreach item=row from=$groups}
                <option value="{$row['code']}">{$row['name']}</option>
            {/foreach}
        </select>
    </div>
    <div class="col-md-2">
        <label class="req"  class="req">Day of week</label>
        <div class="btn-group btn-group-days" id="busTypeweekdaysref" data-toggle="buttons">
            <label class="btn btn-success btn-xs chk-btn active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">S</label>
            <label class="btn btn-success btn-xs chk-btn active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">M</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">T</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">W</label>
            <label class="btn btn-success btn-xs chk-btn active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">T</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">F</label>
            <label class="btn btn-success btn-xs chk-btn  active">
                <input type="checkbox" checked="checked" name="busweeksf" value="1">S</label>
        </div>
    </div>
    <div class="col-md-2">
        <label>&nbsp;</label>
        <button class="btn btn-success btn-xs" type="button" onclick="saveSeatPreference()"><i class="fa fa-plus"></i>&nbsp;Save</button>
        <button  type="button" class="btn btn-default btn-xs" onclick="clearSeatPreference()">&nbsp;Clear</button>
    </div>
    <div class="clear_fix_both"></div>
    <br>
</div>

<div class="col-md-11" id="toggle-seat_header3">
    <table class="table seat-visibilty-list3">
        <tr>
            <th></th>
            <th>From date</th>
            <th>To date</th>
            <th>Seats</th>
            <th>Group</th>
            <th>Days</th>
            <th>Gender</th>
            <th></th>
        </tr>

        {foreach item=sv from=$seatvisiblelists}
            <tr class="del-seat-{$sv->code} hover">
                <td><div class="wid-hig-15" id="seat-assign-{$sv->code}">&nbsp;</div></td>
                <td>{$sv->activeFrom}</td>
                <td>{$sv->activeTo}</td>
                <td>
                    {foreach item=bs from=$sv->busSeatLayout}
                        {$bs->seatName},
                    {/foreach}
                </td>
                <td>
                    {if $sv->groupList|count >0}
                        {foreach from=$sv->groupList item=group key=i}
                            {if $i == 0}
                                {$group->name}
                            {else}
                                {break}
                            {/if}
                        {/foreach}
                        {if $sv->groupList|@count >1}
                        <a href="javascript:;" data-toggle="popover" class="has-popover" data-trigger="hover" data-content="
                            {foreach from=$sv->groupList item=group key=i}
                                {$group->name} <br/>
                            {/foreach}
                            "><span class="label label-success"> {$sv->groupList|count} </span></a>
                        {/if}
                    {else}
                        All Group
                    {/if}
                </td>
                <td>
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
                    {$sv->preferenceGendar}
                </td>

                <td>
                    <a class="pTip_top" title="Edit visiblity" href="javascript:;" onclick="editSeatPreference('{$sv->code}')">
                        <i class="fa fa-pencil"></i>
                    </a>&nbsp;
                    <a class="pTip_top" title="Delete visiblity" href="javascript:;"  onclick="deleteSeatPreference('{$sv->code}')">
                        <i class="fa fa-trash-o"></i>
                    </a>&nbsp;
                    </a><input type="hidden" value="{$sv->bus->code}" id="bus-sch-code">
                </td>
            </tr>

        {/foreach}
    </table>
    <input name="seat-refer-code" id="seat-refer-code" type="hidden" value="" />
    <input name="preference-code" id="preference-code" type="hidden" value="" />
</div>



<script>
    var buslayersp = {$busseatlayers|json_encode};
    var seatAssignsp = {$seatvisiblelists|json_encode};
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
        $('input[name="seat-sch-date-relp"]').daterangepicker({
            buttonClasses: ['btn', 'btn-sm'],
            format: 'YYYY-MM-DD',
            separator: ' | '
        });
        var lay = 0;
        $('.buslayer2,.seat-map-selayer').hide();
        $.each(buslayersp, function (key1, bval) {
            if(bval.busSeatType.code !== 'RRM' &&  bval.busSeatType.code !== 'FRS') {
                $('#layer' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility3').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codesp', bval.code).attr('data-container', 'body');
                $('#layer' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html(bval.seatName).addClass('seat-select-visibility3').addClass('p_tool').attr('data-toggle', 'popover').attr('data-codesp', bval.code).attr('data-container', 'body');
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-trigger', 'hover').attr('data-content', "Seat Name : " + bval.seatName + "<br />Seat Type &nbsp;: " + type[bval.busSeatType.code]);
            } else {
                $('#layer' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#layer' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
                
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).html('x').addClass('hover-background').attr('data-toggle', 'popover');
                $('#lays' + bval.layer + '-' + bval.rowPos + '' + bval.colPos).attr('data-placement', 'top').attr('data-trigger', 'hover').attr('data-content', 'Rest Room');
            }
            $('[data-toggle=popover]').popover({
                container: "body",
                html: true
            });
            if (bval.layer == 2) {
                lay = 1;
            }
        });
        $.each(seatAssignsp, function (k, sval) {
            if (sval.preferenceGendar == 'F'){
                   var color = '#ffcfe3' ;
                }else{
                    var color = '#88d1f2';
                }
            $('#seat-assign-' + sval.code).css('background', color);
            $.each(sval.busSeatLayout, function (kb, bsval) {
                if (sval.preferenceGendar == 'F'){
                    color = '#ffcfe3' ;
                }else{
                    color = '#88d1f2'
                }
                if (bsval.code != '') {
                    if ($('div[data-codesp="' + bsval.code + '"]').hasClass("seat-visible")) {
                        if (!$('div[data-codesp="' + bsval.code + '"]').find('i').hasClass('fa-users')) {
                            $('div[data-codesp="' + bsval.code + '"]').css('background', 'none').append("<i class='fa fa-users grp-seat' ></i>");
                        }
                    } else {
                        $('div[data-codesp="' + bsval.code + '"]').css('background', color).addClass('seat-visible');
                    }
                }
            });
        });
        if (lay > 0) {
            $('.buslayer2,.seat-map-selayer').show();
        }
        $('.seat-select-visibility3').click(function () {
            $(this).toggleClass("schedule-seat-visibility");
        });
        $('.bs_switch').bootstrapSwitch('size', 'mini');
    });
    function radmonColorsp() {
        var color = '#' + Math.floor(Math.random() * 16777215).toString(16);
        if (color == '#27AE60' || color == '#FFFFFF')
            radmonColor();
        return color
    }
    $('#seat-sch-groups').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '175px',
        buttonClass: 'btn btn-default seat-sch-groups',
        dropUp: true
    });
</script>
