<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-14 13:12:54
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\users-commissions.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666bf47e037063_68492712',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'e4c86700adc0ad877f5209c51857a250cbe25ea1' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\users-commissions.tpl',
      1 => 1718350165,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666bf47e037063_68492712 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="table-responsive">
    <table id="cargo_comm_table" class="table table-striped table-bordered">
        <thead>
            <tr>
                <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->captureStateWiseCommissionFlag) {?>
                    <th rowspan="2" class="valign-bottom">State</th>
                <?php }?>
                <th colspan="5" class="text-center">Booking Commissions</th>
                <th colspan="5" class="text-center">Delivery Commissions</th>
                <th rowspan="2" class="valign-bottom">Credit Limit</th>
                <th rowspan="2" width="60"></th>
            </tr>
            <tr>
                <th>Paid <?php echo lang('lr');?>
</th>
                <th>ToPay <?php echo lang('lr');?>
</th>
                <th>AccPay <?php echo lang('lr');?>
</th>
                <th>Door Pickup</th>
                <th>Loading Share</th>
                <th>Paid <?php echo lang('lr');?>
</th>
                <th>ToPay <?php echo lang('lr');?>
</th>
                <th>AccPay <?php echo lang('lr');?>
</th>
                <th>Door Delivery</th>
                <th>Unloading Share</th>
            </tr>
        </thead>
        <tbody class="body_table">
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php if (!$_smarty_tpl->tpl_vars['cargo_setting']->value->captureStateWiseCommissionFlag && isNotNull($_smarty_tpl->tpl_vars['row']->value->state->code)) {?>
                    <?php continue 1;?>
                <?php }?>
                <tr>
                    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->captureStateWiseCommissionFlag) {?>
                        <td><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->state->name)===null||$tmp==='' ? 'Default' : $tmp);?>
</td>
                    <?php }?>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->paidCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->paidCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->paidCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->paidCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->toPayCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->toPayCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->toPayCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->toPayCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->accPayCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->accPayCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->accPayCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->accPayCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->doorPickupCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->doorPickupCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->doorPickupCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->doorPickupCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->loadingCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->loadingCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->loadingCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->loadingCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->deliveryPaidCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->delivaryPaidCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->deliveryPaidCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->delivaryPaidCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->deliveryTopayCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->delivaryTopayCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->deliveryTopayCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->delivaryTopayCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->deliveryAccpayCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->delivaryAccpayCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->deliveryAccpayCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->delivaryAccpayCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->doorDeliveryCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->doorDeliveryCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->doorDeliveryCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->doorDeliveryCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->unloadingCommissionTypeCode == 'PER') {?>
                            <?php echo $_smarty_tpl->tpl_vars['row']->value->unloadingCommissionValue;?>
 %
                        <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->unloadingCommissionTypeCode == 'FLT') {?>
                            Rs. <?php echo $_smarty_tpl->tpl_vars['row']->value->unloadingCommissionValue;?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td align="right" nowrap>
                        <?php echo $_smarty_tpl->tpl_vars['row']->value->creditLimit;?>

                    </td>
                    <td align="center">
                        <a class="edit" title="Edit" href="javascript:;" onclick="commissionsDialog(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['row']->value), ENT_QUOTES, 'UTF-8', true);?>
)"><i class="fa fa-pencil fa-lg"></i></a>&nbsp;
                        <a class="delete" title="Delete" href="javascript:;" onclick="deleteUserCommissions(<?php echo htmlspecialchars(json_encode($_smarty_tpl->tpl_vars['row']->value), ENT_QUOTES, 'UTF-8', true);?>
, '<?php echo $_smarty_tpl->tpl_vars['userCode']->value;?>
')"><i class="fa fa-trash-o fa-lg"></i></a>
                    </td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
    </table>
</div>
<?php }
}
