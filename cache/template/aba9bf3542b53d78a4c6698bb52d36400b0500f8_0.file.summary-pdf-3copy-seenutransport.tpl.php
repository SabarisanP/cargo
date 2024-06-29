<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 14:54:57
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\summary-pdf-3copy-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d5de99aff55_32942312',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'aba9bf3542b53d78a4c6698bb52d36400b0500f8' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\summary-pdf-3copy-seenutransport.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d5de99aff55_32942312 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<style>
    .border-top {
        border-top: 1px solid #666;
    }

    .border-right {
        border-right: 1px solid #666;
    }

    .border-bottom {
        border-bottom: 1px solid #666;
    }

    .border-left {
        border-left: 1px solid #666;
    }

    .font-10 {
        font-size: 10px;
    }

    .heading {
        font-size: 11px;
        text-decoration: underline;
    }

    .bold {
        font-weight: bold;
    }
    .border-size {
    line-height: 1.1;
  
}
.spacer td {
    font-size:8.2px;
}


</style>

<?php
$_smarty_tpl->tpl_vars['iter'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['iter']->step = 1;$_smarty_tpl->tpl_vars['iter']->total = (int) ceil(($_smarty_tpl->tpl_vars['iter']->step > 0 ? $_REQUEST['count']+1 - (1) : 1-($_REQUEST['count'])+1)/abs($_smarty_tpl->tpl_vars['iter']->step));
if ($_smarty_tpl->tpl_vars['iter']->total > 0) {
for ($_smarty_tpl->tpl_vars['iter']->value = 1, $_smarty_tpl->tpl_vars['iter']->iteration = 1;$_smarty_tpl->tpl_vars['iter']->iteration <= $_smarty_tpl->tpl_vars['iter']->total;$_smarty_tpl->tpl_vars['iter']->value += $_smarty_tpl->tpl_vars['iter']->step, $_smarty_tpl->tpl_vars['iter']->iteration++) {
$_smarty_tpl->tpl_vars['iter']->first = $_smarty_tpl->tpl_vars['iter']->iteration === 1;$_smarty_tpl->tpl_vars['iter']->last = $_smarty_tpl->tpl_vars['iter']->iteration === $_smarty_tpl->tpl_vars['iter']->total;
$_smarty_tpl->_assignInScope('actualWeight', array());
$_smarty_tpl->_assignInScope('chargedWeight', array());
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
$_tmp_array = isset($_smarty_tpl->tpl_vars['actualWeight']) ? $_smarty_tpl->tpl_vars['actualWeight']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['article']->value->unit->code] = $_smarty_tpl->tpl_vars['actualWeight']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code]+$_smarty_tpl->tpl_vars['article']->value->actualUnitValue;
$_smarty_tpl->_assignInScope('actualWeight', $_tmp_array);
$_tmp_array = isset($_smarty_tpl->tpl_vars['chargedWeight']) ? $_smarty_tpl->tpl_vars['chargedWeight']->value : array();
if (!is_array($_tmp_array) || $_tmp_array instanceof ArrayAccess) {
settype($_tmp_array, 'array');
}
$_tmp_array[$_smarty_tpl->tpl_vars['article']->value->unit->code] = $_smarty_tpl->tpl_vars['chargedWeight']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code]+$_smarty_tpl->tpl_vars['article']->value->unitValue;
$_smarty_tpl->_assignInScope('chargedWeight', $_tmp_array);
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?><br><table width="100%"><tr><td class="bold heading" align="center">Consignment Receipt</td></tr></table><table width="100%" cellpadding="2">            <tr><td width="63%" colspan="8"><br><br><br><br>                </td><td class="border-right" width="11%" rowspan="2"><img src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
qr?data=<?php echo $_smarty_tpl->tpl_vars['summary']->value->additionalAttribute->SLUG;?>
&size=10" width="65px"></td><td colspan="3" rowspan="2" width="26%"><table style="line-height: 19px;"><tr><td class="bold" width="25%">Branch</td><td width="75%">:&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->shortCode;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->shortCode;?>
</td></tr><tr><td class="bold" width="25%">LR No.</td><td class="bold" width="75%">:&nbsp;<?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
</td></tr><tr><td class="bold" width="25%">Date</td><td width="75%">:&nbsp;<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td></tr></table></td></tr><tr class="bold"><td colspan="3">GSTIN: <?php echo $_smarty_tpl->tpl_vars['gst_no']->value;?>
</td><td colspan="2">SAC CODE: 996511</td><td colspan="3">PAN: AAUCS4702J</td></tr><tr><td class="bold border-top border-right" align="center" colspan="3">Booking Office</td><td class="bold border-top border-right" align="center" colspan="3">Consignor</td><td class="bold border-top border-right" align="center" colspan="3">Consignee</td><td class="bold border-top" align="center" colspan="3">Delivery To/Shipped To</td></tr><tr class="spacer"><td class="border-top border-right border-size font-size" colspan="3"><b><?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name));?>
</b><br><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
,<?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2;?>
<br><?php }
echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
<br><?php if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1)) {?><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2)) {?><br><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact)) {?><br><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'PUDO' || $_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'PDDO') {?>&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #e7e6e3;color: #000"> Door Pickup </span><?php }?></td><td class="border-top border-right border-size" colspan="3" ><b><?php echo ucwords(strtolower(substr($_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name,0,50)));?>
</b><br><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;?>
, <?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address2)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address2;?>
<br><?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
, <?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode)) {
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;?>
<br><?php }?>Ph.No: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber)===null||$tmp==='' ? '-' : $tmp);?>
<br />GST: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST)===null||$tmp==='' ? '-' : $tmp);
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1)) {?><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address2)) {?><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark) && !isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode)) {?><br><?php }?></td><td class="border-top border-right border-size" colspan="3"><b><?php echo ucwords(strtolower(substr($_smarty_tpl->tpl_vars['summary']->value->toCustomer->name,0,50)));?>
</b><br><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;?>
, <?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address2)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address2;?>
<br><?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
, <?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;
}?>Ph.No: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber)===null||$tmp==='' ? '-' : $tmp);?>
<br />GST: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td><td class="border-top border-size" colspan="3"><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code) && ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO' || $_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'PDDO')) {?><b><?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->toCustomer->name));?>
</b><br><?php echo substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1,0,25);?>
, <?php echo substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark,0,10);?>
, <?php echo substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name,0,13);?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;
echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
<br><?php if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1)) {?><br><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber)) {?><br><?php }
} else { ?><b><?php echo ucwords(strtolower($_smarty_tpl->tpl_vars['summary']->value->toOrganization->name));?>
</b><br><?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
,<?php }
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2)) {
echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2;?>
<br><?php }
echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>
<br><?php if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1)) {?><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2)) {?><br><br><?php }
if (!isNotNull($_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact)) {?><br><?php }
}
if ($_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'DYDO' || $_smarty_tpl->tpl_vars['summary']->value->deliveryType->code == 'PDDO') {?>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="background-color: #e7e6e3;color:#000"> Door Delivery </span><?php }?></td></tr><tr><td class="bold border-top border-right" align="center">Qty</td><td class="bold border-top border-right" colspan="4" align="center">Item - Description</td><td class="bold border-top border-right" align="center">UOM</td><td class="bold border-top border-right" align="center">Rate</td><td class="bold border-top border-right" colspan="2" align="center">Actual Weight</td><td class="border-top" colspan="3" rowspan="7"><table><?php if ($_smarty_tpl->tpl_vars['summary']->value->totalAmount > 0 || in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">Freight</td><td align="right"><?php if (in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount);
}?></td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount > 0 || in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">Hamali ch</td><td align="right"><?php if (in_array('LC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount);
}?></td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0 || in_array('DP',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">DC</td><td align="right"><?php if (in_array('DP',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount);
}?></td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0 || in_array('DD',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">DD</td><td align="right"><?php if (in_array('DD',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount);
}?></td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0 || in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">Hamali Ch.</td><td align="right"><?php if (in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge);
}?></td></tr><?php }
if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0 || in_array('DC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">Docket Ch.</td><td align="right"><?php if (in_array('DC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge);
}?></td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue > 0) {?><tr><td colspan="2">CGST</td><td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tax_computed']->value->cgstValue);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue > 0) {?><tr><td colspan="2">SGST</td><td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tax_computed']->value->sgstValue);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue > 0) {?><tr><td colspan="2">IGST</td><td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tax_computed']->value->igstValue);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue > 0) {?><tr><td colspan="2">UGST</td><td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tax_computed']->value->ugstValue);?>
</td></tr><?php }
if ($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value > 0 || in_array('MC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?><tr><td colspan="2">Machine Handling Ch.</td><td align="right"><?php if (in_array('MC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value);
}?></td></tr><?php }?><tr><td colspan="2">Others</td><td align="right"><?php echo inr_format(($_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value));?>
</td></tr><?php if ($_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value) {?><tr><td colspan="2">Add/Less</td><td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value);?>
</td></tr><?php }?><tr><?php $_smarty_tpl->_assignInScope('netAmount', $_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value);?><td class="font-10 bold border-bottom" colspan="2">Grand Total</td><td class="font-10 bold border-bottom" align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['netAmount']->value);?>
</td></tr><?php if ($_smarty_tpl->tpl_vars['Gststate']->value == $_smarty_tpl->tpl_vars['stateCode']->value) {?><tr><td colspan="2">CGST &nbsp;<b>(2.5%)</b></td><td align="right"><b>(<?php echo $_smarty_tpl->tpl_vars['netAmount']->value*2.5/100;?>
)</b></td></tr><tr><td colspan="2">SGST &nbsp;<b>(2.5%)</b></td><td align="right"><b>(<?php echo $_smarty_tpl->tpl_vars['netAmount']->value*2.5/100;?>
)</b></td></tr><?php } else { ?><br><tr><td class="border-bottom" colspan="2">IGST <b>(5%)</b></td><td align="right" class="border-bottom" colspan="2"><b>(<?php echo $_smarty_tpl->tpl_vars['netAmount']->value*5/100;?>
)</b></td></tr><?php }?></table></td></tr><tr><td class="border-top border-right" colspan="7" rowspan="5"><table width="100%"><?php $_smarty_tpl->_assignInScope('totalarticles', 0);
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
?><tr><td width="15%" align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td><td width="57%"><?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->description[0];?>
</td><td width="16%" align="left"><?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>
 <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>
