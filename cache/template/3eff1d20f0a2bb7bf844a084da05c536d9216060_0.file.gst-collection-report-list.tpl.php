<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 16:04:13
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\gst-collection-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6672b425ce6926_83791882',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3eff1d20f0a2bb7bf844a084da05c536d9216060' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\gst-collection-report-list.tpl',
      1 => 1716878895,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6672b425ce6926_83791882 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'gstTable' => 
  array (
    'compiled_filepath' => 'E:\\xampp\\htdocs\\cargo\\cache\\template\\3eff1d20f0a2bb7bf844a084da05c536d9216060_0.file.gst-collection-report-list.tpl.php',
    'uid' => '3eff1d20f0a2bb7bf844a084da05c536d9216060',
    'call_name' => 'smarty_template_function_gstTable_20189826996672b425b016d0_50422029',
  ),
));
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="99%">
    <tr>
        <td  colspan="2" align="center"><span class="bold">GST Collection Report</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span>
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
        <td width="50%" align="right"><span class="bold">Report At : </span> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
 </td>
    </tr>
</table>
<br/>
<div class="row">
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'item', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['item']->value) {
?>
        
    <div class="col-md-3">
        <h5><b><?php echo $_smarty_tpl->tpl_vars['k']->value;?>
</b></h5>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['item']->value, 'row', false, 'l');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['l']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <div class="bold">GSTIN : <?php echo $_smarty_tpl->tpl_vars['row']->value['gst_state'];?>
 - <?php echo $_smarty_tpl->tpl_vars['l']->value;?>
</div>
            <table id="dt_bp_report_table" class="table table-bordered">
                <thead>
                    <tr>
                        <td align="center" class="bold"><?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>Net Amount <?php } else { ?> Freight<?php }?></td>
                        <td align="center" class="bold">SGST</td>
                        <td align="center" class="bold">CGST</td>
                        <td align="center" class="bold">IGST</td>
                        <td align="center" class="bold">Total</td>
                    </tr>
                </thead>
                <tbody class="body_table">
                <?php $_smarty_tpl->_assignInScope('freightNet', 0);?>
                    <tr>                    
                        <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
                            <?php $_smarty_tpl->_assignInScope('freightNet', $_smarty_tpl->tpl_vars['freightNet']->value+$_smarty_tpl->tpl_vars['row']->value['netpayable']);?>
                        <?php } else { ?>
                            <?php $_smarty_tpl->_assignInScope('freightNet', $_smarty_tpl->tpl_vars['freightNet']->value+$_smarty_tpl->tpl_vars['row']->value['freight']);?>
                        <?php }?>
                       <?php $_smarty_tpl->_assignInScope('total', $_smarty_tpl->tpl_vars['total']->value+$_smarty_tpl->tpl_vars['row']->value['igst']+$_smarty_tpl->tpl_vars['row']->value['sgst']+$_smarty_tpl->tpl_vars['row']->value['cgst']+$_smarty_tpl->tpl_vars['freightNet']->value);?>
                        <td class="text-right"><?php echo number_format($_smarty_tpl->tpl_vars['freightNet']->value,2);?>
</td>
                        <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['row']->value['sgst']),2);?>
</td>
                        <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['row']->value['cgst']),2);?>
</td>            
                        <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['row']->value['igst']),2);?>
</td>         
                        <td class="text-right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['row']->value['igst']+$_smarty_tpl->tpl_vars['row']->value['sgst']+$_smarty_tpl->tpl_vars['row']->value['cgst']+$_smarty_tpl->tpl_vars['freightNet']->value)),2);?>
</td>
                    </tr>
                </tbody>
            </table>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </div>
        
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <div class="col-md-5">

        <h5 class="noprint"><b>Summary</b></h5>
        <table class="table table-bordered noprint" style="width:100%;">
            <thead>

                <tr class="info bold">
                    <th>Transaction</th>
                    <th><?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>Net Amount (A)<?php } else { ?>Freight (A)<?php }?></th>
                    <th>SGST (B)</th>
                    <th>CGST (C)</th>
                    <th>IGST (D)</th>
                    <th>Total (A+ B+ C+ D)</th>
                </tr>
            </thead>
            <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
            <?php $_smarty_tpl->_assignInScope('frightnetA', $_smarty_tpl->tpl_vars['booking']->value['netpayable']);?>
            <?php $_smarty_tpl->_assignInScope('frightnetB', $_smarty_tpl->tpl_vars['cancel']->value['netpayable']);?>
            <?php $_smarty_tpl->_assignInScope('frightnetC', $_smarty_tpl->tpl_vars['nongst_booking']->value['netpayable']);?>
            <?php $_smarty_tpl->_assignInScope('frightnetD', $_smarty_tpl->tpl_vars['nongst_cancel']->value['netpayable']);?>
            <?php } else { ?>
            <?php $_smarty_tpl->_assignInScope('frightnetA', $_smarty_tpl->tpl_vars['booking']->value['freight']);?>
            <?php $_smarty_tpl->_assignInScope('frightnetB', $_smarty_tpl->tpl_vars['cancel']->value['freight']);?>
            <?php $_smarty_tpl->_assignInScope('frightnetC', $_smarty_tpl->tpl_vars['nongst_booking']->value['freight']);?>
            <?php $_smarty_tpl->_assignInScope('frightnetD', $_smarty_tpl->tpl_vars['nongst_cancel']->value['freight']);?>
            <?php }?>
            <tbody>
                <tr>
                    <td>Booking (A)</td>
                    <td class="text-right"><?php echo number_format($_smarty_tpl->tpl_vars['frightnetA']->value,2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['booking']->value['sgst']),2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['booking']->value['cgst']),2);?>
