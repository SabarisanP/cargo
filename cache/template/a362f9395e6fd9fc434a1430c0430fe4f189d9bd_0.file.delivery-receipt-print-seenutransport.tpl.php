<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 16:01:41
  from 'E:\xampp\htdocs\cargo\application\views\site\payment\delivery-receipt-print-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d6d8dcdaa49_98316013',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'a362f9395e6fd9fc434a1430c0430fe4f189d9bd' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\payment\\delivery-receipt-print-seenutransport.tpl',
      1 => 1718447499,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d6d8dcdaa49_98316013 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<style>
    .bold {
        font-weight: bold;
    }

    .bordered,
    .bordered tr th,
    .bordered tr td {
        border: 1px solid #000000;
    }

    .title {
        font-weight: bold;
        text-align: center;
    }

    .bold {
        font-weight: bold;
    }

    .bolder {
        font-weight: 900;
    }

    .border-top {
        border-top: 1px solid #000;
    }

    .bordered td {
        border: 1px solid #000;
    }

    .border-bottom {
        border-bottom: 1px solid #000;
    }

    .dotted-border-bottom {
        border-bottom: 1px dashed #000;
    }

    .border-outline {
        border: 1px solid #000;
    }

    #tab-1,
    #tab-2 {
        table-layout: fixed;
        width: 100%;
    }

    .h-seperator {
        border-bottom: 1px dashed #666;
        height: 0px;
    }

