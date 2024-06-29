<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-13 16:11:13
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\delivery-report-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666accc9d11864_99368476',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'ad87bf8044e90c142f9962530f647dbfd9341ec2' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\delivery-report-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666accc9d11864_99368476 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table class="" width="95%">
    <tr>
        <td  colspan="2" align="center"><span class="bold"><?php echo iflang('Cargo Delivery Report');?>
</span></td>
    </tr>
    <tr>
        <td width="50%">
            <span class="bold">Report Date : </span> 
            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['fromDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['toDate']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        <td width="50%" align="right"><span class="bold">Report At : </span> <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td width="50%">&nbsp;</td>
        <td width="50%" align="right"><span class="bold">Report By : </span> <?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 </td>
    </tr>
</table> 

<h5><b>Summary</b></h5>
<table class="table table-bordered" style="width:30%;">
    <tr>
        <td class="bold" >Freight (A)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['freight']);?>
</td>

        <td class="bold" >Paid</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['paid']);?>
</td>
    </tr>
    <tr>
        <td class="bold" >Handling Charges (B)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['handling']);?>
</td>

        <td class="bold" >To Pay</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['topay']);?>
</td>
    </tr>
    <tr>
        <td class="bold" >Unloading Charges (C)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['unloading']);?>
</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >GST (D)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['gst']);?>
</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >Pickup Charges (E)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['pickup']);?>
</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" >Delivery Charges (F)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['delivery']);?>
</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold">Connecting Charges (G)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['connecting']);?>
</td>

        <td class="bold">&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold" ><?php echo lang('other_charges');?>
 (H)</td>
        <td class="text-right"><?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['service_charge']);?>
</td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold">Net Amount (A+B+C+D+E+F+G+H)</td>                                                                                           
        <td class="bold text-right">
            <?php echo inr_format($_smarty_tpl->tpl_vars['amounts']->value['netpayable']);?>

        </td>

        <td class="bold" >&nbsp;</td>
        <td class="text-right"></td>
    </tr>
</table>    
<h5><b>Transactions</b></h5>

<div class="overflow-x-auto">
    <table id="dt_adv_booking_report_table" class="table table-bordered " >
        <thead>
            <tr class="success">        
                <td align="center">Booked Date</td>
                <td align="center"><?php echo lang('cargo_code_term');?>
</td>
                <td align="center">Ogpl No.</td>
                <td align="center">Type Of Packaging</td>
                <td align="center">Type Of Booking</td>
                <td align="center"><?php echo lang('booking_from_term');?>
</td>
                <td align="center">Delivery User</td>
                <td align="center"><?php echo lang('booking_to_label');?>
</td>
                <td align="center"><?php echo lang('booking_sender_term');?>
</td>
                <td align="center"><?php echo lang('booking_sender_term');?>
 Contact Number</td>
                <td align="center"><?php echo lang('booking_receiver_term');?>
</td>
                <td align="center"><?php echo lang('booking_receiver_term');?>
 Contact Number</td>
                <td align="center">Type Of Delivery</td>
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Date Of Delivery</td>
                <td align="center">Delivered Using</td>
                <td align="center">No. Of Articles</td>
                <td align="center">Qty</td>
                <td align="center">Freight Amount</td>
                <td align="center"><?php echo lang('other_charges');?>
 </td>
                <td align="center">Net Payable</td>
                <td align="center">Paid</td>
                <td align="center">To Pay</td>
            </tr>

        </thead>
        <tbody class="body_table" >

            <?php $_smarty_tpl->_assignInScope('tot_lr_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_item_count', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_fare', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_payable', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_paid', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_topay', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_commission', 0);?>

            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CA' && $_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CR') {?>
                    <tr>
                        <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                        <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a><?php if ($_smarty_tpl->tpl_vars['namespace']->value == 'cargodemo' || $_smarty_tpl->tpl_vars['namespace']->value == 'rmtcargo' || $_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?> <br>PNO: <?php echo $_smarty_tpl->tpl_vars['row']->value->private_mark_number;
}?></td>
                        <td align="center" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->transit_alias_code;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->pickup_type_code];?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                        <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                        <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->delivery_type_code];?>
</td>
                        <td align="center" id='pay_state_<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
'>
                            <?php if ($_smarty_tpl->tpl_vars['namespace']->value == "arthitravels" && $_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'TPPAD') {?>
                                <?php echo _cargo_payment_status_badge('TOP');?>

                            <?php } else { ?>
                                <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                            <?php }?>
                        </td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                        <td align="left" nowrap>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->delivered_at) {?>
                                <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->delivered_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                            <?php } else { ?>
                                -
                            <?php }?>
                        </td>
                        <td align="center" nowrap>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->delivery_model)) {?>
                                <?php $_smarty_tpl->_assignInScope('delivery_model', explode(',',$_smarty_tpl->tpl_vars['row']->value->delivery_model));?>

                                <?php if (in_array('OTP',$_smarty_tpl->tpl_vars['delivery_model']->value)) {?>
                                    <span class="label label-default" title="Delivery OTP Verified">OTP</span>
                                <?php }?>
                                <?php if (in_array('POD',$_smarty_tpl->tpl_vars['delivery_model']->value)) {?>
                                    <span class="label label-default" title="POD Verified">POD</span>
                                <?php }?>
                            <?php } else { ?>
                                -
                            <?php }?>
                        </td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->item_count;?>
