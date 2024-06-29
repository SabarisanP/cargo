<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 13:00:05
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\recent-bookings-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665587fd4f28c3_49437367',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'ed4d0ea499ecab67532f021bd7758389378ae806' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\recent-bookings-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665587fd4f28c3_49437367 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="popup_top sticky-row-top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Recent Bookings</div>
        <div class="col-md-2"> 
            <a class="align-right" onclick="closeRecentBookings()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>            
        </div>
    </div>    
</div>

<div class="overflow-x-auto">
    <table id="recent_booking_report_table" class="table table-bordered">
        <thead>
            <tr class="success">
                <td align="center"><?php echo lang('cargo_code_term');?>
</td>
                <td align="center">Booked Date</td>
                <td align="center">No. Of Articles</td>
                <td align="center"><?php echo lang('booking_from_term');?>
</td>
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
                <td align="center">Payment Status</td>
                <td align="center">Cargo Status</td>
                <td align="center">Freight Amount</td>
                <td align="center">GST</td>
                <td align="center"><?php echo lang('other_charges');?>
</td>
                <td align="center">Net Payable</td>
            </tr>
        </thead>
        <tbody class="body_table">

            <?php $_smarty_tpl->_assignInScope('tot_fare', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_gst', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>
            <?php $_smarty_tpl->_assignInScope('tot_charges', 0);?>
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
                <tr>
                    <td align="center" nowrap><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                    <td align="left" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
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
                    <td align="center"><?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>

                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_amount);?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                    <td align="right" nowrap>
                        <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>



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
                            <tr>
                                <td>Handling Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
</td>
                            </tr>
                            <tr>
                                <td>GST</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->service_tax);?>
</td>
                            </tr>
                            <tr>
                                <td>Unloading Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount);?>
</td>
                            </tr>
                            <tr>
                                <td>Pickup Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount);?>
</td>
                            </tr>
                            <tr>
                                <td>Delivery Charges</td>
                                <td>&ensp;:&ensp;</td>
                                <td align="right"><i class="fa fa-rupee"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount);?>
</td>
                            </tr>


                                </table>
                        '></i>
                    </td>
                    <td align="right" nowrap>
                        <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>

                    </td>
                </tr>

                <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_gst', $_smarty_tpl->tpl_vars['tot_gst']->value+$_smarty_tpl->tpl_vars['row']->value->service_tax);?>
                <?php $_smarty_tpl->_assignInScope('tot_charges', $_smarty_tpl->tpl_vars['tot_charges']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+$_smarty_tpl->tpl_vars['row']->value->commission_amount);?>
            <?php
}
} else {
?>
                <tr>
                    <td colspan="15" align="center">No Records Found!</td>
                </tr>
            <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

            <?php if (count($_smarty_tpl->tpl_vars['result']->value)) {?>
                <tr class="active">
                    <td align="left" colspan="2"></td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</td>
                    <td align="left" colspan="7"></td>
    
                    <td align="right" class="bold">Total</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_fare']->value);?>
</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_gst']->value);?>
</td>
                    <td align='right' class="bold" nowrap><?php echo inr_format($_smarty_tpl->tpl_vars['tot_charges']->value);?>
 <i class="fa fa-info-circle invisible"></i></td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_payable']->value);?>
</td>
                </tr>                
            <?php }?>
        </tbody>
    </table>
</div>

<?php echo '<script'; ?>
>
    $('#recent_booking_report_table [data-toggle="popover"]').popover({
        placement: 'left',
        html: true,
        trigger: 'hover'
    });

    function closeRecentBookings() {
        $('#recent-bookings').dialog('destroy').hide();
    }
<?php echo '</script'; ?>
><?php }
}
