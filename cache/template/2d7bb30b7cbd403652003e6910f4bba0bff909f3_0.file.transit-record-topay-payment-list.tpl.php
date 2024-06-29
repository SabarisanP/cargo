<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-10 14:48:05
  from 'E:\xampp\htdocs\cargo\application\views\site\payment\transit-record-topay-payment-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6666c4cd25de51_68904091',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '2d7bb30b7cbd403652003e6910f4bba0bff909f3' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\payment\\transit-record-topay-payment-list.tpl',
      1 => 1717167062,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6666c4cd25de51_68904091 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'topayAllRecord' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_topayAllRecord_17537768486666c4cce18443_94766294',
  ),
  'topayRecordPaidAmount' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_topayRecordPaidAmount_17537768486666c4cce18443_94766294',
  ),
  'topayUnPaidRecord' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_topayUnPaidRecord_17537768486666c4cce18443_94766294',
  ),
  'topayBranchwise' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_topayBranchwise_17537768486666c4cce18443_94766294',
  ),
  'topayPaidwise' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_topayPaidwise_17537768486666c4cce18443_94766294',
  ),
  'topayUnpaidwise' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_topayUnpaidwise_17537768486666c4cce18443_94766294',
  ),
  'summaryWiseTopayALL' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_summaryWiseTopayALL_17537768486666c4cce18443_94766294',
  ),
  'summaryWiseTopayPaid' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_summaryWiseTopayPaid_17537768486666c4cce18443_94766294',
  ),
  'summaryWiseTopayUnpaid' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\2d7bb30b7cbd403652003e6910f4bba0bff909f3_0.file.transit-record-topay-payment-list.tpl.php',
    'uid' => '2d7bb30b7cbd403652003e6910f4bba0bff909f3',
    'call_name' => 'smarty_template_function_summaryWiseTopayUnpaid_17537768486666c4cce18443_94766294',
  ),
));
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
if ($_smarty_tpl->tpl_vars['filter_type']->value == 'SUMMARY') {?>
    <div class="col-md-12">
        <div class="text-right noprint">
            <div class="btn-group btn-group-sm">
                <button class="btn btn-default" onclick="excelTab()"><i class="fa fa-download fa-lg"></i>Excel</button>
                <button class="btn btn-default notpaytypeprint" onclick="printTab()"><i class="fa fa-print fa-lg"></i>
                    Print</button>
            </div>
        </div>
        <ul class="nav nav-tabs" id="report-tabs">
            <li><a data-toggle="tab" href="#ALL">ALL</a></li>
            <li><a data-toggle="tab" href="#PAID">PAID</a></li>
            <li class="active"> <a data-toggle="tab" href="#UNPAID">UNPAID</a></li>
        </ul>
        <div class="tab-content">
            <div id="ALL" class="tab-pane fade">
                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'summaryWiseTopayALL', array('data'=>$_smarty_tpl->tpl_vars['summaryWiseall']->value), true);?>

                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'topayAllRecord', array('data'=>$_smarty_tpl->tpl_vars['stationWise']->value), true);?>

                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'topayBranchwise', array('data'=>$_smarty_tpl->tpl_vars['stationWise']->value), true);?>

            </div>
            <div id="PAID" class="tab-pane fade">
                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'summaryWiseTopayPaid', array('data'=>$_smarty_tpl->tpl_vars['summaryWisePaid']->value), true);?>

                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'topayRecordPaidAmount', array('data'=>$_smarty_tpl->tpl_vars['stationWise']->value), true);?>

                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'topayPaidwise', array('data'=>$_smarty_tpl->tpl_vars['stationWise']->value), true);?>

            </div>
            <div id="UNPAID" class="tab-pane fade in active">
                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'summaryWiseTopayUnpaid', array('data'=>$_smarty_tpl->tpl_vars['summaryWise']->value), true);?>

                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'topayUnPaidRecord', array('data'=>$_smarty_tpl->tpl_vars['stationWise']->value), true);?>

                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'topayUnpaidwise', array('data'=>$_smarty_tpl->tpl_vars['stationWise']->value), true);?>

            </div>
        </div>
    </div>
<?php }?>



<?php if ($_smarty_tpl->tpl_vars['filter_type']->value == 'Trasaction_view') {?>
    <div>
        <div class="row">
            <div class="col-md-10 bold ft_14"></div>
            <div class="col-md-2">
                <a class="align-right" onclick="closeTransitTopayDialog()" href="javascript:;"
                    title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
            </div>
        </div>
    </div>
    <table id="transit_based_branch_report_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center">Date</td>
                <td align="center" nowrap>User</td>
                <td align="center" nowrap>Transaction (Rs)</td>
                <td align="center">Remarks</td>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transactionAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->user->name;?>
</td>
                    <td align="right"><?php if ($_smarty_tpl->tpl_vars['row']->value->transactionType->code == "PMT") {?>+<?php } else { ?> -<?php }
echo inr_format($_smarty_tpl->tpl_vars['row']->value->transactionAmount);?>

                    </td>
                    <td align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->remarks)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                </tr>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="4" align="center">No data found</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
<?php }?>







<?php echo '<script'; ?>
>
    var lrdata =<?php echo json_encode($_smarty_tpl->tpl_vars['stationWise']->value);?>


    if (isNotNull(lrdata)) {
        $('#transit_based_summary_unpaid,#transit_based_summary_paid,#transit_based_summary_all').dataTable({
            "bPaginate": false,
            "info": false,
            "dom": 'lrt',
            "aaSorting": [
                [0, "asc"]
            ]
        });
    }
    if (isNotNull(lrdata)) {
        $('.transit-based-unpaid,.transit-based-paid ,.transit-based-all').DataTable({
            info: false,
            searching: true,
            paging: false,
            order: [
                [0, 'asc']
            ],
            columnDefs: [{
                targets: 'no-sort',
                orderable: false,
            }]
        });
    }

    var namespaceCode = <?php echo json_encode($_smarty_tpl->tpl_vars['namespaceCode']->value);?>