</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>

                                                <td align="right">
                            <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>

                        </td>
                        <td align="right" nowrap>
                            <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge));?>


                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                           <table>
                           <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                               <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                   <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                       <?php continue 1;?>
                                   <?php }?>
                                   <tr>
                                   <td><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</td>
                                   <td>&ensp;:&ensp;</td>
                                   <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                   </tr>
                               <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                           <?php }?>
                           <?php if ($_smarty_tpl->tpl_vars['row']->value->service_charge > 0) {?>
                           <tr>
                               <td><?php echo lang('other_charges');?>
</td>
                               <td>&ensp;:&ensp;</td>
                               <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_charge);?>
</td>
                           </tr>
                           <?php }?>
                           '></i>
                        </td>
                        <td align="right" nowrap>
                            <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>

                            <i class="fa fa-info-circle" data-toggle="popover" data-content='
                            <table>
                            <tr>
                            <td>Net Payable</td>
                            <td>&ensp;:&ensp;</td>
                            <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                            </tr>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->total_handling_amount > 0) {?>
                            <tr>
                                <td>Handling Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
</td>
                            </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->service_tax > 0) {?>
                            <tr>
                                <td>GST</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                            </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->service_charge > 0) {?>
                            <tr>
                                <td><?php echo lang('other_charges');?>
</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_charge);?>
</td>
                            </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount > 0) {?>
                            <tr>
                                <td>Unloading Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
</td>
                            </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount > 0) {?>
                            <tr>
                                <td>Pickup Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
</td>
                            </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount > 0) {?>
                            <tr>
                                <td>Delivery Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
</td>
                            </tr>
                            <?php }?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->other_charges_amount != 0) {?>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, _parse_other_charges($_smarty_tpl->tpl_vars['row']->value->other_charges), 'cv', false, 'ck');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['ck']->value => $_smarty_tpl->tpl_vars['cv']->value) {
?>
                                    <?php if ($_smarty_tpl->tpl_vars['cv']->value == 0) {?>
                                        <?php continue 1;?>
                                    <?php }?>
                                    <tr>
                                    <td><?php echo _snakecase_to_titlecase($_smarty_tpl->tpl_vars['ck']->value);?>
</td>
                                    <td>&ensp;:&ensp;</td>
                                    <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['cv']->value);?>
</td>
                                    </tr>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php }?>

                            </table>'>
                            </i>
                        </td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
</td>
                        <td align="right">
                            <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount)-$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                            <?php echo inr_format($_smarty_tpl->tpl_vars['rtopay']->value);?>

                            <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>
                        </td>
                    </tr>

                    <?php $_smarty_tpl->_assignInScope('tot_lr_count', $_smarty_tpl->tpl_vars['tot_lr_count']->value+1);?>
                    <?php $_smarty_tpl->_assignInScope('tot_item_count', $_smarty_tpl->tpl_vars['tot_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->item_count);?>
                    <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                    <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', $_smarty_tpl->tpl_vars['t_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>
                    <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+$_smarty_tpl->tpl_vars['row']->value->commission_amount);?>
                <?php }?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            <?php if ($_smarty_tpl->tpl_vars['tot_lr_count']->value) {?>
                <tr class="active">
                    <td align="right" colspan="17" class="bold">Total <?php echo $_smarty_tpl->tpl_vars['tot_lr_count']->value;?>
 <?php echo lang('lr');?>
s</td>
                    <td align="right" class="bold"><?php echo $_smarty_tpl->tpl_vars['tot_item_count']->value;?>
</td>
                    <td align="right" class="bold"><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_fare']->value);?>
</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['t_other_tot_amount']->value);?>
</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_payable']->value);?>
</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_paid']->value);?>
</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_topay']->value);?>
</td>
                </tr>
            <?php } else { ?>
                <tr>
                    <td colspan="100%" align="center">No Records Found!</td>
                </tr>
            <?php }?>

        </tbody>
    </table>
</div>

<div class="clear_fix_both text-right">
    <div class="btn-group btn-group-sm">
        <button class="btn btn-default" onclick="exportCargoDeliveryExcel()"><i class="fa fa-download fa-lg"></i>Excel</button>
        <button class="btn btn-default" onclick="window.print();"><i class="fa fa-print fa-lg"></i> Print</button>
    </div>
</div> 

<?php echo '<script'; ?>
>
    $('[data-toggle="popover"]').popover({
        placement: 'top',
        html: true,
        trigger: 'hover'
    });
<?php echo '</script'; ?>
><?php }
}
