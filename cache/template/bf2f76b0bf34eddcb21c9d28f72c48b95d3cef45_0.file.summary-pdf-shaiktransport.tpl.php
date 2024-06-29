<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-12 11:03:04
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\summary-pdf-shaiktransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666933102ab197_83516311',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'bf2f76b0bf34eddcb21c9d28f72c48b95d3cef45' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\summary-pdf-shaiktransport.tpl',
      1 => 1718170353,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666933102ab197_83516311 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.capitalize.php','function'=>'smarty_modifier_capitalize',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<style>
    .h-seperator {
        border-bottom: 1px dashed #666;
        height: 0px;
    }

    .bordered {
        border: 0.2px solid #000;
    }

    .bordered td {
        border: 0.2px solid #000;
    }

    .valign-bottom {
        vertical-align: bottom;
    }

    .font-7 {
        font-size: 7px;
    }

    .font-10 {
        font-size: 10px;
    }

    .font-12 {
        font-size: 12px;
    }

    .font-14 {
        font-size: 14px;
    }

    .bold {
        font-weight: bold;
    }
</style>
<?php
$_smarty_tpl->tpl_vars['iter'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['iter']->step = 1;$_smarty_tpl->tpl_vars['iter']->total = (int) ceil(($_smarty_tpl->tpl_vars['iter']->step > 0 ? $_smarty_tpl->tpl_vars['no_of_copy']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['no_of_copy']->value)+1)/abs($_smarty_tpl->tpl_vars['iter']->step));
if ($_smarty_tpl->tpl_vars['iter']->total > 0) {
for ($_smarty_tpl->tpl_vars['iter']->value = 1, $_smarty_tpl->tpl_vars['iter']->iteration = 1;$_smarty_tpl->tpl_vars['iter']->iteration <= $_smarty_tpl->tpl_vars['iter']->total;$_smarty_tpl->tpl_vars['iter']->value += $_smarty_tpl->tpl_vars['iter']->step, $_smarty_tpl->tpl_vars['iter']->iteration++) {
$_smarty_tpl->tpl_vars['iter']->first = $_smarty_tpl->tpl_vars['iter']->iteration === 1;$_smarty_tpl->tpl_vars['iter']->last = $_smarty_tpl->tpl_vars['iter']->iteration === $_smarty_tpl->tpl_vars['iter']->total;?><table width="100%" class="border-collapse font-10"><tbody><tr><td colspan="2" align="center" class="font-10"><img src="assets/img/clientlogo/shaik-transport-logo.jpg" alt="logo" style="max-width: 100%;"><br><?php echo smarty_modifier_capitalize($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1);?>
, &nbsp;<?php echo smarty_modifier_capitalize($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2);?>
 <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
 &nbsp; | &nbsp; <span class="bold"> GST : <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->tax->gstin)) {?> <?php echo $_smarty_tpl->tpl_vars['summary']->value->tax->gstin;?>
 <?php } else { ?> 33AKQPJ1586N1ZK <?php }?> </span><br></td></tr><tr><td colspan="2"><table class="bordered" cellpadding="3"><tr><td><span class="bold font-10">LR.No : <?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
</span> <br>Date : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td><td><span class="bold font-10">From: </span> <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
,<?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;
}?><br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromStation->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td><td><span class="bold font-10">To: </span> <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
,<?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;
}?><br> <?php echo $_smarty_tpl->tpl_vars['summary']->value->toStation->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td></tr></table></td></tr><tr><td width="70%"> <br><br><?php $_smarty_tpl->_assignInScope('subtotal', 0);
$_smarty_tpl->_assignInScope('totalitems', 0);
$_smarty_tpl->_assignInScope('totalweight', 0);
$_smarty_tpl->_assignInScope('weightunit', '');
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
$_smarty_tpl->_assignInScope('totalitems', $_smarty_tpl->tpl_vars['totalitems']->value+$_smarty_tpl->tpl_vars['article']->value->itemCount);
$_smarty_tpl->_assignInScope('totalweight', $_smarty_tpl->tpl_vars['totalweight']->value+$_smarty_tpl->tpl_vars['article']->value->unitValue);
$_smarty_tpl->_assignInScope('weightunit', $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code]);
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?><table><tr><td><table class="bordered" cellpadding="3"><tr><td align="center">No.of Articles</td></tr><tr><td align="center"><?php echo $_smarty_tpl->tpl_vars['totalitems']->value;?>
</td></tr></table></td><td><table class="bordered" cellpadding="3"><tr><td align="center">Description</td></tr><tr><td align="center"><table><?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
?><tr align="center"><td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->name;?>
</td><td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td></tr><?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?></table></td></tr></table></td><td><table class="bordered" cellpadding="3"><tr><td align="center">Weight KGs</td></tr><tr><td align="center"><?php echo $_smarty_tpl->tpl_vars['totalweight']->value;?>
 <?php echo $_smarty_tpl->tpl_vars['weightunit']->value;?>
