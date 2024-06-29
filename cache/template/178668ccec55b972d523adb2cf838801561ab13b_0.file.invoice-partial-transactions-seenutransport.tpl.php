<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 15:22:03
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\invoice-partial-transactions-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6655a943987a61_46714845',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '178668ccec55b972d523adb2cf838801561ab13b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\invoice-partial-transactions-seenutransport.tpl',
      1 => 1716889909,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6655a943987a61_46714845 (Smarty_Internal_Template $_smarty_tpl) {
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

    .content:last-child {
        margin-top: 0;
    }

    @media print {

        /* Avoid page break inside content */
        .content {
            page-break-after: always;
        }

    }

    table {
        font-size: 8px;
    }
</style>
<?php if ($_smarty_tpl->tpl_vars['printStatus']->value == "ALL") {?>
    <?php $_smarty_tpl->_assignInScope('loopCount', 3);
} else { ?>
    <?php $_smarty_tpl->_assignInScope('loopCount', 1);
}
$_smarty_tpl->tpl_vars['i'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['i']->step = 1;$_smarty_tpl->tpl_vars['i']->total = (int) ceil(($_smarty_tpl->tpl_vars['i']->step > 0 ? $_smarty_tpl->tpl_vars['loopCount']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['loopCount']->value)+1)/abs($_smarty_tpl->tpl_vars['i']->step));
if ($_smarty_tpl->tpl_vars['i']->total > 0) {
for ($_smarty_tpl->tpl_vars['i']->value = 1, $_smarty_tpl->tpl_vars['i']->iteration = 1;$_smarty_tpl->tpl_vars['i']->iteration <= $_smarty_tpl->tpl_vars['i']->total;$_smarty_tpl->tpl_vars['i']->value += $_smarty_tpl->tpl_vars['i']->step, $_smarty_tpl->tpl_vars['i']->iteration++) {
$_smarty_tpl->tpl_vars['i']->first = $_smarty_tpl->tpl_vars['i']->iteration === 1;$_smarty_tpl->tpl_vars['i']->last = $_smarty_tpl->tpl_vars['i']->iteration === $_smarty_tpl->tpl_vars['i']->total;?>
    <div <?php if ($_smarty_tpl->tpl_vars['printStatus']->value == "ALL") {?> class="content" <?php }?>><table class="bordered" width="100%" cellpadding="7"><tr class="bold"><td width="25%" align="center" style="border:none">&nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px"><br><?php if ($_smarty_tpl->tpl_vars['printStatus']->value == "ALL") {
if ($_smarty_tpl->tpl_vars['i']->value == 1) {?><p style="font-size: 10px;">Original for Receipient</p><?php }
if ($_smarty_tpl->tpl_vars['i']->value == 2) {?><p style="font-size: 10px;">Duplicate Copy</p><?php }
if ($_smarty_tpl->tpl_vars['i']->value == 3) {?><p style="font-size: 10px;">Triplicate Copy</p><?php }
}
if ($_smarty_tpl->tpl_vars['printStatus']->value == "ORIGINAL") {?><p style="font-size: 10px;">Original for Receipient</p><?php }
if ($_smarty_tpl->tpl_vars['printStatus']->value == "DUPLICATE") {?><p style="font-size: 10px;">Duplicate Copy</p><?php }
if ($_smarty_tpl->tpl_vars['printStatus']->value == "TRIPLICATE") {?><p style="font-size: 10px;">Triplicate Copy</p><?php }?></td><td align="center" width="75%" style="font-size: 17px; border: none;"><h2 style="font-size: 17px; "> Seenu Transports Pvt.Ltd. </h2><p style="font-size: 8px;">Booking Branch : <span style="font-size: 8px;color: #333232;"><?php echo $_smarty_tpl->tpl_vars['from_address1']->value;
if (isNotNull($_smarty_tpl->tpl_vars['from_address2']->value)) {?>,<?php echo $_smarty_tpl->tpl_vars['from_address2']->value;
}
if (isNotNull($_smarty_tpl->tpl_vars['contact']->value)) {?>,Ph :<?php echo $_smarty_tpl->tpl_vars['contact']->value;?>
 <?php }?></span></p></td></tr></table>
            <table class="bordered" cellpadding="2">
                <tr style="background-color: #E8E8E8;">
                    <td align="center" class="bold" style="font-size: 12px;" colspan="8">TAX INVOICE </td>
                </tr>
                <tr>
                    <td colspan="4"><b>Invoice No :&nbsp;<?php echo $_smarty_tpl->tpl_vars['details']->value->code;?>
</b></td>
                    <td colspan="4"><b>Invoice Date :&nbsp;<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['details']->value->transactionDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</b></td>
                </tr>
                <tr>
                    <td colspan="4"><b>GSTIN :</b>
                        <?php echo $_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->gstin;?>

                    </td>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td class="bold"><b>State</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->name;?>
</td>
                    <td class="bold"><b>Code</b></td>

                    <td>
                        <?php echo substr($_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->gstin,0,2);?>

                    </td>

                    <td colspan="4"><b>SAC Code :</b>&nbsp;996511</td>
                </tr>

                <tr style="background-color: #E8E8E8;">
                    <td align="center" class="bold" colspan="4">Billed To Party</td>
                    <td align="center" class="bold" colspan="4">Shipped To Party</td>
                </tr>
                <tr>
                    <td colspan="4"><b>Name :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->name)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    <td colspan="4">
                        <b>Name :</b>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->name;?>

                            <?php }?>
                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->name;?>

                            <?php }?>
                        <?php }?>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"><b>Address :</b>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->address1)) {