</style>
<?php
$_smarty_tpl->tpl_vars['iter'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['iter']->step = 1;$_smarty_tpl->tpl_vars['iter']->total = (int) ceil(($_smarty_tpl->tpl_vars['iter']->step > 0 ? $_smarty_tpl->tpl_vars['no_of_copy']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['no_of_copy']->value)+1)/abs($_smarty_tpl->tpl_vars['iter']->step));
if ($_smarty_tpl->tpl_vars['iter']->total > 0) {
for ($_smarty_tpl->tpl_vars['iter']->value = 1, $_smarty_tpl->tpl_vars['iter']->iteration = 1;$_smarty_tpl->tpl_vars['iter']->iteration <= $_smarty_tpl->tpl_vars['iter']->total;$_smarty_tpl->tpl_vars['iter']->value += $_smarty_tpl->tpl_vars['iter']->step, $_smarty_tpl->tpl_vars['iter']->iteration++) {
$_smarty_tpl->tpl_vars['iter']->first = $_smarty_tpl->tpl_vars['iter']->iteration === 1;$_smarty_tpl->tpl_vars['iter']->last = $_smarty_tpl->tpl_vars['iter']->iteration === $_smarty_tpl->tpl_vars['iter']->total;
$_smarty_tpl->_assignInScope('transactionAmount', 0);
$_smarty_tpl->_assignInScope('extraCharges', false);
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->cargoTransactionList, 'SinglrList');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['SinglrList']->value) {
if ($_smarty_tpl->tpl_vars['SinglrList']->value->additionalAttribute->TRANSACTION_RECEIPT == $_smarty_tpl->tpl_vars['result']->value->code && $_smarty_tpl->tpl_vars['SinglrList']->value->transactionType->code == "MCHC") {
$_smarty_tpl->_assignInScope('transactionAmount', $_smarty_tpl->tpl_vars['transactionAmount']->value+$_smarty_tpl->tpl_vars['SinglrList']->value->transactionAmount);
$_smarty_tpl->_assignInScope('extraCharges', true);
}
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?><table class="border-outline" width="100%" cellspacing="0" cellpadding="0"><tr class="bold"><td width="25%" align="right"><br><br><br>&nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px"></td><td align="center" width="75%"><h2 style="font-size: 20px;"> Seenu Transports Pvt.Ltd. </h2><p style="font-size: 8px;"><b>Booking Branch : </b> <span style="font-size: 8px;color: #333232;"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value)) {
echo $_smarty_tpl->tpl_vars['summary']->value[0]->fromOrganization->address1;?>
,<?php echo $_smarty_tpl->tpl_vars['summary']->value[0]->fromOrganization->address2;
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value[0]->fromOrganization->contact)) {?> ,Ph :<?php echo $_smarty_tpl->tpl_vars['summary']->value[0]->fromOrganization->contact;
}
} else { ?>-<?php }?></span></p><p style="font-size: 8px;"><b>Delivery Branch : </b> <span style="font-size: 8px;color: #333232;"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value)) {
echo $_smarty_tpl->tpl_vars['summary']->value[0]->toOrganization->address1;?>
,<?php echo $_smarty_tpl->tpl_vars['summary']->value[0]->toOrganization->address2;
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value[0]->toOrganization->contact)) {?> ,Ph :<?php echo $_smarty_tpl->tpl_vars['summary']->value[0]->toOrganization->contact;
}
} else { ?>-<?php }?></span></p> <br></td></tr></table><table class="bordered" cellpadding="2"><tr style="background-color: #E8E8E8;"><td align="center" class="bold" style="font-size: 12px;" colspan="8">TAX INVOICE / CASH RECEIPT</td></tr><tr><td colspan="4"><b>Invoice No :</b>&nbsp;<?php echo $_smarty_tpl->tpl_vars['result']->value->code;?>
</td><td colspan="4"><b>Invoice Date :</b>&nbsp;<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['result']->value->transactionDate,"d-m-Y");?>
</td></tr><tr><td colspan="4"><b>GSTIN :</b> <?php echo $_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->gstin;?>
</td><td colspan="4"></td></tr><tr><td class="bold"><b>State</b></td><td><?php echo $_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->name;?>
</td><td class="bold"><b>Code</b></td><td><?php echo substr($_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->gstin,0,2);?>
</td><td colspan="4"><b>SAC Code :</b>&nbsp;996511</td></tr><tr style="background-color: #E8E8E8;"><td align="center" class="bold" colspan="4">Billed To Party</td><td align="center" class="bold" colspan="4">Shipped To Party</td></tr><tr><td colspan="4"><b>Name :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomer->name)===null||$tmp==='' ? '-' : $tmp);?>
</td><td colspan="4"><b>Name :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomer->name)===null||$tmp==='' ? '-' : $tmp);?>
</td></tr><tr><td colspan="4"><b>Address :</b> <?php echo $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerAddress->address2;?>
,<?php echo $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerAddress->pincode;?>
</td><td colspan="4"><b>Address :</b> <?php echo $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerAddress->address2;?>
,<?php echo $_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerAddress->pincode;?>
</td></tr><tr><td colspan="4"><b>GSTIN :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td><td colspan="4"><b>GSTIN :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td></tr><tr><td class="bold"><b>State</b></td><td><?php echo (($tmp = @$_smarty_tpl->tpl_vars['gst_state']->value[substr($_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerGST,0,2)])===null||$tmp==='' ? '-' : $tmp);?>
</td><td class="bold"><b>Code</b></td><td><?php echo (($tmp = @substr($_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerGST,0,2))===null||$tmp==='' ? '-' : $tmp);?>
</td><td class="bold"><b>State</b></td><td><?php echo (($tmp = @$_smarty_tpl->tpl_vars['gst_state']->value[substr($_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerGST,0,2)])===null||$tmp==='' ? '-' : $tmp);?>
</td><td class="bold"><b>Code</b></td><td><?php echo (($tmp = @substr($_smarty_tpl->tpl_vars['ReceiptLr']->value[0]->toCustomerGST,0,2))===null||$tmp==='' ? '-' : $tmp);?>
</td></tr></table><br /><br /><table class="bordered" cellpadding="2" id="tab-2" width="100%"><thead><tr style="font-weight:bold; background-color: #E8E8E8;"><th align="center" width="8%" rowspan="2">Sl No</th><th align="center" width="16%" rowspan="2" nowrap><?php echo lang('lr');?>
 No</th><th align="center" width="12%" rowspan="2">LR Date</th><th align="center" width="12%" rowspan="2"><?php echo lang('booking_from_term');?>
