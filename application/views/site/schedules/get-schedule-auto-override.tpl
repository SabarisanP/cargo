<div id="fao-form-div" style="display: none">
    <div class="box_content">
        <div class="row">
            <div class="col-lg-3 col-sm-5">
                <div class="form-group">
                    <label class="req" for="seat-sch-date" class="req ">Route</label>
                    <select id='fao-sch-from' class="form-control"  multiple="multiple">
                        <option value='NA'>All Routes</option>
                        {foreach item=route from=$routes}
                            <option value='{$route['from']} - {$route['to']}'>{$route['name']}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-lg-3 col-sm-5 p_l_n p_r_n">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label for="txt_oz_name" class="req">Active From & To</label>
                        <div class="input-group">
                            <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                            <input type="text" name="fao-date_disc" id="fao-date_disc" class="form-control" readonly="true" value="{if $schedules[0]->activeFrom!='' && $schedules[0]->activeTo!='' }{$schedules[0]->activeFrom} | {$schedules[0]->activeTo}{/if}">
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="pull-left col-md-4 col-sm-5 p_l_n p_r_n">
                        <div class="form-group">
                            <label class="req" for="seat-sch-date" class="req">Fare </label>
                            <input type="text" name="fao-seat-sch-fare" id="fao-seat-sch-aofare" class="form-control"  value="" maxlength="4">
                        </div>
                    </div>
                    <div class="pull-right">
                        <div class="form-group">
                            <label for="txt_m_name" class="req">Day of Week</label>
                            <div class="btn-group btn-group-days" id="fao-exp-weekdays" data-toggle="buttons">
                                <label class="btn btn-success btn-xs chk-btn active">
                                    <input type="checkbox" checked="checked" name="fao-weeks" value="1">S</label>
                                <label class="btn btn-success btn-xs chk-btn active">
                                    <input type="checkbox" checked="checked" value="1" name="fao-weeks">M</label>
                                <label class="btn btn-success btn-xs chk-btn  active">
                                    <input type="checkbox" checked="checked" name="fao-weeks" value="1">T</label>
                                <label class="btn btn-success btn-xs chk-btn  active">
                                    <input type="checkbox" checked="checked" name="fao-weeks" value="1">W</label>
                                <label class="btn btn-success btn-xs chk-btn active">
                                    <input type="checkbox" checked="checked" name="fao-weeks" value="1">T</label>
                                <label class="btn btn-success btn-xs chk-btn  active">
                                    <input type="checkbox" checked="checked" name="fao-weeks" value="1">F</label>
                                <label class="btn btn-success btn-xs chk-btn  active">
                                    <input type="checkbox" checked="checked" name="fao-weeks" value="1">S</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="form-group {if $action_rights['SCH-GRPWISE-FARE']<1} hide {/if}">
                        <label class="req" for="fao-group-seat-sch" class="req">Group</label>
                        <select id='fao-group-seat-sch' class="form-control" multiple="multiple">
                            <option value="" selected="selected">All Group</option>
                            {foreach from=$groups item=grp}
                                {if $grp['name']!='' && $grp['name']!='code'}
                                    <option value='{$grp['code']}'>{$grp['name']}</option>
                                {/if}
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="col-sm-12" id='stype-container'>
                    <div class="form-group">
                        <label class="req" for="seat-sch-ov_seat_type" class="req">Seat Type</label>
                        <select id="fao-fare-ovr-seat-type" class="form-control" multiple>
                            {if count($seattype) > 1}
                                <option value='ABST'>All Type </option>
                                {foreach from=$seattype item=typename key=code}
                                    {if $code != 'RRM' && $code != 'FRS'}
                                        <option value='{$code}'>{$typename}</option>
                                    {/if}
                                {/foreach}
                            {else}
                                {foreach from=$seattype item=typename key=code}
                                    {if $code != 'RRM' && $code != 'FRS'}
                                        <option value='{$code}' selected>{$typename}</option>
                                    {/if}
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-6 col-sm-10">
                <div class="alert col-sm-12" style="display: none;" id="fao-schfare-form-action-state"></div>
                <div class="align-right" id="fao-schfare-form-buttons">
                    <input type="hidden" name="fao-sch-fare-type" id="fao-sch-fare-type" value="FLT" />
                    <input type="hidden" name="fao-sch-fare-override-type" id="fao-sch-fare-override-type" value="FLFA" />
                    <input type="hidden" name="fao-fare-ovr-min" id="fao-fare-ovr-min" value="0" />
                    <input type="hidden" name="schfare_code" id="fao-schfare_code" value="" />
                    <input type="hidden" name="schfare_code" id="fao-schfare_code_lookup" value="" />
                    <input type="hidden" name="schfare_over_code" id="fao-schfare_over_code" value="" />
                    <input type="hidden" name="schfare_type" id="fao-schfare_type" value="" />
                    <button class="btn btn-success" type="button" onclick="saveScheduleFare();">Save</button>
                    <button class="btn btn-default" type="button" onclick="clearSheduleOverrideDialog();">Clear</button>&emsp;
                    <button class="btn btn-default" onclick="closeFareOverrideForm();">&nbsp;Close</button>
                </div>
            </div>
            <br/><br/>
        </div>
    </div>
    <br/><br/>
