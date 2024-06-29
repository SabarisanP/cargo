<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:33:44
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\transitv3-loaded-ogpl-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e1b0b19b16_98980056',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'daa5c0892f4b735afbd6d95257182e81639f2e28' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\transitv3-loaded-ogpl-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e1b0b19b16_98980056 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table id="transitv3-loaded-lr-table" class="table table-bordered " style="width:99%" >
    <thead>
        <tr class="success">
            <td align="center">
                <input type="checkbox" onchange="selectAllBooking(this);"/>
            </td>
            <td align="center"><?php echo lang('lr');?>
 No</td>
            <td align="center">Booked Date</td>
            <td align="center">Booked by</td>
            <td align="center"><?php echo lang('booking_from_term');?>
</td>
            <td align="center"><?php echo lang('booking_to_label');?>
</td>
            <td align="center"><?php echo lang('booking_sender_term');?>
</td>
            <td align="center"><?php echo lang('booking_receiver_term');?>
</td>
            <td align="center">Payment Status</td>
            <td align="center">Cargo Status</td>
            <td align="center">Items</td>
            <td align="center">Qty</td>
            <td align="center">Payable</td>
        </tr>
    </thead>
    <tbody class="body_table" id="load-transitv3-list">
        <?php $_smarty_tpl->_assignInScope('loaded_count', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
            <tr>
                <td align="center" colspan="15" class="bold"><?php echo $_smarty_tpl->tpl_vars['t1']->value;?>
</td>
            </tr>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="center">
                        <input type="checkbox" class="transitv3-loaded-items" 
                            data-from="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transit_from_station_code)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->from_station_code : $tmp);?>
" 
                            data-to="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transit_to_station_code)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->to_station_code : $tmp);?>
" 
                            data-fromorg="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transit_from_organization_code)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->from_organization_code : $tmp);?>
" 
                            data-toorg="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transit_to_organization_code)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->to_organization_code : $tmp);?>
"
                            data-transittype="<?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transit_details_type)===null||$tmp==='' ? $_smarty_tpl->tpl_vars['row']->value->transit_details_type : $tmp);?>
"
                            value="<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
" />
                    </td>
                    <td align="center"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
")'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                    <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_mobile;?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_mobile;?>
</td>
                    <td align="center">
                        <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                    </td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                    <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                    <td align="right"><?php echo number_format(($_smarty_tpl->tpl_vars['row']->value->total_booking_amount+$_smarty_tpl->tpl_vars['row']->value->total_unload_handling_amount+$_smarty_tpl->tpl_vars['row']->value->total_handing_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->service_tax),2);?>
</td>
                </tr>
                <?php $_smarty_tpl->_assignInScope('loaded_count', $_smarty_tpl->tpl_vars['loaded_count']->value+1);?>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    </tbody>
</table>

<?php echo '<script'; ?>
>
    var loadedLrCount = <?php echo json_encode($_smarty_tpl->tpl_vars['loaded_count']->value);?>
;
    function selectAllBooking(cb) {
        var $cb = $(cb);

        $('.transitv3-loaded-items')
                .filter($cb.is(':checked') ? ':not(:checked)' : ':checked')
                .prop('checked', $cb.is(':checked'))
                .trigger('change');
    }
<?php echo '</script'; ?>
><?php }
}
