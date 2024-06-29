<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-13 14:59:10
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\booking-report-list-xls.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666abbe6c67932_86072785',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '051b1778ecefd1c2d7845bc941cb5c2cb1c58669' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\booking-report-list-xls.tpl',
      1 => 1718270916,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666abbe6c67932_86072785 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table border='1'>
    <tr>
        <td  colspan="6" align="center"><b><?php echo iflang('Cargo Booking Report');?>
</b></td>
    </tr>
    <tr>
        <td colspan="3" align="left"><b>Report Date :</b>&nbsp; <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['from_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 to <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['to_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
 </td>
        <td colspan="3" align="right"><b>Report At :</b>&nbsp; <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
    </tr>
    <tr>
        <td colspan="3" align="left">&nbsp;</td>
        <td colspan="3" align="right"><b>Report By :</b>&nbsp; <?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 </td>
    </tr>
</table>  
<table border="1">
    <tr>
        <td class="bold"><b>Freight (A)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['freight'];?>
</td>

        <td class="bold"><b>Received</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['paid'];?>
</td>
    </tr>
    <tr>
        <td class="bold"><b>Handling Charges (B)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['handling'];?>
</td>

        <td class="bold"><b>Balance</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['topay'];?>
</td>
    </tr>
    <tr>
        <td class="bold"><b>Unloading Charges (C)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['unloading'];?>
</td>

        <td class="bold"><b><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value['INP'];?>
</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['invoicepay'];?>
</td>
    </tr>
    <tr>
        <td class="bold"><b>GST (D)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['gst'];?>
</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Pickup Charges (E)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['pickup'];?>
</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Delivery Charges (F)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['delivery'];?>
</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b>Connecting Charges (G)</b></td>
        <td align ="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['connecting'];?>
</td>

        <td class="bold">&nbsp;</td>
        <td class="right">&nbsp;</td>
    </tr>
    <tr>
        <td class="bold"><b><?php echo lang('other_charges');?>
 (H)</b></td>
        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['amounts']->value['service_charge'];?>
</td>

        <td class="bold">&nbsp;</td>
        <td align="right">&nbsp;</td>
    </tr>

    <tr>
        <td class="bold"><b>Sub Total (S1 = A+B+C+D+E+F+G+H)</b></td>
        <td class="bold" align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">
            <?php echo $_smarty_tpl->tpl_vars['amounts']->value['netpayable'];?>

        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>

    <tr>
        <td class="bold"><b>Commission (I)</b></td>
        <td class="bold" align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">
            <?php echo ($_smarty_tpl->tpl_vars['amounts']->value['commission']-$_smarty_tpl->tpl_vars['amounts']->value['handling_commission']);?>

        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>

    <tr>
        <td class="bold"><b>Share (J)</b></td>
        <td class="bold" align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">
            <?php echo ($_smarty_tpl->tpl_vars['amounts']->value['handling_commission']);?>

        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>
    
    <tr>
        <td class="bold"><b>Net Total (S1-I-J)</b></td>
        <td class="bold" align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">
            <?php echo ($_smarty_tpl->tpl_vars['amounts']->value['netpayable']-$_smarty_tpl->tpl_vars['amounts']->value['commission']);?>

        </td>

        <td class="bold">&nbsp;</td>
        <td align="right"></td>
    </tr>
</table>
<table border="1">
    <thead>
        <tr style="background-color: #64b92a">
            <th class="bold"></th>
            <th align="right">LRs</th>
            <th align="right">No. Of Articles</th>
            <th align="right">Freight</th>
        </tr>
    </thead>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'paytype');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['paytype']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
        <tr>
            <td class="bold"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['paytype']->value];?>
</td>
            <td align="right"><?php echo sigma(($_smarty_tpl->tpl_vars['row']->value['count']+0),$_smarty_tpl->tpl_vars['summ_count']->value);?>
</td>
            <td align="right"><?php echo sigma(($_smarty_tpl->tpl_vars['row']->value['qtycount']+0),$_smarty_tpl->tpl_vars['summ_qty']->value);?>
</td>
            <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['freight'],$_smarty_tpl->tpl_vars['summ_freight']->value);?>
