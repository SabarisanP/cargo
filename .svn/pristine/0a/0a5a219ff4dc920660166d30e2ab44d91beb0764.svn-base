<div class="brand_top">
    <h3>TCS Report</h3>
    <div class="text-right noprint" id="excl_tcs" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTCSExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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

                                                <form id="tcs_rpt" method="post" name="tcs_rpt" action="report/tcs-report-list" onsubmit="return false;">
                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="tcs_rpt_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="tcs_rpt_date_from" readonly="true" placeholder="Date From">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="tcs_rpt_date_to" readonly="true" placeholder="Date To">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="tcs_rpt_date_to">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="tcs_rpt_date_opt" name="travelDateFlag"  class="form-control" >
                                                                    <option value="0">Transaction Date</option>
                                                                    <option value="1">Travel Date</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="tcs_rpt_date_to">User Group</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="tcs_rpt_user_group" name="groupCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Group/Roles</option>
                                                                    {foreach name=o item=row from=$groupusers.groups}
                                                                        <option  value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="tcs_rpt_date_to">Users</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="tcs_rpt_user_code" name="userCode"  class="form-control" >
                                                                    <option value='NA' selected="">All Users</option>
                                                                    {foreach name=g item=group key=groupname from=$groupusers.groupusers}
                                                                        <optgroup label="{$groupname}">
                                                                            {foreach name=u item=usr from=$group}
                                                                                <option  value="{$usr.code}">{$usr.name}</option>
                                                                            {/foreach}
                                                                        </optgroup>
                                                                    {/foreach}
                                                                </select>
                                                            </div>

                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button"  onclick="getTCSReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearTCSReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="tcs_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden noprint" id="tcs-report-list-graph">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <!--<div class="col-sm-4">
                                        <div class="bold" align="center">Overall Summary</div>
                                        <div id="cancel-booking-graph1"  style="height:150px;"></div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="bold" align="center">Group Wise Bookings</div>
                                        <div id="cancel-booking-graph2"  style="height:150px;"></div>
                                    </div>-->
                                    <div class="col-sm-offset-4 col-sm-4" align="center">
                                        <div class="bold">Group Wise Cancells</div>
                                        <div id="cancel-booking-graph3"  style="height:150px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="tcs-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="tcs-report-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_tcs_downloader" id="ifrm_tcs_downloader" style="display:none"></iframe>

{literal}
<script>
    $('#tcs_rpt_date_from').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function (e) {
    });

    $('#tcs_rpt_date_to').datepicker({
        todayHighlight: true,
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    }).on('changeDate', function (e) {
    });

    function exportTCSExcel() {
        document.tcs_rpt.target = "ifrm_tcs_downloader";
        $('#export').val(1);
        document.tcs_rpt.submit();
        return;
    }

    function getTCSReport() {
        $('#tcs-report-list').html('');
        var data = {};
        data.fromDate = $('#tcs_rpt_date_from').val();
        data.toDate = $('#tcs_rpt_date_to').val();
        data.travelDateFlag = $('#tcs_rpt_date_opt').val();
        data.groupCode = $('#tcs_rpt_user_group').val();
        data.userCode = $('#tcs_rpt_user_code').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.travelDateFlag == '') {
            $('#tcs_rpt_date_opt').addClass('inp_error');
            err++;
        }

        if (data.fromDate == '') {
            $('#tcs_rpt_date_from').addClass('inp_error');
            err++;
        }
        if (data.toDate == '') {
            $('#tcs_rpt_date_to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#tcs_rpt_action_state').removeClass('alert-success hide').addClass('alert-danger');
            $('#tcs_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#tcs_rpt_action_state').show();
            return false;
        } else {
            $('#tcs_rpt_action_state').removeClass('alert-success alert-danger');
            $('#tcs_rpt_action_state').html('');
            $('#tcs_rpt_action_state').hide();
        }

        $('#tcs-report-list-container').removeClass('hidden');
        $('#tcs-report-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/tcs-report-list",
            data: data,
            success: function (response) {
                $('#tcs-report-list').html(response);
                $('#excl_tcs').show();
                $('html, body').animate({
                    scrollTop: $('#tcs-report-list-graph').offset().top - 35
                }, 'slow');
            }
        });
    }

    function clearTCSReport() {
        $('.inp_error').removeClass('inp_error');
        $('#tcs_rpt_date_from').val('');
        $('#tcs_rpt_date_to').val('');
        $('#tcs_rpt_date_opt').val(0);
        $('#tcs_rpt_user_group').val('NA');
        $('#tcs_rpt_user_code').val('NA');
        $('#tcs_rpt_action_state').hide().removeClass('alert-success alert-danger').html('');
        $('#tcs-report-list-container').addClass('hidden');
        $('#tcs-report-list').html('');
        $('#excl_tcs').hide();
    }
</script>
{/literal}