</td>            
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['booking']->value['igst']),2);?>
</td>         
                    <td class="text-right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['booking']->value['igst']+$_smarty_tpl->tpl_vars['booking']->value['sgst']+$_smarty_tpl->tpl_vars['booking']->value['cgst']+$_smarty_tpl->tpl_vars['frightnetA']->value)),2);?>
</td>
                </tr>
                <tr>
                    <td>Cancel (B)</td>
                    <td class="text-right"><?php echo number_format($_smarty_tpl->tpl_vars['frightnetB']->value,2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['cancel']->value['sgst']),2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['cancel']->value['cgst']),2);?>
</td>            
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['cancel']->value['igst']),2);?>
</td>         
                    <td class="text-right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['cancel']->value['igst']+$_smarty_tpl->tpl_vars['cancel']->value['sgst']+$_smarty_tpl->tpl_vars['cancel']->value['cgst']+$_smarty_tpl->tpl_vars['frightnetB']->value)),2);?>
</td>
                </tr>
                <tr>
                    <td>Non GST Booking (C)</td>
                    <td class="text-right"><?php echo number_format($_smarty_tpl->tpl_vars['frightnetC']->value,2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['nongst_booking']->value['sgst']),2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['nongst_booking']->value['cgst']),2);?>
</td>            
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['nongst_booking']->value['igst']),2);?>
</td>         
                    <td class="text-right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['nongst_booking']->value['igst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['sgst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['cgst']+$_smarty_tpl->tpl_vars['frightnetC']->value)),2);?>
</td>
                </tr>
                <tr>
                    <td>Non GST Cancel (D)</td>
                    <td class="text-right"><?php echo number_format($_smarty_tpl->tpl_vars['frightnetD']->value,2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['nongst_cancel']->value['sgst']),2);?>
</td>
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['nongst_cancel']->value['cgst']),2);?>
</td>            
                    <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['nongst_cancel']->value['igst']),2);?>
</td>         
                    <td class="text-right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['nongst_cancel']->value['igst']+$_smarty_tpl->tpl_vars['nongst_cancel']->value['sgst']+$_smarty_tpl->tpl_vars['nongst_cancel']->value['cgst']+$_smarty_tpl->tpl_vars['frightnetD']->value)),2);?>
