<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-28 17:18:53
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\booking-report.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667ea325c3d414_01521353',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'f786c0c4396fa9957a5dd3100906cf40aff969be' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\booking-report.tpl',
      1 => 1719575244,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667ea325c3d414_01521353 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3><?php echo iflang('Cargo Booking Report');?>
</h3>
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoBookingExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="exportTalyExcel()"><i class="fa fa-download fa-lg"></i>Tally Excel</button>
            <button class="btn btn-default notpaytypeprint" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
            <button class="btn btn-default paytypeprint" onclick="bkgPrintPaid();"><i class="fa fa-print fa-lg"></i> Print Paid</button>
            <button class="btn btn-default paytypeprint" onclick="bkgPrintToPaid();"><i class="fa fa-print fa-lg"></i> Print Topay</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the booking details based on the "Booked date" range along with filters.
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

                                                <form id='con_bk_rpt' method="get" name="con_bk_rpt" action="cargo/booking-report-list" onsubmit="return false">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="booking_rpt_date_range" class="req">Date Range</label>
                                                            <div class="input-group">
                                                                <input type="text" name="dateRange" class="form-control sdate" id="booking_rpt_date_range" readonly="true" placeholder="Date Range">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-DBR-USER-FLTR'] > 0) {?>
                                                            <div class="form-group col-md-2">
                                                                <label for="trns_rpt_date_to">Users</label>
                                                                <div class="input-group col-md-12">
                                                                    <select id="trns_rpt_user_code" name="userCode" class="form-control">
                                                                        <option value='NA' selected="">All Users</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groupusers']->value['users'], 'row', false, NULL, 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value['name'];?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        <?php }?>

                                                        <div class="form-group col-md-2">
                                                            <label for="cargo_pay_status">Cargo Payment Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_pay_status" name="payStatus" class="form-control">
                                                                    <option value='NA' selected="">All Status</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargo_payment_status']->value, 'statusname', false, 'code', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['statusname']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['statusname']->value;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_to">Cargo Current Status</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_cargo_status" name="cargoStatus" class="form-control">
                                                                    <option value='NA' selected="">All Status</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['cargo_status']->value, 'statusname', false, 'code', 'o', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['code']->value => $_smarty_tpl->tpl_vars['statusname']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['code']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['statusname']->value;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-VIEW-SAME-BRNCH-LR'] == 0) {?>
                                                            <div class="form-group col-md-2">
                                                                <label for="cgo-organization">Branch</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="cgo-organization" name="organizationCode" class="form-control">
                                                                        <option value="NA">All Branch</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        <?php }?>

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_to_states">States</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_to_states" name="states" class="form-control">
                                                                    <option value='NA' selected="">All State</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['states']->value, 'state');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['state']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['state']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['state']->value->name;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-DBR-USER-FLTR'] > 0) {?>
                                                            <div class="form-group col-md-2">
                                                                <label for="bkg-group">Groupwise</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="bkg-group" name="groupCode" class="form-control">
                                                                        <option value="NA">All group</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['groups']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        <?php }?>

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_from_station" name="fromStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="trns_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="trns_rpt_to_station" name="toStation" class="form-control">
                                                                    <option value='NA' selected="">All Stations</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
"><?php echo $_smarty_tpl->tpl_vars['station']->value['name'];?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="customerName">Customer Name</label>
                                                            <div class="input-group col-md-12">
                                                                <input type="text" class="form-control" id="customerName" name="customerName" placeholder="Customer Name" value="" />
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="bkg_group_by">Group By</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="bkg_group_by" name="groupBy" class="form-control">
                                                                    <option value='NA' selected="">Select Group By</option>
                                                                    <option value="PAYTYPE">Pay Type</option>
                                                                    <option value="SUMMARY" <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'rajeshcargo' || $_smarty_tpl->tpl_vars['namespace']->value == "rajeshexpress") {?>selected<?php }?>>Summary</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2 hide">
                                                            <label for="bkg_rpt_filter">Filter</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="bkg_rpt_filter" name="filterType" class="form-control">
                                                                    <option value="DETAILS" selected="seleted">DETAILS</option>
                                                                    <option value="SUMMARY">SUMMARY</option>
                                                                    <option value="SUBDETAILS">SUBDETAILS</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'seenutransports' || $_smarty_tpl->tpl_vars['namespace']->value == 'seenucargo') {?>
                                                            <div class="form-group col-md-2">
                                                                <label for="report_filter_bk">Report Filter</label>
                                                                <div class="input-group col-md-11">
                                                                    <select id="report_filter_bk" name="Report_filter" class="form-control">
                                                                        <option value="BOOKING" selected="seleted">Booking</option>
                                                                        <option value="ORGANIZATION">Organization</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        <?php }?>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="Talyexport" id="Talyexport" value="">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="searchCargoBookingBooking();">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearCargoBookingReport();">Clear</button>
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
   


    <?php echo '<script'; ?>
