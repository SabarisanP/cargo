<div class="brand_top">
    <h3>{iflang('Transit Based Branch Collection Report')}</h3>
    <div class="text-right noprint" id="transit_excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransitExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default notpaytypeprint" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
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
                                        <div id="search-panel">
                                            <form id='transit_bst_branch' method="post" name="transit_bst_branch" action="report/transit-based-branch-collection-report-list" onsubmit="return false">
                                                <div class="row">

                                                    <div class="form-group col-md-2">
                                                        <label for="trnsit_branch_rpt_date_from">From Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="fromDate" class="form-control sdate" id="trnsit_branch_rpt_date_from" readonly="true" placeholder="Date From">
                                                            <label class="input-group-addon" for="trnsit_branch_rpt_date_from"><i class="fa fa-calendar"></i></label>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="trnsit_branch_rpt_date_to">To Date</label>
                                                        <div class="input-group">
                                                            <input type="text" name="toDate" class="form-control sdate" id="trnsit_branch_rpt_date_to" readonly="true" placeholder="Date To">
                                                            <label class="input-group-addon" for="trnsit_branch_rpt_date_to"><i class="fa fa-calendar"></i></label>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="trnsit_branch_rpt_type">Type</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="trnsit_branch_rpt_type" name="filterType" class="form-control">
                                                                <option value="NA">Select</option>
                                                                <option value="BRANCH">Branch</option>
                                                                <option value="ZONE">Zone</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2" id="zone_values">
                                                        <label for="transit_typewise">Status</label>
                                                        <div class="input-group col-md-11">
                                                            <select id="transit_typewise" name="filterCode" class="form-control">
                                                                <option value="NA" selected="">All Branch</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    {* <div class="form-group col-md-2 " id="Branch_vales">
                                                        <label for="transit_typewise_1">Branch</label>
                                                        <div class="input-group col-md-11">
                                                            <select id="transit_typewise_1" name="filterCode" class="form-control">
                                                                <option value="NA">All Branch</option>
                                                                {foreach item=row from=$branch}
                                                                    <option value="{$row->code}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div> *}

                                                    <div class="col-md-4" style="border: 1px solid #2222; background: #eaecf0; color: #696969;">
                                                        <label style="text-align: center;">Transit Status</label>
                                                        <span><i class=" fa fa-shield"></i> <b>Dispatch : </b>Total Transit Dispatched towords the Receving Branch</span>
                                                        <br>
                                                        <span><i class="fa fa-shield"></i> <b>Booking : </b>Total Transit Dispacthed From Booking Branch</span>
                                                        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </div>

                                                </div>

                                                <div class="row">
                                                    <div class="form-group col-md-2">
                                                        <label for="transit_branch_rpt_Stats">Transit Status</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="transit_branch_rpt_Stats" name="transitStatus" class="form-control">
                                                                <option value="DISPATCH" selected="">Dispatch</option>
                                                                <option value="BOOKING">Booking</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    {* <div class="form-group col-md-2">
                                                            <label for="transit_groupby">Group By</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="transit_groupby" name="requestType" class="form-control">
                                                                    <option value="SUMMARY" selected="">Summary</option>
                                                                    <option value="DETAILS">Details</option>
                                                                </select>
                                                            </div>
                                                        </div> *}
                                                    <div class="form-group col-md-2">
                                                        <label for="trnsit_rpt_pay_status">Cargo Payment Status</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="trnsit_rpt_pay_status" name="paymentStatusCode" class="form-control">
                                                                <option value='NA' selected="">All Status</option>
                                                                {foreach name=o item=statusname from=$cargo_payment_status key=code}
                                                                    <option value="{$code}">{$statusname}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="">
                                                            <button class="btn btn-success" type="button" onclick="searchtransitBrachReport();">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearTrabsitReport();">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                        <br class="clear_fix_both">
                                        <div class="align-center alert alert-danger pull-left" style="display:none" id="transit_based_branch_action_state"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!--row end-->

                    <div class="row hidden" id="trns-bs-branch-collaction-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="trns-bs-branch-collaction-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="transit-head-dialog" class="hide dialog-content-page"></div>
                </div><!--content end-->
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_transit_downloader" id="ifrm_transit_downloader" style="display:none"></iframe>
<script>
    var zone = {$zone|json_encode}
    var branch = {$branch|json_encode}
    $('#trnsit_branch_rpt_date_from').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        changeMonth: true
    }).on('changeDate', function(e) {
        var fDate = new Date(e.date);
        var end = new Date(fDate.setDate(fDate.getDate() + 365));
        $('#trnsit_branch_rpt_date_to').datepicker('setStartDate', e.date);
        $('#trnsit_branch_rpt_date_to').datepicker('setEndDate', end)
    });
    $('#trnsit_branch_rpt_date_to').datepicker({
        todayHighlight: true,
        startDate: '-0m',
        format: 'yyyy-mm-dd',
        maxDate: '+365D',
        autoclose: true
    }).on('changeDate', function(e) {
        $('#trnsit_branch_rpt_date_from').datepicker('setEndDate', e.date)
    });

    $('#trnsit_branch_rpt_type, #transit_typewise, #transit_typewise_1 ,#transit_branch_rpt_Stats, #transit_groupby, #trnsit_rpt_pay_status').select2();

    $('#trnsit_branch_rpt_type').on('change', function(e) {
        var valueSelected = this.value;
        $('#transit_typewise').empty();

        if (valueSelected == "BRANCH") {
            $('#transit_typewise').append('<option value="NA" selected="">All Branch</option>');
            $.each(branch, function(key, val) {
                $('#transit_typewise').append('<option value="' + val.code + '">' + val.name + '</option>');
            });
        } else if (valueSelected == "ZONE") {
            $('#transit_typewise').append('<option value="NA">All Zone</option>');
            $.each(zone, function(key, val) {
                $('#transit_typewise').append('<option value="' + val.code + '">' + val.name + '</option>');
            });
        }
    });

    $('#trnsit_branch_rpt_type').trigger('change');

    function searchtransitBrachReport() {
        $('#trns-bs-branch-collaction-list').html('');
        var data = {};
        data.fromDate = $('#trnsit_branch_rpt_date_from').val();
        data.toDate = $('#trnsit_branch_rpt_date_to').val();
        data.filterType = $('#trnsit_branch_rpt_type').val();
        data.transitStatus = $('#transit_branch_rpt_Stats').val();
        data.paymentStatusCode = $('#trnsit_rpt_pay_status').val();
        data.filterCode = $('#transit_typewise').val();

        var err = 0;
        $('#trnsit_branch_rpt_date_from, #trnsit_branch_rpt_date_to').removeClass('inp_error');
        if (data.fromDate == '') {
            $('#trnsit_branch_rpt_date_from').addClass('inp_error');
            err++;
        }

        if (data.toDate == '') {
            $('#trnsit_branch_rpt_date_to').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#transit_based_branch_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#transit_based_branch_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#transit_based_branch_action_state').show();
            return false;
        } else {
            $('#transit_based_branch_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#transit_based_branch_action_state').html('');
            $('#transit_based_branch_action_state').hide();
        }
        var html = "";
        $('#trnsit_branch_rpt_date_to').removeClass('inp_error');
        $('#trns-bs-branch-collaction-list-container').removeClass('hidden');
        $('#trns-bs-branch-collaction-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/transit-based-branch-collection-report-list",
            data: data,
            success: function(response) {
                $('#trns-bs-branch-collaction-list').html(response);
                $('#transit_excl_cons').show();
            }
        })
    }

    function exportTransitExcel() {
        document.transit_bst_branch.target = "ifrm_transit_downloader";
        $('#export').val(1);
        document.transit_bst_branch.submit();
        return;
    }

    function clearTrabsitReport() {
        $('#trnsit_branch_rpt_date_to').val('').trigger('change');
        $('#trnsit_branch_rpt_date_from').val('').trigger('change');
        $('#trns-bs-branch-collaction-list-container').addClass('hidden');
        $('#trns-bs-branch-collaction-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#transit_based_branch_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#transit_based_branch_action_state').html('');
        $('#transit_based_branch_action_state').hide();
        $('#trnsit_rpt_pay_status').val('NA').trigger('change');
        $('#trnsit_branch_rpt_type').val('NA').trigger('change');
        $('#transit_typewise').trigger('change');
    }

    function showTransitReportDialog(ogpl, org_code, rel_orgCode) {

        var data = {};
        data.fromDate = $('#trnsit_branch_rpt_date_from').val();
        data.toDate = $('#trnsit_branch_rpt_date_to').val();
        data.filterType = $('#trnsit_branch_rpt_type').val();
        data.transitStatus = $('#transit_branch_rpt_Stats').val();
        data.paymentStatusCode = $('#trnsit_rpt_pay_status').val();
        data.filterCode = org_code + "," + rel_orgCode;
        data.transitCode = ogpl;
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/transit-based-branch-collection-report-details-list",
            data: data,
            success: function(response) {
                $('#transit-head-dialog').html(response);
                $('#transit-head-dialog').show();
                $('#transit-head-dialog').removeClass('hide');
                $('#transit-head-dialog').dialog({
                    autoOpen: true,
                    width: 1000,
                    maxWidth: 1200,
                    height: 350,
                    resizable: false,
                    modal: true
                });
            }
        })
    }

    function closeTransitDialog() {
        $('#transit-head-dialog').dialog('destroy');
        $('#transit-head-dialog').hide();
    }
</script>