</th><th align="center" width="12%" rowspan="2"><?php echo lang('booking_to_label');?>
</th><th align="center" width="16%" rowspan="2">Mode of Payment</th><th align="center" width="12%" rowspan="2">Amt.</th><th align="center" width="12%" rowspan="2">Total Amt.</th></tr></thead><?php $_smarty_tpl->_assignInScope('total', 0);
$_smarty_tpl->_assignInScope('total_amt', 0);
$_smarty_tpl->_assignInScope('total_lr_amt', 0);
$_smarty_tpl->_assignInScope('total_lr', 0);
$_smarty_tpl->_assignInScope('k', 0);
$_smarty_tpl->_assignInScope('lr_net_amount', $_smarty_tpl->tpl_vars['lr_net_amount']->value);
$_smarty_tpl->_assignInScope('total_amts', 0);
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ReceiptLr']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
$_smarty_tpl->_assignInScope('rounf_off_val', 0);
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row']->value->cargoAddonsDetails, 'keys');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['keys']->value) {
if ($_smarty_tpl->tpl_vars['keys']->value->addonsType->code == "RNDF") {
$_smarty_tpl->_assignInScope('rounf_off_val', $_smarty_tpl->tpl_vars['rounf_off_val']->value+$_smarty_tpl->tpl_vars['keys']->value->value);
break 1;
}
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
$_smarty_tpl->_assignInScope('lr_net_amount', $_smarty_tpl->tpl_vars['lr_net_amount']->value+($_smarty_tpl->tpl_vars['row']->value->totalAmount+$_smarty_tpl->tpl_vars['row']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->docketCharge+$_smarty_tpl->tpl_vars['row']->value->passCharge+$_smarty_tpl->tpl_vars['row']->value->hamaliCharge+$_smarty_tpl->tpl_vars['row']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['other_ch_amount']->value));
$_smarty_tpl->_assignInScope('total_amts', $_smarty_tpl->tpl_vars['total_amts']->value+($_smarty_tpl->tpl_vars['row']->value->paymentAmount));?><tr><th align="center" width="8%"><?php echo $_smarty_tpl->tpl_vars['k']->value+1;?>
</th><td align="left" width="16%" nowrap><?php echo $_smarty_tpl->tpl_vars['row']->value->code;?>
</td><td align="left" width="12%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->bookedAt,"d-m-Y");?>
</td><td align="left" width="12%"><?php echo $_smarty_tpl->tpl_vars['row']->value->fromOrganization->shortCode;?>
</td><td align="left" width="12%"><?php echo $_smarty_tpl->tpl_vars['row']->value->toOrganization->shortCode;?>
</td><td align="center" width="16%"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->paymentType->code];?>
</td><td align="right" width="12%"><?php echo amountToRupeesPaise(($_smarty_tpl->tpl_vars['row']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->hamaliCharge+$_smarty_tpl->tpl_vars['row']->value->passCharge+$_smarty_tpl->tpl_vars['row']->value->docketCharge+$_smarty_tpl->tpl_vars['row']->value->totalAmount+$_smarty_tpl->tpl_vars['row']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->totalUnloadHandlingAmount),'RUPEES');?>
</td><td align="right" width="12%"><?php echo amountToRupeesPaise(($_smarty_tpl->tpl_vars['row']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->hamaliCharge+$_smarty_tpl->tpl_vars['row']->value->passCharge+$_smarty_tpl->tpl_vars['row']->value->docketCharge+$_smarty_tpl->tpl_vars['row']->value->totalAmount+$_smarty_tpl->tpl_vars['row']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->totalUnloadHandlingAmount),'RUPEES');?>
</td></tr><?php $_smarty_tpl->_assignInScope('total_lr_amt', $_smarty_tpl->tpl_vars['total_lr_amt']->value+($_smarty_tpl->tpl_vars['row']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->hamaliCharge+$_smarty_tpl->tpl_vars['row']->value->passCharge+$_smarty_tpl->tpl_vars['row']->value->docketCharge+$_smarty_tpl->tpl_vars['row']->value->totalAmount+$_smarty_tpl->tpl_vars['row']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['row']->value->totalUnloadHandlingAmount));
$_smarty_tpl->_assignInScope('k', $_smarty_tpl->tpl_vars['k']->value+1);
}
} else {
?><tr><td colspan="7" align="center" class="bordered">No Records Found!</td></tr><?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?></table><?php $_smarty_tpl->_assignInScope('net_total', $_smarty_tpl->tpl_vars['net_total']->value+($_smarty_tpl->tpl_vars['total_lr_amt']->value+$_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge+$_smarty_tpl->tpl_vars['result']->value->demurrageCharge+$_smarty_tpl->tpl_vars['rounf_off_val']->value));
if (($_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD") && $_smarty_tpl->tpl_vars['extraCharges']->value) {
$_smarty_tpl->_assignInScope('net_total', 0);
$_smarty_tpl->_assignInScope('net_total', (($_smarty_tpl->tpl_vars['net_total']->value+$_smarty_tpl->tpl_vars['transactionAmount']->value)));
}?><table id="tab-1" style="border-top: 1px solid #000; border-bottom: 1px solid #000; border-left: 1px solid #000;" width="100%"><tr><td colspan="5"><table style="padding:5px 4px;"><tr><td colspan="4"></td></tr><tr><td colspan="4"></td></tr><tr><td class="bold">Freight on W/B No.</td><td class="dotted-border-bottom blod"><b><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->code;?>
</b></td><td class="bold" align="right">Date :</td><td class="dotted-border-bottom blod"><b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->bookedAt,"d-m-Y");?>
</b></td></tr><tr><td class="bold">No. of Days</td><td class="dotted-border-bottom"><?php if ($_smarty_tpl->tpl_vars['result']->value->demurrageCharge > 0) {?>10<?php }?></td><td class="bold" align="right">Demurrage Charge :</td><td class="dotted-border-bottom"><?php echo inr_format($_smarty_tpl->tpl_vars['result']->value->demurrageCharge);?>
</td></tr><tr><td class="bold">Add Other Charges</td>                                                <td class="dotted-border-bottom" colspan="1" align = "center"><?php echo inr_format($_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge);?>
</td><td class="dotted-border-bottom" colspan="2" align = "left"><b><?php if (($_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge > 0 || $_smarty_tpl->tpl_vars['transactionAmount']->value > 0)) {?>(Machine Handling Charge)<?php }?></b></td>                </tr><tr><td class="bold">Less Other Charges</td><td class="dotted-border-bottom" colspan="3"></td></tr><tr><td class="bold">TDS LESS AMOUNT</td><td class="dotted-border-bottom blod" colspan="3"><b><?php echo inr_format($_smarty_tpl->tpl_vars['result']->value->tdsAmount);?>
</b></td></tr><tr><td class=" bold">TAXABLE VALUE :</td><td class=" bold dotted-border-bottom" align="center"> <?php echo inr_format(($_smarty_tpl->tpl_vars['net_total']->value));?>
</td><td align="right" colspan="2" class="bold">Total</td></tr><?php if ($_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->state->code == $_smarty_tpl->tpl_vars['Gststate']->value) {?><tr><td align="right" colspan="4" class="bold">GST on CGST &nbsp;<b>(2.5%)</b></td></tr><tr><td align="right" colspan="4" class="bold">GST on SGST &nbsp;<b>(2.5%)</b></td></tr><?php } else { ?><tr><td align="right" colspan="4" class="bold">GST on IGST <b>(5%)</b></td></tr><?php }?>&nbsp; &nbsp; &nbsp; &nbsp;</table></td><td colspan="2"><table style="padding:5px 5px;" class="bordered"><tr class="bold"><td colspan="2" align="center">Amount : <?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD" && $_smarty_tpl->tpl_vars['extraCharges']->value ? (amountToRupeesPaise($_smarty_tpl->tpl_vars['transactionAmount']->value,'RUPEES')) : (amountToRupeesPaise($_smarty_tpl->tpl_vars['total_lr_amt']->value,'RUPEES'));?>
</td></tr><tr class="bold"><td align="center">Rs.</td><td align="center">P.</td></tr><tr><td align="right"><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD" && $_smarty_tpl->tpl_vars['extraCharges']->value ? (amountToRupeesPaise(0,'RUPEES')) : (amountToRupeesPaise($_smarty_tpl->tpl_vars['total_lr_amt']->value,'RUPEES'));?>
</td><td align="right"><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD" && $_smarty_tpl->tpl_vars['extraCharges']->value ? (amountToRupeesPaise(0,'RUPEES')) : (amountToRupeesPaise(($_smarty_tpl->tpl_vars['result']->value->transactionAmount+$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'PAISE'));?>
</td></tr><tr><td align="right"><?php echo amountToRupeesPaise($_smarty_tpl->tpl_vars['result']->value->demurrageCharge,'RUPEES');?>
</td><td align="right"><?php echo amountToRupeesPaise($_smarty_tpl->tpl_vars['result']->value->demurrageCharge,'PAISE');?>
</td></tr><tr>                    <td align="right"><?php echo amountToRupeesPaise($_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge,'RUPEES');?>
</td><td align="right"><?php echo amountToRupeesPaise($_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge,'PAISE');?>
</td>                </tr><tr><td align="right">00</td><td align="right">00</td></tr><tr><td align="right"><?php echo amountToRupeesPaise($_smarty_tpl->tpl_vars['result']->value->tdsAmount,'RUPEES');?>
</td><td align="right"><?php echo amountToRupeesPaise($_smarty_tpl->tpl_vars['result']->value->tdsAmount,'PAISE');?>
</td></tr><tr><?php if (($_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD" && $_smarty_tpl->tpl_vars['extraCharges']->value)) {?><td align="right" class="bold" style="font-size: 9px;"><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD" && $_smarty_tpl->tpl_vars['extraCharges']->value ? (amountToRupeesPaise(($_smarty_tpl->tpl_vars['net_total']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'RUPEES')) : (amountToRupeesPaise($_smarty_tpl->tpl_vars['net_total']->value,'RUPEES'));?>
</td><td align="right" class="bold" style="font-size: 9px;"><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD" && $_smarty_tpl->tpl_vars['extraCharges']->value ? (amountToRupeesPaise(($_smarty_tpl->tpl_vars['net_total']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'PAISE')) : (amountToRupeesPaise($_smarty_tpl->tpl_vars['net_total']->value,'PAISE'));?>
</td><?php } else { ?><td align="right" class="bold" style="font-size: 9px;"><?php echo amountToRupeesPaise(($_smarty_tpl->tpl_vars['total_lr_amt']->value+$_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge+$_smarty_tpl->tpl_vars['result']->value->demurrageCharge+$_smarty_tpl->tpl_vars['rounf_off_val']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'RUPEES');?>
</td><td align="right" class="bold" style="font-size: 9px;"><?php echo amountToRupeesPaise(($_smarty_tpl->tpl_vars['total_lr_amt']->value+$_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge+$_smarty_tpl->tpl_vars['result']->value->demurrageCharge+$_smarty_tpl->tpl_vars['rounf_off_val']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'PAISE');?>
</td><?php }?></tr><?php if ($_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->state->code == $_smarty_tpl->tpl_vars['Gststate']->value) {?><tr><td align="center" class="bold" style="font-size: 9px;" colspan="2"><b><?php echo $_smarty_tpl->tpl_vars['net_total']->value*2.5/number_format(100,2);?>
</b></td></tr><tr><td align="center" class="bold" style="font-size: 9px;" colspan="2"><b><?php echo $_smarty_tpl->tpl_vars['net_total']->value*2.5/number_format(100,2);?>
</b></td></tr><?php } else { ?><tr><td align="center" colspan="2"><b><?php echo $_smarty_tpl->tpl_vars['net_total']->value*5/number_format(100,2);?>
</b></td></tr><?php }?></table></td></tr></table><br /><br /><table><tr><td width="70%"><table style="padding:5px 4px;"><tr><td colspan="3">Receipt No :&nbsp;<b><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->additionalAttribute->VOUCHER_NUMBER;?>
</b></td></tr><tr><td colspan="3">Received From : &nbsp;<b><?php echo $_smarty_tpl->tpl_vars['result']->value->cargoCustomer->name;?>
</b></td><td class=""></td><td class=""></td><td class=""></td></tr><tr><td class="" <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "CASH") {?> width="50%" <?php }?> <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "UPI") {?> width="70%" <?php }?> <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "NBK") {?> width="70%" <?php }?> <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "CHEQUE") {?> width="70%" <?php }?> class="bordered" colspan="3">Mode Of Payment : &nbsp;<b><?php echo $_smarty_tpl->tpl_vars['result']->value->transactionMode->name;?>
</b> <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "CHEQUE") {?>( Cheque No - <?php echo $_smarty_tpl->tpl_vars['result']->value->chequeDetails->chequeNo;?>
 ) <?php }?> <?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "NBK") {?>( Ref No - <?php echo $_smarty_tpl->tpl_vars['result']->value->addAttr3;?>
 ) <?php }