;
    $('[data-toggle="popover"]').popover({
        placement: 'bottom',
        html: true,
        trigger: 'hover'
    });

    $('#transit_based_branch_report_table input').keypress(function(event) {
        if (event.keyCode == 13) {
            updateTransitTopayPayment($(this).attr('id'));
            remarkAdd($(this).attr('id'));
        }
    });

    function toggleTopayBranch(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();

        var $trows = $('.branch-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code +
            '"><td colspan="100%"><div class="slide" style="display: none;"><table width="100%">' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function toggleTopayPaid(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();

        var $trows = $('.paid-drill-down').filter('.' + code);

        $('#' + code).after('<tr class="branchlist ' + code +
            '"> <td colspan = "100%" ><div class = "slide"style = "display: none;" ><table width = "100%" > ' +
            $trows.html() + '</table> </div> </td> </tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function toggleTopayUnPaid(code) {
        if ($('.branchlist').hasClass(code)) {
            $('.branchlist .slide').slideToggle('linear', function() {
                $('.branchlist').remove();
            });
            return;
        }

        $('.branchlist').remove();
        var $trows = $('.un-paid-drill-down').filter('.' + code);
        $('#' + code).after('<tr class="branchlist ' + code +
            '"><td colspan="100%"> <div class="slide" style="display: none;"> <table width = "100%" > ' +
            $trows.html() + '</table></div></td></tr>');
        $('.branchlist .slide').slideToggle('linear');
        $(".has-popover").popover({
            trigger: 'hover',
            placement: 'top',
            html: true
        });
    }

    function excelTab() {
        var activeTab = $("#report-tabs li.active a").attr("href");
        if (activeTab === "#ALL") {
            exportTransitToPayExcel("ALL");
        } else if (activeTab === "#PAID") {
            exportTransitToPayExcel("PAID");
        } else if (activeTab === "#UNPAID") {
            exportTransitToPayExcel("UNPAID");
        }
    }

    function printTab() {
        var activeTab = $("#report-tabs li.active a").attr("href");
        if (activeTab === "#ALL") {
            printTransitToPay("ALL");
        } else if (activeTab === "#PAID") {
            printTransitToPay("PAID");
        } else if (activeTab === "#UNPAID") {
            printTransitToPay("UNPAID");
        }
    }

    function makeCalculation(elm) {
      let $row = $(elm).closest('tr');
        if ($(elm).is(':checked')) {
            $row.find('.topay-pmt-input').prop('disabled', true);
            $row.find('.save-btn').hide();
        } else {
            $row.find('.topay-pmt-input').prop('disabled', false);
            $row.find('.save-btn').show();
        }

        if($('.checked-list:checked').length > 0){
            $('#makeAllPayment').show();
        }else{
            $('#makeAllPayment').hide();
        }
        selectedLists();
    }

    function selectedLists() {
        var data = [];
        $('.checked-list:checked').each(function() {
            // handeBtn('hide');
            $('#unpaid-' + code).attr('disabled', true);
            $('#row-' + code + '-action .save-btn').addClass('hide');

            var code = $(this).data('code');
            var frmOrgCode = $(this).data('branch_code');
            var relOrgCode = $(this).data('related_organization_code');
            var transitCode = $(this).data('transit_code');
            var rtopay = $(this).data('rtopay');
            var list = {};
            list.code = '';
            transactionType = {};
            list.transactionType = "PMT";

            list.transactionAmount = $.trim($('#row-' + code).val());
            list.remarks ="";
            list.fromOrganization = frmOrgCode;
            list.organization = relOrgCode;
            list.transitCargo = transitCode;
            // var paid_amount = parseInt(rtopay);
            data.push(list);
        });
        return data;
    }
    function showConfirmationPopup() {
      let totalAmount =  0 ;
      selectedLists().forEach(obj => {
        totalAmount += Number(obj.transactionAmount);
      });
      $('.total-selected-amount').text(totalAmount);
      $('#total-amount').val(totalAmount);

      $('#confirmation-modal').modal('show');

    }
    
    $(document).ready(function(){
        $('#makeAllPayment').hide();
    })

<?php echo '</script'; ?>
><?php }
/* smarty_template_function_topayAllRecord_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_topayAllRecord_17537768486666c4cce18443_94766294')) {
function smarty_template_function_topayAllRecord_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>

    <?php if ($_smarty_tpl->tpl_vars['filter_type']->value == 'SUMMARY') {?>
        <div style="overflow: auto;">
        <table id="transit_based_report_ogpl" class="table table-bordered transit-based-all">
            <thead>
                <tr class="success">
                    <td align="center" class="bold" nowrap>Date <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap><?php echo lang('ogpl');?>
 No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Vehicle No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Route <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>From Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>To Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Remarks <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Action <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                <?php $_smarty_tpl->_assignInScope('t_payableAmt', 0);?>
                <?php $_smarty_tpl->_assignInScope('t_paidAmt', 0);?>
                <?php $_smarty_tpl->_assignInScope('t_balAmt', 0);?>

                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'rows');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['rows']->value) {
?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['rows']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <tr id="row-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
" class="tr-hover"
                            onclick="toggleTopayBranch('row-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
');">
                            <td nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value['load_date'];?>
</td>
                            <td>
                                <span class="text-success">
                                    <a class="tab-link"
                                        href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value['load_date'];?>
"
                                        title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
</a>
                                </span>
                            </td>
                            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle'];?>
</td>
                            <td nowrap> <?php echo smarty_modifier_truncate(((($_smarty_tpl->tpl_vars['row']->value['from_station_name']).(" to ")).($_smarty_tpl->tpl_vars['row']->value['to_station_name'])),30);?>
</td>
                            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['from_station_name'];?>
</td>
                            <td><?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['payable_amt'],2);?>
</td>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid_amt'],2);?>
 &nbsp;&nbsp;&nbsp; <a
                                    title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true"
                                        onclick="getTransitAllTransaction('<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['station_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_station_code'];?>
')"></i>
                                </a></td>
                            <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value['payable_amt']-$_smarty_tpl->tpl_vars['row']->value['paid_amt']));?>
                            <?php $_smarty_tpl->_assignInScope('t_payableAmt', $_smarty_tpl->tpl_vars['t_payableAmt']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                            <?php $_smarty_tpl->_assignInScope('t_paidAmt', $_smarty_tpl->tpl_vars['t_paidAmt']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                            <?php $_smarty_tpl->_assignInScope('t_balAmt', $_smarty_tpl->tpl_vars['t_balAmt']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                            <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['rtopay']->value);?>
</td>
                            <?php } else { ?>
                                <td align="right">
                                    <input type="text" class="form-control topay-pmt-input"
                                        id="<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                        value="<?php echo number_format($_smarty_tpl->tpl_vars['rtopay']->value,2,'.','');?>
"<?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-SAVE-OPTION-TOPAY'] <= 0) {?> readonly <?php }?>>
                                       
                                </td>
                            <?php }?>

                            <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                <td align="center"><?php echo trim($_smarty_tpl->tpl_vars['row']->value['remark'],', ');?>
</td>
                            <?php } else { ?>
                                <?php if (trim($_smarty_tpl->tpl_vars['row']->value['remark']) == '' || $_smarty_tpl->tpl_vars['row']->value['remark'] == '') {?>
                                    <td align="center">
                                        <input type="text" class="form-control"
                                            id="remarks-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                            maxlength="1000" value="">
                                    </td>
                                <?php } else { ?>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value['remark'];?>

                                        <a href="javascript:;" class="btn btn-sm btn-primary" title="Add Remarks" style="font-size: 5px;"
                                            onclick="remarkAdd('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
')"> <i
                                                class="fa fa-plus" style="font-size:10px;"></i></a>
                                        <br><br>
                                        <input type="text" class="form-control hide add_remark"
                                            id="remarks-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                            maxlength="1000" value="">
                                    </td>
                                <?php }?>
                            <?php }?>

                            <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                <td align="center" nowrap><span class="badge">Completed</span>
                                    <?php if ($_smarty_tpl->tpl_vars['row']->value['paid_amt'] > 0) {?>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-REVERT-OPTION-TOPAY'] > 0) {?>
                                            <button class="btn-app btn-danger" type="button"
                                                onclick="RevertTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['paid_amt'];?>
');">Revert</button>
                                        <?php }?>
                                    <?php }?>
                                </td>

                            <?php } else { ?>
                                <td align="center" id="<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
-action"
                                    nowrap>
                                    <span class="act-loading"></span>
                                    <span class="act-status"></span>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-SAVE-OPTION-TOPAY']) {?>
                                            <button class="btn btn-sm btn-success save-btn"
                                                onclick="updateTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['rtopay']->value;?>
');">Save</button>
                                        <?php }?>
                                        
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value['paid_amt'] > 0) {?>
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-REVERT-OPTION-TOPAY'] > 0) {?>
                                            <button class="btn-app btn-danger" type="button"
                                                onclick="RevertTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['paid_amt'];?>
');">Revert</button>
                                        <?php }?>
                                    <?php }?>
                                </td>
                            <?php }?>
                        </tr>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
} else {
?>
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
            <?php if (count($_smarty_tpl->tpl_vars['stationWise']->value) > 0) {?>
                <tfoot>
                    <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                        <td colspan="6" align="right">Total</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payableAmt']->value,2);?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_paidAmt']->value,2);?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_balAmt']->value,2);?>
</td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                </tfoot>
            <?php }?>
        </table>
        </div>
    <?php }
}}
/*/ smarty_template_function_topayAllRecord_17537768486666c4cce18443_94766294 */
/* smarty_template_function_topayRecordPaidAmount_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_topayRecordPaidAmount_17537768486666c4cce18443_94766294')) {
function smarty_template_function_topayRecordPaidAmount_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>

    <?php if ($_smarty_tpl->tpl_vars['filter_type']->value == 'SUMMARY') {?>
        <div style="overflow: auto;">
        <table id="transit_based_report_ogpl_paid" class="table table-bordered transit-based-paid">
            <thead>
                <tr class="success">
                    <td align="center" class="bold" nowrap>Date <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap><?php echo lang('ogpl');?>
 No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Vehicle No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Route <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>From Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap> To Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Remarks <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Action <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                <?php $_smarty_tpl->_assignInScope('t_payableAmt', 0);?>
                <?php $_smarty_tpl->_assignInScope('t_paidAmt', 0);?>
                <?php $_smarty_tpl->_assignInScope('t_balAmt', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'rows');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['rows']->value) {
?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['rows']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php $_smarty_tpl->_assignInScope('paid_amount', 0);?>
                        <?php $_smarty_tpl->_assignInScope('paid_amount', ($_smarty_tpl->tpl_vars['row']->value['payable_amt']-$_smarty_tpl->tpl_vars['row']->value['paid_amt']));?>
                        <?php if ($_smarty_tpl->tpl_vars['paid_amount']->value <= 0) {?>
                            <tr id="brn-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
" class="tr-hover"
                                onclick="toggleTopayPaid('brn-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
');">
                                <td nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value['load_date'];?>
</td>
                                <td>
                                    <span class="text-success">
                                        <a class="tab-link"
                                            href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value['load_date'];?>
"
                                            title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
</a>
                                    </span>
                                </td>
                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle'];?>
</td>
                                <td nowrap> <?php echo smarty_modifier_truncate(((($_smarty_tpl->tpl_vars['row']->value['from_station_name']).(" to ")).($_smarty_tpl->tpl_vars['row']->value['to_station_name'])),30);?>
</td>
                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value['from_station_name'];?>
</td>
                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</td>

                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['payable_amt'],2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid_amt'],2);?>
 &nbsp;&nbsp;&nbsp; <a
                                        title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true"
                                            onclick="getTransitAllTransaction('<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['station_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_station_code'];?>
')"></i>
                                    </a></td>
                                <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value['payable_amt']-$_smarty_tpl->tpl_vars['row']->value['paid_amt']));?>
                                <?php $_smarty_tpl->_assignInScope('t_payableAmt', $_smarty_tpl->tpl_vars['t_payableAmt']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_paidAmt', $_smarty_tpl->tpl_vars['t_paidAmt']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_balAmt', $_smarty_tpl->tpl_vars['t_balAmt']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                                <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['rtopay']->value);?>
</td>
                                <?php } else { ?>
                                    <td align="right">
                                        <input type="text" class="form-control topay-pmt-input"
                                            id="<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                            value="<?php echo number_format($_smarty_tpl->tpl_vars['rtopay']->value,2,'.','');?>
" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-SAVE-OPTION-TOPAY'] <= 0) {?> readonly <?php }?>>
                                    </td>
                                <?php }?>

                                <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                    <td align="center"><?php echo trim($_smarty_tpl->tpl_vars['row']->value['remark'],', ');?>
</td>
                                <?php } else { ?>
                                    <?php if (trim($_smarty_tpl->tpl_vars['row']->value['remark']) == '' || $_smarty_tpl->tpl_vars['row']->value['remark'] == null) {?>
                                        <td align="center">
                                            <input type="text" class="form-control"
                                                id="remarks-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                                maxlength="1000" value="">
                                        </td>
                                    <?php } else { ?>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value['remark'];?>

                                            <a href="javascript:;" class="btn btn-sm btn-primary" title="Add Remarks" style="font-size: 5px;"
                                                onclick="remarkAdd('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
')"> <i
                                                    class="fa fa-plus" style="font-size:10px;"></i></a>
                                            <br><br>
                                            <input type="text" class="form-control hide add_remark"
                                                id="remarks-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                                maxlength="1000" value="">
                                        </td>
                                    <?php }?>
                                <?php }?>

                                <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                    <td align="center" nowrap>
                                        <span class="badge">Completed</span>
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value['paid_amt'] > 0) {?>
                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-REVERT-OPTION-TOPAY'] > 0) {?>
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['paid_amt'];?>
');">Revert</button>
                                            <?php }?>
                                        <?php }?>
                                    </td>
                                <?php } else { ?>
                                    <td align="center" id="<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
-action"
                                        nowrap>
                                        <span class="act-loading"></span>
                                        <span class="act-status"></span>
                                        
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-SAVE-OPTION-TOPAY']) {?>
                                            <button class="btn btn-sm btn-success save-btn"
                                                onclick="updateTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['rtopay']->value;?>
');">Save</button>
                                        <?php }?>
                                      
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value['paid_amt'] > 0) {?>
                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-REVERT-OPTION-TOPAY'] > 0) {?>
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['paid_amt'];?>
');">Revert</button>
                                            <?php }?>
                                        <?php }?>
                                    </td>
                                <?php }?>
                            </tr>
                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
} else {
?>
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
            <?php if (count($_smarty_tpl->tpl_vars['stationWise']->value) > 0) {?>
                <tfoot>
                    <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                        <td colspan="6" align="right">Total</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payableAmt']->value,2);?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_paidAmt']->value,2);?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_balAmt']->value,2);?>
</td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                </tfoot>
            <?php }?>
        </table>
        </div>
    <?php }
}}
/*/ smarty_template_function_topayRecordPaidAmount_17537768486666c4cce18443_94766294 */
/* smarty_template_function_topayUnPaidRecord_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_topayUnPaidRecord_17537768486666c4cce18443_94766294')) {
function smarty_template_function_topayUnPaidRecord_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>

    <?php if ($_smarty_tpl->tpl_vars['filter_type']->value == 'SUMMARY') {?>
                <div  style="overflow: auto;">
        <button id="makeAllPayment" class="btn btn-success" style="display: none; float: right; margin-top: 10px;" onclick="showConfirmationPopup();">Make Payments</button>
        <table id="transit_based_report_ogpl_unpaid" class="table table-bordered transit-based-unpaid">
       
            <thead>
                <tr class="success">
                    <td align="center" class="bold" nowrap></td>
                    <td align="center" class="bold" nowrap>Date <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap><?php echo lang('ogpl');?>
 No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Vehicle No. <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Route <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>From Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap> To Station <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Remarks <i class="fa fa-sort"></td>
                    <td align="center" class="bold" nowrap>Action <i class="fa fa-sort"></td>
                </tr>
            </thead>
            <tbody class="body_table">
                <?php $_smarty_tpl->_assignInScope('t_payableAmt', 0);?>
                <?php $_smarty_tpl->_assignInScope('t_paidAmt', 0);?>
                <?php $_smarty_tpl->_assignInScope('t_balAmt', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'rows');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['rows']->value) {
?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['rows']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php $_smarty_tpl->_assignInScope('un_paid_amount', 0);?>
                        <?php $_smarty_tpl->_assignInScope('un_paid_amount', ($_smarty_tpl->tpl_vars['row']->value['payable_amt']-$_smarty_tpl->tpl_vars['row']->value['paid_amt']));?>
                        <?php if ($_smarty_tpl->tpl_vars['un_paid_amount']->value > 0) {?>
                            <tr id="un-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
" class="tr-hover"
                                onclick="toggleTopayUnPaid('un-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
');">
                                <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value['payable_amt']-$_smarty_tpl->tpl_vars['row']->value['paid_amt']));?>
                                <?php $_smarty_tpl->_assignInScope('t_payableAmt', $_smarty_tpl->tpl_vars['t_payableAmt']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_paidAmt', $_smarty_tpl->tpl_vars['t_paidAmt']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_balAmt', $_smarty_tpl->tpl_vars['t_balAmt']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                                <td nowrap> <input type="checkbox" class="checked-list list-<?php echo $_smarty_tpl->tpl_vars['row']->value['code'];?>
"
                                        data-code="<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                        data-branch_code="<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
"
                                        data-related_organization_code="<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                        data-transit_code="<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
" data-branch_code="<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
"
                                        data-related_organization_code="<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
" data-rtopay="<?php echo $_smarty_tpl->tpl_vars['rtopay']->value;?>
"
                                        onclick="makeCalculation(this);"></td>
                                <td nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value['load_date'];?>
</td>
                                <td>
                                    <span class="text-success">
                                        <a class="tab-link"
                                            href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value['load_date'];?>
"
                                            title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];?>
</a>
                                    </span>
                                </td>
                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value['vehicle'];?>
</td>
                                <td nowrap> <?php echo smarty_modifier_truncate(((($_smarty_tpl->tpl_vars['row']->value['from_station_name']).(" to ")).($_smarty_tpl->tpl_vars['row']->value['to_station_name'])),30);?>
</td>
                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value['from_station_name'];?>
</td>
                                <td><?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</td>

                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['payable_amt'],2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid_amt'],2);?>
 &nbsp;&nbsp;&nbsp; <a
                                        title="Click to Get Transaction Details"><i class="fa fa-money" aria-hidden="true"
                                            onclick="getTransitAllTransaction('<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['station_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_station_code'];?>
')"></i>
                                    </a></td>

                                <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['rtopay']->value);?>
</td>
                                <?php } else { ?>
                                    <td align="right">
                                        <input type="text" class="form-control topay-pmt-input"
                                            id="row-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                            value="<?php echo number_format($_smarty_tpl->tpl_vars['rtopay']->value,2,'.','');?>
" <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-SAVE-OPTION-TOPAY'] <= 0) {?> readonly <?php }?>>
                                    </td>
                                <?php }?>

                                <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                    <td align="center"><?php echo trim($_smarty_tpl->tpl_vars['row']->value['remark'],', ');?>
</td>
                                <?php } else { ?>
                                    <?php if (trim($_smarty_tpl->tpl_vars['row']->value['remark']) == '' || $_smarty_tpl->tpl_vars['row']->value['remark'] == null) {?>
                                        <td align="center">
                                            <input type="text" class="form-control"
                                                id="unpaid-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                                maxlength="1000" value="">
                                        </td>
                                    <?php } else { ?>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value['remark'];?>

                                            <a href="javascript:;" class="btn btn-sm btn-primary" title="Add Remarks" style="font-size: 5px;"
                                                onclick="remarkAddUnpaid('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
')">
                                                <i class="fa fa-plus" style="font-size:10px;"></i></a>
                                            <br><br>
                                            <input type="text" class="form-control hide add_remark"
                                                id="unpaid-<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
"
                                                maxlength="1000" value="">
                                        </td>
                                    <?php }?>
                                <?php }?>

                                <?php if ($_smarty_tpl->tpl_vars['rtopay']->value == 0) {?>
                                    <td align="left" nowrap>
                                        <span class="badge">Completed</span>
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value['paid_amt'] > 0) {?>
                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-REVERT-OPTION-TOPAY'] > 0) {?>
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['paid_amt'];?>
');">Revert</button>
                                            <?php }?>
                                        <?php }?>
                                    </td>
                                <?php } else { ?>
                                    <td align="left" id="<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
-action"
                                        nowrap>
                                        <span class="act-loading"></span>
                                        <span class="act-status"></span>
                                    
                                        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-SAVE-OPTION-TOPAY']) {?>
                                            <button class="btn btn-sm btn-success save-btn myButton"
                                                onclick="updateTransitUnpaidPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['rtopay']->value;?>
');">Save</button>
                                        <?php }?>
                                      
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value['paid_amt'] > 0) {?>
                                            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['HIDE-REVERT-OPTION-TOPAY'] > 0) {?>
                                                <button class="btn-app btn-danger" type="button"
                                                    onclick="RevertTransitTopayPayment('<?php echo $_smarty_tpl->tpl_vars['row']->value['ogpl_no'];
echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];
echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['transit_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['branch_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['related_organization_code'];?>
','<?php echo $_smarty_tpl->tpl_vars['row']->value['paid_amt'];?>
');">Revert</button>
                                            <?php }?>
                                        <?php }?>
                                    </td>
                                <?php }?>
                            </tr>
                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
} else {
?>
                    <tr>
                        <td colspan="11" align="center">No data found</td>
                    </tr>
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
            <?php if (count($_smarty_tpl->tpl_vars['stationWise']->value) > 0) {?>
                <tfoot>
                    <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                        <td colspan="7" align="right">Total</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payableAmt']->value,2);?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_paidAmt']->value,2);?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_balAmt']->value,2);?>
</td>
                        <td align="right"></td>
                        <td align="right"></td>
                    </tr>
                </tfoot>
            <?php }?>
        </table>
        </div>
    <?php }
}}
/*/ smarty_template_function_topayUnPaidRecord_17537768486666c4cce18443_94766294 */
/* smarty_template_function_topayBranchwise_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_topayBranchwise_17537768486666c4cce18443_94766294')) {
function smarty_template_function_topayBranchwise_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>

    <table class="hide noprint branch-drill-down">
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'brns');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brns']->value) {
?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brns']->value, 'brn');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brn']->value) {
?>
                <tr class="row-<?php echo $_smarty_tpl->tpl_vars['brn']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['brn']->value['code'];?>
  branch-drill-down">
                    <td>
                        <table id="transit_based_branch" class="table table-bordered table-bordered m_b_5">
                            <thead>
                                <tr class="success">
                                    <td align="center" width="10%">Date</td>
                                    <td align="center" width="10%"><?php echo lang('ogpl');?>
 No.</td>
                                    <td align="center" width="10%">Vehicle No.</td>
                                    <td align="center" width="20%">Route</td>
                                    <td align="center" width="15%">From Station</td>
                                    <td align="center" width="15%">To Station</td>
                                    <td align="center" width="10%" nowrap>Branch Name</td>
                                    <td align="center" width="10%" nowrap>Net Payable</td>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                <?php $_smarty_tpl->_assignInScope('t_payableAmt', 0);?>
                                <?php $_smarty_tpl->_assignInScope('t_paidAmt', 0);?>
                                <?php $_smarty_tpl->_assignInScope('t_balAmt', 0);?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brn']->value['data'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                    <tr>
                                        <td nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->loaded_date,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                        <td>
                                            <span class="text-success">
                                                <a class="tab-link"
                                                    href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->trip_date;?>
"
                                                    title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->transit_alias_code;?>
</a>
                                            </span>
                                        </td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->registration_number;?>
</td>
                                        <td nowrap>
                                            <?php echo smarty_modifier_truncate(((($_smarty_tpl->tpl_vars['row']->value->transit_from_station_name).(" to ")).($_smarty_tpl->tpl_vars['row']->value->transit_to_station_name)),30);?>

                                        </td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->station_name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->related_organization_name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->organization_name;?>
</td>
                                        <td align="right">
                                            <?php echo number_format((($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount)),2);?>

                                        </td>
                                                                                <?php $_smarty_tpl->_assignInScope('rtopay', ((($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount))-($_smarty_tpl->tpl_vars['row']->value->transit_payment_amount)));?>
                                        <?php $_smarty_tpl->_assignInScope('t_payableAmt', $_smarty_tpl->tpl_vars['t_payableAmt']->value+($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount));?>
                                        <?php $_smarty_tpl->_assignInScope('t_paidAmt', $_smarty_tpl->tpl_vars['t_paidAmt']->value+$_smarty_tpl->tpl_vars['row']->value->transit_payment_amount);?>
                                        <?php $_smarty_tpl->_assignInScope('t_balAmt', $_smarty_tpl->tpl_vars['t_balAmt']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                                    </tr>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </tbody>
                            <tfoot>
                                <tr style=" font-weight: bold;">
                                    <td colspan="7" align="right">Total</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payableAmt']->value,2);?>
</td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </table>
<?php
}}
/*/ smarty_template_function_topayBranchwise_17537768486666c4cce18443_94766294 */
/* smarty_template_function_topayPaidwise_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_topayPaidwise_17537768486666c4cce18443_94766294')) {
function smarty_template_function_topayPaidwise_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>

    <table class="hide noprint paid-drill-down">
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'brns');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brns']->value) {
?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brns']->value, 'brn');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brn']->value) {
?>
                <tr class="brn-<?php echo $_smarty_tpl->tpl_vars['brn']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['brn']->value['code'];?>
  paid-drill-down">
                    <td>
                        <table id="transit_based_branch" class="table table-bordered table-bordered m_b_5">
                            <thead>
                                <tr class="success">
                                    <td align="center" width="10%">Date</td>
                                    <td align="center" width="10%"><?php echo lang('ogpl');?>
 No.</td>
                                    <td align="center" width="10%">Vehicle No.</td>
                                    <td align="center" width="20%">Route</td>
                                    <td align="center" width="15%">From Station</td>
                                    <td align="center" width="15%">To Station</td>
                                    <td align="center" width="10%" nowrap>Branch Name</td>
                                    <td align="center" width="10%" nowrap>Net Payable</td>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                <?php $_smarty_tpl->_assignInScope('t_payableAmt', 0);?>
                                <?php $_smarty_tpl->_assignInScope('t_paidAmt', 0);?>
                                <?php $_smarty_tpl->_assignInScope('t_balAmt', 0);?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brn']->value['data'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                    <tr>
                                        <td nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->loaded_date,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                        <td>
                                            <span class="text-success">
                                                <a class="tab-link"
                                                    href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->trip_date;?>
"
                                                    title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->transit_alias_code;?>
</a>
                                            </span>
                                        </td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->registration_number;?>
</td>
                                        <td nowrap>
                                            <?php echo smarty_modifier_truncate(((($_smarty_tpl->tpl_vars['row']->value->transit_from_station_name).(" to ")).($_smarty_tpl->tpl_vars['row']->value->transit_to_station_name)),30);?>

                                        </td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->station_name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->related_organization_name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->organization_name;?>
</td>
                                        <td align="right">
                                            <?php echo number_format((($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount)),2);?>

                                        </td>
                                                                                <?php $_smarty_tpl->_assignInScope('rtopay', ((($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount))-($_smarty_tpl->tpl_vars['row']->value->transit_payment_amount)));?>
                                        <?php $_smarty_tpl->_assignInScope('t_payableAmt', $_smarty_tpl->tpl_vars['t_payableAmt']->value+($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount));?>
                                        <?php $_smarty_tpl->_assignInScope('t_paidAmt', $_smarty_tpl->tpl_vars['t_paidAmt']->value+$_smarty_tpl->tpl_vars['row']->value->transit_payment_amount);?>
                                        <?php $_smarty_tpl->_assignInScope('t_balAmt', $_smarty_tpl->tpl_vars['t_balAmt']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                                    </tr>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </tbody>
                            <tfoot>
                                <tr style=" font-weight: bold;">
                                    <td colspan="7" align="right">Total</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payableAmt']->value,2);?>
</td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </table>
<?php
}}
/*/ smarty_template_function_topayPaidwise_17537768486666c4cce18443_94766294 */
/* smarty_template_function_topayUnpaidwise_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_topayUnpaidwise_17537768486666c4cce18443_94766294')) {
function smarty_template_function_topayUnpaidwise_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>

    <table class="hide noprint branch-drill-down">
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'brns');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brns']->value) {
?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brns']->value, 'brn');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['brn']->value) {
?>
                <tr class="un-<?php echo $_smarty_tpl->tpl_vars['brn']->value['ogpl_no'];?>
-<?php echo $_smarty_tpl->tpl_vars['brn']->value['code'];?>
  un-paid-drill-down">
                    <td>
                        <table id="transit_based_branch" class="table table-bordered table-bordered m_b_5">
                            <thead>
                                <tr class="success">
                                    <td align="center" width="10%">Date</td>
                                    <td align="center" width="10%"><?php echo lang('ogpl');?>
 No.</td>
                                    <td align="center" width="10%">Vehicle No.</td>
                                    <td align="center" width="20%">Route</td>
                                    <td align="center" width="15%">From Station</td>
                                    <td align="center" width="15%">To Station</td>
                                    <td align="center" width="10%" nowrap>Branch Name</td>
                                    <td align="center" width="10%" nowrap>Net Payable</td>
                                </tr>
                            </thead>
                            <tbody class="body_table">
                                <?php $_smarty_tpl->_assignInScope('t_payableAmt', 0);?>
                                <?php $_smarty_tpl->_assignInScope('t_paidAmt', 0);?>
                                <?php $_smarty_tpl->_assignInScope('t_balAmt', 0);?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['brn']->value['data'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                                    <tr>
                                        <td nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->loaded_date,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                        <td>
                                            <span class="text-success">
                                                <a class="tab-link"
                                                    href="#cargo/ogpl-chart-details?transitCode=<?php echo $_smarty_tpl->tpl_vars['row']->value->transit_code;?>
&date=<?php echo $_smarty_tpl->tpl_vars['row']->value->trip_date;?>
"
                                                    title="View Chart" target="_blank"><?php echo $_smarty_tpl->tpl_vars['row']->value->transit_alias_code;?>
</a>
                                            </span>
                                        </td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->registration_number;?>
</td>
                                        <td nowrap>
                                            <?php echo smarty_modifier_truncate(((($_smarty_tpl->tpl_vars['row']->value->transit_from_station_name).(" to ")).($_smarty_tpl->tpl_vars['row']->value->transit_to_station_name)),30);?>

                                        </td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->station_name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->related_organization_name;?>
</td>
                                        <td><?php echo $_smarty_tpl->tpl_vars['row']->value->organization_name;?>
</td>
                                        <td align="right">
                                            <?php echo number_format((($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount)),2);?>

                                        </td>
                                                                                <?php $_smarty_tpl->_assignInScope('rtopay', ((($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount))-($_smarty_tpl->tpl_vars['row']->value->transit_payment_amount)));?>
                                        <?php $_smarty_tpl->_assignInScope('t_payableAmt', $_smarty_tpl->tpl_vars['t_payableAmt']->value+($_smarty_tpl->tpl_vars['row']->value->topay_amount)-($_smarty_tpl->tpl_vars['row']->value->topay_hamali_charge+$_smarty_tpl->tpl_vars['row']->value->topay_demurrage_charge+$_smarty_tpl->tpl_vars['row']->value->topay_unload_handling_amount));?>
                                        <?php $_smarty_tpl->_assignInScope('t_paidAmt', $_smarty_tpl->tpl_vars['t_paidAmt']->value+$_smarty_tpl->tpl_vars['row']->value->transit_payment_amount);?>
                                        <?php $_smarty_tpl->_assignInScope('t_balAmt', $_smarty_tpl->tpl_vars['t_balAmt']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                                    </tr>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            </tbody>
                            <tfoot>
                                <tr style=" font-weight: bold;">
                                    <td colspan="7" align="right">Total</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payableAmt']->value,2);?>
</td>
                                </tr>
                            </tfoot>
                        </table>
                    </td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </table>
<?php
}}
/*/ smarty_template_function_topayUnpaidwise_17537768486666c4cce18443_94766294 */
/* smarty_template_function_summaryWiseTopayALL_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_summaryWiseTopayALL_17537768486666c4cce18443_94766294')) {
function smarty_template_function_summaryWiseTopayALL_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
?>

    <?php if ($_smarty_tpl->tpl_vars['filterCode']->value == "NA") {?>
        <div class="row">
            <div class="col-md-4"><br><br>
                <table id="transit_based_summary_all" class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        <?php $_smarty_tpl->_assignInScope('t_payable', 0);?>
                        <?php $_smarty_tpl->_assignInScope('t_paid', 0);?>
                        <?php $_smarty_tpl->_assignInScope('t_bal', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value['name'] == "ALL") {?>
                                <tr>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['payable_amt'],2);?>
</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid_amt'],2);?>
</td>
                                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value['bal_amt'];?>
</td>
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('t_payable', $_smarty_tpl->tpl_vars['t_payable']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_paid', $_smarty_tpl->tpl_vars['t_paid']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_bal', $_smarty_tpl->tpl_vars['t_bal']->value+$_smarty_tpl->tpl_vars['row']->value['bal_amt']);?>
                            <?php }?>

                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <?php if (count($_smarty_tpl->tpl_vars['summaryWise']->value) > 0) {?>
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                                <td align="right">Total</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payable']->value,2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_paid']->value,2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_bal']->value,2);?>
</td>

                            </tr>
                        </tfoot>
                    <?php }?>
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
        </div>
    <?php }
}}
/*/ smarty_template_function_summaryWiseTopayALL_17537768486666c4cce18443_94766294 */
/* smarty_template_function_summaryWiseTopayPaid_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_summaryWiseTopayPaid_17537768486666c4cce18443_94766294')) {
function smarty_template_function_summaryWiseTopayPaid_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
?>

    <?php if ($_smarty_tpl->tpl_vars['filterCode']->value == "NA") {?>
        <div class="row">
            <div class="col-md-4"><br><br>
                <table id="transit_based_summary_paid" class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">
                        <?php $_smarty_tpl->_assignInScope('t_payable', 0);?>
                        <?php $_smarty_tpl->_assignInScope('t_paid', 0);?>
                        <?php $_smarty_tpl->_assignInScope('t_bal', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value['name'] == "PAID") {?>
                                <tr>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['payable_amt'],2);?>
</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid_amt'],2);?>
</td>
                                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value['bal_amt'];?>
</td>
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('t_payable', $_smarty_tpl->tpl_vars['t_payable']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_paid', $_smarty_tpl->tpl_vars['t_paid']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_bal', $_smarty_tpl->tpl_vars['t_bal']->value+$_smarty_tpl->tpl_vars['row']->value['bal_amt']);?>
                            <?php }?>
                       
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <?php if (count($_smarty_tpl->tpl_vars['summaryWise']->value) > 0) {?>
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                                <td align="right">Total</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payable']->value,2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_paid']->value,2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_bal']->value,2);?>
</td>
                            </tr>
                        </tfoot>
                    <?php }?>
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
        </div>
    <?php }
}}
/*/ smarty_template_function_summaryWiseTopayPaid_17537768486666c4cce18443_94766294 */
/* smarty_template_function_summaryWiseTopayUnpaid_17537768486666c4cce18443_94766294 */
if (!function_exists('smarty_template_function_summaryWiseTopayUnpaid_17537768486666c4cce18443_94766294')) {
function smarty_template_function_summaryWiseTopayUnpaid_17537768486666c4cce18443_94766294(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
?>

    <?php if ($_smarty_tpl->tpl_vars['filterCode']->value == "NA") {?>
        <div class="row">
            <div class="col-md-4"><br><br>
                <table id="transit_based_summary_unpaid" class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap>Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap>Balance (Rs) <i class="fa fa-sort"></td>
                        </tr>
                    </thead>
                    <tbody class="body_table">

                        <?php $_smarty_tpl->_assignInScope('t_payable', 0);?>
                        <?php $_smarty_tpl->_assignInScope('t_paid', 0);?>
                        <?php $_smarty_tpl->_assignInScope('t_bal', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value['name'] == "UNPAID") {?>
                                <tr>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value['to_station_name'];?>
</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['payable_amt'],2);?>
</td>
                                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value['paid_amt'],2);?>
</td>
                                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value['bal_amt'];?>
</td>
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('t_payable', $_smarty_tpl->tpl_vars['t_payable']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_paid', $_smarty_tpl->tpl_vars['t_paid']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_bal', $_smarty_tpl->tpl_vars['t_bal']->value+$_smarty_tpl->tpl_vars['row']->value['bal_amt']);?>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <?php if (count($_smarty_tpl->tpl_vars['summaryWise']->value) > 0) {?>
                        <tfoot>
                            <tr class="bold" style="background-color: #bbbbbb; color: #ffff;">
                                <td align="right">Total</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_payable']->value,2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_paid']->value,2);?>
</td>
                                <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['t_bal']->value,2);?>
</td>

                            </tr>
                        </tfoot>
                    <?php }?>
                </table>
            </div>
            <div class="col-md-4"></div>
            <div class="col-md-4"></div>
        </div>
    <?php }?>
    <div id="confirmation-modal" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Payments</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                <div>
                <label for ="total-amount">Total Selected Amount:  <b><span class="total-selected-amount"></span></b></label>
                <input type="number" class="form-control" id="total-amount">
                </div>
                <div>
                    <label for ="total-amount">Remarks</label>
                    <textarea id="common-remarks" name="remarks" class="form-control"
                        placeholder="Enter remarks for all selected payments"></textarea>
                 </div>
                </div>
                <div class="modal-footer">
                    <div class="alert fl" id="action-state">Haridas</div> 
                    <button type="button" class="btn btn-primary" onclick="confirmPayments()">Save</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
<?php
}}
/*/ smarty_template_function_summaryWiseTopayUnpaid_17537768486666c4cce18443_94766294 */
}
