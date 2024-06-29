<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 15:03:59
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\generate-invoice-list.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6672a60751d9c7_47038300',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '7ac95219cb7b05d8a774da30875b032dd5b9d45b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\generate-invoice-list.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6672a60751d9c7_47038300 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'vendor', false, 'vendorkey');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['vendorkey']->value => $_smarty_tpl->tpl_vars['vendor']->value) {
?>
    <div class="row bg-info">
        <div class="col-md-8">
            <div class="col-md-4"><h5><b><?php echo $_smarty_tpl->tpl_vars['vendorkey']->value;?>
</b></h5></div>
            <div class="col-md-3 p-y-10 bold text-center" title="Total <?php echo count($_smarty_tpl->tpl_vars['vendor']->value['data']);?>
 LR"><span id="<?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
-lr-count"><?php echo count($_smarty_tpl->tpl_vars['vendor']->value['data']);?>
</span> Selected</div>
            <div class="col-md-3 p-y-10 bold text-center">Rs. <span id="<?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
"><?php echo number_format($_smarty_tpl->tpl_vars['vendor']->value['total'],2,'.','');?>
</span></div>
            <div class="col-md-2 m-t-4">
                <button type="button" class="btn btn-success pull-right btn-sm" onclick="invoicePopup('<?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
', '<?php echo $_smarty_tpl->tpl_vars['vendorkey']->value;?>
');">Generate Invoice</button>
            </div>
        </div>
    </div>
    <div class="clearfix"></div><br/>
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
                <tr class="bold">
                    <th class="text-center"><input type="checkbox" class="gen_invoice_checkall <?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
" data-vendor="<?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
" checked></th>
                    <th align="center"><?php echo lang('lr');?>
 No</th>
                    <th align="center">Booked Date</th>
                    <th align="center">Booked by</th>
                    <th align="center"><?php echo lang('booking_from_term');?>
</th>
                    <th align="center"><?php echo lang('booking_to_label');?>
</th>
                    <th align="center">Payment Status</th>
                    <th align="center">Cargo Status</th>
                    <th align="center">Qty</th>
                    <th align="center">Payable</th>
                </tr>
            </thead>
            <tbody class="body_table">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['vendor']->value['data'], 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <tr>
                        <td align="center"><input type="checkbox" class="gen_invoice_check <?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
" value="<?php echo $_smarty_tpl->tpl_vars['row']->value->transaction_code;?>
" data-vendor="<?php echo $_smarty_tpl->tpl_vars['vendor']->value['vendor_code'];?>
" data-payable="<?php echo $_smarty_tpl->tpl_vars['row']->value->total_amount;?>
" checked></td>
                        <td align="left"><a href='javascript:;' title="more details" onclick='getCargoDetails("<?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
");'><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</a></td>
                        <td align="left"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->user_first_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->from_station_name;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->to_station_name;?>
</td>
                        <td align="left">
                            <?php echo _cargo_payment_status_badge($_smarty_tpl->tpl_vars['row']->value->payment_status_code);?>

                        </td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['cargo_status']->value[$_smarty_tpl->tpl_vars['row']->value->cargo_status_code];?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
</td>
                        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['row']->value->total_amount,2);?>
</td>
                    </tr>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
        </table>
    </div>
<?php
}
} else {
?>
    <div class="well well-large"> No Transactions found.</div>
<?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

<?php echo '<script'; ?>
>
    $('.gen_invoice_check').on('change', function () {
        var $ele = $(this);
        var vendor = $('#' + $ele.data('vendor'));
        var pble = parseFloat($ele.data('payable'));

        if ($(this).is(':checked')) {
            vendor.html((parseFloat(vendor.html()) + pble).toFixed(2));
        } else {
            vendor.html((parseFloat(vendor.html()) - pble).toFixed(2));
        }
        
        $('#' + $ele.data('vendor') + '-lr-count').html($('.gen_invoice_check.' + $ele.data('vendor') + ':checked').length);
    });
    
    $('.gen_invoice_checkall').on('change', function () {
        var $ele = $(this);
        
        $('.gen_invoice_check.' + $ele.data('vendor'))
            .filter($ele.is(':checked') ? ':not(:checked)' : ':checked')
            .prop('checked', $ele.is(':checked'))
            .trigger('change');
    });
<?php echo '</script'; ?>
><?php }
}
