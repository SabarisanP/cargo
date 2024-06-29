<div class="brand_top">
    <h3>Revenue Report</h3>
    <div class="text-right noprint" id="stock_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchRevenue()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows branch total booking net amount, total freight, total commission, total other charges
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
                                                <form id="branch_stock" method="post" name="branch_stock" action="cargo/branch-revenue-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="stock_rpt_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate d-none" id="stock_rpt_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="stock_rpt_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="stock_rpt_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="stock_rpt_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="stock_rpt_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="stock_rpt_organization">Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="stock_rpt_organization" name="organizationCode" class="form-control">
                                                                    <option value="NA" selected="">All Branch</option>
                                                                    {foreach item=row from=$branches}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="stock_rpt_filter">Filter Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="stock_rpt_filter" name="pcrFilterType" onchange="setOrganization(this);" class="form-control">
                                                                    <option value="SUMMARY" selected="">Summary</option>
                                                                    <option value="DETAILS" selected="">Details</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getBranchRevenueReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearBranchRevenueReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="stock_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
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
<div id="dia-rev-details" class="hide dialog-content-page">

</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

{literal}
    <script>
        $('#stock_rpt_from').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#stock_rpt_to').datepicker('setStartDate', e.date);
            $('#stock_rpt_to').datepicker('setEndDate', end)
        });
        $('#stock_rpt_to').datepicker({
            todayHighlight: true,
            // startDate: '-0m',
            format: 'dd-mm-yyyy',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function (e) {
            $('#stock_rpt_from').datepicker('setEndDate', e.date)
        });
               
        $('#stock_rpt_organization').select2();
        
        function setOrganization(ele){
            if($(ele).val() == "SUMMARY"){
                $('#stock_rpt_organization').val('NA').trigger('change');
                $('#stock_rpt_organization').attr('disabled' ,true);
            }else{
                $('#stock_rpt_organization').attr('disabled' ,false);
            }
        }

        function exportBranchRevenue() {
            document.branch_stock.target = "ifrm_downloader";
            document.branch_stock.submit();
            return;
        }

        function getBranchRevenueReport() {
            $('#stock-rpt-list').html('');
            var data = {};
            data.fromDate = $('#stock_rpt_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#stock_rpt_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.organizationCode = $('#stock_rpt_organization').val();
            data.pcrFilterType = $('#stock_rpt_filter').val();
            data.organizationName = $("#stock_rpt_organization option:selected").text();
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.fromDate == '') {
                $('#stock_rpt_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#stock_rpt_to').addClass('inp_error');
                err++;
            }  
            if (!data.organizationCode) {
                $('#stock_rpt_organization').addClass('inp_error');
                err++;
            }
            
            if(data.pcrFilterType == "DETAILS" && data.organizationCode == "NA"){
                $('#stock_rpt_organization').addClass('inp_error');
                err++;
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
            $('#stock-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/branch-revenue-report-list",
                data: data,
                success: function (response) {
                    $('#stock-rpt-list').html(response);
                    $('#stock_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#stock-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }


        function clearBranchRevenueReport() {
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
        
        function closeRevenueDetailsDialog() {
            $('#dia-rev-details').dialog('destroy');
            $('#dia-rev-details').hide();
            $('#dia-rev-details').html('');
        }
    </script>
{/literal}