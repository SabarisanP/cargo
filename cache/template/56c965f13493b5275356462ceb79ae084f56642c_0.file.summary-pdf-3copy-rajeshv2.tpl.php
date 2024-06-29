<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-12 10:34:40
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\summary-pdf-3copy-rajeshv2.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66692c688beb33_60538027',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '56c965f13493b5275356462ceb79ae084f56642c' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\summary-pdf-3copy-rajeshv2.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66692c688beb33_60538027 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),1=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.truncate.php','function'=>'smarty_modifier_truncate',),));
?>
<style>
    .bordered td { border-right-width:0.1px; border-top-width:0.1px; border-left-width:0.1px; border-bottom-width:0.1px; border-color: #666; }
    .border-outline { border: 1px solid #000; }
    .border-left { border-left: 1px solid #000; }
    .h-seperator { border-bottom: 3px solid #2e2e64;  }
    .v-seperator { border-left: 2px solid #2e2e64;  }
    .receipt-title {
        background-color: #2e2e64;
        color: #fff;
        text-align: center;
    }
</style>

<?php
$_smarty_tpl->tpl_vars['iter'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['iter']->step = 1;$_smarty_tpl->tpl_vars['iter']->total = (int) ceil(($_smarty_tpl->tpl_vars['iter']->step > 0 ? 2+1 - (1) : 1-(2)+1)/abs($_smarty_tpl->tpl_vars['iter']->step));
if ($_smarty_tpl->tpl_vars['iter']->total > 0) {
for ($_smarty_tpl->tpl_vars['iter']->value = 1, $_smarty_tpl->tpl_vars['iter']->iteration = 1;$_smarty_tpl->tpl_vars['iter']->iteration <= $_smarty_tpl->tpl_vars['iter']->total;$_smarty_tpl->tpl_vars['iter']->value += $_smarty_tpl->tpl_vars['iter']->step, $_smarty_tpl->tpl_vars['iter']->iteration++) {
$_smarty_tpl->tpl_vars['iter']->first = $_smarty_tpl->tpl_vars['iter']->iteration === 1;$_smarty_tpl->tpl_vars['iter']->last = $_smarty_tpl->tpl_vars['iter']->iteration === $_smarty_tpl->tpl_vars['iter']->total;?>
    
    <?php echo str_repeat('<br/>',3);?>


    <table width="100%">
        <tr>
            <td width="63%"><br><br><br>
                <img src="assets/img/rajeshexpress-header.png" alt="logo" width="500px">
            </td>
            <td width="3%">
            </td>
            <td width="1%">
                <div class="v-seperator"><?php echo str_repeat('<br/>',7);?>
</div>
            </td>
            <td width="31%">
                <div style="font-size: 7px;">
                    <b>Head Office :</b>
                    <br/>
                    <table cellpadding="1">
                        <tr>
                            <td width="7%">
                                <img src="assets/img/icons/marker.png" alt="logo" width="8px">
                            </td>
                            <td width="93%">
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2;?>

                            </td>
                        </tr>
                        <tr>
                            <td width="7%">
                                <img src="assets/img/icons/mail.png" alt="logo" width="8px">
                            </td>
                            <td width="93%"valign="middle">
                                info@rajeshexpresscargo.com
                            </td>
                        </tr>
                        <tr>
                            <td width="7%">
                            <img src="assets/img/icons/globe.png" alt="logo" width="8px">
                            </td>
                            <td width="93%"valign="middle">
                                http://www.rajeshtransports.com
                            </td>
                        </tr>
                        <tr>
                            <td width="7%">
                                <img src="assets/img/icons/phone.png" alt="logo" width="7px">
                            </td>
                            <td width="93%">
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <div class="h-seperator"></div><br/>

    <table cellpadding="4">
        <tr>
            <td></td>
            <td class="receipt-title" width="35%">
                <b style="font-size: 8px;"> GOODS CONSIGNMENT BOOKING RECEIPT</b>
            </td>
            <td></td>
        </tr>
    </table>
    <br/>
    <br/>

    <table width="100%" cellpadding="1">
        <tr>
            <td width="40%"><b>From City :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>
</td>
            <td><b>To City : <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>
</b></td>
            <td><b>Bkg DT : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['summary']->value->bookedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</b></td>
        </tr>
        <tr>
<td colspan="2"><b><?php echo lang('booking_sender_term');?>
 Name :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
 <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST)) {?>&nbsp; <b>GST NO : </b><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST;
}?></td>
            <td><b>GC No : <?php echo $_smarty_tpl->tpl_vars['summary']->value->code;?>
</b></td>
        </tr>
        <tr>
            <td colspan="2"><b><?php echo lang('booking_receiver_term');?>
 Name :</b> <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
 <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)) {?>&nbsp; <b>GST NO : </b><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerGST;
}?></td>
            <td><b>Booking Type : <?php echo strtoupper($_smarty_tpl->tpl_vars['payment_type_name']->value);?>
</b></td>
        </tr>
        <tr>
            <td><b>GST NO : 29AAVFR9980R1ZG</b></td>
            <td></td>
            <td><b>PAN NO : AAVFR9980R</b></td>
        </tr>
    </table>

    <table width="100%" cellpadding="1">
        <tr>
            <td colspan="3" align="center" style="font-size: 7px;"><b>Consignment Particulars</b></td>
        </tr>
    </table>

    <?php $_smarty_tpl->_assignInScope('qty', 0);?>
    <?php $_smarty_tpl->_assignInScope('articles', array());?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
?>
        <?php $_smarty_tpl->_assignInScope('qty', $_smarty_tpl->tpl_vars['qty']->value+$_smarty_tpl->tpl_vars['article']->value->itemCount);?>
        <?php $_smarty_tpl->_assignInScope('articles', array_merge($_smarty_tpl->tpl_vars['articles']->value,array($_smarty_tpl->tpl_vars['article']->value->cargoItem->name)));?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
    <?php $_smarty_tpl->_assignInScope('totalfreight', ($_smarty_tpl->tpl_vars['summary']->value->totalAmount+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value));?>
    <?php $_smarty_tpl->_assignInScope('hideCargoFreight', '');?>
    <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->vendorUser) && isNotNull($_smarty_tpl->tpl_vars['summary']->value->vendorUser->code)) {?>
        <?php $_smarty_tpl->_assignInScope('hideCargoFreight', $_smarty_tpl->tpl_vars['summary']->value->vendorUser->hideCargoFreight);?>
    <?php }?>
    <table width="100%" cellpadding="0" class="border-outline px-2" style="border-spacing: 3px 1px">
        <tr>
            <td>Quantity</td>
            <td><?php echo $_smarty_tpl->tpl_vars['qty']->value;?>
</td>
            <td class="border-left"> Freight Rate</td>
            <td><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalAmount,2);
}?></td>
            <td> Door Pickup</td>
            <td align="right"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);
}?></td>
        </tr>
        <tr>
            <td>Type of Packing</td>
            <td><?php echo smarty_modifier_truncate(implode($_smarty_tpl->tpl_vars['articles']->value,', '),35);?>
