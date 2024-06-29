<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 17:08:52
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\profit-and-loss.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66604e4c215925_75593065',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5ebf82962b547c8fe38c75640d4dbf034aa93c67' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\profit-and-loss.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66604e4c215925_75593065 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="brand_top">
    <h3>Profit and Loss</h3>
    <div class="text-right noprint" id="export-balance-sheet" style="display: none">
        <div class="btn-group btn-group-sm">
            <button class="btn btn-default" onclick="exportBalanceSheet();"><i class="fa fa-download fa-lg"></i>Excel</button>
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
                                            <form id="balance_sheet_form" name="balance_sheet_form" method="post" onsubmit="return false">
                                            <div class="row">
                                                <div class="form-group col-md-2">
                                                    <label for="balance_sheet_from">From Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="fromDate" class="form-control sdate" id="balance_sheet_from" readonly="true" placeholder="Date From">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="balance_sheet_to">To Date</label>
                                                    <div class="input-group">
                                                        <input type="text" name="toDate" class="form-control sdate" id="balance_sheet_to" readonly="true" placeholder="Date To">
                                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                                    </div>
                                                </div>
                                                <div class="form-group col-md-2">
                                                        <label for="">&nbsp;</label>
                                                        <div class="input-group">
                                                            <input type="hidden" name="export" id="export" value="1">
                                                            <button class="btn btn-success" type="button"  onclick="searchBalanceSheet()">Generate</button>&nbsp;
                                                            <button type="button" class="btn btn-default btn-clear" onclick="clearBalanceSheet()">Clear</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="align-center alert alert-danger pull-left" style="display:none;margin-left:15px" id="balance_sheet_state"></div>
                                            </form>
                                        </div><!--row end-->
                                    </div><!--content end-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row hidden" id="balance-sheet-list-container">
                    <br>
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div id="balance-sheet-list"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<iframe name="ifrm_balance_sheet" id="ifrm_balance_sheet" style="display:none"></iframe>


    <?php echo '<script'; ?>
>
        $('#balance_sheet_from').datepicker({
            //     todayHighlight: true,
            format: 'yyyy-mm-dd',
            autoclose: true,
            startDate: '-3m',
            endDate: '+3m',
            changeMonth: true,
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var end = new Date(fDate.setDate(fDate.getDate() + 61));
            $('#balance_sheet_to').datepicker('setStartDate', e.date);
            $('#balance_sheet_to').datepicker('setEndDate', end)
        });
        $('#balance_sheet_to').datepicker({
            todayHighlight: true,
            startDate: '-0m',
            endDate: '+3m',
            format: 'yyyy-mm-dd',
            maxDate: '+365D',
            autoclose: true
        }).on('changeDate', function (e) {
            var fDate = new Date(e.date);
            var start = new Date(fDate.setDate(fDate.getDate() - 61));
            $('#balance_sheet_from').datepicker('setStartDate', start);
            $('#balance_sheet_from').datepicker('setEndDate', e.date)
        });

        function searchBalanceSheet() {
            $('#balance-sheet-list').html('');
            var data = {};
            data.fromDate = $('#balance_sheet_from').val();
            data.toDate = $('#balance_sheet_to').val();

            var err = 0;
            $('.inp_error').removeClass('inp_error');
            if (data.fromDate == '') {
                $('#balance_sheet_from').addClass('inp_error');
                err++;
            }
            if (data.toDate == '') {
                $('#balance_sheet_to').addClass('inp_error');
                err++;
            }

            if (err > 0) {
                $('#balance_sheet_state').removeClass('alert-success').addClass('alert-danger').removeClass('hide');
                $('#balance_sheet_state').html('Please enter/select the values in the field that are marked in red');
                $('#balance_sheet_state').show();
                return false;
            }
            
            $('#balance_sheet_state').removeClass('alert-success').removeClass('alert-danger');
            $('#balance_sheet_state').html('').hide();
            
            $('#balance-sheet-list-container').removeClass('hidden');
            $('#balance-sheet-list').html(loading_popup);
            
            $.ajax({
                type: 'POST',
                dataType: 'html',
                url: base_url + 'cargo/profit-and-loss-list',
                data: data,
                success: function (response) {
                    $('#balance-sheet-list').html(response);
                    $('#export-balance-sheet').show();
                }
            });
        }

        function clearBalanceSheet() {
            $('#balance_sheet_from').val('');
            $('#balance_sheet_to').val('');
            $('#balance-sheet-list-container').addClass('hidden');
            $('#balance-sheet-list').html('');
            $('.inp_error').removeClass('inp_error');
            $('#balance_sheet_state').removeClass('alert-success').removeClass('alert-danger');
            $('#balance_sheet_state').html('');
            $('#balance_sheet_state').hide();
            $('#export-balance-sheet').hide();
        }

        function balanceSheet(code) {
            $('#balance-sheet-dialog .table-responsive').addClass('hide');
            if(code == 'VOU') {
                $('#VOU_INT, #VOU_PAID').removeClass('hide');
            } else if(code == 'INV') {
                $('#INV_INT, #INV_PAID').removeClass('hide');
            } else if(code == 'INCOME') {
                $('#INCOME').removeClass('hide');
            }
            $('#balance-sheet-dialog').css('background', '#fff');
            $('#balance-sheet-dialog').removeClass('hide');
            $('#balance-sheet-dialog').dialog({
                autoOpen: true,
                height: 475,
                width: 750,
                modal: true,
                resizable: false,
                closeOnEscape: false
            });
            $('.ui-dialog-titlebar').hide();
        }

        function closeBalanceSheet() {
            $('#balance-sheet-dialog').addClass('hide');
            $('#balance-sheet-dialog').dialog('destroy');
        }

        function exportBalanceSheet() {
            document.balance_sheet_form.action = 'cargo/profit-and-loss-list';
            document.balance_sheet_form.target = 'ifrm_balance_sheet';
            document.balance_sheet_form.submit();
            return;
        }
    <?php echo '</script'; ?>
>
<?php }
}
