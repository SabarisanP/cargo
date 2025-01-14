<div class="brand_top">
    <h3>{iflang('Cargo Delivery Report')}</h3>
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoDeliveryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="exportTalyExcel()"><i class="fa fa-download fa-lg"></i>Tally Excel</button>
            <button class="btn btn-default" id="delivery-print" onclick="printDeliveryReport()"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the delivered details based on the "Delivered date" and along with other filters used.
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

                                                <form id='con_bk_rpt' method="post" name="con_bk_rpt" action="cargo/delivery-report-list" onsubmit="return false">
                                                    <div class="row">

                                                        <div class="form-group col-md-4">
                                                            <label for="delivery_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="delivery_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cargo_pay_status">Cargo Payment Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_pay_status" name="payStatus" class="form-control">
                                                                    <option value='NA' selected="">All Status</option>
                                                                    {foreach name=o item=statusname from=$cargo_payment_status key=code}
                                                                        <option value="{$code}">{$statusname}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                        {if $action_rights['CGO-DLR-USER-FLTR']>0}
                                                            <div class="form-group col-md-2">
                                                                <label for="cargo_pay_status">Users</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="trns_rpt_users" class="form-control" name='deliveredUser'>
                                                                        <option value="NA">All User</option>
                                                                        {foreach name=o item=row from=$entity}
                                                                            <optgroup label="{$row['name']}">
                                                                                {foreach name=o item=usr from=$row["userlist"]}
                                                                                    <option value='{$usr->code}'>{$usr->name}</option>
                                                                                {/foreach}
                                                                            </optgroup>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                    </div>

                                                    <div class="row">

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_from_station" name="fromStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="trns_rpt_to_station" name="toStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    {foreach item=station from=$stations}
                                                                        <option value="{$station.code}">{$station.name}</option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_delivtype">Filter Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="trns_rpt_delivtype" name="deliveryType" class="form-control">
                                                                    <option value='NA' selected="">All</option>
                                                                    {if $namespace =="seenutransports"}
                                                                        {foreach key=code item=name from=$delivery_filter_type_seenu}
                                                                            <option value="{$code}">{$name}</option>
                                                                        {/foreach}
                                                                    {else}
                                                                        {foreach key=code item=name from=$delivery_report_type}
                                                                            <option value="{$code}">{$name}</option>
                                                                        {/foreach}
                                                                    {/if}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2 hide" id="dd-status-filter">
                                                            <label class="req">Door Delivery Status</label>
                                                            <div class="input-group col-md-11">
                                                                <select class="form-control" name="deliveryStatusTypeCode" id="dd-delivery-status">
                                                                    <option value="">Select Status</option>
                                                                    {foreach item=row from=$cargoremarks}
                                                                        {if $row->cargoStatus->code == 'DRDLY'}
                                                                            <option value="{$row->code}">{$row->name}</option>
                                                                        {/if}
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2 hide">
                                                            <label for="del_rpt_filter">Filter</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="del_rpt_filter" name="filterType" class="form-control">
                                                                    <option value="DETAILS" selected="seleted">DETAILS</option>
                                                                    <option value="SUMMARY">SUMMARY</option>
                                                                    <option value="SUBDETAILS">SUBDETAILS</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <button class="btn btn-success" type="button" onclick="searchCargoDeliveryDelivery();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDeliveryReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="trns_rpt_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="trns-booking-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="trns-booking-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_consolidate_downloader" id="ifrm_consolidate_downloader" style="display:none"></iframe>


{literal}
    <script>
        $('#delivery_rpt_date_range').daterangepicker({
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

        var picker = $('#delivery_rpt_date_range').data('daterangepicker');

        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }

        $('#dd-delivery-status').select2();

        $('#trns_rpt_delivtype').on('change', function() {
            $('#dd-status-filter').addClass('hide');
            var type = $(this).val();
            if (type == 'DR_DLRY_STS') {
                $('#dd-status-filter').removeClass('hide');
            }
        });

        function exportCargoDeliveryExcel() {
            document.con_bk_rpt.action = "cargo/delivery-report-list";
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            $('#print').val('');
            document.con_bk_rpt.submit();
            return;
        }

        function searchCargoDeliveryDelivery() {
            $('#trns-booking-list-container').addClass('hidden');
            $('#trns-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#excl_cons').hide();

            var data = {};
            data.dateRange = $('#delivery_rpt_date_range').val();
            data.userCode = 'NA';
            data.payStatus = $('#trns_rpt_pay_status').val();
            data.fromStation = $('#trns_rpt_from_station').val();
            data.toStation = $('#trns_rpt_to_station').val();
            data.deliveredUser = $('#trns_rpt_users').val();
            data.deliveryType = $('#trns_rpt_delivtype').val();
            data.deliveryStatusTypeCode = $('#dd-delivery-status').val();
            data.filterType = $('#del_rpt_filter').val();

            var err = 0;

            if ($('#delivery_rpt_date_range').val() === '') {
                $('#delivery_rpt_date_range').addClass('inp_error');
                err++;
            } else{
                $('#delivery_rpt_date_range').removeClass('inp_error');
            }

            if (data.deliveryType == 'DR_DLRY_STS') {
                if (data.deliveryStatusTypeCode == '') {
                    $('#dd-delivery-status').addClass('inp_error');
                    err++;
                }
            }

            if (err > 0) {
                $('#trns_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#trns_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#trns_rpt_action_state').show();
                return false;
            } else {
                $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#trns_rpt_action_state').html('');
                $('#trns_rpt_action_state').hide();
            }
            var html = "";
            $('#trns_rpt_date_to').removeClass('inp_error');
            $('#trns-booking-list-container').removeClass('hidden');
            $('#trns-booking-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/delivery-report-list",
                data: data,
                success: function(response) {
                    $('#trns-booking-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#trns-booking-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }


        function clearDeliveryReport() {
            $('#delivery_rpt_date_range').val('');
            $('#trns-booking-list-container').addClass('hidden');
            $('#trns-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#trns_rpt_action_state').html('');
            $('#trns_rpt_action_state').hide();

            $('#trns_rpt_from_station').val('NA');
            $('#trns_rpt_to_station').val('NA');
            $('#trns_rpt_pay_status').val('NA');
            $('#trns_rpt_users').val('NA').trigger('change');
            $('#trns_rpt_delivtype').val('NA').trigger('change');
            $('#dd-delivery-status').val('').trigger('change');
            $('#excl_cons').hide();
        }

        function printDeliveryReport() {
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val('');
            $('#print').val(1);
            document.con_bk_rpt.submit();
            return;
        }

        function exportTalyExcel() {
            document.con_bk_rpt.action = "cargo/delivery-report-list-tally";
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            document.con_bk_rpt.submit();
            return;
        }
    </script>
{/literal}
