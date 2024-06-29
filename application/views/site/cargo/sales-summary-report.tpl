<div class="brand_top">
    <h3>Sales Summary Report</h3>
    <div class="text-right noprint" id="sales_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoSales();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the user wise transaction amount based on transaction date & booked date.
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
                                                <form id="sales_report" method="post" name="sales_report" action="cargo/sales-summary-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-3">
                                                            <label for="sales_range">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="sales_range" readonly placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="sales_rpt_users">Users</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="sales_rpt_users" name="userCode" class="form-control" >
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
                                                            <label for="sales_rpt_date_type">Date Option</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="sales_rpt_date_type" name="dateType" class="form-control" >
                                                                    <option value='BOOK' selected="">Booked Date</option>
                                                                    <option value='TRANSACTION' selected="">Transaction Date</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getSalesSummaryReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearSalesSummaryReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="sales_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="sales-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="sales-rpt-list"></div>
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


{literal}
<script>
    $('#sales_range').daterangepicker({
        buttonClasses: ['btn', 'btn-xs'],
        format: 'DD-MM-YYYY',
        separator: ' | ',
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        },
    }).on('show.daterangepicker', function (ev, picker) {
        picker.showCalendars()
    });

    function exportCargoSales() {
        document.sales_report.target = "ifrm_downloader";
        document.sales_report.submit();
        return;
    }

    function getSalesSummaryReport() {
        $('#sales-rpt-list').html('');
        var data = {};
        data.dateRange = $('#sales_range').val();
        data.userCode = $('#sales_rpt_users').val();
        data.dateType = $('#sales_rpt_date_type').val();

        var err = 0;
        $('.inp_error').removeClass('inp_error');

        if (data.daterange == '') {
            $('#sales_range').addClass('inp_error');
            err++;
        }

        if (err > 0) {
            $('#sales_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#sales_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#sales_rpt_action_state').show();
            return false;
        } else {
            $('#sales_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#sales_rpt_action_state').html('');
            $('#sales_rpt_action_state').hide();
        }

        $('#sales_rpt_to').removeClass('inp_error');
        $('#sales-rpt-list-container').removeClass('hidden');
        $('#sales-rpt-list').html(loading_popup);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "cargo/sales-summary-report-list",
            data: data,
            success: function (response) {
                $('#sales-rpt-list').html(response);
                $('#sales_rpt_excel').show();
                $('html, body').animate({
                    scrollTop: $('#sales-rpt-list-container').offset().top - 35
                }, 'slow');
            }
        });
    }


    function clearSalesSummaryReport() {
        $('#sales_range').val('');
        $('#sales_range').data('daterangepicker').setStartDate({});
        $('#sales_range').data('daterangepicker').setEndDate({});
        $('#sales_rpt_users').val('NA');
        $('#sales_rpt_date_type').val('BOOK');
        $('#sales-rpt-list-container').addClass('hidden');
        $('#sales-rpt-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#sales_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#sales_rpt_action_state').html('');
        $('#sales_rpt_action_state').hide();
        $('#sales_rpt_excel').hide();
    }
</script>
{/literal}