</div>

<div class="row">
    <div class="col-lg-5 col-sm-8" id="fao-search-filter">
        <div class="col-sm-6">
            <label for="fao-date-filter">Date</label>
            <div class="input-group col-sm-12">
                <input type="text" name="from_date" class="form-control sdate" id="fao-date-filter" readonly="true" placeholder="Date">
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
        <div class="col-sm-6">
            <label>&nbsp;</label>
            <button class="btn btn-success btn-sm" type="button" onclick="renderFaoRow();">&nbsp;Search</button>
            <button type="button" class="btn btn-default btn-sm" onclick="clearFareOverrideFilter();renderFaoRow();">&nbsp;Cancel</button>
        </div>
    </div>
    <div class="col-lg-5 col-sm-4">
        <span>
            <label>&nbsp;</label>
            <a href="javascript:;" class="btn btn-success  btn-sm" onclick="toggleFareOverrideForm();">New Fare Override</a>
        </span>
    </div>
</div>
<br>

<div class="col-sm-12" id="fao-list-table-div"></div>

<!-- Exception dialog -->

<div id="fare-override-exp-dialog"  class="dialog-content-page hide">

    <div style="padding:15px;">
        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label class="req" for="seat-sch-date" class="req ">Route</label>
                    <select id='exp-sch-routes' class="form-control"  multiple="multiple">
                    </select>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group">
                    <label class="req" for="exp-sch-group" class="req">Group</label>
                    <select id="exp-sch-group" class="form-control" multiple="multiple">
                        <option value="" selected="selected">All Group</option>
                        {foreach from=$groups item=grp}
                            {if $grp['name']!='' && $grp['name']!='code'}
                                <option value='{$grp['code']}'>{$grp['name']}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="form-group">
                    <label for="txt_oz_name" class="req">Active From & To</label>
                    <div class="input-group">
                        <span class="input-group-addon "><i class="fa fa-calendar"></i></span>
                        <input type="text" name="fare-date-disc" id="fare-date-disc" class="form-control inp_error" readonly="true" value="">
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group">
                    <label for="txt_m_name" class="req">Day of Week</label>
                    <div class="btn-group btn-group-days" id="fareover-exp-weekdays" data-toggle="buttons">
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="fareover-week" id="fareover-weeks" value="1">S</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" value="1" name="fareover-week" id="fareover-weeks">M</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">W</label>
                        <label class="btn btn-success btn-xs chk-btn active">
                            <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">T</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">F</label>
                        <label class="btn btn-success btn-xs chk-btn  active">
                            <input type="checkbox" checked="checked" name="fareover-week" value="1" id="fareover-weeks">S</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="clear_fix_both">
                <div class="alert fl suc_cre" style="display: none;" id="fareover-form-action-state"></div>
                <div class="align-right cre_sve" id="fareover-form-buttons">
                    <input type="hidden" name="schfareoverride_code" id="schfareoverride_code" value="" />
                    <input type="hidden" name="schfareoverride_exp_code" id="schfareoverride_exp_code" value="" />
                    <button class="btn btn-success" type="button" onclick="saveFareOverrideExceptionDialog();">Save</button>
                    <button class="btn btn-default" type="button" onclick="cancelFareOverrideException();">Cancel</button>
                </div>
            </div>
        </div>

    </div>
</div>
<!-- Dialog ends  -->
<input name="fao-schfare_code" id="fao-schfare_code" type="hidden" value="" />

