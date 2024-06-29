<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 15:52:16
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\onbehalf-report.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66603c58866d90_42227347',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '15e19db5ce9def9cc5637b4535aa4bdf67b3f86d' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\onbehalf-report.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66603c58866d90_42227347 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>On Behalf Of Booking and delivery Report</h3> 
    <div class="text-right noprint" id="excl_cons" style="display:none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportOnbehalfExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
            <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
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

                                                <form id='onbehalf_report_form' method="post" name="onbehalf_report_form" action="cargo/onbehalf-report-list" onsubmit="return false;">
                                                    <div class="row">   

                                                        <div class="form-group col-md-2">
                                                            <label for="onbehalf_date_from">From Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="fromDate" class="form-control sdate" id="onbehalf_date_from" readonly="true" placeholder="Date From">
                                                                <label class="input-group-addon" for="onbehalf_date_from"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">To Date</label>
                                                            <div class="input-group">
                                                                <input type="text" name="toDate" class="form-control sdate" id="onbehalf_date_to" readonly="true" placeholder="Date To">
                                                                <label class="input-group-addon" for="onbehalf_date_to"><i class="fa fa-calendar"></i></label>
                                                            </div>
                                                        </div>                                                           

                                                        <div class="form-group col-md-2">
                                                            <label  for="onbehalf_date_to">From Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="onbehalf_from_branch" name="fromOrganizationCode"  class="form-control select2" >
                                                                    <option value='NA' selected="">All Branch</option>
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
                                                                </select>      
                                                            </div>
                                                        </div>    
                                                        <div class="form-group col-md-2">
                                                            <label  for="onbehalf_date_to">To Branch</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="onbehalf_to_branch" name="toOrganizationCode"  class="form-control select2" >
                                                                    <option value='NA' selected="">All Branch</option>
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
                                                                </select>      
                                                            </div>
                                                        </div>    

                                                    </div>

                                                    <div class="row">


                                                        <div class="form-group col-md-2">
                                                            <label  for="onbehalf_date_to">From Station</label>
                                                            <div class="input-group col-md-12">
                                                                <select id="onbehalf_from_station" name="fromStation"  class="form-control select2" >
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
                                                            <label  for="onbehalf_date_to">To Station</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="onbehalf_to_station" name="toStation"  class="form-control select2" >
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
                                                            <label  for="onbehalf_date_to">Type</label>
                                                            <div class="input-group col-md-11">
                                                                <select id="onbehalf_filter" name="filterType"  class="form-control" >
                                                                    <option value='BOOKING'>Booking</option>
                                                                    <option value='TRANSACTION'>Transaction</option>
                                                                </select>      
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-2">
                                                            <label for="cons_rpt_date_to">&nbsp;</label>
                                                            <div class="input-group">
                                                                <input type="hidden" name="export" id="export" value="">
                                                                <input type="hidden" name="pdf" id="pdf" value="">
                                                                <button class="btn btn-success" type="button" id="generate-report-btn" onclick="onbehalfReport();">Search</button>&nbsp;
                                                                <button type="button" class="btn btn-default btn-clear" onclick="clearOnbehalfReport();">Clear</button>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                </form> 
                                            </div>
                                            <br class="clear_fix_both">
                                            <div class="align-center alert alert-danger pull-left" style="display:none" id="onbehalf_action_state"></div>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row hidden" id="onbehalf-list-container">
                        <br>
                        <div class="col-lg-12">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <div id="onbehalf-list"></div>                                    
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


    <?php echo '<script'; ?>
>
        $('#onbehalf_date_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            startDate: '-6m',
            autoclose: true,
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 365));
            $('#onbehalf_date_to').datepicker('setStartDate', e.date);
            $("#onbehalf_date_to").datepicker("setEndDate", end)
        });
        $('#onbehalf_date_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            format: 'yyyy-mm-dd',
            maxDate: "+365D",
            autoclose: true
        }).on('changeDate', function (e) {
            $('#onbehalf_date_from').datepicker('setEndDate', e.date)
        });

        $('.select2').select2();
        
        function onbehalfReport() {
            $('#onbehalf-list').html('');
            var data = {};
            data.fromDate = $('#onbehalf_date_from').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.toDate = $('#onbehalf_date_to').data('datepicker').getFormattedDate('yyyy-mm-dd');
            data.fromStation = $('#onbehalf_from_station').val();
            data.toStation = $('#onbehalf_to_station').val();
            data.fromOrganizationCode = $('#onbehalf_from_branch').val();
            data.toOrganizationCode = $('#onbehalf_to_branch').val();
            data.filterType = $('#onbehalf_filter').val();

            var err = 0;
            $('#onbehalf_date_from, #onbehalf_date_to').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#onbehalf_date_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#onbehalf_date_to').addClass('inp_error');
                err++;
            }

            if (data.fromDate != '' && data.toDate != '') {
                var f = data.fromDate.split('-');
                var a = moment([f[0], f[1], f[2]]);

                var e = data.toDate.split('-');
                var b = moment([e[0], e[1], e[2]]);
                var t = b.diff(a, 'days');
                if (t > 31) {
                    $('#onbehalf_date_to').addClass('inp_error');
                    $('#onbehalf_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                    $('#onbehalf_action_state').html('Date range should be 31 days or less');
                    $('#onbehalf_action_state').show();
                    err++;
                    return false;
                }
            }

            if (err > 0) {
                $('#onbehalf_action_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#onbehalf_action_state').html('Please enter/select the values in the field that are marked in red');
                $('#onbehalf_action_state').show();
                return false;
            } else {
                $('#onbehalf_action_state').removeClass('alert-success').removeClass('alert-danger');
                $('#onbehalf_action_state').html('');
                $('#onbehalf_action_state').hide();
            }
            var html = "";
            $('#onbehalf_date_to').removeClass('inp_error');
            $('#onbehalf-list-container').removeClass('hidden');
            $('#generate-report-btn').prop('disabled', true);
            $('#onbehalf-list').html(loading_popup);

            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "cargo/onbehalf-report-list",
                data: data,
                success: function (response) {
                    $('#generate-report-btn').prop('disabled', false);
                    $('#onbehalf-list').html(response);
                    $('#excl_cons').show();
                    $("html, body").animate({
                        scrollTop: $('#onbehalf-list-container').offset().top - 35
                    }, "slow");
                }
            })
        }

        function clearOnbehalfReport() {
            $('#onbehalf_date_from').val('');
            $('#onbehalf_date_to').val('');
            $('#onbehalf-list-container').addClass('hidden');
            $('#onbehalf-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#onbehalf_action_state').removeClass('alert-success').removeClass('alert-danger');
            $('#onbehalf_action_state').html('');
            $('#onbehalf_action_state').hide();

            $('#onbehalf_from_station').val('NA').trigger('change');
            $('#onbehalf_to_station').val('NA').trigger('change');
            $('#onbehalf_from_branch').val('NA').trigger('change');
            $('#onbehalf_to_branch').val('NA').trigger('change');
            $('#onbehalf_filter').val('BOOKING').trigger('change');
            
            $('#excl_cons').hide();
        }

        function exportOnbehalfExcel() {
            $('#export').val(1);
            document.onbehalf_report_form.target = "ifrm_downloader";
            document.onbehalf_report_form.submit();
            return;
        }
    <?php echo '</script'; ?>
>

<?php }
}