</td>
        </tr>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <?php if (count($_smarty_tpl->tpl_vars['summary']->value)) {?>
        <tfoot>
            <tr>
                <td class="bold">Total</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['summ_count']->value;?>
</td>
                <td align="right"><?php echo $_smarty_tpl->tpl_vars['summ_qty']->value;?>
</td>
                <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['summ_freight']->value;?>
</td>
            </tr>
        </tfoot>
    <?php } else { ?>
        <tfoot>
            <tr>
                <td colspan="4" align="center">No Records Found</td>
            </tr>
        </tfoot>
    <?php }?>
</table>

<table border='1'>
    <thead>
        <tr style="background-color: #64b92a">        
            <td align="center"><b>Booked Date</b></td> 
            <td align="center"><b><?php echo lang('cargo_code_term');?>
</b></td>
            <td align="center">No. Of Articles</td> 
            <td align="center">Type Of Packaging</td>
            <td align="center">Type Of Booking</td>  
            <td align="center"> From State</td>
            <td align="center"><b><?php echo lang('booking_from_term');?>
</b></td>
            <td align="center"><b>User</b></td>  
            <td align="center">To State</td>                               
            <td align="center"><b><?php echo lang('booking_to_label');?>
</b></td>
            <td align="center"><b><?php echo lang('booking_sender_term');?>
</b></td>
            <td align="center"><b>RAC Name</b></td>
            <td align="center"><?php echo lang('booking_sender_term');?>
 Contact  Number</td>
            <td align="center"><b><?php echo lang('booking_receiver_term');?>
</b></td>
            <td align="center"><b><?php echo lang('booking_receiver_term');?>
 Contact  Number</b></td>
            <td align="center">Type Of Delivery</td>
            <td align="center"><b>Payment Status</b></td>
            <td align="center">Date Of Dispatch</td>
            <td align="center">Dispatch Status</td>
            <td align="center"><b>Cargo Status</b></td> 
            <td align="center"><b>Items</b></td>
            <?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutransport' || $_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutrans') {?>
                <td align="center">LL No</td>
                <td align="center">LL Date</td>
                <td align="center">RP Send</td>
                <td align="center">RP Receiving</td>
                <td align="center">Payment Receive Date</td>
            <?php }?>
            <td align="center"><?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == "dishashree") {?>Qty/Kg <?php } else { ?>Qty<?php }?></td>
            <td align="center"><b>Net Payable</b></td>
            <td align="center"><b>Handling Charges </b></td>
            <td align="center"><b>Freight Amount </b></td>
            <td align="center"><b>GST </b></td>
            <td align="center"><b>Unloading Charges </b></td>
            <td align="center"><b>Pickup Charges </b></td>
            <td align="center"><b>Delivery Charges </b></td>
            <td align="center"><b><?php echo lang('other_charges');?>
 </b></td>
            <td align="center"><b>Commission</b></td>
            <td align="center"><b>Share</b></td>
            <td align="center"><b>Received</b></td>
            <td align="center"><b>Balance</b></td>     
        </tr>

    </thead>
    <tbody class="body_table" >
        
        <?php $_smarty_tpl->_assignInScope('tot_fare', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_payable', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_paid', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_topay', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_commission', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_share', 0);?>
        
        <?php $_smarty_tpl->_assignInScope('t_service_tax', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_total_handling_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_total_unload_handling_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_pickup_handling_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_delivery_handling_amount', 0);?>
        <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', 0);?>
        
        <?php if ($_REQUEST['groupBy'] == "PAYTYPE") {?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'val', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                <tr><td align="center" colspan="20" class="bold"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td> </tr>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['val']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CA' && $_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CR') {?>
                    <tr> 
                        <td align="left" nowrap><?php $_smarty_tpl->smarty->ext->_capture->open($_smarty_tpl, 'default', 'timestamp', null);
echo strtotime($_smarty_tpl->tpl_vars['row']->value->booked_at);
$_smarty_tpl->smarty->ext->_capture->close($_smarty_tpl);
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['timestamp']->value,"%d %b %Y %I:%M %p");?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;
if ($_smarty_tpl->tpl_vars['namespace']->value == 'rmtcargo' || $_smarty_tpl->tpl_vars['namespace']->value == 'cargodemo' || $_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics') {?> PNO: <?php echo $_smarty_tpl->tpl_vars['row']->value->private_mark_number;
}?></td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->pickup_type_code];?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_state_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td> 
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_state_name;?>
</td>                               
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                        <td align="left"><?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'INP') {
echo $_smarty_tpl->tpl_vars['row']->value->vendor_name;
} else { ?> - <?php }?></td>
                        <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                        <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->delivery_type_code];?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                        
                        <td align="left" nowrap>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_at)) {?>
                                <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                            <?php } else { ?>
                                -
                            <?php }?>
                        </td>
                        <td align="center">
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CD") {?>
                                Yes
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CB" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUD" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CR" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CA") {?>
                                No
                            <?php }?>
                        </td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
 </td>            
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                        <?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutransport' || $_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutrans') {?>
                            <td align="center" nowrap> <?php echo $_smarty_tpl->tpl_vars['row']->value->transit_alias_code;?>
</td>
                            <td  align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transit_trip_date,"d-m-Y");?>
 </td>
                            <td  align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->pod_sending_at,"d-m-Y");?>
 </td>
                            <td  align="left" nowrap> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->pod_received_at,"d-m-Y");?>
