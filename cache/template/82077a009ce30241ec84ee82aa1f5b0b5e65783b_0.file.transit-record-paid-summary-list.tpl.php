<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-10 14:48:27
  from 'E:\xampp\htdocs\cargo\application\views\site\payment\transit-record-paid-summary-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6666c4e35ff7c9_70908346',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '82077a009ce30241ec84ee82aa1f5b0b5e65783b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\payment\\transit-record-paid-summary-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6666c4e35ff7c9_70908346 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'summaryWiseTopayUnpaid' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\82077a009ce30241ec84ee82aa1f5b0b5e65783b_0.file.transit-record-paid-summary-list.tpl.php',
    'uid' => '82077a009ce30241ec84ee82aa1f5b0b5e65783b',
    'call_name' => 'smarty_template_function_summaryWiseTopayUnpaid_15726687546666c4e358cb26_55619714',
  ),
));
if ($_smarty_tpl->tpl_vars['filter_type']->value == 'SUMMARY') {?>
    <?php if ($_smarty_tpl->tpl_vars['filterCode']->value == "NA") {?>
    <div class="col-md-12">
        <div class="text-right noprint">
            <div class="btn-group btn-group-sm">
                <button class="btn btn-default" onclick="excelTab()"><i class="fa fa-download fa-lg"></i>Excel</button>
                <button class="btn btn-default notpaytypeprint" onclick="printTab()"><i class="fa fa-print fa-lg"></i>
                    Print</button>
            </div>
        </div>
        <ul class="nav nav-tabs" id="report-tabs">
            <li class="active"> <a data-toggle="tab" href="#UNPAID">UNPAID</a></li>
        </ul>
        <div class="tab-content">
            <div id="UNPAID" class="tab-pane fade in active">
                <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'summaryWiseTopayUnpaid', array('data'=>$_smarty_tpl->tpl_vars['summaryWise']->value), true);?>

            </div>
        </div>
    </div>
    <?php } else { ?>
        <table>
        <tr>
            <td colspan="12" align="center">No data found</td>
        </tr>
        </table>
    <?php }
}?>

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
            exportTransitUnPaidExcel("ALL");
        } else if (activeTab === "#PAID") {
            exportTransitUnPaidExcel("PAID");
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
<?php echo '</script'; ?>
><?php }
/* smarty_template_function_summaryWiseTopayUnpaid_15726687546666c4e358cb26_55619714 */
if (!function_exists('smarty_template_function_summaryWiseTopayUnpaid_15726687546666c4e358cb26_55619714')) {
function smarty_template_function_summaryWiseTopayUnpaid_15726687546666c4e358cb26_55619714(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>

    <?php if ($_smarty_tpl->tpl_vars['filterCode']->value == "NA") {?>
        <div class="row">
            <div class="col-md-12"><br><br>
                <table id="transit_based_summary_unpaid" class="table table-bordered" width="100%">
                    <thead>
                        <tr class="success">
                            <td align="center" class="bold" nowrap width="20%">Station <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%">Net Payable <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%">Paid (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%">Balance (Rs) <i class="fa fa-sort"></td>
                            <td align="center" class="bold" nowrap width="20%"> Last Payment Date</td>
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
                                    <td align="center"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value['transaction_at']);?>
</td>
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('t_payable', $_smarty_tpl->tpl_vars['t_payable']->value+$_smarty_tpl->tpl_vars['row']->value['payable_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_paid', $_smarty_tpl->tpl_vars['t_paid']->value+$_smarty_tpl->tpl_vars['row']->value['paid_amt']);?>
                                <?php $_smarty_tpl->_assignInScope('t_bal', $_smarty_tpl->tpl_vars['t_bal']->value+$_smarty_tpl->tpl_vars['row']->value['bal_amt']);?>
                            <?php }?>
                        <?php
}
} else {
?>
                            <tr>
                                <td colspan="10" align="center">No data found</td>
                            </tr>
                        <?php
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
                                <td></td>
                            </tr>
                        </tfoot>
                    <?php }?>
                </table>
            </div>
        </div>
    <?php } else { ?>
        <table>
        <tr>
            <td colspan="10" align="center">No data found</td>
        </tr>
        </table>
    <?php }
}}
/*/ smarty_template_function_summaryWiseTopayUnpaid_15726687546666c4e358cb26_55619714 */
}
