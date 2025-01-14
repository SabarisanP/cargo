<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 15:58:05
  from 'E:\xampp\htdocs\cargo\application\views\site\report\transit-analysis-report.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6672b2b5ce7cb4_43912547',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '86ec6c2f2d19f8dc474cfc07a73213c1baa6998a' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\transit-analysis-report.tpl',
      1 => 1718792098,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6672b2b5ce7cb4_43912547 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Transit Movement Report</h3>
    <div class="text-right noprint hide" id="transit_rcv_rpt_excel">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportTransitReceivableReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                            <form id='transit_rcv_report' name="transit_rcv_report" method="post" action="report/transit-analysis-report-list" onsubmit="return false">
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label for="transit_rcv_date_ranget" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="transit_rcv_date_ranget" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>

                                                                                                            <div class="form-group col-md-2">
                                                            <label for="transit-rcv-transit" class="">Zone</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="transit-rcv-transit" name="zoneCode" class="form-control">
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
                                                                                                        <div class="form-group col-md-2">
                                                        <label for="zone-branch" class="">Branch</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="transit-branch" name="organizationCode" class="form-control">
                                                                <option value="NA" data-brachcode="NA">All Branch</option>
                                                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organization']->value, 'branch', false, 'bcode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bcode']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['branch']->value->code;?>
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
                                                        <label for="search-lr" class="">Search LR</label>
                                                        <div class="input-group col-md-12">
                                                            <input type="text" name="cargoCode" class="form-control sdate capitalize" id="search-lr" placeholder="LR Number">
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="transit-transaction-type" class="">Transit Type</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="transit-transaction-type" name="transitTypeCode" class="form-control">
                                                                <option value="INTRANSIT">INTRANSIT</option>
                                                                <option value="YETTRANSIT">YETTRANSIT</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="transitAge" class="">Transit Age</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="transitAge" name="transitAge" class="form-control">
                                                                <option value="0">0 Day</option>
                                                                <option value="1">Same Day</option>
                                                                <option value="2"> 1 Days</option>
                                                                <option value="3">Above 1 Day</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="transit-filter-type" class="">Filter Type</label>
                                                        <div class="input-group col-md-12">
                                                            <select id="transit-filter-type" name="filterType" class="form-control">
                                                                <option value="SUMMARY">SUMMARY</option>
                                                                <option value="DETAILS">DETAILS</option>

                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <input type="hidden" name="zoneName" id="zoneName" value="">
                                                            <input type="hidden" name="branchName" id="branchName" value="">
                                                            <input type="hidden" name="statusCode" id="statusCode" value="">
                                                            <button class="btn btn-success" type="button" onclick="searchZoneReceivableReport()">Search</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearZoneReceivableReport()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <br class="clear_fix_both">
                                                <div class="align-center alert alert-danger pull-left" style="display:none;" id="transit_rcv_rpt_action_state"></div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row hidden" id="transit-rcv-list-container">
                    <br>
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="transit-rcv-list"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!--content end-->
        </div>
        <!--row end-->
    </div>
</div>

<div id="transit-lr-details" class="hide dialog-content-page">
    <div>
        <div class="popup_top noprint">
            <div class="row">
                <div class="col-md-10 bold ft_14">Transit Movement Report - <span id="transit-lr-details-user"></span></div>
                <div class="col-md-2">
                    <a class="align-right" onclick="closeTransitDetailsDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
                </div>
            </div>
        </div>
        <br />
        <div class="clearfix"></div>
        <div id="transit-lr-details-list">

        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>

<div id="transit-rcv-rpt-details-dialog" class="dialog-content-page hide">
    <div id="transit-rcv-details-list"></div>
</div>