</td>
                </tr>
            </tbody>
            <?php $_smarty_tpl->_assignInScope('book_total', $_smarty_tpl->tpl_vars['frightnetA']->value+$_smarty_tpl->tpl_vars['booking']->value['sgst']+$_smarty_tpl->tpl_vars['booking']->value['cgst']+$_smarty_tpl->tpl_vars['booking']->value['igst']);?>
            <?php $_smarty_tpl->_assignInScope('cancel_total', $_smarty_tpl->tpl_vars['frightnetB']->value+$_smarty_tpl->tpl_vars['cancel']->value['sgst']+$_smarty_tpl->tpl_vars['cancel']->value['cgst']+$_smarty_tpl->tpl_vars['cancel']->value['igst']);?>
            <?php $_smarty_tpl->_assignInScope('nongst_booking_total', $_smarty_tpl->tpl_vars['frightnetC']->value+$_smarty_tpl->tpl_vars['nongst_booking']->value['sgst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['cgst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['igst']);?>
            <?php $_smarty_tpl->_assignInScope('nongst_cancel_total', $_smarty_tpl->tpl_vars['frightnetD']->value+$_smarty_tpl->tpl_vars['nongst_cancel']->value['sgst']+$_smarty_tpl->tpl_vars['nongst_cancel']->value['cgst']+$_smarty_tpl->tpl_vars['nongst_cancel']->value['igst']);?>

            <?php $_smarty_tpl->_assignInScope('freight_total', $_smarty_tpl->tpl_vars['frightnetA']->value-$_smarty_tpl->tpl_vars['frightnetB']->value+$_smarty_tpl->tpl_vars['frightnetC']->value-$_smarty_tpl->tpl_vars['frightnetD']->value);?>
            <?php $_smarty_tpl->_assignInScope('sgst_total', $_smarty_tpl->tpl_vars['booking']->value['sgst']-$_smarty_tpl->tpl_vars['cancel']->value['sgst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['sgst']-$_smarty_tpl->tpl_vars['nongst_cancel']->value['sgst']);?>
            <?php $_smarty_tpl->_assignInScope('cgst_total', $_smarty_tpl->tpl_vars['booking']->value['cgst']-$_smarty_tpl->tpl_vars['cancel']->value['cgst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['cgst']-$_smarty_tpl->tpl_vars['nongst_cancel']->value['cgst']);?>
            <?php $_smarty_tpl->_assignInScope('igst_total', $_smarty_tpl->tpl_vars['booking']->value['igst']-$_smarty_tpl->tpl_vars['cancel']->value['igst']+$_smarty_tpl->tpl_vars['nongst_booking']->value['igst']-$_smarty_tpl->tpl_vars['nongst_cancel']->value['igst']);?>

            <tr class="active bold">
                <td class="text-left" colspan="1"><b>Net Total (A - B + C - D)</b></td>
                <td class="text-right"><?php echo number_format($_smarty_tpl->tpl_vars['freight_total']->value,2);?>
</td>
                <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['sgst_total']->value),2);?>
</td>
                <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['cgst_total']->value),2);?>
</td>            
                <td class="text-right"><?php echo number_format(ceil($_smarty_tpl->tpl_vars['igst_total']->value),2);?>
</td>         
                <td class="text-right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['book_total']->value-$_smarty_tpl->tpl_vars['cancel_total']->value+$_smarty_tpl->tpl_vars['nongst_booking_total']->value-$_smarty_tpl->tpl_vars['nongst_cancel_total']->value)),2);?>
</td>
            </tr>
        </table>
        
    </div>
</div>
   

    
    <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'gstTable', array('data'=>array('data'=>$_smarty_tpl->tpl_vars['booking']->value['booking'],'title'=>'Booking')), true);?>

    
    <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'gstTable', array('data'=>array('data'=>$_smarty_tpl->tpl_vars['cancel']->value['cancel'],'title'=>'Cancel')), true);?>

    
    <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'gstTable', array('data'=>array('data'=>$_smarty_tpl->tpl_vars['nongst_booking']->value['nongst_booking'],'title'=>'Non GST Booking')), true);?>


    <?php $_smarty_tpl->smarty->ext->_tplFunction->callTemplateFunction($_smarty_tpl, 'gstTable', array('data'=>array('data'=>$_smarty_tpl->tpl_vars['nongst_cancel']->value['nongst_cancel'],'title'=>'Non GST Cancel')), true);?>

    

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoTransExcel();"><i class="fa fa-download fa-lg"></i>Excel</button>
    </div>
