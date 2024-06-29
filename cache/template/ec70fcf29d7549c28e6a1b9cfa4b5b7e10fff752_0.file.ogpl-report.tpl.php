<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-27 10:55:40
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-report.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667cf7d45e4fb2_01386626',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'ec70fcf29d7549c28e6a1b9cfa4b5b7e10fff752' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-report.tpl',
      1 => 1719464252,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667cf7d45e4fb2_01386626 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Transit Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportRevenueExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="exportOgplReportTally()"><i class="fa fa-download fa-lg"></i>Tally Excel</button>
            <button class="btn btn-default" onclick="<?php if (in_array($_smarty_tpl->tpl_vars['namespace']->value,array("rmtcargo","seenutransports","seenucargo"))) {?>printOgplReport()<?php } else { ?>window.print()<?php }?>"><i class="fa fa-print fa-lg"></i> Print</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 note text-muted noprint">
            <i class="fa fa-info-circle" data-toggle="tooltip" data-title="Notes" data-original-title="" title=""></i>
            Shows the the OGPL route details based on vehicle and branch.
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

                                                <form id='con_rv_rpt' method="post" name="con_rv_rpt" action="cargo/ogpl-report-list" onsubmit="return false;">
                                                    <div class="row">   
                                                    <div class="form-group col-md-3">
                                                        <label for="ogpl_rpt_date_range" class="req">Date Range</label>
                                                        <div class="input-group">
                                                            <input type="text" name="dateRange" class="form-control sdate" id="ogpl_rpt_date_range" readonly="true" placeholder="Date Range">
                                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                        </div>
                                                    </div>         
                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl-report-vehicle">Vehicle</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ogpl-report-vehicle" name="vehicleCode" class="form-control select2">
                                                                    <option value="NA" selected="">Select Vehicle</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vehicles']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->activeFlag == 1) {?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->registationNumber;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->vehicleType->name;?>
</option>
                                                                        <?php }?>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="ogpl-report-type">Type</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="ogpl-report-type" name="filterType" class="form-control select2">
                                                                    <option value="ALL" selected="">All</option>
                                                                    <option value="LOAD">Load</option>
                                                                    <option value="UNLOAD">Unload</option>
                                                                </select>
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="organizationCode" name="organizationCode"  class="form-control select2" >
                                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-OTHER-BRANCH-LR'] > 0) {?>    
                                                                    <option value="<?php echo $_smarty_tpl->tpl_vars['login_branch']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['login_branch_name']->value;?>
</option>
                                                                <?php } else { ?>
                                                                     <option value='NA' selected="">Select Branch</option>
                                                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branches']->value, 'branch', false, 'bcode');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['bcode']->value => $_smarty_tpl->tpl_vars['branch']->value) {
?>
                                                                        <option value="<?php echo $_smarty_tpl->tpl_vars['bcode']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['branch']->value;?>
</option>
                                                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                <?php }?>
                                                                </select>      
                                                            </div>
                                                        </div>    

                                                    </div>

                                                    <div class="row">


                                                        <div class="form-group col-md-2">
                                                            <label  for="rev_rpt_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="rev_rpt_from_station" name="fromStation"  class="form-control select2" >
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
                                                            <label  for="rev_rpt_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="rev_rpt_to_station" name="toStation"  class="form-control select2" >
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
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <input type="hidden" name="organizationName" id="organizationName" value="">
                                                                <button class="btn btn-success" type="button"  onclick="deliveryReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDeliveryReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="revenue_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="revenue-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="revenue-list"></div>                                    
                                </div>
                            </div>
                        </div>
                    </div>

                </div>                        
            </div>                    
        </div>
    </div>            
</div>
<div id="unload-lr-dialog"  class="dialog-content-page hide">
    <div class="clearfix">
        <span style="font-size: 18px;">Unloading Complaints</span>
        <a href="javascript:;" class="pull-right" onclick="hideUnloadLrDialog();"><i class="fa fa-times-circle fa-2x"></i></a>
    </div>
    <div id="unload-lr-body" style="height: 450px;overflow: auto;"></div></div>          
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe> 


    <?php echo '<script'; ?>