if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "UPI") {?>( UPI ID - <?php echo $_smarty_tpl->tpl_vars['result']->value->addAttr1;?>
 ) <?php }?> </td><td class="" width="20%" align=""></td><td class="" width="30%"></td><td class="" width="10%"></td></tr><?php if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "NBK") {?><tr><td class="" colspan="3">Bank Name : <b><?php echo $_smarty_tpl->tpl_vars['result']->value->addAttr2;?>
</b></td><td class=""></td><td class=""></td><td class=""></td></tr><?php }
if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "CHEQUE") {?><tr><td class="" colspan="3">Bank Name :&nbsp;<b><?php echo $_smarty_tpl->tpl_vars['result']->value->chequeDetails->bankDetails;?>
 <?php echo $_smarty_tpl->tpl_vars['result']->value->chequeDetails->bankCity;?>
</b></td><td class=""></td><td class=""></td><td class=""></td></tr><?php }
if ($_smarty_tpl->tpl_vars['result']->value->transactionMode->code == "CHEQUE") {?><tr><td class="" colspan="3">Dated : &nbsp;<b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['result']->value->chequeDetails->chequeDate,"d-m-Y");?>
</b></td><td class=""></td><td class=""></td><td class=""></td></tr><?php } else { ?><tr><td class="" colspan="3">Dated : &nbsp;<b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['result']->value->transactionDate,"d-m-Y");?>
</b></td><td class=""></td><td class=""></td><td class=""></td></tr><?php }?><tr><?php if (($_smarty_tpl->tpl_vars['result']->value->cargoBookings[0]->paymentType->code == "PAD") && $_smarty_tpl->tpl_vars['extraCharges']->value) {?><td class="" colspan="5">Received Amount (Rs) :&nbsp;<b><?php echo amountToRupeesPaise(($_smarty_tpl->tpl_vars['net_total']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'RUPEES');?>
 / <?php echo ucwords(amount_in_words(($_smarty_tpl->tpl_vars['net_total']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount)));?>
 Only </b></td><?php } else { ?><td class="" colspan="5">Received Amount (Rs) :&nbsp;<b><?php echo amountToRupeesPaise(($_smarty_tpl->tpl_vars['total_lr_amt']->value+$_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge+$_smarty_tpl->tpl_vars['result']->value->demurrageCharge+$_smarty_tpl->tpl_vars['rounf_off_val']->value-$_smarty_tpl->tpl_vars['result']->value->tdsAmount),'RUPEES');?>
 / <?php echo ucwords(amount_in_words(($_smarty_tpl->tpl_vars['total_lr_amt']->value+$_smarty_tpl->tpl_vars['result']->value->machineHandlingCharge+$_smarty_tpl->tpl_vars['result']->value->demurrageCharge-$_smarty_tpl->tpl_vars['result']->value->tdsAmount)));?>
 Only </b></td><?php }?><td class=" blod " align="left"></td><td class=""></td><td class=""></td></tr></table></td><td width="30%"><table><tr><td align="right">Date : </td><td align="left"><b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['result']->value->transactionDate,"d-m-Y");?>
