<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 11:27:50
  from 'E:\xampp\htdocs\cargo\application\views\site\report\zone-report.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665ffe5e28e0d2_53046013',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3c1de90f413c72795f5a6e106d5ab598686f71b4' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\zone-report.tpl',
      1 => 1717055751,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665ffe5e28e0d2_53046013 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Zone Report</h3>
    <div class="text-right noprint hide" id="zone_rcv_rpt_excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportZoneReceivableReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the branch collection amount based on grouping multiple branch.
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
                                            <form id='zone_rcv_report' name="zone_rcv_report" method="post" action="report/zone-report-list" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label for="zone_rcv_date_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="zone_rcv_date_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                                                                            <div class="form-group col-md-2">
                                                            <label for="zone-rcv-zone" class="">Zone</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="zone-rcv-zone" name="zoneCode" class="form-control">
                                                                    <option value="NA" data-stationcode="">All Zone</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['zone']->value, 'row', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                        <?php $_smarty_tpl->_assignInScope('stationsArray', array());?>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->stations, 'stn', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['stn']->value) {
?>
                                                                            <?php $_tmp_array = isset($_smarty_tpl->tpl_vars['stationsArray']) ? $_smarty_tpl->tpl_vars['stationsArray']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[] = $_smarty_tpl->tpl_vars['stn']->value->code;
$_smarty_tpl->_assignInScope('stationsArray', $_tmp_array);?>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-stationcode="<?php echo implode(",",$_smarty_tpl->tpl_vars['stationsArray']->value);?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>
                                                                                                        <div class="col-md-2">
                                                        <label for="stationCode" class="">Stations</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="zone-station" name="stationCode" class="form-control" onclick="stationfilter();">
                                                                <option value="NA" data-station="">All Station</option>
                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['stations']->value, 'station');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['station']->value) {
?>
                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
" data-station="<?php echo $_smarty_tpl->tpl_vars['station']->value['code'];?>
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
                                                        <label for="zone-branch" class="">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="zone-branch" name="organizationCode" class="form-control">
                                                                <option value="NA" data-brachcode="NA">All Branch</option>
                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'branch', false, 'bcode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bcode']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
" data-brachcode="<?php echo $_smarty_tpl->tpl_vars['branch']->value->station->code;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value->name;?>
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

                                                    <div class="form-group col-md-2">
                                                        <label for="zone-transaction-type" class="">Type</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="zone-transaction-type" name="transactionType" class="form-control">
                                                                <option value="BOOKING">Outward</option>
                                                                <option value="DELIVERY">Inward</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-2">
                                                        <label for="zone-charges-type" class="">Charges</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="zone-charges-type" name="zone-charges-type" class="form-control">
                                                                <option value="1">With Conn.Charges</option>
                                                                <option value="0">W/o Conn.Charges</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <input type="hidden" name="zoneName" id="zoneName" value="">
                                                            <input type="hidden" name="branchName" id="branchName" value="">
                                                            <input type="hidden" name="chargeType" id="chargeType" value="">
                                                            <button class="btn btn-success" type="button" onclick="searchZoneReceivableReport()">Search</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearZoneReceivableReport()">Clear</button>
                                                        </div>
                                                    </div>

                                                </div>
                                                <br class="clear_fix_both">
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="zone_rcv_rpt_action_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row hidden" id="zone-rcv-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="zone-rcv-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="zone-rcv-rpt-details-dialog" class="dialog-content-page hide">
    <div id="zone-rcv-details-list"></div>
</div>