</td>
                            <td  align="left" nowrap> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->pod_transaction_date,"d-m-Y");?>
</td>
                        <?php }?>
                        <td align="center"><?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == "dishashree") {
echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
/<?php echo $_smarty_tpl->tpl_vars['row']->value->total_unit_value;
} else {
echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;
}?></td>

                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->service_tax;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo ($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->handling_commission_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->transaction_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">                    
                            <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge)-$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                            <?php echo $_smarty_tpl->tpl_vars['rtopay']->value;?>

                            <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>                    
                        </td>
                    </tr> 

                    <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->connecting_charge+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                    <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount));?>
                    <?php $_smarty_tpl->_assignInScope('tot_share', $_smarty_tpl->tpl_vars['tot_share']->value+$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
                    
                    <?php $_smarty_tpl->_assignInScope('t_service_tax', $_smarty_tpl->tpl_vars['t_service_tax']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                    <?php $_smarty_tpl->_assignInScope('t_total_handling_amount', $_smarty_tpl->tpl_vars['t_total_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_total_unload_handling_amount', $_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_pickup_handling_amount', $_smarty_tpl->tpl_vars['t_pickup_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_delivery_handling_amount', $_smarty_tpl->tpl_vars['t_delivery_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', $_smarty_tpl->tpl_vars['t_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>

                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>  
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>  
        <?php } else { ?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CA' && $_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CR') {?>
                    <tr>
                        <td align="left" nowrap><?php $_smarty_tpl->smarty->ext->_capture->open($_smarty_tpl, 'default', 'timestamp', null);
echo strtotime($_smarty_tpl->tpl_vars['row']->value->booked_at);
$_smarty_tpl->smarty->ext->_capture->close($_smarty_tpl);
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['timestamp']->value,"%d %b %Y %I:%M %p");?>
</td>                
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;
if ($_smarty_tpl->tpl_vars['namespace']->value == 'ktwoklogistics' || $_smarty_tpl->tpl_vars['namespace']->value == 'cargodemo' || $_smarty_tpl->tpl_vars['namespace']->value == 'rmtcargo') {?> PNO: <?php echo $_smarty_tpl->tpl_vars['row']->value->private_mark_number;
}?></td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->pickup_type_code];?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_state_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td> 
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_state_name;?>
</td>  
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
 </td>
                        <td align="left"><?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == 'INP') {
echo $_smarty_tpl->tpl_vars['row']->value->vendor_name;
} else { ?> - <?php }?></td>
                        <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->from_customer_mobile);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                        <td align="left"><?php echo mask_mobileno($_smarty_tpl->tpl_vars['row']->value->to_customer_mobile);?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['row']->value->delivery_type_code];?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                        <td align="left" nowrap>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['row']->value->unloaded_at)) {?>
                                <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloaded_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                            <?php } else { ?>
                                -
                            <?php }?>
                        </td>
                        <td align="center">
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUL" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CD") {?>
                                Yes
                            <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CB" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CUD" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CR" || $_smarty_tpl->tpl_vars['row']->value->cargo_status_code == "CA") {?>
                                No
                            <?php }?>
                        </td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
 </td>            
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>      
                        <?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutransport' || $_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutrans') {?>
                            <td align="center" nowrap> <?php echo $_smarty_tpl->tpl_vars['row']->value->transit_alias_code;?>
</td>
                            <td  align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->transit_trip_date,"d-m-Y");?>
 </td>
                            <td  align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->pod_sending_at,"d-m-Y");?>
 </td>
                            <td  align="left" nowrap> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->pod_received_at,"d-m-Y");?>
