<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 12:25:17
  from 'E:\xampp\htdocs\cargo\application\views\site\report\pending-current-door-delivery-report.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_667280d5605f19_79853589',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4e2b16bc545f9a4189122f28c1631ab8d37da1a9' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\pending-current-door-delivery-report.tpl',
      1 => 1718780113,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_667280d5605f19_79853589 (Smarty_Internal_Template $_smarty_tpl) {
?>
<div class="brand_top">
    <h3>Door Delivery Report</h3>
    <div class="text-right noprint" id="pedg_curnt_delvy_excel" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportCargoEditReport();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="DeliveryReportPrint();"><i class="fa fa-print fa-lg"></i> Print</button>
            <button class="btn btn-default" onclick="DeliverysumaryPrint();"><i class="fa fa-print fa-lg"></i> Summary Print</button>
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
                                                <form id="pending_curnt_Dlvery_report" method="post" name="pending_curnt_Dlvery_report" action="report/pending-current-delivery-report-list" onsubmit="return false;">
                                                    <div class="row">
                                                        <div class="form-group col-md-2">
                                                            <label for="pending_curnt_delivery_date">Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="date" class="form-control sdate" id="pending_curnt_delivery_date" readonly placeholder="Date">
                                                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="pending_crnt_org">Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CGO-VIEW-ALL-LR'] == 1) {?>
                                                                    <select id="pending_crnt_org" class="form-control" name="organizationCode">
                                                                        <option value="NA" selected="" data-name="NA">All Branch</option>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organizations']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-name="<?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                <?php } else { ?>
                                                                    <select id="pending_crnt_org" class="form-control" name="organizationCode" disabled>
                                                                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organizations']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                                                            <option value="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" data-name="<?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
" <?php if ($_smarty_tpl->tpl_vars['row']->value->code == $_smarty_tpl->tpl_vars['login_user_branch_code']->value) {?>selected="<?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
" <?php }?>><?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>
</option>
                                                                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                                                    </select>
                                                                <?php }?>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2 ">
                                                            <div class="input-group">
                                                                <input type="hidden" name="print" id="print" value="">
                                                                <input type="hidden" name="branch_name" id="branch_name" value="">
                                                                <input type="hidden" name="export" id="export" value=""><br>
                                                                <button class="btn btn-success" type="button" onclick="searchDeliveryReport()">Generate</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearDeliveryReport();">Clear</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="pending_curnt_report"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--row end-->
                    <div class="row hidden" id="pending-delry-rpt-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="pending-delry-rpt-list"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--content end-->
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_downloader" id="ifrm_downloader" style="display:none"></iframe>
<?php echo '<script'; ?>
>
    $('#pending_crnt_org').select2();
    $('#pending_curnt_delivery_date').datepicker({
        todayHighlight: true,
        startDate: '-20m',
        endDate: '+3m',
        format: 'yyyy-mm-dd',
        maxDate: "+365D",
        autoclose: true
    });
    
        $('#pending_crnt_org').change(function() {
            var selectedOptionName = $(this).find(':selected').data('name');
            console.log(selectedOptionName);
            $('#branch_name').val(selectedOptionName);
        });


        function searchDeliveryReport() {
            $('#pending-delry-rpt-list').html('');
            var data = {};
            data.date = $('#pending_curnt_delivery_date').val();
            data.organizationCode = $('#pending_crnt_org').val();
            data.branch_name = $('#pending_crnt_org option:selected').text();
            var err = 0;
            $('.inp_error').removeClass('inp_error');

            if (data.date == '') {
                $('#pending_curnt_delivery_date').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#pending_curnt_report').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#pending_curnt_report').html('Please enter/select the values in the field that are marked in red');
                $('#pending_curnt_report').show();
                return false;
            } else {
                $('#pending_curnt_report').removeClass('alert-success').removeClass('alert-danger');
                $('#pending_curnt_report').html('');
                $('#pending_curnt_report').hide();
            }
            var html = "";
            $('#pending_curnt_delivery_date').removeClass('inp_error');
            $('#pending-delry-rpt-list-container').removeClass('hidden');
            $('#pending-delry-rpt-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "report/pending-current-delivery-report-list",
                data: data,
                success: function(response) {
                    $('#pending-delry-rpt-list').html(response);
                    $('#pedg_curnt_delvy_excel').show();
                    $('html, body').animate({
                        scrollTop: $('#pending-delry-rpt-list-container').offset().top - 35
                    }, 'slow');
                }
            });
        }

        function clearDeliveryReport() {
            $('#pending_curnt_delivery_date').val('');
            $('#pending-delry-rpt-list-container').addClass('hidden');
            $('#pending-delry-rpt-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#pending_curnt_report').removeClass('alert-success').removeClass('alert-danger');
            $('#pending_curnt_report').html('');
            $('#pending_curnt_report').hide();
            $('#pending_crnt_org').val('NA').trigger('change');
            $('#cargoedit_rpt_event').val('NA').trigger('change');
            $('#pedg_curnt_delvy_excel').hide();
        }

        function DeliveryReportPrint() {
            $('#print').val(1);
            $('#export').val('');
            document.pending_curnt_Dlvery_report.target = "ifrm_downloader";
            document.pending_curnt_Dlvery_report.action = "report/pending-current-delivery-report-list";
            document.pending_curnt_Dlvery_report.submit();
            return;
        }

        function exportCargoEditReport() {
            $('#export').val(1);
            $('#print').val('');
            document.pending_curnt_Dlvery_report.target = "ifrm_downloader";
            document.pending_curnt_Dlvery_report.action = "report/pending-current-delivery-report-list";
            document.pending_curnt_Dlvery_report.submit();
            return;
        }



        function DeliverysumaryPrint() {
            $('#branch_name').val();
            $('#export').val('');
            $('#print').val('');
            document.pending_curnt_Dlvery_report.target = "ifrm_downloader";
            document.pending_curnt_Dlvery_report.action = "report/pending-current-delivery-report-sumry-print";
            document.pending_curnt_Dlvery_report.submit();
            return;
        }

    
<?php echo '</script'; ?>
><?php }
}