echo $_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->address1;?>
,
                            <?php echo $_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->address2;?>
<br><?php echo $_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->landmark;?>
,
                        <?php echo $_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['details']->value->vendorBillingAddress->pincode;
} else { ?> -
                        <?php }?>
                    </td>
                    <td colspan="4">
                        <b>Address :</b>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->code)) {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address1;
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address2;?>
<br>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->landmark;?>
,
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->pincode;?>

                            <?php }?>
                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->code)) {?>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->address1;
echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomerAddress->address2;?>
<br>
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->landmark;?>
,
                                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomerAddress->pincode;?>

                            <?php }?>
                        <?php }?>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"> <b>GSTIN :</b>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>

                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>

                        <?php }?></td>
                    <td colspan="4">
                        <b>GSTIN :</b>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>

                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>

                        <?php }?>
                    </td>
                </tr>
                <tr>
                    <td class="bold"><b>State</b></td>
                    <td>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['get_gst_state']->value[substr($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST,0,2)])===null||$tmp==='' ? '-' : $tmp);?>

                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['get_gst_state']->value[substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST,0,2)])===null||$tmp==='' ? '-' : $tmp);?>

                        <?php }?>
                    </td>



                    <td class="bold"><b>Code</b></td>
                    <td>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo (($tmp = @substr($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST,0,2))===null||$tmp==='' ? '-' : $tmp);?>

                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo (($tmp = @substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST,0,2))===null||$tmp==='' ? '-' : $tmp);?>

                        <?php }?>

                    </td>
                    <td class="bold"><b>State</b></td>
                    <td>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['get_gst_state']->value[substr($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST,0,2)])===null||$tmp==='' ? '-' : $tmp);?>

                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo (($tmp = @$_smarty_tpl->tpl_vars['get_gst_state']->value[substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST,0,2)])===null||$tmp==='' ? '-' : $tmp);?>

                        <?php }?>
                    </td>

                    <td class="bold"><b>Code</b></td>
                    <td> <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'INP') {?>
                            <?php echo (($tmp = @substr($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST,0,2))===null||$tmp==='' ? '-' : $tmp);?>

                        <?php } elseif (isNotNull($_smarty_tpl->tpl_vars['summary']->value) && $_smarty_tpl->tpl_vars['summary']->value->paymentType->code == 'OATP') {?>
                            <?php echo (($tmp = @substr($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST,0,2))===null||$tmp==='' ? '-' : $tmp);?>

                        <?php }?></td>
                </tr>
            </table>
            <table class="bordered" cellpadding="2" width="100%">
                <thead>
                    <tr>
                        <th align="center" colspan="8">
                            <b> Transport Charges</b>
                        </th>
                    </tr>
                    <tr style="font-weight:bold; background-color: #E8E8E8;">
                        <th align="center" width="6%" rowspan="2">Sl No</th>
                        <th align="center" width="16%" rowspan="2"><?php echo lang('lr');?>
 No</th>
                        <th align="center" width="10%" rowspan="2">LR Date</th>
                        <th align="center" width="14%" rowspan="2"><?php echo lang('booking_from_term');?>