>
   
        $('#ogpl-report-vehicle').select2();
        $('#organizationCode').select2();
        $('#ogpl_rpt_date_range').daterangepicker({
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

        var picker = $('#ogpl_rpt_date_range').data('daterangepicker');
        picker.container.find('.calendar').on('click', 'td.available', function() {
            setEndTime(picker);
        });

        function setEndTime(picker) {
            if (picker.endDate.format('HH:mm:ss') == '00:00:00') {
                picker.setEndDate(moment(picker.endDate).endOf('day'));
            }
        }
            
        function deliveryReport() {
            $('#revenue-list').html('');
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            var data = {};
            data.dateRange = $('#ogpl_rpt_date_range').val();
            data.organizationCode = $('#organizationCode').val();
            data.filterType = $('#ogpl-report-type').val();
            if (data.filterType != 'ALL') {
                if (data.organizationCode == 'NA') {
                    $('#organizationCode').addClass('inp_error');
                    err++;
                }
            }

            data.vehicleCode = $('#ogpl-report-vehicle').val();

            if (data.dateRange == '') {
                $('#ogpl_rpt_date_range').addClass('inp_error');
                err++;
            } else {
                $('#ogpl_rpt_date_range').removeClass('inp_error');
            }

            if (err > 0) {
                $('#revenue_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#revenue_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#revenue_action_state').show();
                return false;
            } else {
                $('#revenue_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#revenue_action_state').html('');
                $('#revenue_action_state').hide();
            }
            var html = "";
            $('#ogpl_rpt_date_range').removeClass('inp_error');
            $('#revenue-list-container').removeClass('hidden');
            $('#revenue-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/ogpl-report-list",
                data: data,
                success: function (response) {
                    $('#revenue-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#revenue-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearDeliveryReport() {
            $('#ogpl_rpt_date_range').val('');
            $('#revenue-list-container').addClass('hidden');
            $('#revenue-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#revenue_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#revenue_action_state').html('');
            $('#revenue_action_state').hide();
            $('#rev_rpt_from_station').val('NA').trigger('change');
            $('#rev_rpt_to_station').val('NA').trigger('change');
            $('#organizationCode').val('NA').trigger('change');
            $('#ogpl-report-vehicle').val('NA').trigger('change');
            $('#excl_cons').hide();
        }

        function exportRevenueExcel() {
            $('#export').val(1);
            $('#print').val('');
            document.con_rv_rpt.action = "cargo/ogpl-report-list";
            
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.submit();
            return;
        }

        function printOgplReport() {
            $('#export').val('');
            $('#print').val(1);
            var branch = $('#organizationCode option:selected').text();
            $('#organizationName').val(branch);
            document.con_rv_rpt.target = "ifrm_downloader";
            document.con_rv_rpt.submit();
            return;
        }

        function getComplaintLr(transitCode, aliasCode, organizationCode) {
            if(transitCode=="") return;
            
            $('#unload-lr-dialog').removeClass('hide');
            $('#unload-lr-dialog').dialog({
                autoOpen: true,
                height: 550,
                width: 800,
                modal: true,
                closeOnEscape:true,
                resizable: false
            });
            $(".ui-dialog-titlebar").hide();   
            $('#unload-lr-body').html(loading_small);  
            
            var data = {};
            data.transitCode = transitCode;  
            data.aliasCode = aliasCode;
            data.organizationCode = organizationCode;
            data.filterType = 'UNLD_WI_RMK';
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/ogpl-report-lr-list",
                data: data,
                success: function (res) {
                    $('#unload-lr-body').html(res);
                }
            })
        }

        function hideUnloadLrDialog() {
            $('#unload-lr-dialog').dialog('destroy');
            $('#unload-lr-dialog').hide();
        }

        function exportOgplReportTally() {
            document.con_rv_rpt.action = "cargo/ogpl-report-list-tally";
            document.con_rv_rpt.target = "ifrm_downloader";
			$('#export').val(1);
            document.con_rv_rpt.submit();
            return;
        }

    <?php echo '</script'; ?>
>

<?php }
}