<?php echo '<script'; ?>
>
    $('#transit_rcv_date_ranget').daterangepicker({
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

    var picker = $('#transit_rcv_date_ranget').data('daterangepicker');
    picker.container.find('.calendar').on('click', 'td.available', function() {
        setEndTime(picker);
    });

    function setEndTime(picker) {
        if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
            picker.setEndDate(moment(picker.endDate).endOf('day'));
        }
    }

    $('#transit-rcv-transit, #transit-branch ').select2();
    $('#transit-rcv-transit').val('NA').trigger('change');

    function searchZoneReceivableReport() {
        $('#transit-rcv-list').html('');
        var data = {};

        data.dateRange = $('#transit_rcv_date_ranget').val();
        data.zoneCode = $('#transit-rcv-transit').val();
        data.cargoCode = $('#search-lr').val().trim();
        data.transitTypeCode = $('#transit-transaction-type').val();
        data.transitAge = $('#transitAge').val();
        data.filterType = $('#transit-filter-type').val();
        data.organizationCode = $('#transit-branch').val();

        var err = 0;
        if (data.dateRange == '') {
            $('#transit_rcv_date_ranget').addClass('inp_error');
            err++;
        } else {
            $('#transit_rcv_date_ranget').removeClass('inp_error');
        }

        if (err > 0) {
            $('#transit_rcv_rpt_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
            $('#transit_rcv_rpt_action_state').html('Please enter/select the values in the field that are marked in red');
            $('#transit_rcv_rpt_action_state').show();
            return false;
        } else {
            $('#transit_rcv_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#transit_rcv_rpt_action_state').html('');
            $('#transit_rcv_rpt_action_state').hide();
        }

        $('#transit_rcv_date_ranget').removeClass('inp_error');
        $('#transit-rcv-list-container').removeClass('hidden');
        $('#transit_rcv_rpt_excel').addClass('hide');
        $('#transit-rcv-list').html(loading_popup);
        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/transit-analysis-report-list",
            data: data,
            success: function(response) {
                $('#transit-rcv-list').html(response);
                $('#transit_rcv_rpt_excel').removeClass('hide');
            }
        })
    }

    function clearZoneReceivableReport() {
        $('#transit-branch').val('NA');
        $('#transit_rcv_date_ranget').val('');
        $('#transit-transaction-type').val('INTRANSIT');
        $('#transit-rcv-transit').val('NA').trigger('change');
        $('#transit-rcv-list-container').addClass('hidden');
        $('#transit-rcv-list').html('');
        $('.inp_error').removeClass('inp_error');
        $('#transit_rcv_rpt_action_state').removeClass('alert-success').removeClass('alert-danger');
        $('#transit_rcv_rpt_excel').addClass('hide');
    }

    function exportTransitReceivableReport() {
        document.transit_rcv_report.target = "ifrm_downloader";
        $('#export').val(1);
        var zoneName = $('#transit-rcv-transit option:selected').text();
        $('#zoneName').val(zoneName);
        document.transit_rcv_report.submit();
        return;
    }


    function getTransitlrDetails(orgCode, statusCode, name) {

        var data = {};
        data.dateRange = $('#transit_rcv_date_ranget').val();
        data.zoneCode = $('#transit-rcv-transit').val();
        data.cargoCode = $('#search-lr').val().trim();
        data.transitTypeCode = $('#transit-transaction-type').val();
        if(statusCode==="NA"){
            data.transitAge =0;
        }else{
            data.transitAge = $('#transitAge').val();
        }
        
        data.organizationCode = orgCode;
        data.statusCode = statusCode;

        console.log(data);
        $('#transit-lr-details').removeClass('hide');
        $('#transit-lr-details').dialog({
            autoOpen: true,
            height: 650,
            width: 1400,
            modal: true,
            closeOnEscape: true,
            resizable: false
        });
        $(".ui-dialog-titlebar").hide();
        $('#transit-lr-details-list').html(loading_small);

        $('#transit-lr-details-user').html(name);

        $.ajax({
            type: "POST",
            dataType: 'html',
            url: base_url + "report/transit-analysis-report-list-details",
            data: data,
            success: function(res) {
                $('#transit-lr-details-list').html(res);
            }
        })
    }

    function closeTransitDetailsDialog() {
        $('#transit-lr-details').dialog('destroy');
        $('#transit-lr-details').hide();
        $('#transit-lr-details-list').html('');
    }
<?php echo '</script'; ?>
><?php }
}
