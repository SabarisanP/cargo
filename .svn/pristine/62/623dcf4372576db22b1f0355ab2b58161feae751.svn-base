<div class="brand_top">
    <h3> Sector</h3>
    <span class="align-right">
        <a class="btn btn-success btn-sm" href="javascript:;" onclick="showSectorDialog();">Add Sector</a>
    </span>
</div>

<div class="page_content">
    <div id="container-fluid">
        <div class="row">
            <div id="contents" class="col-lg-12">
                <!-- PAGE HEADER-->
                <div class="row">
                    <div style="clear: both;"></div><br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="panel-body">
                                    <div class="tabbable tabs-left">
                                        <ul class="nav nav-tabs" id="sector-tabs">
                                            {foreach from=$sector item=row}
                                                <li><a id="sector-{$row->code}-tab" data-code="{$row->code}" data-name="{$row->name}" data-toggle="tab" href="#sector-{$row->code}" role="tab" aria-controls="sector-{$row->code}" aria-selected="false">{$row->name}</a></li>
                                                {/foreach}
                                        </ul>
                                        <div class="tab-content" id="tabs_content_extra">
                                            <div id="bulk_station_point_exception" class="tab-pane active fade in">
                                                <div id="sector-well-div">
                                                    <div class="well">
                                                        Please select an option in left panel to view sector.
                                                    </div>
                                                </div>
                                                <div class="hide col-md-12" id="sector-form-div">
                                                    <div class="col-md-6">
                                                        <div class="heading_b">
                                                            <span id="sector-title">Quick Book</span>
                                                            <div class="btn-group pull-right">
                                                                <a href="javascript:;" class="btn btn-default" title="Edit Sector" data-toggle="tooltip" onclick="showSectorDialog();">
                                                                    <i class="fa fa-pencil igreen"></i>
                                                                </a>
                                                            </div>
                                                            <div class="clear_fix_both"></div>
                                                        </div>
                                                        <div class="clear_fix_both"></div>
                                                        <div>
                                                            <ul class="nav nav-tabs tabs-top" id="tabs_a">
                                                                <li class="active"><a data-toggle="tab" id="schedule-tab" href="#schedule-cont">Schedule (<span class="count"></span>)</a></li>
                                                                <li><a data-toggle="tab" id="vehicle-tab" href="#vehicle-cont">Vehicle (<span class="count"></span>)</a></li>
                                                                <li><a data-toggle="tab" id="organization-tab" href="#organization-cont">Organization (<span class="count"></span>)</a></li>
                                                                <li><a data-toggle="tab" id="station-tab" href="#station-cont">Station (<span class="count"></span>)</a></li>
                                                            </ul>
                                                            <div class="tab-content clear_fix_both" id="tabs_content_a">
                                                                <div id="schedule-cont" class="tab-pane fade in active">
                                                                    <div class="clear_fix_both"></div><br/>
                                                                    <div class="well well-sm">
                                                                        <div class="row">
                                                                            <div class="col-md-7 clearfix">
                                                                                <a class="btn btn-default btn-sm" href="javascript:;" title="Add New Schedule" onclick="showScheduleDialog();"><i class="fa fa-plus"></i></a>
                                                                            </div>
                                                                            <div class="col-md-5 clearfix">
                                                                                <div>
                                                                                    <input type="search" class="form-control input-sm" id="schedule-search">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <table class="table" id="schedule-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="bold">Name</td>
                                                                                    <td class="bold">Service No</td>
                                                                                    <td width="10%"></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>

                                                                <div id="vehicle-cont" class="tab-pane fade">
                                                                    <div class="clear_fix_both"></div><br/>
                                                                    <div class="well well-sm">
                                                                        <div class="row">
                                                                            <div class="col-md-7 clearfix">
                                                                                <a class="btn btn-default btn-sm" href="javascript:;" title="Add New Vehicle" onclick="showVehicleDialog();"><i class="fa fa-plus"></i></a>
                                                                            </div>
                                                                            <div class="col-md-5 clearfix">
                                                                                <div>
                                                                                    <input type="search" class="form-control input-sm" id="vehicle-search">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <table class="table" id="vehicle-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="bold">Registation Number</td>
                                                                                    <td width="10%"></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>

                                                                <div id="organization-cont" class="tab-pane fade">
                                                                    <div class="clear_fix_both"></div><br/>
                                                                    <div class="well well-sm">
                                                                        <div class="row">
                                                                            <div class="col-md-7 clearfix">
                                                                                <a class="btn btn-default btn-sm" href="javascript:;" title="Add New Organization" onclick="showOrganizationDialog();"><i class="fa fa-plus"></i></a>
                                                                            </div>
                                                                            <div class="col-md-5 clearfix">
                                                                                <div>
                                                                                    <input type="search" class="form-control input-sm" id="organization-search">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <table class="table" id="organization-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="bold">Name</td>
                                                                                    <td width="10%"></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>

                                                                <div id="station-cont" class="tab-pane fade">
                                                                    <div class="clear_fix_both"></div><br/>
                                                                    <div class="well well-sm">
                                                                        <div class="row">
                                                                            <div class="col-md-7 clearfix">
                                                                                <a class="btn btn-default btn-sm" href="javascript:;" title="Add New Station" onclick="showStationDialog();"><i class="fa fa-plus"></i></a>
                                                                            </div>
                                                                            <div class="col-md-5 clearfix">
                                                                                <div>
                                                                                    <input type="search" class="form-control input-sm" id="station-search">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="table-responsive">
                                                                        <table class="table" id="station-table">
                                                                            <thead>
                                                                                <tr>
                                                                                    <td class="bold">Name</td>
                                                                                    <td width="10%"></td>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>

                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <h5>Users</h5>
                                                        <div>
                                                            <div id="sec-usr-load"></div>
                                                            <div id="sec-usr-list" class="hide">
                                                                {foreach from=$groupusers['groupusers'] key=groupname item=group}
                                                                    <h6><b>{$groupname}</b></h6>
                                                                    <div class="row">
                                                                        {foreach from=$group item=user}
                                                                            {if $user['activeFlag'] == 1}
                                                                                <div class="col-md-4">
                                                                                    <label class="checkbox-inline">
                                                                                        <input type="checkbox" id="usr-{$user['code']}" class="user-sector-map-cb {$user['code']}" data-user="{$user['code']}" value="1">&nbsp;{$user['name']}
                                                                                    </label>
                                                                                </div>
                                                                            {/if}
                                                                        {/foreach}
                                                                    </div>
                                                                {/foreach}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hid-sector-code">