<?php echo '<script'; ?>
>
    $('#zone_rcv_date_range').daterangepicker({
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

    var picker = $('#zone_rcv_date_range').data('daterangepicker');
    picker.container.find('.calendar').on('click', 'td.available', function() {
        setEndTime(picker);
    });

    // $('#zone-station').multiselect({
    //     maxHeight: 200,
    //     numberDisplayed: 1,
    //     buttonWidth: '100%',
    //     dropLeft: true,
    //     buttonClass: 'btn btn-default zone-station',
    // });

    function setEndTime(picker) {
        if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
            picker.setEndDate(moment(picker.endDate).endOf('day'));
        }
    }

    $('#zone-rcv-zone, #zone-branch, #zone-station').select2();
    $('#zone-rcv-zone, #zone-branch').val('NA').trigger('change');
    var zone_branch_list = $('#zone-branch option');
    var zone_station_list = $('#zone-station option')
    var emptyOrgOption = '<option value="NA" data-brachcode="NA">All Branch</option>';
    var emptyStnOption = '';

    $('#zone-rcv-zone').on('change', function() {
        $('#zone-station').val('NA').trigger('change.select2');
        $('#zone-branch').val('NA').trigger('change.select2');
        let zoneValue = $('#zone-rcv-zone').val();
        let stationValue = $('#zone-rcv-zone').val();
        let branchValue = $('#zone-rcv-zone').val();

        if ($(this).val() != "" && $(this).val() != 'NA' && stationValue != "NA") {
            $("#zone-station").select2("val", "");
        }
        if ($(this).val() != "" && $(this).val() != 'NA' && stationValue != "NA" && branchValue != 'NA') {
            $("#zone-branch").select2("val", "");
        }

        var zone_station_code = $('#zone-rcv-zone option:selected').data('stationcode');
        var zone_stn_array = zone_station_code.split(',');
        branchOfStation(zone_stn_array);

        $('#zone-station').html(function() {
        var allOption = $('<option>').val('NA').text('All Station').data('station', "");
            var filteredOptions = zone_station_list.filter(function() {
                return $.inArray($(this).data('station'), zone_stn_array) !== -1 || ($('#zone-rcv-zone').val() == 'NA' && $(this).val() != 'NA' && $('#zone-rcv-zone').val() != $(this).data('station'));
            });
            return [allOption].concat(filteredOptions.toArray());
        }).val('NA').trigger('change.select2');
    });

    function stationfilter() {
        var zone_station_code = $('#zone-station option:selected').data('station');
        var zone_stn_array = zone_station_code.split(',');
        branchOfStation(zone_stn_array);
        $('#zone-branch').html(function() {
            return zone_branch_list.filter(function() {
                return $.inArray($(this).data('brachcode'), zone_stn_array) !== -1 || ($('#zone-station').val() == 'NA' && $(this).val() != 'NA');
            });
        }).prepend(emptyOrgOption).val('NA').trigger('change');
    }

    function branchOfStation(zone_stn_array) {
        $('#zone-branch').html(function() {
            var allOption = $('<option>').val('NA').text('All Branch').data('brachcode', '');
            var filteredOptions = zone_branch_list.filter(function() {
                return $.inArray($(this).data('brachcode'), zone_stn_array) !== -1 || ($('#zone-rcv-zone').val() == 'NA' && $(this).val() != 'NA');
            });

            return [allOption].concat(filteredOptions.toArray());
        }).val('NA').trigger('change.select2');
    }

    var user_branch_code = '<?php echo $_smarty_tpl->tpl_vars['login_station']->value;?>
';
    if (user_branch_code !== '') {
        $('#zone-station').val(user_branch_code).prop('selected', true).change();
        stationfilter();
    }

    function searchZoneReceivableReport() {
        $('#zone-rcv-list').html('');
        var data = {};
        data.dateRange = $('#zone_rcv_date_range').val();
        data.zoneCode = $('#zone-rcv-zone').val();
        data.organizationCode = $('#zone-branch').val();
        data.transactionType = $('#zone-transaction-type').val();
        data.chargeType = $('#zone-charges-type').val();
        data.stationCode = $('#zone-station').val();
        // data.stationCode = ($('#zone-station').val() || []).join(',');
        var err = 0;
        if (data.dateRange == '') {
            $('#zone_rcv_date_range').addClass('inp_error');
            err++;
        } else {
            $('#zone_rcv_date_range').removeClass('inp_error');
        }

        if (err > 0) {
            $('#zone_rcv_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#zone_rcv_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#zone_rcv_rpt_action_state').show();
            return false;
        } else {
            $('#zone_rcv_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#zone_rcv_rpt_action_state').html('');
            $('#zone_rcv_rpt_action_state').hide();
        }

        $('#zone_rcv_date_range').removeClass('inp_error');
        $('#zone-rcv-list-container').removeClass('hidden');
        $('#zone_rcv_rpt_excel').addClass('hide');
        $('#zone-rcv-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/zone-report-list",
            data: data,
            success: function(response) {
                $('#zone-rcv-list').html(response);
                $('#zone_rcv_rpt_excel').removeClass('hide');
            }
        })
    }

    function clearZoneReceivableReport() {
        $('#zone_rcv_date_range').val('');
        $('#zone-transaction-type').val('BOOKING').trigger('change');
        // $('#zone-station').val('').multiselect('rebuild');
        $('#zone-station').val('NA').trigger('change');
        $('#zone-branch').val('NA').trigger('change');
        $('#zone-rcv-zone').val('NA').trigger('change');
        $('#zone-rcv-list-container').addClass('hidden');
        $('#zone-rcv-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#zone_rcv_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#zone_rcv_rpt_excel').addClass('hide');
        $('#zone-charges-type').val('1').trigger('change');
    }

    function exportZoneReceivableReport() {
        document.zone_rcv_report.target = "ifrm_downloader";
        $('#export').val(1);
        var chargeType = $('#zone-charges-type').val();
        var zoneName = $('#zone-rcv-zone option:selected').text();
        var branchName = $('#zone-branch option:selected').text();
        $('#zoneName').val(zoneName);
        $('#branchName').val(branchName);
        $('#chargeType').val(chargeType);
        document.zone_rcv_report.submit();
        return;
    }
<?php echo '</script'; ?>
>

<?php }
}