</td>
                            <td  align="left" nowrap> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->pod_transaction_date,"d-m-Y");?>
</td>
                        <?php }?>      
                        <td align="center"><?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == "dishashree") {
echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
/<?php echo $_smarty_tpl->tpl_vars['row']->value->total_unit_value;
} else {
echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;
}?></td>

                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->service_tax;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo ($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->handling_commission_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><?php echo $_smarty_tpl->tpl_vars['row']->value->transaction_amount;?>
</td>
                        <td align="right" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
">                    
                            <?php $_smarty_tpl->_assignInScope('rtopay', ($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge+$_smarty_tpl->tpl_vars['row']->value->connecting_charge)-$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                            <?php echo $_smarty_tpl->tpl_vars['rtopay']->value;?>

                            <?php $_smarty_tpl->_assignInScope('tot_topay', $_smarty_tpl->tpl_vars['tot_topay']->value+$_smarty_tpl->tpl_vars['rtopay']->value);?>                    
                        </td>
                    </tr> 

                    <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->connecting_charge+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                    <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                    <?php $_smarty_tpl->_assignInScope('tot_unit', $_smarty_tpl->tpl_vars['tot_unit']->value+$_smarty_tpl->tpl_vars['row']->value->total_unit_value);?>
                    <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+($_smarty_tpl->tpl_vars['row']->value->commission_amount-$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount));?>
                    <?php $_smarty_tpl->_assignInScope('tot_share', $_smarty_tpl->tpl_vars['tot_share']->value+$_smarty_tpl->tpl_vars['row']->value->handling_commission_amount);?>
                        
                    <?php $_smarty_tpl->_assignInScope('t_service_tax', $_smarty_tpl->tpl_vars['t_service_tax']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                    <?php $_smarty_tpl->_assignInScope('t_total_handling_amount', $_smarty_tpl->tpl_vars['t_total_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_total_unload_handling_amount', $_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_pickup_handling_amount', $_smarty_tpl->tpl_vars['t_pickup_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_delivery_handling_amount', $_smarty_tpl->tpl_vars['t_delivery_handling_amount']->value+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
                    <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', $_smarty_tpl->tpl_vars['t_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['row']->value->connecting_charge);?>
                <?php }?>

            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>  
        <?php }?>
    </tbody>
    <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
        <tfoot>
            <tr class="active">                    
                <td align="right" <?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutransport' || $_smarty_tpl->tpl_vars['namespaceCode']->value == 'seenutrans') {?>  colspan="26" <?php } else { ?> colspan="21"   <?php }?> class="bold"><b>Total</b></td>  
                <td align="center" class="bold"><?php if ($_smarty_tpl->tpl_vars['namespaceCode']->value == "dishashree") {?><b><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</b>/<b><?php echo $_smarty_tpl->tpl_vars['tot_unit']->value;?>
</b><?php } else { ?><b><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</b><?php }?></td>
                <td align="right" class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['tot_payable']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['t_total_handling_amount']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['tot_fare']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['t_service_tax']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['t_total_unload_handling_amount']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['t_pickup_handling_amount']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['t_delivery_handling_amount']->value;?>
</b></td>
                <td align='right' class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['t_other_tot_amount']->value;?>
</b></td>
                <td align="right" class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['tot_commission']->value;?>
</b></td>
                <td align="right" class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['tot_share']->value;?>
</b></td>
                <td align="right" class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['tot_paid']->value;?>
</b></td>
                <td align="right" class="bold" data-format="<?php echo $_smarty_tpl->tpl_vars['xlformat']->value['currency'];?>
"><b><?php echo $_smarty_tpl->tpl_vars['tot_topay']->value;?>
</b></td>
            </tr> 
        </tfoot>
    <?php } else { ?>
        <tfoot>
            <tr>
                <td colspan="31" align="center">No Records Found</td>
            </tr>
        </tfoot>
    <?php }?>
</table>                

<?php }
}