<script id="dow-template" type="text/template">
    <div class="btn-group btn-group-days-display">
        <label class="btn btn-success-list btn-xs chk-btn">S</label>
        <label class="btn btn-success-list btn-xs chk-btn">M</label>
        <label class="btn btn-success-list btn-xs chk-btn">T</label>
        <label class="btn btn-success-list btn-xs chk-btn">W</label>
        <label class="btn btn-success-list btn-xs chk-btn">T</label>
        <label class="btn btn-success-list btn-xs chk-btn">F</label>
        <label class="btn btn-success-list btn-xs chk-btn">S</label>
    </div>
</script>

<script id="fao-table-template" type="text/template">
    <div class="overflow-x-auto">
        <table class="table no-wrap" width="100%" id="fao-list-table">
            <thead>
                <tr>
                    <th width="1%" align="center"></th>
                    <th width="20%" align="center">Date Range</th>
                    <th width="15%" align="center">Route</th>
                    <th width="10%" align="center">Group</th>
                    <th width="8%" align="center">Fare</th>
                    <th width="10%" align="center">Days</th>
                    {*<th width="10%" align="center">BF Dept.Time</th>*}
                    <th width="7%" align="center">
                        <span class="txt_green">&nbsp;<i class="fa fa-list"></i>&nbsp;<span class="fao-count"></span>&nbsp;Found</span>
                        <a title="Filter Fare Overrides" class="fao-filter-btn" href="javascript:;"><i class="fa fa-filter"></i></a>
                    </th>
                </tr>
            </thead>
            <tbody id="fao-list-table-body"></table>
        </table>
    </div>
</script>

<script id="fao-row-template" type="text/template">
    <tr>
        <td><span class="fao-caret"></span></td>
        <td width="20%">
            <span class="fao-date"></span><br>
            <span class="fao-label"></span>
        </td>
        <td width="15%">
            <span class="fao-route"></span>
        </td>
        <td width="15%">
            <i class="fa fa-users"></i> &nbsp;
            <span class="fao-group"></span><br>
            <span class="text-muted fao-seattype"></span>
        </td>
        <td width="10%">
            <span class="fao-fare"></span><br>
            {*<span class="fao-faretype text-muted"></span>*}
        </td>
        <td width="15%" style="min-width: 150px;">
            <span class="fao-dow"></span>
        </td>
        {*<td width="10%">
            <span class="fao-departure"></span>
        </td>*}
        <td width="10%">
            <a class="fao-edit edit pTip_top" title="Edit" href="javascript:;">
                <i class="fa fa-pencil fa-lg"></i>
            </a>&nbsp;
            <a class="fao-delete delete pTip_top" title="Delete" href="javascript:;">
                <i class="fa fa-trash-o fa-lg"></i>
            </a>&nbsp;
            <a class="fao-excep" href="javascript:;" title="Add Exception">
                <i class="fa fa-exclamation-circle fa-lg"></i>
            </a>&nbsp;
            <a class="fao-over" href="javascript:;" title="Add Override">
                <i class="fa fa-exclamation-triangle fa-lg"></i>
            </a>&nbsp;
            <a class="fao-user" href="javascript:;">
                <i class="fa fa fa-question-circle fa-lg"></i>
            </a>
        </td>
    </tr>
</script>

<script id="fao-exp-template" type="text/template">
    <tr class="rou-exp-ovr-lst-hide" style="display:none">
        <td colspan="7">
            <div class="pull-left heading">
                <span class="text-danger" style="padding-left: 80px;"> Exception List </span>
            </div>

            <table class="table" id="fao-exp-list-table"></table>
        </td>
    </tr>
</script>

<script id="fao-exp-row-template" type="text/template">
    <tr>
        <td width="10%"></td>
        <td width="15%">
            <span class="fao-exp-route"></span>
        </td>
        <td width="10%">
            <i class="fa fa-users"></i> &nbsp;
            <span class="fao-exp-group"></span>
        <td>
        <td width="20%">
            <span class="fao-exp-date"></span>
        </td>
        <td width="15%">
            <span class="fao-exp-dow"></span>
        </td>
        <td width="10%"></td>
        <td width="15%">
            <a class="fao-exp-edit edit pTip_top" title="Edit routes exception" href="javascript:;">
                <i class="fa fa-pencil fa-lg"></i>
            </a>&nbsp;
            <a class="fao-exp-delete delete pTip_top" title="Delete" href="javascript:;">
                <i class="fa fa-trash-o fa-lg"></i>
            </a>&nbsp;
        </td>
    </tr>
