<div class="brand_top">
    <h3>Pickup / Delivery Report</h3>
    <div class="text-right noprint" id="pkpdlv_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoCollection();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the door pickup and door delivery applied LRs.
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
                                                <form id="pkpdlv_report" method="post" name="pkpdlv_report" action="cargo/pickup-delivery-report-list" onsubmit="return false;">                                                  <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="pkpdlv_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="pkpdlv_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="pkpdlv_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="pkpdlv_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="pkpdlv_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="pkpdlv_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['CGO-PKDYRPT-ALL-BRAH']==1}
                                                        <div class="form-group col-md-2">
                                                            <label for="pkpdlv_organization">Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="pkpdlv_organization" name="organizationCode" class="form-control">
                                                                    <option value="NA" selected="">All Branch</option>
                                                                    {foreach item=row from=$branches}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        {/if}
                                                        <div class="form-group col-md-2">
                                                            <label for="pkpdlv_filter">Filter Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="pkpdlv_filter" name="filterCode" class="form-control">
                                                                    <option value="PICKUP">Door Pickup</option>
                                                                    <option value="DELIVERY">Door Delivery</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="1">
                                                                <button type="button" class="btn btn-success" onclick="getPickupDeliveryReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPickupDeliveryReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="pkpdlv_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="pkpdlv-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="pkpdlv-rpt-list"></div>
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
        $('#pkpdlv_from').datepicker({
            format: 'dd-mm-yyyy',
            autoclose: true,
            changeMonth: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#pkpdlv_to').datepicker('setStartDate', e.date);
            $('#pkpdlv_to').datepicker('setEndDate', end)
        });
        $('#pkpdlv_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'dd-mm-yyyy',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function (e) {
            $('#pkpdlv_from').datepicker('setEndDate', e.date)
        });

        function exportCargoCollection() {
            document.pkpdlv_report.target = "ifrm_downloader";
            document.pkpdlv_report.submit();
            return;
        }

        function getPickupDeliveryReport() {
            $('#pkpdlv-rpt-list').html('');
            var data = {};
            data.fromDate = $('#pkpdlv_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#pkpdlv_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.organizationCode = $('#pkpdlv_organization').val();
            data.filterCode = $('#pkpdlv_filter').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.fromDate == '') {
                $('#pkpdlv_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#pkpdlv_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#pkpdlv_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#pkpdlv_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#pkpdlv_action_state').show();
                return false;
            } else {
                $('#pkpdlv_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#pkpdlv_action_state').html('');
                $('#pkpdlv_action_state').hide();
            }

            $('#pkpdlv_to').removeClass('inp_error');
            $('#pkpdlv-rpt-list-container').removeClass('hidden');
            $('#pkpdlv-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/pickup-delivery-report-list",
                data: data,
                success: function (response) {
                    $('#pkpdlv-rpt-list').html(response);
                    $('#pkpdlv_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#pkpdlv-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }


        function clearPickupDeliveryReport() {
            $('#pkpdlv_from').val('');
            $('#pkpdlv_to').val('');
            $('#pkpdlv-rpt-list-container').addClass('hidden');
            $('#pkpdlv-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#pkpdlv_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#pkpdlv_action_state').html('');
            $('#pkpdlv_action_state').hide();
            $('#pkpdlv_organization').val('NA');
            $('#pkpdlv_rpt_excel').hide();
        }
    </script>
{/literal}