</b></td></tr></table><br><br><table class="bordered" cellpadding="2"><tr><td class="bold" style="font-size: 7px;">Ceritified that the particulars given above are true and correct</td></tr><tr><td align="center" class="bold" style="font-size: 9px;">For Seenu Transports Pvt Ltd.<br><br></td></tr><tr><td align="center" class="bold">Authorised Signatory</td></tr></table></td></tr></table><br> <br>
<table>
    <tr>
        <td width="100%">
            <table cellpadding="2" style="border:1px soild #000;">
                <tr>
                    <td class="bold" style="font-size: 7px;"> <b>Declaration for E-Invoicing Exemption:</b></td>
                </tr>
                <tr>
                    <td class="bold"> &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 6px;">We hereby declare that the GSTIN: <?php echo $_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->gstin;?>
 SEENU TRANSPORTS PVT LTD is exempt from preparing an invoice in terms of Rule 48(4) of CGST Rules 2017.</span></td>
                </tr>
                <tr>
                    <td class="bold" style="font-size: 7px;"> <b> Exemption Category :</b></td>
                </tr>
                <tr>
                    <td class="bold"> &nbsp;&nbsp;&nbsp;&nbsp; <span style="font-size: 6px;"> Goods Transport Agency supplying services in relation to transportation of goods by road in a goods carriage (13/2020-Central Tax dated 21st march 2020) </span></td>
                </tr>
                <tr>
                    <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp;<b>Note :</b> TDS Applicable @2% U/S 194C of I.T act</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
<?php }
}
}
}
