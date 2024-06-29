<div class="brand_top">
    <h3>Cargo Partition Detail Report</h3>
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

                                                <form id='con_rv_rpt' method="post" name="con_rv_rpt" action="report/cargo-partition-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-4">
                                                            <label for="par_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="par_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="par_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="par_rpt_from_station" name="fromStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="par_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="par_rpt_to_station" name="toStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                    </div>

                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="fromOrganizationCode">From Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="fromOrganizationCode" name="fromOrganizationCode" class="form-control">
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="toOrganizationCode">To Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="toOrganizationCode" name="toOrganizationCode" class="form-control">
                                                                    <option value='NA' selected="">All Branch</option>
                                                                    {foreach item=branch from=$branches key=bcode}
                                                                        <option value="{$bcode}">{$branch}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        {* <div class="form-group col-md-2">
                                                            <label for="cargo_pay_status">Cargo Payment Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="par_rpt_pay_status" name="payStatus" class="form-control">
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_payment_status key=code}
                                                                        <option value="{$code}">{$statusname}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div> *}

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" onclick="partitionSearch();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearPartition();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="partition_list_action_state"></div>
                                        </div>
                                        <!--row end-->
                                    </div>
                                    <!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="partition-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="partition-list"></div>
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
        $('#par_rpt_date_range').daterangepicker({
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

        var picker = $('#par_rpt_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        function partitionSearch() {
            $('#partition-list').html('');
            var data = {};
            data.dateRange = $('#par_rpt_date_range').val();
            data.fromStation = $('#par_rpt_from_station').val();
            data.toStation = $('#par_rpt_to_station').val();
            data.fromOrganizationCode = $('#fromOrganizationCode').val();
            data.toOrganizationCode = $('#toOrganizationCode').val();

            var err = 0;
            $('#par_rpt_date_range').removeClass('inp_error');

            if (data.dateRange == '') {
                $('#par_rpt_date_range').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#partition_list_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#partition_list_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#partition_list_action_state').show();
                return false;
            } else {
                $('#partition_list_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#partition_list_action_state').html('');
                $('#partition_list_action_state').hide();
            }

            var html = "";
            $('#rev_rpt_date_to').removeClass('inp_error');
            $('#partition-list-container').removeClass('hidden');
            $('#partition-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/cargo-partition-report-list",
                data: data,
                success: function(response) {
                    $('#partition-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#partition-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearPartition() {
            $('#partition-list-container').addClass('hidden');
            $('#partition-list').html('');
            $('#par_rpt_date_range').val('');
            $('.inp_error').removeClass('inp_error');

            $('#partition_list_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#partition_list_action_state').html('');
            $('#partition_list_action_state').hide();

            $('#par_rpt_from_station').val('NA');
            $('#par_rpt_to_station').val('NA');
            $('#fromOrganizationCode').val('NA');
            $('#toOrganizationCode').val('NA');
            $('#par_rpt_pay_status').val('NA');

            $('#excl_cons').hide();
        }

        function exportPartitionExcel() {
            $('#export').val(1);
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.action = "report/cargo-partition-report-list";
            document.con_rv_rpt.submit();
            return;
        }
    </script>
{/literal}