>
        $('#booking_rpt_date_range').daterangepicker({
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

        var picker = $('#booking_rpt_date_range').data('daterangepicker');

        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }
        $('#trns_rpt_user_code, #trns_rpt_pay_status, #trns_rpt_cargo_status, #cgo-organization, #bkg-group, #trns_rpt_from_station, #trns_rpt_to_station,#trns_rpt_to_states').select2();

        function exportCargoBookingExcel() {
            document.con_bk_rpt.action = "cargo/booking-report-list";
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#export').val(1);
            document.con_bk_rpt.submit();
            return;
        }

        function searchCargoBookingBooking() {
            $('#trns-booking-list').html('');
            var data = {};
            data.dateRange = $('#booking_rpt_date_range').val();
            data.userCode = $('#trns_rpt_user_code').val();
            data.cargoStatus = $('#trns_rpt_cargo_status').val();
            data.payStatus = $('#trns_rpt_pay_status').val();
            data.fromStation = $('#trns_rpt_from_station').val();
            data.toStation = $('#trns_rpt_to_station').val();
            data.organizationCode = $('#cgo-organization').val();
            data.customerName = $.trim($('#customerName').val());
            data.groupBy = $('#bkg_group_by').val();
            data.filterType = $('#bkg_rpt_filter').val();
            data.groupCode = $('#bkg-group').val();
            data.stateCode = $('#trns_rpt_to_states').val();
            data.Report_filter =$('#report_filter_bk').val();

            var err = 0;
            $('#trns_rpt_date_from, #trns_rpt_date_to, #customerName').removeClass('inp_error');

            if (data.dateRange == '') {
                $('#booking_rpt_date_range').addClass('inp_error');
                err++;
            } else {
                $('#booking_rpt_date_range').removeClass('inp_error');
            }

            if (data.customerName != '' && data.customerName.length < 3) {
                $('#customerName').addClass('inp_error');
                err++;
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
            $('#booking_rpt_date_range').removeClass('inp_error');
            $('#trns-booking-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#trns-booking-list').html(loading_popup);

            $.ajax({
                type: "GET",
                dataType: 'html',
                url: base_url + "cargo/booking-report-list",
                data: data,
                success: function(response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#trns-booking-list').html(response);
                    $('#excl_cons').show();
                    if (data.groupBy == "PAYTYPE") {
                        $("#excl_cons .paytypeprint").show();
                        $("#excl_cons .notpaytypeprint").hide();
                    } else {
                        $("#excl_cons .notpaytypeprint").show();
                        $("#excl_cons .paytypeprint").hide();
                    }
                    $("html, body").animate({
                        scrollTop: $('#trns-booking-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }


        function clearCargoBookingReport() {
            $('#booking_rpt_date_range').val('');
            $('#trns-booking-list-container').addClass('hidden');
            $('#trns-booking-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#trns_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#trns_rpt_action_state').html('');
            $('#trns_rpt_action_state').hide();

            $('#trns_rpt_from_station').val('NA').trigger('change');
            $('#trns_rpt_to_station').val('NA').trigger('change');
            $('#trns_rpt_pay_status').val('NA').trigger('change');
            $('#trns_rpt_cargo_status').val('NA').trigger('change');
            $('#trns_rpt_user_code').val('NA').trigger('change');
            $('#customerName').val('');
            $('#bkg_group_by').val('');
            $('#excl_cons').hide();
            $('#cgo-organization').val('NA').trigger('change');
            $('#bkg-group').val('NA').trigger('change');
            $('#trns_rpt_to_states').val('NA').trigger('change');
            $('#report_filter_bk').val('BOOKING').trigger('change');
        }

        function bkgPrintPaid() {
            var data = {};
            data.dateRange = $('#booking_rpt_date_range').val();
            data.userCode = $('#trns_rpt_user_code').val();
            data.payStatus = $('#trns_rpt_pay_status').val();
            data.fromStation = $('#trns_rpt_from_station').val();
            data.toStation = $('#trns_rpt_to_station').val();
            data.customerName = $.trim($('#customerName').val());
            data.groupBy = $('#bkg_group_by').val();

            var url = base_url + "cargo/booking-report-list?print=1&printPaid=1&toDate=" + data.toDate + '&fromDate=' + data.fromDate + '&userCode=' + data.userCode + '&payStatus=' + data.payStatus + '&fromStation=' + data.fromStation + '&toStation=' + data.toStation + '&customerName=' + data.customerName + '&groupBy=' + data.groupBy;
            var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
            wo.print();
        }

        function bkgPrintToPaid() {
            var data = {};
            data.dateRange = $('#booking_rpt_date_range').val();
            data.userCode = $('#trns_rpt_user_code').val();
            data.payStatus = $('#trns_rpt_pay_status').val();
            data.fromStation = $('#trns_rpt_from_station').val();
            data.toStation = $('#trns_rpt_to_station').val();
            data.customerName = $.trim($('#customerName').val());
            data.groupBy = $('#bkg_group_by').val();

            var url = base_url + "cargo/booking-report-list?print=1&printToPay=1&toDate=" + data.toDate + '&fromDate=' + data.fromDate + '&userCode=' + data.userCode + '&payStatus=' + data.payStatus + '&fromStation=' + data.fromStation + '&toStation=' + data.toStation + '&customerName=' + data.customerName + '&groupBy=' + data.groupBy;
            var wo = window.open(url, "_blank", "toolbar=no, scrollbars=yes, resizable=yes, top=50, left=50, width=1000, height=650");
            wo.print();
        }

        function exportTalyExcel() {
            document.con_bk_rpt.action = "cargo/booking-report-list-tally";
            document.con_bk_rpt.target = "ifrm_consolidate_downloader";
            $('#Talyexport').val(1);
            document.con_bk_rpt.submit();
            return;
        }
    <?php echo '</script'; ?>
>

<?php }
}