</th>
                        <th align="center" width="13%" rowspan="2"><?php echo lang('booking_to_label');?>
</th>
                        <th align="center" width="16%" rowspan="2">Mode of Payment</th>
                        <th align="center" width="15%" rowspan="2">Amt.</th>
                        <th align="center" width="10%" rowspan="2">Total Amt.</th>
                    </tr>
                </thead>
                <?php $_smarty_tpl->_assignInScope('total', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_amt', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_lr', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <tr>
                        <th align="center" width="6%"><?php echo $_smarty_tpl->tpl_vars['k']->value+1;?>
</th>
                        <td align="left" width="16%"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                        <td align="left" width="10%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                        <td align="left" width="14%"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_name;?>
</td>
                        <td align="left" width="13%"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_organization_name;?>
</td>
                        <td align="left" width="16%"><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code];?>
</td>
                        <td align="right" width="15%"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->transaction_amount-$_smarty_tpl->tpl_vars['row']->value->commission_amount));?>
</td>
                        <td align="right" width="10%"><?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->transaction_amount-$_smarty_tpl->tpl_vars['row']->value->commission_amount));?>
</td>
                    </tr>
                    <?php $_smarty_tpl->_assignInScope('total_amt', $_smarty_tpl->tpl_vars['total_amt']->value+($_smarty_tpl->tpl_vars['row']->value->total_amount));?>
                    <?php $_smarty_tpl->_assignInScope('total', $_smarty_tpl->tpl_vars['total']->value+($_smarty_tpl->tpl_vars['row']->value->transaction_amount-$_smarty_tpl->tpl_vars['row']->value->commission_amount));?>
                    <?php $_smarty_tpl->_assignInScope('total_lr', $_smarty_tpl->tpl_vars['k']->value+1);?>
                <?php
}
} else {
?>
                    <tr>
                        <td colspan="12" align="center" class="bordered">No Records Found!</td>
                    </tr>
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <tr class="bold">
                    <td align="right" width="75%" colspan="5">Total</td>
                    <td align="right" width="15%"><?php echo inr_format($_smarty_tpl->tpl_vars['total']->value);?>
</td>
                    <td align="right" width="10%"><?php echo inr_format($_smarty_tpl->tpl_vars['total']->value);?>
</td>
                </tr>

                <tr>
                    <td align="left" rowspan="6" colspan="5"><b>Amount In Words :</b>&nbsp;<?php echo ucwords(amount_in_words($_smarty_tpl->tpl_vars['total']->value));?>
<br><br><br><br><b>Enclosed by: </b><?php echo $_smarty_tpl->tpl_vars['total_lr']->value;?>
</td>
                    <td align="left" class="bold">Total Amount</td>
                    <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['total']->value);?>