<div id="sector-dialog" class="hide dialog-content-page">
    <form role="form" id="sector-update-form"class="form-horizontal " onsubmit="return false;">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="sector-name" class="req">Name</label>
                <input type="text" placeholder="Name" id="sector-name" class="form-control">
            </div>
        </div>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="clear_fix_both"></div> <br>
            <div class="alert fl col-md-12" style="display: none;" id="sector-action-state"></div>
        </div>
    </form>
    <div class="row">
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveSector();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelSectorDialog();">Cancel</button>
        </div>
    </div>
</div>

<div id="schedule-dialog" class="hide dialog-content-page">
    <form role="form" id="schedule-update-form"class="form-horizontal " onsubmit="return false;">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="sector-schedule" class="req">Schedule</label>
                <select id="sector-schedule" class="form-control" multiple>
                    {foreach from=$schedules item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="clear_fix_both"></div> <br>
            <div class="alert fl col-md-12" style="display: none;" id="schedule-action-state"></div>
        </div>
    </form>
    <div class="row">
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveSchedule();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelScheduleDialog();">Cancel</button>
        </div>
    </div>
</div>

<div id="vehicle-dialog" class="hide dialog-content-page">
    <form role="form" id="vehicle-update-form"class="form-horizontal " onsubmit="return false;">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="sector-vehicle" class="req">Vehicle</label>
                <select id="sector-vehicle" class="form-control" multiple>
                    {foreach from=$vehicles item=row}
                        <option value="{$row->code}">{$row->registationNumber}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="clear_fix_both"></div> <br>
            <div class="alert fl col-md-12" style="display: none;" id="vehicle-action-state"></div>
        </div>
    </form>
    <div class="row">
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveVehicle();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelVehicleDialog();">Cancel</button>
        </div>
    </div>
</div>

<div id="organization-dialog" class="hide dialog-content-page">
    <form role="form" id="organization-update-form"class="form-horizontal " onsubmit="return false;">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="sector-organization" class="req">Organization</label>
                <select id="sector-organization" class="form-control" multiple>
                    {foreach from=$organizations item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="clear_fix_both"></div> <br>
            <div class="alert fl col-md-12" style="display: none;" id="organization-action-state"></div>
        </div>
    </form>
    <div class="row">
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveOrganization();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelOrganizationDialog();">Cancel</button>
        </div>
    </div>
</div>

<div id="station-dialog" class="hide dialog-content-page">
    <form role="form" id="station-update-form"class="form-horizontal " onsubmit="return false;">
        <div class="col-lg-12 p_l_n p_r_n">
            <div>
                <label for="sector-station" class="req">Station</label>
                <select id="sector-station" class="form-control" multiple>
                    {foreach from=$stations item=row}
                        <option value="{$row->code}">{$row->name}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="col-lg-12 p_l_n p_r_n">
            <div class="clear_fix_both"></div> <br>
            <div class="alert fl col-md-12" style="display: none;" id="station-action-state"></div>
        </div>
    </form>
    <div class="row">
        <div class="align-right cre_sve" id="form-bttons">
            <button class="btn btn-success" type="button" onclick="saveStation();">Save</button>
            <button class="btn btn-default" type="button" onclick="cancelStationDialog();">Cancel</button>
        </div>
    </div>
</div>

<script>
    var sectorDataRaw = {$sector|json_encode};
    var sectorData = {};

    $.each(sectorDataRaw, function (i, e) {
        sectorData[e.code] = e;
    });

    $('#sector-schedule').multiselect({
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        templates: {
            filterClearBtn: ''
        },
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default sector-schedule'
    });
    $('#sector-vehicle').multiselect({
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        templates: {
            filterClearBtn: ''
        },
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default sector-vehicle'
    });
    $('#sector-organization').multiselect({
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        templates: {
            filterClearBtn: ''
        },
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default sector-organization'
    });
    $('#sector-station').multiselect({
        enableFiltering: true,
        enableCaseInsensitiveFiltering: true,
        templates: {
            filterClearBtn: ''
        },
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default sector-station'
    });

    var dtoptions = {
        sDom: '',
        paging: false,
        info: false
    };
    var dtschedule = $('#schedule-table').DataTable(dtoptions);
    var dtvehicle = $('#vehicle-table').DataTable(dtoptions);
    var dtorganization = $('#organization-table').DataTable(dtoptions);
    var dtstation = $('#station-table').DataTable(dtoptions);

    $('#schedule-search').on('keyup change', function () {
        dtschedule.search(this.value).draw();
    });
    $('#vehicle-search').on('keyup change', function () {
        dtvehicle.search(this.value).draw();
    });
    $('#organization-search').on('keyup change', function () {
        dtorganization.search(this.value).draw();
    });
    $('#station-search').on('keyup change', function () {
        dtstation.search(this.value).draw();
    });

    $('#sector-tabs a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $('#sector-form-div').removeClass('hide');
        $('#sector-well-div').addClass('hide');

        var $tab = $(e.target);
        $('#sector-title').text($tab.data('name'));
        $('#hid-sector-code').val($tab.data('code'));
        getMappedUser($tab.data('code'));
        renderTables($tab.data('code'));
    });

    $('.user-sector-map-cb').on('change', mapUserSector);

    function showSectorDialog() {
        $('.inp_error').removeClass('inp_error');
        $('#sector-action-state').hide();
        $('#sector-dialog').css('background', '#fff');
        $('#sector-dialog').removeClass('hide');
        $('#sector-dialog').dialog({
            autoOpen: true,
            height: 250,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        var code = $('#hid-sector-code').val();

        if (_isdefined(code)) {
            var data = sectorData[code];
            $('#sector-name').val(data.name);
            $('#hid-sector-code').val(data.code);
        } else {
            $('#hid-sector-code').val('');
            $('#sector-name').val('');
        }
    }

    function cancelSectorDialog() {
        $('#sector-dialog').dialog('destroy');
        $('#sector-dialog').hide();
    }

    function saveSector() {
        var data = {};
        data.code = $.trim($('#hid-sector-code').val());
        data.name = $.trim($('#sector-name').val());

        var err = 0;
        if (data.name == '') {
            $('#sector-name').addClass('inp_error');
            err++;
        } else {
            $('#sector-name').removeClass('inp_error');
        }

        if (err > 0) {
            $('#sector-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#sector-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#sector-action-state').show();
            return false;
        } else {
            $('#sector-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#sector-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#sector-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#sector-action-state').html(loading_popup);
        $('#sector-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#sector-action-state').removeClass('alert-danger');
                    $('#sector-action-state').addClass('alert-success');
                    $('#sector-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelSectorDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#sector-action-state').addClass('alert-danger');
                    $('#sector-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function showScheduleDialog(code) {
        $('.inp_error').removeClass('inp_error');
        $('#schedule-action-state').hide();
        $('#schedule-dialog').css('background', '#fff');
        $('#schedule-dialog').removeClass('hide');
        $('#schedule-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        $('#sector-schedule').val([]).multiselect('rebuild');
    }

    function cancelScheduleDialog() {
        $('#schedule-dialog').dialog('destroy');
        $('#schedule-dialog').hide();
    }

    function saveSchedule() {
        var data = {};
        data.actionCode = 'ADD';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.schedule = $('#sector-schedule').val();

        var err = 0;
        if (data.schedule == null || data.schedule.length == 0) {
            $('.sector-schedule').addClass('inp_error');
            err++;
        } else {
            $('.sector-station').removeClass('inp_error');
        }

        if (err > 0) {
            $('#schedule-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#schedule-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#schedule-action-state').show();
            return false;
        } else {
            $('#schedule-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#schedule-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#schedule-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#schedule-action-state').html(loading_popup);
        $('#schedule-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-schedule",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#schedule-action-state').removeClass('alert-danger');
                    $('#schedule-action-state').addClass('alert-success');
                    $('#schedule-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelScheduleDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#schedule-action-state').addClass('alert-danger');
                    $('#schedule-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function showVehicleDialog(code) {
        $('.inp_error').removeClass('inp_error');
        $('#vehicle-action-state').hide();
        $('#vehicle-dialog').css('background', '#fff');
        $('#vehicle-dialog').removeClass('hide');
        $('#vehicle-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        $('#sector-vehicle').val([]).multiselect('rebuild');
    }

    function cancelVehicleDialog() {
        $('#vehicle-dialog').dialog('destroy');
        $('#vehicle-dialog').hide();
    }

    function saveVehicle() {
        var data = {};
        data.actionCode = 'ADD';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.vehicle = $('#sector-vehicle').val();

        var err = 0;
        if (data.vehicle == null || data.vehicle.length == 0) {
            $('.sector-vehicle').addClass('inp_error');
            err++;
        } else {
            $('.sector-vehicle').removeClass('inp_error');
        }

        if (err > 0) {
            $('#vehicle-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#vehicle-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#vehicle-action-state').show();
            return false;
        } else {
            $('#vehicle-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#vehicle-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#vehicle-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#vehicle-action-state').html(loading_popup);
        $('#vehicle-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-vehicle",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#vehicle-action-state').removeClass('alert-danger');
                    $('#vehicle-action-state').addClass('alert-success');
                    $('#vehicle-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelVehicleDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#vehicle-action-state').addClass('alert-danger');
                    $('#vehicle-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function showOrganizationDialog(code) {
        $('.inp_error').removeClass('inp_error');
        $('#organization-action-state').hide();
        $('#organization-dialog').css('background', '#fff');
        $('#organization-dialog').removeClass('hide');
        $('#organization-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        $('#sector-organization').val([]).multiselect('rebuild');
    }

    function cancelOrganizationDialog() {
        $('#organization-dialog').dialog('destroy');
        $('#organization-dialog').hide();
    }

    function saveOrganization() {
        var data = {};
        data.actionCode = 'ADD';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.organization = $('#sector-organization').val();

        var err = 0;
        if (data.organization == null || data.organization.length == 0) {
            $('.sector-organization').addClass('inp_error');
            err++;
        } else {
            $('.sector-organization').removeClass('inp_error');
        }

        if (err > 0) {
            $('#organization-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#organization-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#organization-action-state').show();
            return false;
        } else {
            $('#organization-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#organization-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#organization-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#organization-action-state').html(loading_popup);
        $('#organization-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-organization",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#organization-action-state').removeClass('alert-danger');
                    $('#organization-action-state').addClass('alert-success');
                    $('#organization-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelOrganizationDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#organization-action-state').addClass('alert-danger');
                    $('#organization-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function showStationDialog(code) {
        $('.inp_error').removeClass('inp_error');
        $('#station-action-state').hide();
        $('#station-dialog').css('background', '#fff');
        $('#station-dialog').removeClass('hide');
        $('#station-dialog').dialog({
            autoOpen: true,
            height: 350,
            width: 500,
            modal: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();

        $('#sector-station').val([]).multiselect('rebuild');
    }

    function cancelStationDialog() {
        $('#station-dialog').dialog('destroy');
        $('#station-dialog').hide();
    }

    function saveStation() {
        var data = {};
        data.actionCode = 'ADD';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.station = $('#sector-station').val();

        var err = 0;
        if (data.station == null || data.station.length == 0) {
            $('.sector-station').addClass('inp_error');
            err++;
        } else {
            $('.sector-station').removeClass('inp_error');
        }

        if (err > 0) {
            $('#station-action-state').removeClass('alert-success').addClass('alert-danger');
            $('#station-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#station-action-state').show();
            return false;
        } else {
            $('#station-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#station-action-state').hide();
        }

        $('#form-bttons').hide();
        $('#station-action-state').removeClass('alert-danger').removeClass('alert-success');
        $('#station-action-state').html(loading_popup);
        $('#station-action-state').show();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-station",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#form-bttons').hide();
                    $('#station-action-state').removeClass('alert-danger');
                    $('#station-action-state').addClass('alert-success');
                    $('#station-action-state').html('Your request has been completed successfully');
                    window.setTimeout(function () {
                        cancelStationDialog();
                        checkURL();
                        return;
                    }, 3000);
                } else {
                    $('#station-action-state').addClass('alert-danger');
                    $('#station-action-state').html(response.errorDesc);
                    $('#form-bttons').show();
                }
            }
        });
    }

    function deleteSchedules(code, btn) {
        if (!confirm('Do you want to delete this Schedule?')) {
            return;
        }
        var data = {};
        data.actionCode = 'REMOVE';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.schedule = [code];

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-schedule",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    sectorData[data.sectorCode] = response.data;
                    $('#schedule-tab .count').html(response.data.schedules.length);
                    $(btn).parents('tr').animate({
                        backgroundColor: '#1AA1E1'
                    }, 2000, function () {
                        dtschedule.row(this).remove().draw()
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
        });
    }

    function deleteVehicles(code, btn) {
        if (!confirm('Do you want to delete this Vehicle?')) {
            return;
        }
        var data = {};
        data.actionCode = 'REMOVE';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.vehicle = [code];

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-vehicle",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    sectorData[data.sectorCode] = response.data;
                    $('#vehicle-tab .count').html(response.data.vehicles.length);
                    $(btn).parents('tr').animate({
                        backgroundColor: '#1AA1E1'
                    }, 2000, function () {
                        dtvehicle.row(this).remove().draw()
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
        });
    }

    function deleteOrganizations(code, btn) {
        if (!confirm('Do you want to delete this Organization?')) {
            return;
        }
        var data = {};
        data.actionCode = 'REMOVE';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.organization = [code];

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-organization",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    sectorData[data.sectorCode] = response.data;
                    $('#organization-tab .count').html(response.data.organizations.length);
                    $(btn).parents('tr').animate({
                        backgroundColor: '#1AA1E1'
                    }, 2000, function () {
                        dtorganization.row(this).remove().draw()
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
        });
    }

    function deleteStations(code, btn) {
        if (!confirm('Do you want to delete this Station?')) {
            return;
        }
        var data = {};
        data.actionCode = 'REMOVE';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.station = [code];

        var loading_overlay = iosOverlay({
            text: "Deleting...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/update-sector-station",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    sectorData[data.sectorCode] = response.data;
                    $('#station-tab .count').html(response.data.stations.length);
                    $(btn).parents('tr').animate({
                        backgroundColor: '#1AA1E1'
                    }, 2000, function () {
                        dtstation.row(this).remove().draw()
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
        });
    }


    function renderTables(code) {
        dtschedule.destroy();
        dtvehicle.destroy();
        dtorganization.destroy();
        dtstation.destroy();

        var data = sectorData[code];

        var $delbtn = $('<a href="javascript:;" class="btn btn-default btn-sm" title="Delete"><i class="fa fa-trash-o ired"></i></a>');

        $('#schedule-tab .count').html(data.schedules.length);
        $('#schedule-table tbody').html('');
        $.each(data.schedules, function (i, obj) {
            var $tr = $('<tr/>');
            var del = $delbtn.clone().attr('onclick', "deleteSchedules('" + obj.code + "', this)").prop('outerHTML');
            $tr.append('<td>' + obj.name + '</td>');
            $tr.append('<td><span class="warning-text">' + obj.serviceNumber + '</span></td>');
            $tr.append('<td><div class="btn-group btn-group-xs">' + del + '</div></td>');
            $('#schedule-table tbody').append($tr);
        });

        $('#vehicle-tab .count').html(data.vehicles.length);
        $('#vehicle-table tbody').html('');
        $.each(data.vehicles, function (i, obj) {
            var $tr = $('<tr/>');
            var del = $delbtn.clone().attr('onclick', "deleteVehicles('" + obj.code + "', this)").prop('outerHTML');
            $tr.append('<td>' + obj.registationNumber + '</td>');
            $tr.append('<td><div class="btn-group btn-group-xs">' + del + '</div></td>');
            $('#vehicle-table tbody').append($tr);
        });

        $('#organization-tab .count').html(data.organizations.length);
        $('#organization-table tbody').html('');
        $.each(data.organizations, function (i, obj) {
            var $tr = $('<tr/>');
            var del = $delbtn.clone().attr('onclick', "deleteOrganizations('" + obj.code + "', this)").prop('outerHTML');
            $tr.append('<td>' + obj.name + '</td>');
            $tr.append('<td><div class="btn-group btn-group-xs">' + del + '</div></td>');
            $('#organization-table tbody').append($tr);
        });

        $('#station-tab .count').html(data.stations.length);
        $('#station-table tbody').html('');
        $.each(data.stations, function (i, obj) {
            var $tr = $('<tr/>');
            var del = $delbtn.clone().attr('onclick', "deleteStations('" + obj.code + "', this)").prop('outerHTML');
            $tr.append('<td>' + obj.name + '</td>');
            $tr.append('<td><div class="btn-group btn-group-xs">' + del + '</div></td>');
            $('#station-table tbody').append($tr);
        });

        dtschedule = $('#schedule-table').DataTable(dtoptions);
        dtvehicle = $('#vehicle-table').DataTable(dtoptions);
        dtorganization = $('#organization-table').DataTable(dtoptions);
        dtstation = $('#station-table').DataTable(dtoptions);
    }

    function mapUserSector() {
        var data = {};
        data.actionCode = $(this).is(':checked') ? 'ADD' : 'REMOVE';
        data.sectorCode = $.trim($('#hid-sector-code').val());
        data.userCode = $(this).data('user');

        var loading_overlay = iosOverlay({
            text: "Updating...",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/map-sector-user",
            data: data,
            success: function (response) {
                if (response.status == 1) {
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
                }, 1000);
            }
        });
    }

    function getMappedUser(code) {
        var data = {};
        data.sectorCode = code;

        $('.user-sector-map-cb:checked').prop('checked', false);
        $('#sec-usr-list').addClass('hide');
        $('#sec-usr-load').html(loading_small).removeClass('hide');

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/get-map-sector-user",
            data: data,
            success: function (response) {
                if (response.status == 1) {
                    $('#sec-usr-list').removeClass('hide');
                    $('#sec-usr-load').addClass('hide');
                    $.each(response.data, function (i, row) {
                        $('#usr-' + row.code).prop('checked', true);
                    });
                }
            }
        });
    }

</script>