</td><td width="12%" align="right"><?php if (in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->value)) {?>FS<?php } else {
echo inr_format($_smarty_tpl->tpl_vars['article']->value->fare);
}?></td></tr><?php $_smarty_tpl->_assignInScope('totalarticles', $_smarty_tpl->tpl_vars['totalarticles']->value+$_smarty_tpl->tpl_vars['article']->value->itemCount);
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?></table></td><td class="bold border-top border-right" align="center">Qt.</td><td class="bold border-top border-right" align="center">Kgs.</td></tr><tr><td class="border-top border-right" align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['actualWeight']->value['QNTL'])===null||$tmp==='' ? '0' : $tmp);?>
</td><td class="border-top border-right" align="center"><?php echo (($tmp = @($_smarty_tpl->tpl_vars['actualWeight']->value['KG']+$_smarty_tpl->tpl_vars['actualWeight']->value['TON']))===null||$tmp==='' ? '0' : $tmp);?>
</td></tr><tr><td class="bold border-top border-right" colspan="2" align="center">Charged Weight</td></tr><tr><td class="bold border-top border-right" align="center">Qt.</td><td class="bold border-top border-right" align="center">Kgs.</td></tr><tr><td class="border-top border-right border-bottom" align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['chargedWeight']->value['QNTL'])===null||$tmp==='' ? '0' : $tmp);?>
</td><td class="border-top border-right border-bottom" align="center"><?php echo (($tmp = @($_smarty_tpl->tpl_vars['chargedWeight']->value['KG']+$_smarty_tpl->tpl_vars['chargedWeight']->value['TON']))===null||$tmp==='' ? '0' : $tmp);?>
</td></tr><tr><td align="center"><?php echo $_smarty_tpl->tpl_vars['totalarticles']->value;?>
</td><td class="border-right" colspan="6">No. of items <?php echo num_to_words($_smarty_tpl->tpl_vars['totalarticles']->value);?>
 Only</td><td class="border-right" colspan="2"></td></tr><tr><td class="bold border-top border-right" colspan="3">Invoice No</td><td class="bold border-top border-right" colspan="2">Invoice Date</td><td class="bold border-top border-right" colspan="2">Invoice Value</td><td class="bold border-top border-right border-bottom" colspan="2">E-Way Bill</td>                            </tr><tr><td class="border-top border-right" colspan="9"><table class="100%"><tbody><?php $_smarty_tpl->_assignInScope('totalInvoiceAmount', 0);
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'], 'val');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['val']->value) {
?><tr><?php $_smarty_tpl->_assignInScope('invoiceDetail', explode("|",$_smarty_tpl->tpl_vars['val']->value->value));?><td width="35%"><?php echo $_smarty_tpl->tpl_vars['invoiceDetail']->value[1];?>
</td><td width="25%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['invoiceDetail']->value[2],$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td><td width="15%" align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['invoiceDetail']->value[0]);?>
</td><td width="25%" align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->referenceCode;?>
</td></tr><?php $_smarty_tpl->_assignInScope('totalInvoiceAmount', $_smarty_tpl->tpl_vars['totalInvoiceAmount']->value+$_smarty_tpl->tpl_vars['invoiceDetail']->value[0]);
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
if ((count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])) < 2) {
$_smarty_tpl->tpl_vars['space'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['space']->step = 1;$_smarty_tpl->tpl_vars['space']->total = (int) ceil(($_smarty_tpl->tpl_vars['space']->step > 0 ? 2-(count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL']))+1 - (1) : 1-(2-(count($_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'])))+1)/abs($_smarty_tpl->tpl_vars['space']->step));
if ($_smarty_tpl->tpl_vars['space']->total > 0) {
for ($_smarty_tpl->tpl_vars['space']->value = 1, $_smarty_tpl->tpl_vars['space']->iteration = 1;$_smarty_tpl->tpl_vars['space']->iteration <= $_smarty_tpl->tpl_vars['space']->total;$_smarty_tpl->tpl_vars['space']->value += $_smarty_tpl->tpl_vars['space']->step, $_smarty_tpl->tpl_vars['space']->iteration++) {
$_smarty_tpl->tpl_vars['space']->first = $_smarty_tpl->tpl_vars['space']->iteration === 1;$_smarty_tpl->tpl_vars['space']->last = $_smarty_tpl->tpl_vars['space']->iteration === $_smarty_tpl->tpl_vars['space']->total;?><tr><td width="35%"></td><td width="25%"></td><td width="15%"></td><td width="25%"></td></tr><?php }
}
}?><tr><td class="bold" colspan="2" align="right">Total</td><td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['totalInvoiceAmount']->value);?>
</td></tr></tbody></table></td><td class="bold" style="font-size: 13px;" colspan="3" align="center"><br><?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentType->name;
if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[0]->transactionMode->code)) {?>/ <?php echo $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList[0]->transactionMode->name;?>
<br><span style="font-size: 10px;"><?php echo $_smarty_tpl->tpl_vars['trans_no']->value;?>
</span><?php }?></td></tr><tr><td class="border-top border-right" colspan="9"><span class="bold">Rupees In Words</span> <span style="<?php if (strlen(amount_in_words($_smarty_tpl->tpl_vars['netAmount']->value)) > 65) {?>font-size: 8px;<?php } else { ?>font-size: 10px;<?php }?>">&nbsp;&nbsp;<?php if ($_smarty_tpl->tpl_vars['netAmount']->value) {
echo amount_in_words($_smarty_tpl->tpl_vars['netAmount']->value);?>
 Only<?php }?></span></td><td class="border-top border-left" rowspan="3" colspan="9" align="center">For SEENU TRANSPORTS <span style="font-size: 7px;">Pvt Ltd</span></td></tr><tr><td align="left" colspan="2" style="font-size: 9px;" class="bold"><br>Goods Remarks :</td><td colspan="7" align="left"><br><?php echo $_smarty_tpl->tpl_vars['summary']->value->remarks[0]->name;?>
</td></tr><tr><td colspan="4"><br>Goods Carried At Owner's Risk</td><td colspan="5" align="center"><br>(Receiver : Date, Signature, Mobile No. & Stamp) </td></tr><tr><td class="bold" colspan="2" align="right">Booked by :</td><td colspan="4"><?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedUser->name;?>
</td><td colspan="3"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td></tr></table><?php if ($_smarty_tpl->tpl_vars['iter']->value < 3) {?><div></div><?php }
}
}
}
}
