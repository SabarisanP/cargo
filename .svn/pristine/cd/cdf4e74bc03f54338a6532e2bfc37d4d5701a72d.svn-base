<div class="brand_top">
    <h3>Branch Collections Report</h3>
    <div class="text-right noprint hidden" id="brcol-export-div">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchCollectionsExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
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

                                                <form id='brd_pnt' method="post" name="brd_pnt" action="report/branch-collections-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="date_from">From Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="from_date" class="form-control sdate" id="brcol_date_from" readonly="true" placeholder="From Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="date_to">To Date</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" name="to_date" class="form-control sdate" id="brcol_date_to" readonly="true" placeholder="To Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">Date Option</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="brcol_date_opt" name="date_option"  class="form-control" >
                                                                    <option value="1">Travel Date</option>
                                                                    <option value="0">Transaction Date</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                </div>
                                                <div class="row">
                                                    {if $action_rights['BRN-COL-RPT-ALL-BRN']==1}
                                                        <div class="form-group col-md-2">
                                                            <label for="gen_voucher_branch_code">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="brcol_org_code" name="organizationCode"  class="form-control">
                                                                    <option value="NA" selected="">All Branches</option>
                                                                    {foreach key=key item=row from=$branches}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    {/if}            
                                                    <div class="form-group col-md-2">
                                                        <label for="brcol_pbl_flag">&nbsp;</label>
                                                        <input type="checkbox" checked="checked" id="brcol_pbl_flag" name="pbl_flag" value="1"/> 
                                                        <label for="brcol_pbl_flag" style="display: inline;font-weight: normal;">Phone book ticket</label>                                                        
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <label for="cons_rpt_date_to">&nbsp;</label>
                                                        <input type="hidden" name="export" id="export" value="">
                                                        <button class="btn btn-success" type="button"  onclick="getBranchCollectionReport();" >Generate</button>
                                                        <button type="button" class="btn btn-default btn-clear" onclick="clearBranchCollectionReport();">Clear</button>
                                                    </div>
                                                </div>

                                                </form>
                                                <br>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="brcol-action-state"></div>
                                            </div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row hidden" id="brcol-report-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="brcol-report-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe id="irm_downloader" name="irm_downloader" style="display: none"></iframe>

{literal}
<script>

    function exportBranchCollectionsExcel() {
        document.brd_pnt.target = "irm_downloader";
        $('#export').val(1);
        document.brd_pnt.submit();
        return;
    }

    $('#brcol_date_from').datepicker({
        format: 'yyyy-mm-dd',
        startDate: '-3m',
        endDate: "+3m",
        autoclose: true,
        changeMonth: true,
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 31));
        $('#brcol_date_to').datepicker('setStartDate', e.date);
        $("#brcol_date_to").datepicker("setEndDate", end)
    });

    $('#brcol_date_to').datepicker({
        startDate: '-3m',
        endDate: "+3m",
        format: 'yyyy-mm-dd',
        autoclose: true
    }).on('changeDate', function (e) {
        var fDate = new Date(e.date);
        var start = new Date(fDate.setDate(fDate.getDate() - 31));
        $('#brcol_date_from').datepicker('setStartDate', start);
        $('#brcol_date_from').datepicker('setEndDate', e.date)
    });

    function getBranchCollectionReport() {
        $('#brcol-report-list').html('');
        var data = {};
        data.date_option = $('#brcol_date_opt').val();
        data.from_date = $('#brcol_date_from').val();
        data.to_date = $('#brcol_date_to').val();
        data.organizationCode = $('#brcol_org_code').val();
        data.pbl_flag = +$('#brcol_pbl_flag').is(':checked');

        var err = 0;

        if (data.from_date == '') {
            $('#brcol_date_from').addClass('inp_error');
            err++;
        } else {
            $('#brcol_date_from').removeClass('inp_error');
        }

        if (data.from_date != '') {
            if (data.to_date == '') {
                $('#brcol_date_to').removeClass('inp_error');
                var d = new Date();

                var month = d.getMonth() + 1;
                var day = d.getDate();

                var output = d.getFullYear() + '-' +
                        (('' + month).length < 2 ? '0' : '') + month + '-' +
                        (('' + day).length < 2 ? '0' : '') + day;

                data.to_date = output;
                $('#brcol_date_to').val(output);
            }
        }

        if (data.from_date != '' && data.to_date != '') {
            var f = data.from_date.split('-');
            var a = moment([f[0], f[1], f[2]]);

            var e = data.to_date.split('-');
            var b = moment([e[0], e[1], e[2]]);
            var t = b.diff(a, 'days');
            if (t > 31) {
                $('#brcol_date_to').addClass('inp_error');
                $('#brcol-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#brcol-action-state').html('Date range should be 31 days or less');
                $('#brcol-action-state').show();
                err++;
                return false;
            }
        }

        if (err > 0) {
            $('#brcol-action-state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#brcol-action-state').html('Please enter/select the values in the field that are marked in red');
            $('#brcol-action-state').show();
            return false;
        } else {
            $('#brcol-action-state').removeClass('alert-success').removeClass('alert-danger');
            $('#brcol-action-state').html('');
            $('#brcol-action-state').hide();
        }

        $('#brcol_date_to').removeClass('inp_error');
        $('#brcol-report-list-container').removeClass('hidden');
        $('#brcol-report-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/branch-collections-report-list",
            data: data,
            success: function (response) {
                $('#brcol-report-list').html(response);
                $('#brcol-export-div').removeClass('hidden');
            }
        });
    }

    function clearBranchCollectionReport() {
        $('#brcol_date_opt').val(1);
        $('#brcol_date_from').val('');
        $('#brcol_date_to').val('');
        $('#brcol_org_code').val('NA');
        $('#brcol_user_code').val('NA');
        $('#brcol_group_code').val('NA');
        $('#brcol_pbl_flag').prop('checked', true)

        var fDate = new Date();
        var start = new Date(fDate.setDate(fDate.getDate() - 93));
        var tDate = new Date();
        var end = new Date(tDate.setDate(tDate.getDate() + 93));
        $('#brcol_date_from').datepicker('setStartDate', start);
        $('#brcol_date_from').datepicker('setEndDate', end);

        $('#brcol_date_to').datepicker('setStartDate', start);
        $('#brcol_date_to').datepicker('setEndDate', end);

        $('#brcol-report-list-container').addClass('hidden');
        $('#brcol-report-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#brcol-action-state').removeClass('alert-success').removeClass('alert-danger');
        $('#brcol-action-state').html('');
        $('#brcol-action-state').hide();

        $('#brcol-export-div').addClass('hidden');
    }
</script>
{/literal}