</td>
            <td class="border-left"> WB/Value Surcharge</td>
            <td><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else { ?>0.00<?php }?></td>
            <td> Door Delivery Charges</td>
            <td align="right"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);
}?></td>
        </tr>
        <tr>
            <td>Total Kg. CDM</td>
            <td>0</td>
            <td class="border-left"> Loading charges</td>
            <td><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);
}?></td>
            <td> With Pass Charges</td>
            <td align="right"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);
}?></td>
        </tr>
        
        <?php $_smarty_tpl->_assignInScope('invoiceDetail', explode("|",$_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'][0]->value));?>
        <tr>
            <td>Value Of the Goods</td>
            <td><?php echo number_format($_smarty_tpl->tpl_vars['invoiceDetail']->value[0],2);?>
</td>
            <td class="border-left"> Unhandling charges</td>
            <td><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);
}?></td>
            <td> Hamali charges</td>
            <td align="right"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);
}?></td>
        </tr>
        <tr>
            <td>Invoice Number</td>
            <td><?php echo $_smarty_tpl->tpl_vars['invoiceDetail']->value[1];?>
</td>
            <td rowspan="4" class="border-left"> <b>Amount In Words</b></td>
            <td rowspan="4"><b><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo ucwords(amount_in_words($_smarty_tpl->tpl_vars['totalfreight']->value));
}?></b></td>
            <td> Docket Charges</td>
            <td align="right"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);
}?></td>
        </tr>
        <tr>
            <td>E Way Bill</td>
            <td><?php echo $_smarty_tpl->tpl_vars['addons_mapped']->value['EWBL'][0]->referenceCode;?>
</td>
            <td> GST</td>
            <td align="right"><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);
}?></td>
        </tr>
        <tr>
            <td>GC Reference No</td>
            <td></td>
            <td> <b>Total freight Charges</b></td>
            <td align="right"><b><?php if ($_smarty_tpl->tpl_vars['summary']->value->paymentType->code == "INP" && $_smarty_tpl->tpl_vars['hideCargoFreight']->value == 1) {?>-<?php } else {
echo number_format($_smarty_tpl->tpl_vars['totalfreight']->value,2);
}?></b></td>
        </tr>
        <tr>
            <td>Booked By</td>
            <td><?php echo $_smarty_tpl->tpl_vars['summary']->value->bookedUser->name;?>
</td>
            <td></td>
            <td align="right"></td>
        </tr>
    </table>

    <table width="100%" cellpadding="1">
        <tr>
            <td><b>Booking Branch Address : <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->address2;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>
</b></td>
        </tr>
        <tr>
            <td><b>Delivery Branch Address : <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address1;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->address2;?>
 <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>
</b></td>
        </tr>
    </table>
    
    <div></div>

    <?php if (count($_smarty_tpl->tpl_vars['terms_list']->value) > 0) {?>
        <table width="100%" cellpadding="1">
            <tr class="success">
                <td><b>Terms & Conditions</b></td>
            </tr>
            <tbody class="body_table">
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['terms_list']->value, 'term');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['term']->value) {
?>
                    <tr style="font-size: 5px;">
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['term']->value->name;?>
</td>
                    </tr>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
        </table>
        <div></div>
    <?php }
}
}
}
}
