    <div class="brand_top">
    <h3>Branch Sales Summary</h3>
    <div class="text-right noprint" id="export-branch-sales" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBranchSales()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the sales details based on the "Booked date" for a branch.
        </div>
    </div>
</div>
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
                                            <form id="branch_sales_form" name="branch_sales_form" method="post" onsubmit="return false;">
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label for="branch_sale_date_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="branch_sale_date_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="zone-sales-sumary-report" class="">Zone</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="zone-sales-sumary-report" name="zoneCode" class="form-control">
                                                                <option value="NA" data-stationcode="">All Zone</option>
                                                                {foreach key=key item=row from=$zone}
                                                                    {$stationsArray = array()}
                                                                    {foreach from=$row->stations item=stn key=key}
                                                                        {$stationsArray[] = $stn->code}
                                                                    {/foreach}
                                                                    <option value="{$row->code}" data-stationcode="{implode(",",$stationsArray)}">{$row->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <label for="stationCode" class="">Stations</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="sales-sumary-station" name="stationCode" class="form-control" onclick="stationfilter();">
                                                                <option value="NA" data-station="">All Station</option>
                                                                {foreach item=station from=$stations}
                                                                    <option value="{$station.code}" data-station="{$station.code}">{$station.name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="sales-sumary-branch" class="">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="sales-sumary-branch" name="organizationCode" class="form-control">
                                                                <option value="NA" data-brachcode="NA">All Branch</option>
                                                                {foreach item=branch from=$organization key=bcode}
                                                                    <option value="{$branch->code}" data-brachcode="{$branch->station->code}">{$branch->name}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>
                                                {* {/if} *}
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchBranchSales()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBranchSales()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="branch_sales_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="branch-sales-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="branch-sales-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_branch_sales" id="ifrm_branch_sales" style="display:none"></iframe>

    <script>
        $('#branch_sale_date_range').daterangepicker({
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

        var picker = $('#branch_sale_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        $('#zone-sales-sumary-report, #sales-sumary-branch, #sales-sumary-station').select2();
        $('#zone-sales-sumary-report, #sales-sumary-branch').val('NA').trigger('change');
        var zone_branch_list = $('#sales-sumary-branch option');
        var zone_station_list = $('#sales-sumary-station option')
        var emptyOrgOption = '<option value="NA" data-brachcode="NA">All Branch</option>';
        var emptyStnOption = '';

        $('#zone-sales-sumary-report').on('change', function() {
            $('#sales-sumary-station').val('NA').trigger('change.select2');
            $('#sales-sumary-branch').val('NA').trigger('change.select2');
            let zoneValue = $('#zone-sales-sumary-report').val();
            let stationValue = $('#zone-sales-sumary-report').val();
            let branchValue = $('#zone-sales-sumary-report').val();

            if ($(this).val() != "" && $(this).val() != 'NA' && stationValue != "NA") {
                $("#sales-sumary-station").select2("val", "");
            }
            if ($(this).val() != "" && $(this).val() != 'NA' && stationValue != "NA" && branchValue != 'NA') {
                $("#sales-sumary-branch").select2("val", "");
            }

            var zone_station_code = $('#zone-sales-sumary-report option:selected').data('stationcode');
            var zone_stn_array = zone_station_code.split(',');
            branchOfStation(zone_stn_array);

            $('#sales-sumary-station').html(function() {
            var allOption = $('<option>').val('NA').text('All Station').data('station', "");
                var filteredOptions = zone_station_list.filter(function() {
                    return $.inArray($(this).data('station'), zone_stn_array) !== -1 || ($('#zone-sales-sumary-report').val() == 'NA' && $(this).val() != 'NA' && $('#zone-sales-sumary-report').val() != $(this).data('station'));
                });
                return [allOption].concat(filteredOptions.toArray());
            }).val('NA').trigger('change.select2');
        });

        function stationfilter() {
            var zone_station_code = $('#sales-sumary-station option:selected').data('station');
            var zone_stn_array = zone_station_code.split(',');
            branchOfStation(zone_stn_array);
            $('#sales-sumary-branch').html(function() {
                return zone_branch_list.filter(function() {
                    return $.inArray($(this).data('brachcode'), zone_stn_array) !== -1 || ($('#sales-sumary-station').val() == 'NA' && $(this).val() != 'NA');
                });
            }).prepend(emptyOrgOption).val('NA').trigger('change');
        }

        function branchOfStation(zone_stn_array) {
            $('#sales-sumary-branch').html(function() {
                var allOption = $('<option>').val('NA').text('All Branch').data('brachcode', '');
                var filteredOptions = zone_branch_list.filter(function() {
                    return $.inArray($(this).data('brachcode'), zone_stn_array) !== -1 || ($('#zone-sales-sumary-report').val() == 'NA' && $(this).val() != 'NA');
                });

                return [allOption].concat(filteredOptions.toArray());
            }).val('NA').trigger('change.select2');
        }

        var user_branch_code = '{$login_station}';
        if (user_branch_code !== '') {
            $('#sales-sumary-station').val(user_branch_code).prop('selected', true).change();
            stationfilter();
        }

        function searchBranchSales() {
            $('#branch-sales-list').html('');
            var data = {};
            data.dateRange = $('#branch_sale_date_range').val();
            data.zoneCode = $('#zone-sales-sumary-report').val();
            data.stationCode = $('#sales-sumary-station').val();
            data.organizationCode = $('#sales-sumary-branch').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            
            if (data.dateRange == '') {
                $('#branch_sale_date_range').addClass('inp_error');
                err++;
            } else {
                $('#branch_sale_date_range').removeClass('inp_error');
            }

            if (err > 0) {
                $('#branch_sales_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#branch_sales_state').html('Please enter/select the values in the field that are marked in red');
                $('#branch_sales_state').show();
                return false;
            } else {
                $('#branch_sales_state').removeClass('alert-success').removeClass('alert-danger');
                $('#branch_sales_state').html('');
                $('#branch_sales_state').hide();
            }
            $('#branch-sales-list-container').removeClass('hidden');
            $('#branch-sales-list').html(loading_popup);
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/branch-sales-summary-list",
                data: data,
                success: function (response) {
                    $('#branch-sales-list').html(response);
                    $('#export-branch-sales').show();
                }
            });
        }

        function clearBranchSales() {
            $('#branch_sales_from').val('');
            $('#branch_sales_to').val('');
            $('#branch_sales_organization').val('NA').trigger('change');
            $('#branch-sales-list-container').addClass('hidden');
            $('#branch-sales-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#branch_sales_state').removeClass('alert-success').removeClass('alert-danger');
            $('#branch_sales_state').html('');
            $('#branch_sales_state').hide();
            $('#export-branch-sales').hide();
        }

        function exportBranchSales() {
            document.branch_sales_form.action = "cargo/branch-sales-summary-list";
            document.branch_sales_form.target = "ifrm_branch_sales";
            document.branch_sales_form.submit();
            return;
        }
    </script>