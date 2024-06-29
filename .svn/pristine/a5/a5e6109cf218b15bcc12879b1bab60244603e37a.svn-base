<div class="brand_top">
    <h3>Day Closing Report</h3>
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportDayClosingReport()"><i class="fa fa-download fa-lg"></i>Excel</button>  
            {* <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button> *}
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content">
        <div id="container-fluid">
            <div class="row">
                <div id="contents" class="col-lg-12"> <br>
                    <!-- PAGE HEADER-->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div class="col-md-12">
                                        <div class="">
                                            <div id="search-panel">
                                                <form id='day_closing_report' method="post" name="day_closing_report" method="post" action="report/day-closing-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label class="req" for="from-date">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="from-date" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label class="req" for="to-date">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="to-date" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label  for="day-closing-report-branch" class="">Branch</label>
                                                            <select class="form-control" id="day-closing-report-branch" name="organizationCode" data-type="BRN" onchange="disableOtherFilter(this)">
                                                                <option value="NA">Select Branch</option>
                                                                {foreach from=$organization item=val}
                                                                    <option value="{$val->code}" {if $logged_in_usr_org_code == $val->code}selected{/if}>{$val->name}</option>
                                                                {/foreach}
                                                            </select>  
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="day-closing-report-station" class="">Zone / Station</label>
                                                            <select class="form-control" id="day-closing-report-station" name="stationCodes" data-type="STN" onchange="disableOtherFilter(this)">
                                                                <option value="">Select</option>
                                                                {if $zone|count > 0}
                                                                    <optgroup label="Zone">
                                                                        {foreach item=row from=$zone}
                                                                            <option value="{$row['code']|rtrim:','}">{$row['name']}</option>
                                                                        {/foreach}
                                                                    </optgroup>
                                                                {/if}
                                                                {if $stations|count > 0}
                                                                    <optgroup label="Station">
                                                                        {foreach item=val from=$stations}
                                                                            <option value="{$val.code}">{$val.name}</option>
                                                                        {/foreach}
                                                                    </optgroup>
                                                                {/if}
                                                            </select>  
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="day-closing-report-user">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="day-closing-report-user" name="userCode"  class="form-control" data-type="USER" onchange="disableOtherFilter(this)">
                                                                    <option value='NA' selected="">Select</option>
                                                                    {foreach name=o item=row from=$users}                                                                            
                                                                        <option value='{$row->code}' data-org="{$row->organization->code}">{$row->name}</option>                                                                                
                                                                    {/foreach}
                                                                </select>       
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="form-group col-md-2">
                                                            <label>&nbsp;</label>
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button"  onclick="generateDayClosingReport();" >Generate</button>
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearDayClosingReport();">Clear</button>
                                                        </div>
                                                    </div>
                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="day-closing-report-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="day-closing-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="day-closing-report-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="day-closing-rpt-details-dialog"  class="dialog-content-page hide">
    <div id="day-closing-details-list"></div>     
</div>
<iframe id="ifrm_downloader" name="ifrm_downloader" style="display: none"></iframe>

<script>
    var userOption = $('#day-closing-report-user option');
    var emptyOrgOption = '<option value="">Select User</option>';

    $('#from-date').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        startDate: '-6m',
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#to-date').datepicker('setStartDate', e.date);
        $("#to-date").datepicker("setEndDate", end)
    });
    $('#to-date').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
        $('#from-date').datepicker('setEndDate', e.date)
    });
    
    $('#day-closing-report-station').select2();
    $('#day-closing-report-branch').select2();
    $('#day-closing-report-user').select2();

    $('#day-closing-report-branch').on('change', function () {
        var branch = $(this).val();
        $('#day-closing-report-user').html( function () {
            if (branch != 'NA') {
                return userOption.filter( function () {
                    return $(this).data('org') == branch;
                });
            } else {
                return userOption;
            }
        }).prepend(emptyOrgOption).val('').trigger('change');
    }).trigger('change');

    function generateDayClosingReport() {
        var err = 0;
        $('.inp_error').removeClass('inp_error');
        $('#day-closing-report-list').html('');

        var data = {};
        data.fromDate = $('#from-date').val();
        data.toDate = $('#to-date').val();
        data.organizationCode = $('#day-closing-report-branch').val();
        data.userCode = $('#day-closing-report-user').val();
        data.stationCodes = $('#day-closing-report-station').val();

        if ($('#from-date').val() == '') {
            $('#from-date').addClass('inp_error');
            err++;
        }

        if ($('#to-date').val() == '') {
            $('#to-date').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#day-closing-report-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#day-closing-report-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#day-closing-report-action-state').show();
            return false;
        } else {
            $('#day-closing-report-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#day-closing-report-action-state').html('');
            $('#day-closing-report-action-state').hide();
        }

        $('#day-closing-report-list-container').removeClass('hidden');
        $('#day-closing-report-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/day-closing-report-list",
            data: data,
            success: function (response) {
                $('#day-closing-report-list').html(response);
                $('#excl_cons').show();
            }
        });
    }

    function clearDayClosingReport() {
        $('#from-date').val('').datepicker('setEndDate', '');
        $('#to-date').val('').datepicker('setStartDate', '');
        $('#day-closing-report-branch').val('NA').trigger('change');
        $('#day-closing-report-user').val('').trigger('change');
        $('#day-closing-report-station').val('').trigger('change');

        $('#day-closing-report-list-container').addClass('hidden');
        $('#day-closing-report-list').html('');
        $('.inp_error').removeClass('inp_error');
        
        $('#day-closing-report-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#day-closing-report-action-state').html('');
        $('#day-closing-report-action-state').hide();
        $('#excl_cons').hide();
    }

    function getUserDetailsDialog(userCode, orgCode, stationCodes) {
        event && event.stopPropagation();

        $('#day-closing-rpt-details-dialog').css('background', '#fff');
        $('#day-closing-rpt-details-dialog').removeClass('hide');
        $('#day-closing-rpt-details-dialog').dialog({
            autoOpen: true,
            height: 600,
            // width: 1500,
            width: $(window).width() - 100,
            modal: true,
            resizable: false,
            closeOnEscape: true,
        });
        $('.ui-dialog-titlebar').hide();

        var data = {};
        data.fromDate = fromDate;
        data.toDate = toDate;
        data.organizationCode = orgCode;
        data.userCode = userCode;
        data.reportType = 'DETAILS';
        data.stationCodes = stationCodes;

        $('#day-closing-details-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/day-closing-report-details-list",
            data: data,
            success: function (response) {
                $('#day-closing-details-list').html(response);
            }
        })
    }

    function closeUserDetailsDialog() {
        $('#day-closing-rpt-details-dialog').addClass('hide');
        $('#day-closing-rpt-details-dialog').dialog('destroy');
    }

    function exportDayClosingReport() {
        document.day_closing_report.target = "ifrm_downloader";
        $('#export').val(1);
        document.day_closing_report.submit();
        return;
    }

    function disableOtherFilter(ele) {
        var type = $(ele).data('type');
        var value = $(ele).val();
        $('#day-closing-report-branch ,#day-closing-report-station, #day-closing-report-user').prop('disabled', false);
        if (value != "NA" && value != "") {
            if (type == "BRN") {
                $('#day-closing-report-station, #day-closing-report-user').prop('disabled', true);
            } else if (type == "STN") {
                $('#day-closing-report-branch, #day-closing-report-user').prop('disabled', true);
            } else if (type == "USER") {
                $('#day-closing-report-branch ,#day-closing-report-station').prop('disabled', true);
            }
        }
    }
</script>