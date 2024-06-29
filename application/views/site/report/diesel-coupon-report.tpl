<div class="brand_top">
    <h3>Diesel Coupon Report</h3>
    <div class="text-right noprint" id="diesel_coupon_rpt_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="export_DC_Report();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="Print_DC_Report()"><i class="fa fa-print fa-lg"></i> Print</button>
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
                                                <form id="diesel_coupon_report" method="post" name="diesel_coupon_report" action="report/diesel-coupon-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="diesel_coupon_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="diesel_coupon_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="diesel_coupon_rpt_org">Branch</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="diesel_coupon_rpt_org" name="organizationCode" class="form-control">
                                                                    <option value="NA" selected="">All Branch</option>
                                                                    {foreach item=row from=$branches}
                                                                        <option value="{$row->code}" {if $login_branch ==$row->code}selected="{$row->code}" {/if}>{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="diesel_coupon_rpt_vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="diesel_coupon_rpt_vehicle" name="vehicleCode" class="form-control">
                                                                    <option value="" selected="">All Vehicle</option>
                                                                    {foreach item=row from=$vehicles}
                                                                        {if $row->activeFlag == 1}
                                                                            <option {if $fvehicle==$row->code} selected="selected" {/if} value="{$row->code}">{$row->registationNumber} - {$row->vehicleType->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="diesel_coupon_vendor_code">Vendor</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="diesel_coupon_vendor_code" name="vendorCode" class="form-control">
                                                                    <option value="NA" selected="">All Vendors</option>
                                                                    {foreach item=row from=$vendors}
                                                                        <option value="{$row->code}">{$row->name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="diesel_coupon_rpt_filter">Filter Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="diesel_coupon_rpt_filter" name="filterType" class="form-control">
                                                                    <option value="NA">All</option>
                                                                    <option value="OWN">Own</option>
                                                                    <option value="ATCH">Attached</option>
                                                                    <option value="HIRE">Hire / Walk-In</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button type="button" class="btn btn-success" id="generate-report-btn" onclick="getDieselCoupoReport();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDieselCoupoReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="diesel_coupon_rpt_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row hidden" id="diesel-coupon-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="diesel-coupon-rpt-list"></div>
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
        $(document).ready(function() {
            $('#diesel_coupon_vendor_code, #diesel_coupon_rpt_org, #diesel_coupon_rpt_vehicle').select2();
        });

        $('#diesel_coupon_rpt_date_range').daterangepicker({
            buttonClasses: ['btn', 'btn-xs'],
            format: 'DD-MM-YYYY',
            separator: ' | ',
            timePicker: false,
            ranges: {
                'Today': [moment().startOf('day'), moment().endOf('day')],
                'Yesterday': [moment().subtract(1, 'days').startOf('day'), moment().subtract(1, 'days').endOf('day')],
                'Last 7 Days': [moment().subtract(6, 'days').startOf('day'), moment().endOf('day')],
                'Last 30 Days': [moment().subtract(29, 'days').startOf('day'), moment().endOf('day')],
            },
        }).on('show.daterangepicker', function(ev, picker) {
            setEndTime(picker);
            picker.showCalendars();
        });

        var picker = $('#diesel_coupon_rpt_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        function export_DC_Report() {
            $('#export').val(1);
            $('#print').val('');
            document.diesel_coupon_report.target = "ifrm_downloader";
            document.diesel_coupon_report.action = "report/diesel-coupon-report-list";
            document.diesel_coupon_report.submit();
            return;
        }

        function getDieselCoupoReport() {
            $('#diesel-coupon-rpt-list').html('');

            var data = {};
            data.dateRange = $('#diesel_coupon_rpt_date_range').val();
            data.organizationCode = $('#diesel_coupon_rpt_org').val();
            data.vendorCode = $('#diesel_coupon_vendor_code').val();
            data.filterType = $('#diesel_coupon_rpt_filter').val();
            data.vehicleCode = $('#diesel_coupon_rpt_vehicle').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.dateRange == '') {
                $('#diesel_coupon_rpt_date_range').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#diesel_coupon_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#diesel_coupon_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#diesel_coupon_rpt_action_state').show();
                return false;
            } else {
                $('#diesel_coupon_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#diesel_coupon_rpt_action_state').html('');
                $('#diesel_coupon_rpt_action_state').hide();
            }

            $('#diesel_coupon_rpt_date_range').removeClass('inp_error');

            $('#diesel-coupon-rpt-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#diesel-coupon-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/diesel-coupon-report-list",
                data: data,
                success: function(response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#diesel-coupon-rpt-list').html(response);
                    $('#diesel_coupon_rpt_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#diesel-coupon-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }


        // function clearDepartureReport() {
        //     $('#arrival_departure_rpt_date_range').val('');
        //     $('#arrival-departure-rpt-list-container').addClass('hidden');
        //     $('#arrival-departure-rpt-list').html('');
        //     $('.inp_error').removeClass('inp_error');
        //     $('#diesel_coupon_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        //     $('#diesel_coupon_rpt_action_state').html('');
        //     $('#diesel_coupon_rpt_action_state').hide();
        //     $('#arrival_departure_rpt_from_org').val('NA').trigger('change');
        //     $('#arrival_departure_rpt_from_station').val('NA').trigger('change');
        //     $('#arrival_departure_rpt_to_station').val('NA').trigger('change');
        //     $('#arrival_rpt_excel').hide();
        // }

        function Print_DC_Report() {
            $('#print').val(1);
            $('#export').val('');
            document.diesel_coupon_report.target = "ifrm_downloader";
            document.diesel_coupon_report.action = "report/diesel-coupon-report-list";
            document.diesel_coupon_report.submit();
            return;
        }
    </script>
{/literal}