</script>

<script id="fao-ovr-template" type="text/template">
    <tr class="rou-exp-ovr-lst-hide" style="display:none">
        <td colspan="7">
            <div class="pull-left heading">
                <span class="text-danger" style="padding-left: 80px;"> Override List </span>
            </div>

            <table class="table" id="fao-ovr-list-table"></table>
        </td>
    </tr>
</script>

<script id="fao-ovr-row-template" type="text/template">
    <tr>
        <td width="10%"></td>
        <td width="15%">
            <span class="fao-ovr-route"></span>
        </td>
        <td width="10%">
            <i class="fa fa-users"></i> &nbsp;
            <span class="fao-ovr-group"></span>
        <td>
        <td width="20%">
            <span class="fao-ovr-date"></span>
        </td>
        <td width="15%">
            <span class="fao-ovr-dow"></span>
        </td>
        <td width="10%">
            <span class="fao-ovr-fare"></span><br>
            <span class="fao-ovr-faretype text-muted"></span>
        </td>
        <td width="15%">
            <a class="fao-ovr-edit edit pTip_top" title="Edit routes exception" href="javascript:;">
                <i class="fa fa-pencil fa-lg"></i>
            </a>&nbsp;
            <a class="fao-ovr-delete delete pTip_top" title="Delete" href="javascript:;">
                <i class="fa fa-trash-o fa-lg"></i>
            </a>&nbsp;
        </td>
    </tr>
</script>
    
<script>
    var schfareOverride = {$schedulefare|json_encode}
    var confSeatType = {$conf_seattype|json_encode}
    var fao_sch_from_html = $('#fao-sch-from').html();
    var fao_group_seat_sch_html = $('#fao-group-seat-sch').html();
    $('input[name="fao-date_disc"],input[name="fao-exp_disc_date"],input[name="fare-date-disc"]').daterangepicker({
        buttonClasses: ['btn', 'btn-sm'],
        format: 'YYYY-MM-DD',
        separator: ' | ',
        showDropdowns: true,
        showWeekNumbers: true,
    });
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip({
            html: true,
        });
    });
    $('#fao-sch-from').multiselect({
        maxHeight: 250,
        numberDisplayed: 1,
        dropLeft: true,
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        buttonClass: 'btn btn-default fao-sch-from',
        buttonContainer: '<div id="fao-routes-list-container" class="custom-cb multiselect-inline fao-sch-from"></div>',
        templates: {
            button: '',
            ul: '<ul class="multiselect-container checkbox-list"></ul>',
            li: '<li><label></label></li>',
        }
    });
    $('#exp-sch-routes').multiselect({
        maxHeight: 350,
        numberDisplayed: 1,
        buttonWidth: '200px',
        enableFiltering: true,
        dropLeft: true,
        buttonClass: 'btn btn-default exp-sch-routes'
    });
    $(".has-popover").popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });
    $('#fao-sch-from').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '250px',
        dropLeft: true,
        includeSelectAllOption: true,
        selectAllText: 'All Routes',
        buttonClass: 'btn btn-default fao-sch-from'
    });
    $('#exp-sch-routes').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        includeSelectAllOption: true,
        selectAllText: 'All Routes',
        buttonClass: 'btn btn-default exp-sch-routes'
    });
    $('#fao-group-seat-sch').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default fao-group-seat-sch'
    });
    $('#exp-sch-group').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default exp-sch-group'
    });
    $('#fao-fare-ovr-seat-type').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '100%',
        dropLeft: true,
        buttonClass: 'btn btn-default fao-fare-ovr-seat-type'
    });
    $(".has-popover").popover({
        trigger: 'hover',
        placement : 'right',
        html: true
    });
    $('#fao-date-filter').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        changeMonth: true,
        startDate: '0d',
    });
</script>