</td></tr></table></td></tr><tr><?php $_smarty_tpl->_assignInScope('invoiceDetail', explode("|",$_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'][0]->value));?><td class="bordered" cellpadding="3">Invoice No : <?php echo (($tmp = @$_smarty_tpl->tpl_vars['invoiceDetail']->value[1])===null||$tmp==='' ? '-' : $tmp);?>
 <br>Invoice Date : <?php echo (($tmp = @$_smarty_tpl->tpl_vars['invoiceDetail']->value[2])===null||$tmp==='' ? '-' : $tmp);?>
 <br>Invoice Value : <?php echo (($tmp = @$_smarty_tpl->tpl_vars['invoiceDetail']->value[0])===null||$tmp==='' ? '-' : $tmp);?>
</td><td colspan="2" class="bordered" align="center"><div class="h-seperator" style="padding-bottom: 3px;">At Owner's Risk</div><span>Undertaking charges payable by party</span><div class="bold" style="font-size: 12px;"> VALUE OF GOODS</div></td></tr></table><table cellpadding="3"><tr><td width="40%"><span class="bold">E-Way Bill : </span> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'][0]->referenceCode)===null||$tmp==='' ? '-' : $tmp);?>
</td><td align="center" class="font-14 bold"> <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['payment_type_name']->value, 'UTF-8');?>
 </td></tr></table></td><td width="30%"> <br><br><table cellpadding="2" class="bordered"><tr class="bold " align="center"><td>Particulars</td><td>Amount</td></tr><tr><td align="left">Freight</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount,2);?>
</td></tr><tr><td align="left">L Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);?>
</td></tr><?php if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0) {?><tr><td align="left">Pickup Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0) {?><tr><td align="left">Delivery Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0) {?><tr><td align="left">Hamali Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->passCharge > 0) {?><tr><td align="left">Pass Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0) {?><tr><td align="left">Docket Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);?>
</td></tr><?php }
if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH'])) {?><tr><td align="left">POD Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount > 0) {?><tr><td align="left">Unloading Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->serviceCharge > 0) {?><tr><td align="left">Service Charges</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceCharge,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue != 0) {?><tr><td align="left">CGST</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue != 0) {?><tr><td align="left">SGST</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue != 0) {?><tr><td align="left">UGST</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue,2);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue != 0) {?><tr><td align="left">IGST</td><td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue,2);?>
</td></tr><?php }?><tr class="bold " class="font-10"><td align="left" class="bold">Net Amount</td><td align="right" class="bold"><?php echo number_format(($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value),2);?>
</td></tr><tr class="bold " class="font-10"><td align="left" class="bold">Amount Paid</td><td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->paymentAmount,2);?>
</td></tr><?php $_smarty_tpl->_assignInScope('balance_to_pay', ($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount);
if ($_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?><tr class="font-10 bold"><td align="left" class="bold">TOTAL</td><td align="right" class="bold"><?php echo number_format($_smarty_tpl->tpl_vars['balance_to_pay']->value,2);?>
</td></tr><?php }?></table></td></tr><tr><td colspan="2"><table cellpadding="3" class="bordered"><tr><td><span class="bold"> Delivery Address : </span><br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2;?>
, <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>
</td><td align="center">For <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['namespace_name']->value, 'UTF-8');?>
 <br><br></td></tr></table></td></tr></tbody></table><?php if (count($_smarty_tpl->tpl_vars['terms_list']->value) > 0) {?><table width="100%" cellpadding="1"><tr class="success"><td class="bold">Terms & Conditions</td></tr><tbody class="body_table"><?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['terms_list']->value, 'term');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['term']->value) {
?><tr><td class="font-7" align="left"><?php echo $_smarty_tpl->tpl_vars['term']->value->name;?>
</td></tr><?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?><tr><td class="font-7" align="right">Powered By www.ezeecargo.com</td><tr></tbody></table><?php }
if ($_smarty_tpl->tpl_vars['iter']->value < 3) {?><div class="h-seperator"></div><div></div><?php }
}
}
}
}