</div><?php }
/* smarty_template_function_gstTable_20189826996672b425b016d0_50422029 */
if (!function_exists('smarty_template_function_gstTable_20189826996672b425b016d0_50422029')) {
function smarty_template_function_gstTable_20189826996672b425b016d0_50422029(Smarty_Internal_Template $_smarty_tpl,$params) {
$params = array_merge(array('data'=>array()), $params);
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
        
<?php if ($_smarty_tpl->tpl_vars['data']->value['data']) {?>    
    <h5><b><?php echo $_smarty_tpl->tpl_vars['data']->value['title'];?>
 Transactions</b></h5>
    <div class="clearfix"></div>
<div class="table-responsive" style="overflow: auto;">
    <table id="demo" class="table table-bordered" width="98%" nowrap>
        <thead>
            <tr class="success">
                <td align="center"><?php echo lang('cargo_code_term');?>
</td>
                <td align="center">Booked Date</td> 
                <td align="center"><?php echo lang('booking_from_term');?>
</td>                    
                <td align="center"><?php echo lang('booking_to_label');?>
</td>
                <td align="center"><?php echo lang('booking_sender_term');?>
</td>
                <td align="center"><?php echo lang('booking_receiver_term');?>
</td>
                <td align="center"><?php echo lang('booking_sender_term');?>
 GST</td>
                <td align="center"><?php echo lang('booking_receiver_term');?>
 GST</td>
                <td align="center">Trade Name</td>
                <td align="center">GSTIN</td>
                <td align="center">State</td>
                <td align="center"><?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>Net Amount<?php } else { ?>Freight<?php }?></td>
                <td align="center">SGST</td>
                <td align="center">CGST</td>
                <td align="center">IGST</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Handling Charge</td>
                <td align="center">Unloading Charge</td>
            </tr>
        </thead>
        <tbody class="body_table">

            <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_payable', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_gst', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_unload', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_pickup', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_dlvry', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_commission', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_paid', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_topay', 0);?>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['data']->value['data'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>                            
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name ? $_smarty_tpl->tpl_vars['row']->value->to_organization_name : "-";?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
 - <?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                            <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_gstin ? $_smarty_tpl->tpl_vars['row']->value->from_customer_gstin : "-";?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_gstin ? $_smarty_tpl->tpl_vars['row']->value->to_customer_gstin : "-";?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->trade_name ? $_smarty_tpl->tpl_vars['row']->value->trade_name : "-";?>
</td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->gstin ? $_smarty_tpl->tpl_vars['row']->value->gstin : "-";?>
</td>
                            <td align="left" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->state_name;?>
</td>
                            <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
                                <?php $_smarty_tpl->_assignInScope('nettotal', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>
                                <?php $_smarty_tpl->_assignInScope('taxttotal', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>
                            <?php } else { ?> 
                                <?php $_smarty_tpl->_assignInScope('nettotal', ($_smarty_tpl->tpl_vars['row']->value->total_amount));?>
                                <?php $_smarty_tpl->_assignInScope('taxttotal', ($_smarty_tpl->tpl_vars['row']->value->total_amount));?>
                            <?php }?>
                            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['nettotal']->value,2);?>
</td>
                            <td align="right">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->service_tax == 0 ? "0.00" : (number_format(ceil((($_smarty_tpl->tpl_vars['taxttotal']->value*$_smarty_tpl->tpl_vars['row']->value->sgst)/100)),2));?>

                            </td>
                            <td align="right">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->service_tax == 0 ? "0.00" : (number_format(ceil((($_smarty_tpl->tpl_vars['taxttotal']->value*$_smarty_tpl->tpl_vars['row']->value->cgst)/100)),2));?>

                            </td>
                            <td align="right">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->service_tax == 0 ? "0.00" : (number_format(ceil((($_smarty_tpl->tpl_vars['taxttotal']->value*$_smarty_tpl->tpl_vars['row']->value->igst)/100)),2));?>

                            </td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td> 
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td> 
                                                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount,2);?>
</td>
                                                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount,2);?>
</td>
                                            </tr>
                <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
                    <?php $_smarty_tpl->_assignInScope('tot_freight', $_smarty_tpl->tpl_vars['tot_freight']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                <?php } else { ?>
                    <?php $_smarty_tpl->_assignInScope('tot_freight', $_smarty_tpl->tpl_vars['tot_freight']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                <?php }?>
                <?php $_smarty_tpl->_assignInScope('tot_sgst', $_smarty_tpl->tpl_vars['tot_sgst']->value+($_smarty_tpl->tpl_vars['row']->value->service_tax == 0 ? "0.00" : (($_smarty_tpl->tpl_vars['taxttotal']->value*$_smarty_tpl->tpl_vars['row']->value->sgst)/100)));?>
                <?php $_smarty_tpl->_assignInScope('tot_cgst', $_smarty_tpl->tpl_vars['tot_cgst']->value+($_smarty_tpl->tpl_vars['row']->value->service_tax == 0 ? "0.00" : (($_smarty_tpl->tpl_vars['taxttotal']->value*$_smarty_tpl->tpl_vars['row']->value->cgst)/100)));?>
                <?php $_smarty_tpl->_assignInScope('tot_igst', $_smarty_tpl->tpl_vars['tot_igst']->value+($_smarty_tpl->tpl_vars['row']->value->service_tax == 0 ? "0.00" : (($_smarty_tpl->tpl_vars['taxttotal']->value*$_smarty_tpl->tpl_vars['row']->value->igst)/100)));?>



                <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_gst', $_smarty_tpl->tpl_vars['tot_gst']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                <?php $_smarty_tpl->_assignInScope('tot_pickup', $_smarty_tpl->tpl_vars['tot_pickup']->value+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_unload', $_smarty_tpl->tpl_vars['tot_unload']->value+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_dlvry', $_smarty_tpl->tpl_vars['tot_dlvry']->value+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+$_smarty_tpl->tpl_vars['row']->value->commission_amount+$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
                <tr class="active bold">
                    <td align="right" colspan="11" class="bold">Total</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tot_freight']->value,2);?>
</td>
                    <td align="right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['tot_sgst']->value)),2);?>
</td>
                    <td align="right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['tot_cgst']->value)),2);?>
</td>
                    <td align="right"><?php echo number_format(ceil(($_smarty_tpl->tpl_vars['tot_igst']->value)),2);?>
</td>
                    <td align="right"></td>
                    <td align="right"></td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tot_handling']->value,2);?>
</td>
                    <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tot_unload']->value,2);?>
</td>
                </tr>
            <?php }?>
        </tbody>
    </table>
</div>
    <?php }?>
    <?php
}}
/*/ smarty_template_function_gstTable_20189826996672b425b016d0_50422029 */
}