<script>
    function toggleFareOverrideForm() {
        !$('#fao-form-div').is(':visible') && $('#fao-form-div').slideToggle();
    }

    function closeFareOverrideForm() {
        $('#fao-form-div').is(':visible') && $('#fao-form-div').slideToggle();
    }

    function renderFaoRow() {
        $('#fao-list-table-div').html($('#fao-table-template').html());
        var $trtpl = $($('#fao-row-template').html());
        var $dowtpl = $($('#dow-template').html());
        var $tbody = $('#fao-list-table-body').html('');

        var $tablediv = $('#fao-list-table-div');
        $tablediv.find('.fao-count').html(schfareOverride.length);
        $tablediv.find('.fao-filter-btn').on('click', function() {
            clearFareOverrideFilter();
            $('#fao-search-filter').slideToggle();
        });

        $.each(schfareOverride || [], function (i, schfare) {
            if(filterFaoList(schfare)) {
                return;
            }
            var $tr = $trtpl.clone();
            $tr.attr('id', 'fareover-' + schfare.code);
            if(schfare.overrideList.length > 0) {
                $tr.addClass('trhover').attr('onclick', "viewFareExceptionOverride(event, '" + schfare.code + "')");
            }
            $tr.find('.fao-caret').toggleClass('caret', schfare.overrideList.length != 0);

            $tr.find('.fao-date').html(function() {
                var txt = moment(schfare.activeFrom).format('DD-MM-YYYY');
                if(schfare.activeTo != schfare.activeFrom) {
                    txt += ' <span class="glyphicon glyphicon-resize-horizontal"></span> ' + moment(schfare.activeTo).format('DD-MM-YYYY');
                }
                return txt;
            });
            $tr.find('.fao-label').html(function() {
                if(schfare.daysDiff1 < 0) {
                    return '<span class="label label-default">Expired</span>';
                } else if(schfare.daysDiff >= 10 && schfare.daysDiff1 < 30) {
                    return '<span class="label label-danger">Ending soon</span>';
                }
                if(schfare.recordage <=15) {
                    return '<span title="' + schfare.recordage + ' min ago created this" class="label label-success">New</span>';
                }
            });

            $tr.find('.fao-route').html(function() {
                if(schfare.routeList.length == 0) {
                    return 'All Routes';
                }
                var a = '';
                if(schfare.routeList.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + schfare.routeList.length + '</span>' +
                        '</a>';
                }
                return schfare.routeList[0].fromStation.name + ' - ' + schfare.routeList[0].toStation.name + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(schfare.routeList, function(routeList) {
                        return routeList.fromStation.name + ' - ' + routeList.toStation.name;
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-group').html(function() {
                if(schfare.groupList.length == 0) {
                    return 'All Group';
                }
                var a = '';
                if(schfare.groupList.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + schfare.groupList.length + '</span>' +
                        '</a>';
                }
                return schfare.groupList[0].name + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(schfare.groupList, function(groupList) {
                        return groupList.name;
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-seattype').html(function() {
                if(schfare.busSeatTypeCodes.length == 0) {
                    return 'All Seat Types';
                }
                var a = '';
                if(schfare.busSeatTypeCodes.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + schfare.busSeatTypeCodes.length + '</span>' +
                        '</a>';
                }
                return confSeatType[schfare.busSeatTypeCodes[0]] + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(schfare.busSeatTypeCodes, function(busSeatTypeCodes) {
                        return confSeatType[busSeatTypeCodes];
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-fare').html(function() {
                if(schfare.fareType == 'FLT') {
                    return 'Rs. ' + schfare.fare;
                } else {
                    return schfare.fare + ' %';
                }
            });

            $tr.find('.fao-faretype').html(function() {
                if(schfare.fareOverrideType == 'FLFA') {
                    return 'Final Fare';
                } else if(schfare.fareOverrideType == 'DRFA'){
                    return 'Offer';
                } else {
                    return 'Increase Fare';
                }
            });

            $tr.find('.fao-dow').html(function() {
                if(schfare.dayOfWeek == '1111111') {
                    return 'All Days'
                }
                var dweek = schfare.dayOfWeek.split('');
                return $dowtpl.clone().find('label').each(function(i) {
                    $(this).toggleClass('active', dweek[i] === '1');
                }).parent();
            });

            $tr.find('.fao-departure').html(function() {
                if(schfare.overrideMinutes == 0) {
                    return 'Always';
                } else {
                    return schfare.overrideMinutes/60 + ' hrs';
                }
            });

            $tr.find('.fao-edit').attr('onclick', "showSheduleOverrideDialog('" + schfare.code + "', '" + schfare.fare + "', '" + schfare.fareType + "', '" + schfare.fareOverrideType + "', '', '" + schfare.dateType + "', '" + schfare.activeFrom + "', '" + schfare.activeTo + "', '" + schfare.dayOfWeek + "', '', '', '" + schfare.overrideMinutes + "', '" + schfare.busSeatTypeCode + "', 1)");
            $tr.find('.fao-delete').attr('onclick', "deleteScheduleOverride('" + schfare.code + "')");
            $tr.find('.fao-excep').attr('onclick', "fareOverrideExceptionDialog('" + schfare.code + "')");
            $tr.find('.fao-over').attr('onclick', "showSheduleOverrideDialog('', '" + schfare.code + "', 2)");
            $tr.find('.fao-user').tooltip({
                html: true,
                title: function () {
                    return schfare.user.name + '<br/>' + moment(schfare.updateAt).format('DD-MM-YYYY h:mm A');
                }
            });

            $tbody.append($tr);

            if(schfare.overrideList.length) {
                renderFaoExpRow(schfare);
                renderFaoOvrRow(schfare);
            }
        });

        !$tbody.find('tr').length && $tbody.append('<tr><td colspan="100%" class="well text-center">No details dound</td></tr>');
    }

    function renderFaoExpRow(schfare) {
        var $exptpl = $($('#fao-exp-template').html());
        var $trtpl = $($('#fao-exp-row-template').html());
        var $dowtpl = $($('#dow-template').html());
        var $tbody = $exptpl.find('#fao-exp-list-table');

        $exptpl.addClass('routes-sch-exp-' + schfare.code);
        $exptpl.find('.heading').attr('id', 'over-' + schfare.code);

        $('#fao-list-table-body').append($exptpl);

        $.each(schfare.overrideList || [], function (i, faoexp) {
            if(faoexp.fare != -1) {
                return;
            }
            var $tr = $trtpl.clone();

            $tr.addClass('st-eo-del-' + faoexp.code);

            $tr.find('.fao-exp-route').html(function() {
                if(faoexp.routeList.length == 0) {
                    return 'All Routes';
                }
                var a = '';
                if(faoexp.routeList.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + faoexp.routeList.length + '</span>' +
                        '</a>';
                }
                return faoexp.routeList[0].fromStation.name + ' - ' + faoexp.routeList[0].toStation.name + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(faoexp.routeList, function(routeList) {
                        return routeList.fromStation.name + ' - ' + routeList.toStation.name;
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-exp-group').html(function() {
                if(faoexp.groupList.length == 0) {
                    return 'All Group';
                }
                var a = '';
                if(faoexp.groupList.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + faoexp.groupList.length + '</span>' +
                        '</a>';
                }
                return faoexp.groupList[0].name + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(faoexp.groupList, function(groupList) {
                        return groupList.name;
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-exp-date').html(function() {
                var txt = moment(faoexp.activeFrom).format('DD-MM-YYYY');
                if(faoexp.activeTo != faoexp.activeFrom) {
                    txt += ' <span class="glyphicon glyphicon-resize-horizontal"></span> ' + moment(faoexp.activeTo).format('DD-MM-YYYY');
                }
                return txt;
            });

            $tr.find('.fao-exp-dow').html(function() {
                if(faoexp.dayOfWeek == '1111111') {
                    return 'All Days'
                }
                var dweek = faoexp.dayOfWeek.split('');
                return $dowtpl.clone().find('label').each(function(i) {
                    $(this).toggleClass('active', dweek[i] === '1');
                }).parent();
            });

            $tr.find('.fao-exp-edit').attr('onclick', "fareOverrideExceptionDialog('" + schfare.code + "', this)").attr({
                'data-code' : schfare.code,
                'data-daysofweek' : faoexp.dayOfWeek,
                'data-date' : faoexp.activeFrom + ' | '  +faoexp.activeTo,
                'data-ecode' : faoexp.code
            });
            $tr.find('.fao-exp-delete').attr('onclick', "deleteScheduleOverrideException('" + schfare.code + "', '" + faoexp.code + "')");

            $tbody.append($tr);
        });

        $exptpl.children('td').toggle($tbody.find('tr').length !== 0);
    }

    function renderFaoOvrRow(schfare) {
        var $exptpl = $($('#fao-ovr-template').html());
        var $trtpl = $($('#fao-ovr-row-template').html());
        var $dowtpl = $($('#dow-template').html());
        var $tbody = $exptpl.find('#fao-ovr-list-table');

        $exptpl.addClass('routes-sch-ove-' + schfare.code);
        $exptpl.find('.heading').attr('id', 'over-' + schfare.code);

        $('#fao-list-table-body').append($exptpl);

        $.each(schfare.overrideList || [], function (i, faoexp) {
            if(faoexp.fare == -1) {
                return;
            }
            var $tr = $trtpl.clone();

            $tr.addClass('st-eo-del-' + faoexp.code);

            $tr.find('.fao-ovr-route').html(function() {
                if(faoexp.routeList.length == 0) {
                    return 'All Routes';
                }
                var a = '';
                if(faoexp.routeList.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + faoexp.routeList.length + '</span>' +
                        '</a>';
                }
                return faoexp.routeList[0].fromStation.name + ' - ' + faoexp.routeList[0].toStation.name + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(faoexp.routeList, function(routeList) {
                        return routeList.fromStation.name + ' - ' + routeList.toStation.name;
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-ovr-group').html(function() {
                if(faoexp.groupList.length == 0) {
                    return 'All Group';
                }
                var a = '';
                if(faoexp.groupList.length > 1) {
                    a += '<a href="javascript:;" data-toggle="popover" class="has-popover">' +
                            '<span class="label label-success">' + faoexp.groupList.length + '</span>' +
                        '</a>';
                }
                return faoexp.groupList[0].name + ' ' + a;
            }).find('.has-popover').popover({
                html: true,
                trigger: 'hover',
                placement : 'right',
                content: function() {
                    return $.map(faoexp.groupList, function(groupList) {
                        return groupList.name;
                    }).join('<br/>');
                }
            });

            $tr.find('.fao-ovr-date').html(function() {
                var txt = moment(faoexp.activeFrom).format('DD-MM-YYYY');
                if(faoexp.activeTo != faoexp.activeFrom) {
                    txt += ' <span class="glyphicon glyphicon-resize-horizontal"></span> ' + moment(faoexp.activeTo).format('DD-MM-YYYY');
                }
                return txt;
            });

            $tr.find('.fao-ovr-dow').html(function() {
                if(faoexp.dayOfWeek == '1111111') {
                    return 'All Days'
                }
                var dweek = faoexp.dayOfWeek.split('');
                return $dowtpl.clone().find('label').each(function(i) {
                    $(this).toggleClass('active', dweek[i] === '1');
                }).parent();
            });

            $tr.find('.fao-ovr-fare').html(function() {
                if(faoexp.fareType == 'FLT') {
                    return 'Rs. ' + faoexp.fare;
                } else {
                    return faoexp.fare + ' %';
                }
            });

            $tr.find('.fao-ovr-faretype').html(function() {
                if(faoexp.fareOverrideType == 'FLFA') {
                    return 'Final Fare';
                } else if(faoexp.fareOverrideType == 'DRFA'){
                    return 'Offer';
                } else {
                    return 'Increase Fare';
                }
            });

            $tr.find('.fao-ovr-edit').attr('onclick', "showSheduleOverrideDialog('" + schfare.code + "', '" + schfare.fare + "', '" + schfare.fareType + "', '" + schfare.fareOverrideType + "', '', '" + schfare.dateType + "', '" + schfare.activeFrom + "', '" + schfare.activeTo + "', '" + schfare.dayOfWeek + "', '', '', '" + schfare.overrideMinutes + "', '" + schfare.busSeatTypeCode + "', 1, this)");
            $tr.find('.fao-ovr-delete').attr('onclick', "deleteScheduleOverrideException('" + schfare.code + "', '" + faoexp.code + "')");

            $tbody.append($tr);
        });

        $exptpl.children('td').toggle($tbody.find('tr').length !== 0);
    }

    function filterFaoList(schfare) {
        var datefilter = $('#fao-date-filter').val();

        if(datefilter == '') {
            return false;
        }
        var datefilter = moment(datefilter, 'YYYY-MM-DD').valueOf();
        return !(moment(schfare.activeFrom).valueOf() <= datefilter && datefilter <= moment(schfare.activeTo).valueOf());
    }
</script>