</td>
                </tr>

                <tr>
                    <td align="left" class="bold">ROUNDED OFF</td>
                    <td align="right" class="bold">0.00</td>
                </tr>
                <?php if ($_smarty_tpl->tpl_vars['deliveryBranchGstCodes']->value->state->code == $_smarty_tpl->tpl_vars['Gststate']->value) {?>
                    <tr>
                        <td align="left" class="bold">CGST (2.5%)</td>
                        <td align="right" class="bold"><b><?php echo $_smarty_tpl->tpl_vars['total']->value*2.5/inr_format(100);?>
</b></td>
                    </tr>
                    <tr>
                        <td align="left" class="bold">SGST (2.5%)</td>
                        <td align="right" class="bold"><b><?php echo $_smarty_tpl->tpl_vars['total']->value*2.5/inr_format(100);?>
</b></td>
                    </tr>
                <?php } else { ?>
                    <tr>
                        <td align="left" class="bold">IGST (5%)</td>
                        <td align="right" class="bold"><b><?php echo $_smarty_tpl->tpl_vars['total']->value*5/inr_format(100);?>
</b></td>
                    </tr>
                <?php }?>
                <tr>
                    <td align="left" class="bold">GST on Reverse Charge</td>
                    <td align="right" class="bold"><?php if (isNotNull($_smarty_tpl->tpl_vars['details']->value->namespaceTax->gstin)) {?>YES<?php } else { ?>YES<?php }?></td>
                </tr>
            </table>
            <br />
            <br />
            <table width="100%"><tr><td align="center" width="40%"><table class="bordered" cellpadding="2"><tr style="background-color: #E8E8E8;"><td align="center" class="bold" style="font-size: 10px;">Bank Details</td></tr><tr><td align="left"><b>Bank Name :</b>&nbsp;<?php if (count($_smarty_tpl->tpl_vars['bank_detail']->value) > 0) {
echo $_smarty_tpl->tpl_vars['bank_detail']->value[0]->bankName;
}?></td></tr><tr><td align="left"><b>Bank A/C :</b>&nbsp;<?php if (count($_smarty_tpl->tpl_vars['bank_detail']->value) > 0) {
echo $_smarty_tpl->tpl_vars['bank_detail']->value[0]->accountNumber;
}?></td></tr><tr><td align="left"><b>Bank IFSC :</b>&nbsp;<?php if (count($_smarty_tpl->tpl_vars['bank_detail']->value) > 0) {
echo $_smarty_tpl->tpl_vars['bank_detail']->value[0]->ifscCode;
}?></td></tr></table></td><td width="20%"></td><td width="40%"><table class="bordered" cellpadding="2"><tr><td class="bold" style="font-size: 7px;">Ceritified that the particulars given above are true andcorrect</td></tr><tr><td align="center" class="bold" style="font-size: 9px;">For Seenu Transports Pvt Ltd.<br><br></td></tr><tr><td align="center" class="bold">Authorised Signatory</td></tr></table></td></tr><tr><td align="center" class="bold">Terms & Conditions</td><td align="center" class="bold">Common Seal</td><td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['username']->value;?>
 (<?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
)</td></tr><tr><td align="center" width="40%"><table class="bordered" cellpadding="2"><tr style="background-color: #E8E8E8;"><td align="center" class="bold" style="font-size: 10px;">For any further information, KindlyContact:</td></tr><tr><td align="left"><b>Contact Person :</b></td></tr><tr><td align="left"><b>Contact No :</b></td></tr></table></td></tr></table><br><br>
            <br>
            <table>
                <tr>

                    <td width="100%">
                        <table cellpadding="2" style="border:1px soild #000;">
                            <tr>
                                <td class="bold" style="font-size: 7px;"> <b>Declaration for E-Invoicing Exemption:</b></td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp; We hereby declare that the GSTIN: <?php echo $_smarty_tpl->tpl_vars['deliveryBranchGstCode']->value->gstin;?>
 SEENU TRANSPORTS PVT LTD is exempt from preparing an invoice in terms of Rule 48(4) of CGST Rules 2017.</td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> <b> Exemption Category :</b></td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp; Goods Transport Agency supplying services in relation to transportation of goods by road in a goods carriage (13/2020-Central Tax dated 21st march 2020)</td>
                            </tr>
                            <tr>
                                <td class="bold" style="font-size: 7px;"> &nbsp;&nbsp;&nbsp;&nbsp;<b>Note :</b> TDS Applicable @2% U/S 194C of I.T act</td>
                            </tr>
                        </table>
                    </td>
                                    </tr>
            </table>
        </div>
    
<?php }
}
}
}
