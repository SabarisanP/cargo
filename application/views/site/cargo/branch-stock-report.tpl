<div class="brand_top">
    <h3>Branch Stock Report</h3>
    <div class="text-right noprint" id="stock_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchStock();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
            {if $namespace =="seenutransports"}
                <button class="btn btn-default" id="godown-Print" onclick="godownPrint()"><i class="fa fa-print fa-lg"></i>Godown Print</button>
                <button class="btn btn-default" id="godown-excel" onclick="exportGodownExcel();"><i class="fa fa-download fa-lg"></i>Godown Excel</button>
            {/if}
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows pending LRs based on loading, unloading, delivery and inwards to the particular branch
        </div>
    </div>
</div>

<div id="main_wrapper">
    <div class="page_content" style="min-height: 500px;">
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
                                                <form id="branch_stock" method="post" name="branch_stock" action="cargo/branch-stock-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="branch_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="branch_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="stock_rpt_cargo_status">Cargo Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="stock_rpt_cargo_status" name="cargoStatusCode" class="form-control">
                                                                    {foreach item=code from=$branch_stock_status}
                                                                        <option value="{$code}">{lang('branch_stock_status_'|cat:$code)}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['BSR-ALL-BRNC']>0 || $action_rights['BSR-ALL-STION']>0}
                                                        </div>
                                                        <div class="row">
                                                        {/if}
                                                        {if $action_rights['BSR-ALL-STION']>0}
                                                            <div class="form-group col-md-2">
                                                                <label for="stock_rpt_stations">Station</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="stock_rpt_stations" name="stationCode" class="form-control" onchange="changeStationBranch(this)">
                                                                        <option value="NA" selected="">All Station</option>
                                                                        {foreach item=row from=$stations}
                                                                            <option value="{$row.code}">{$row.name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                        {if $action_rights['BSR-ALL-BRNC']>0}
                                                            <div class="form-group col-md-2">
                                                                <label for="stock_rpt_organization">Branch</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="stock_rpt_organization" name="transitOrganizationCode[]" class="form-control" multiple="">
                                                                        <option value="NA" selected="" data-name="ALL">All Branch</option>
                                                                        {foreach item=row from=$branches}
                                                                            <option value="{$row->code}" data-name="{$row->name}">{$row->name}</option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                        <div class="form-group col-md-2 hide">
                                                            <label for="stock_rpt_filter">Filter</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="stock_rpt_filter" name="" class="form-control">
                                                                    <option value="DETAILS" selected="seleted">DETAILS</option>
                                                                    <option value="SUMMARY">SUMMARY</option>
                                                                    <option value="SUBDETAILS">SUBDETAILS</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <input type="hidden" name="print" id="print" value="1">
                                                                <input type="hidden" name="labelName" id="labelName" value="">
                                                                <input type="hidden" name="branch_name" id="branch_name" value="">
                                                                <button type="button" class="btn btn-success" id="generate-report-btn" onclick="getBranchStockReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearBranchStockReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="stock_rpt_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="stock-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="stock-rpt-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<script>
    var branchList = {$branches|json_encode};
    $('#stock_rpt_stations').select2();
    $('#godown-Print').addClass('hide');
    $('#godown-excel').addClass('hide');

    $(document).ready(function() {
        $('#stock_rpt_cargo_status').change(function() {
            var demo = $(this).val();
            if (demo == 'CUL') {
                $('#godown-Print').removeClass('hide');
                $('#godown-excel').removeClass('hide');
            } else {
                $('#godown-Print').addClass('hide');
                $('#godown-excel').addClass('hide');
            }
        });
    });

    $('#stock_rpt_organization').change(function() {
        var selectedOptionName = $(this).find(':selected').data('name');
        $('#branch_name').val(selectedOptionName);
    });

    $(document).ready(function() {
        if (menu_permission['SHOW-TILL-DATE-RANGE'] == 1) {
            var picker = $('#branch_rpt_date_range').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            timePicker: false,
            ranges: {
                'Today': [moment().startOf('day'), moment().endOf('day')],
                'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                'Last 31 Days': [moment().subtract(31, 'days').startOf('day'), moment().endOf('day')],
                'Till Date': [moment().subtract(1, 'days').startOf('day'), moment().endOf('day')],
            },
            startDate: moment().subtract(3, 'months').startOf('day'),
            endDate: moment().endOf('day')
        });
        }else{
            var picker = $('#branch_rpt_date_range').daterangepicker({
                buttonClasses: ['btn', 'btn-xs'],
                format: 'DD-MM-YYYY',
                separator: ' | ',
                timePicker: false,
                ranges: {
                    'Today': [moment().startOf('day'), moment().endOf('day')],
                    'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                    'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                    'Last 31 Days': [moment().subtract(31, 'days').startOf('day'), moment().endOf('day')],
                },
                startDate: moment().subtract(3, 'months').startOf('day'),
                endDate: moment().endOf('day')
            });
        }
       

        $('#branch_rpt_date_range').on('apply.daterangepicker', function(ev, picker) {
            var selectedRange = $(".ranges ul li.active").text();
            $('#labelName').val(selectedRange);
        });


        picker.data('daterangepicker').setStartDate(moment().subtract(3, 'months').startOf('day'));
        picker.data('daterangepicker').setEndDate(moment().endOf('day'));

        $('#branch_rpt_date_range').val(picker.data('daterangepicker').startDate.format('DD-MM-YYYY') + ' | ' + picker.data('daterangepicker').endDate.format('DD-MM-YYYY'));
    });

    $('#stock_rpt_organization').multiselect({
        maxHeight: 200,
        numberDisplayed: 1,
        buttonWidth: '200px',
        dropLeft: true,
        buttonClass: 'btn btn-default stock_rpt_organization'
    });

    function changeStationBranch(select) {
        var station = $(select).val();

        var options = [];
        $.each(branchList || [], function(i, branch) {
            if (station == 'NA' || branch.station.code == station) {
                options.push(new Option(branch.name, branch.code));
            }
        });

        $('#stock_rpt_organization')
            .html('<option value="NA" selected="">All Branch</option>')
            .append(options)
            .multiselect('rebuild');
    }

    function exportBranchStock() {
        document.branch_stock.target = "ifrm_downloader";
        document.branch_stock.submit();
        return;
    }

    function print_branch_stock_delivary_report() {
        var print_page = $('.print-branch-stock-delivary').html();
        var mywindow = window.open('', 'Branch stock delivery report', 'width=500,height=500');
        mywindow.document.write(print_page);
        mywindow.document.write('<style type="text/css"> .table { border:1px solid #ddd; border-collapse: collapse; width: 100%;} .table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td  { border:1px solid #ddd; white-space: nowrap}</style>');
        mywindow.document.close();
        mywindow.onafterprint = mywindow.close;
        mywindow.print();

    }

    function getBranchStockReport() {
        $('.FixedHeader_Cloned.fixedHeader.FixedHeader_Header').hide();
        $('#stock-rpt-list').html('');
        var data = {};
        data.stationCode = $('#stock_rpt_stations').val();
        data.transitOrganizationCode = $('#stock_rpt_organization').val() || ['NA'];
        data.cargoStatusCode = $('#stock_rpt_cargo_status').val();
        data.filterType = $('#stock_rpt_filter').val();
        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if ($('#labelName').val() == 'Till Date') {
            data.dateRange = "NA | NA";
            if ($('#stock_rpt_stations').val() == 'NA') {
                $('#stock_rpt_stations').addClass('inp_error');
                err++;
            }
        } else {
            $('#stock_rpt_stations').removeClass('inp_error')
            data.dateRange = $('#branch_rpt_date_range').val();
        }


        if (data.dateRange == '') {
            $('#branch_rpt_date_range').addClass('inp_error');
            err++;
        } else {
            $('#branch_rpt_date_range').removeClass('inp_error');
        }

        if (data.cargoStatusCode == 'INW' && $.inArray('NA', data.transitOrganizationCode) !== -1 && data.stationCode == 'NA') {
            $('#stock_rpt_stations').addClass('inp_error');
            $('.stock_rpt_organization').addClass('inp_error');
            $('#stock_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#stock_rpt_action_state').html('Please select alteast one Branch or Station');
            $('#stock_rpt_action_state').show();
            return false;
        }

        if (err > 0) {
            $('#stock_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#stock_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#stock_rpt_action_state').show();
            return false;
        } else {
            $('#stock_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#stock_rpt_action_state').html('');
            $('#stock_rpt_action_state').hide();
        }

        $('#stock_rpt_to').removeClass('inp_error');
        $('#stock-rpt-list-container').removeClass('hidden');
        $('#generate-report-btn').prop('disabled', true);
        $('#stock-rpt-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/branch-stock-report-list",
            data: data,
            success: function(response) {
                $('#generate-report-btn').prop('disabled', false);
                $('#stock-rpt-list').html(response);
                $('#stock_rpt_excel').show();
                $('html, body').animate({
                    scrollTop: $('#stock-rpt-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }

    function clearBranchStockReport() {
        $('#labelName').val('');
        $('#stock_rpt_stations').val('NA').trigger('change');
        $('#branch_rpt_date_range').val('');
        $('.FixedHeader_Cloned.fixedHeader.FixedHeader_Header').hide();
        $('#stock_rpt_from').val('');
        $('#stock_rpt_to').val('');
        $('#stock_rpt_stations').val('NA');
        $('#stock_rpt_organization').val(['NA']).multiselect('refresh');
        $('#stock_rpt_cargo_status').val("CB");
        $('#stock-rpt-list-container').addClass('hidden');
        $('#stock-rpt-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#stock_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#stock_rpt_action_state').html('');
        $('#stock_rpt_action_state').hide();
        $('#stock_rpt_excel').hide();
    }

    function godownPrint() {
        $('#print').val(1);
        $('#export').val('');
        $('#branch_name').val();
        document.branch_stock.target = "ifrm_downloader";
        document.branch_stock.action = "cargo/branch-stock-report-godown-seenutransport";
        document.branch_stock.submit();
        return;
    }

    function exportGodownExcel() {
        $('#print').val('');
        $('#export').val(1);
        document.branch_stock.target = "ifrm_downloader";
        $('#branch_name').val();
        document.branch_stock.action = "cargo/branch-stock-report-godown-seenutransport";
        document.branch_stock.submit();
        return;
    }
</script>