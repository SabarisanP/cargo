<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-25 18:37:32
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\booking-preview.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6651e2945d3b75_82309211',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5ff0e5be31d2ed266992ef54dcada31261aad850' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\booking-preview.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6651e2945d3b75_82309211 (Smarty_Internal_Template $_smarty_tpl) {
?><div class="popup_top">
    <div class="row">
        <div class="col-md-10 bold ft_14">Cargo Booking Preview
        </div>
        <div class="col-md-2">
            <a class="align-right" onclick="closeCargoPreviewDialog()" href="javascript:;" title="click or press ESC to close"><i class="fa fa-times-circle ft_22"></i></a>
        </div>
    </div>
</div>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tbody class="body_table">
        <tr class="success">
            <td align="left" width="50%">
                <span class="bold"> <?php echo lang('booking_from_label');?>
</span>
            </td>
            <td align="left" width="50%">
                <span class="bold"><?php echo lang('booking_to_label');?>
</span>
            </td>
        </tr>
        <tr>
            <td align="left" width="50%">
                <?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->name;?>

                <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromOrganization->contact;?>

            </td>
            <td align="left" width="50%">
                <?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->name;?>

                <br><?php echo $_smarty_tpl->tpl_vars['summary']->value->toOrganization->contact;?>

            </td>
        </tr>
        <tr>
            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->name;?>
</td>
            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->name;?>
</td>
        </tr>
        <tr>
            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->fromCustomer->mobileNumber;?>
</td>
            <td align="left" width="50%" class=""><?php echo $_smarty_tpl->tpl_vars['summary']->value->toCustomer->mobileNumber;?>
</td>
        </tr>
        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)) {?>
            <tr>
                <td align="left" width="50%" ><b>GSTIN :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                <td align="left" width="50%" ><b>GSTIN :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomerGST)===null||$tmp==='' ? '-' : $tmp);?>
</td>
            </tr>
        <?php }?>
        <?php if (isNotNull($_smarty_tpl->tpl_vars['summary']->value->fromCustomer->companyName) || isNotNull($_smarty_tpl->tpl_vars['summary']->value->toCustomer->companyName)) {?>
            <tr>
                <td align="left" width="50%" ><b>Company :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->fromCustomer->companyName)===null||$tmp==='' ? '-' : $tmp);?>
</td>                
                <td align="left" width="50%" ><b>Company :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['summary']->value->toCustomer->companyName)===null||$tmp==='' ? '-' : $tmp);?>
</td>         	
            </tr>
        <?php }?>
    </tbody>
</table>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tbody class="body_table">
        <tr>
            <td align="left" width="50%" class="bold">Payment Type</td>
            <td align="left" width="50%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->paymentType->name;?>
</td>
        </tr>
        <?php if ($_smarty_tpl->tpl_vars['summary']->value->vendorUser->code) {?>
            <tr>
                <td align="left" width="50%" class="bold">Vendor</td>
                <td align="left" width="50%"><?php echo $_smarty_tpl->tpl_vars['summary']->value->vendorUser->name;?>
</td>
            </tr>
        <?php }?>
    </tbody>
</table>

<table width="100%" cellpadding="5" class="table table-bordered ">
    <tr class="success">
        <td align="center" class="bold">S No</td>
        <td align="center" class="bold"><?php echo lang('booking_article_label');?>
</td>
        <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
            <td align="center" class="bold"><?php echo lang('booking_UOM_label');?>
 <?php if (lang('booking_UOM_label_info')) {?><i class="fa fa-info-circle" data-toggle="tooltip" data-title="<?php echo lang('booking_UOM_label_info');?>
"></i><?php }?></td>
        <?php }?>
        <td align="center" class="bold">Quantity</td>
        <td align="center" class="bold">Rate</td>
        <td align="center" class="bold">Freight</td>
    </tr>
    <tbody class="body_table">
        <?php $_smarty_tpl->_assignInScope('subtotal', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->itemDetails, 'article', false, NULL, 'carArt', array (
  'index' => true,
));
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['article']->value) {
$_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']++;
?>
            <tr>
                <td align="center"><?php echo (isset($_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_carArt']->value['index'] : null)+1;?>
</td>
                <td align="left">
                    <?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->name;?>

                    <?php if (isNotNull($_smarty_tpl->tpl_vars['article']->value->cargoItem->description[0])) {?>
                    <br/><small class="text-muted"><?php echo $_smarty_tpl->tpl_vars['article']->value->cargoItem->description[0];?>
</small>
                    <?php }?>
                </td>
                <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                    <td align="center">
                        <?php echo $_smarty_tpl->tpl_vars['article']->value->unitValue;?>

                        <?php echo $_smarty_tpl->tpl_vars['article_unit']->value[$_smarty_tpl->tpl_vars['article']->value->unit->code];?>

                    </td>
                <?php }?>
                <td align="center"><?php echo $_smarty_tpl->tpl_vars['article']->value->itemCount;?>
</td>
                <td align="right">
                    <?php if (in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                    <?php echo $_smarty_tpl->tpl_vars['article']->value->fare;?>

                </td>
                <td align="right">
                    <?php echo number_format($_smarty_tpl->tpl_vars['article']->value->computed->freight,2);?>

                </td>
            </tr>
            <?php $_smarty_tpl->_assignInScope('subtotal', $_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['article']->value->computed->freight);?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <tr>
            <?php if ($_smarty_tpl->tpl_vars['action_rights']->value['CARGO-UNITS'] == 1) {?>
                <td align="right" colspan="5">Sub Total</td>
            <?php } else { ?>
                <td align="right" colspan="4">Sub Total</td>
            <?php }?>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['subtotal']->value,2);?>
</td>
        </tr>
    </tbody>
</table>

<?php $_smarty_tpl->_assignInScope('customerTdsTaxAmount', 0);
if (count($_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList) > 0) {?>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->cargoTransactionList, 'cargoTransactionList');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['cargoTransactionList']->value) {
?>
        <?php $_smarty_tpl->_assignInScope('customerTdsTaxAmount', $_smarty_tpl->tpl_vars['customerTdsTaxAmount']->value+$_smarty_tpl->tpl_vars['cargoTransactionList']->value->customerTdsTaxAmount);?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);
}?>

<table width="100%" cellpadding="5" class="table table-bordered">
    <tr>
        <td align="right">Freight</td>
        <td align="right">
            <?php if (in_array('FR',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
            <?php echo number_format($_smarty_tpl->tpl_vars['subtotal']->value,2);?>

        </td>
    </tr>
    <tr>
        <td align="right">L Charges</td>
        <td align="right">
            <?php if (in_array('LC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
            <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount,2);?>

        </td>
    </tr>
    <?php if ($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount > 0 || in_array('DP',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
        <tr>
            <td align="right">Pickup Charges</td>
            <td align="right">
                <?php if (in_array('DP',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount,2);?>

            </td>
        </tr>
    <?php }?>
    <?php if ($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount > 0 || in_array('DD',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
        <tr>
            <td align="right">Delivery Charges</td>
            <td align="right">
                <?php if (in_array('DD',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount,2);?>

            </td>
        </tr>
    <?php }?>
    <?php if ($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount > 0) {?>
        <tr>
            <td align="right">Unloading Charges</td>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount,2);?>
</td>
        </tr>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['summary']->value->serviceCharge > 0 || in_array('OC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
        <tr>
            <td align="right">Service Charges</td>
            <td align="right">
                <?php if (in_array('OC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceCharge,2);?>

            </td>
        </tr>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge > 0 || in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
        <tr>
            <td align="right">Hamali Charges</td>
            <td align="right">
                <?php if (in_array('HC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->hamaliCharge,2);?>

            </td>
        </tr>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['summary']->value->passCharge > 0) {?>
        <tr>
            <td align="right">Pass Charges</td>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->passCharge,2);?>
</td>
        </tr>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['summary']->value->docketCharge > 0 || in_array('DC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
        <tr>
            <td align="right">Docket Charges</td>
            <td align="right">
                <?php if (in_array('DC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
                <?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->docketCharge,2);?>

            </td>
        </tr>
    <?php }?>
    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH'])) {?>
        <tr>
            <td align="right">POD Charge</td>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value,2);?>
</td>
        </tr>
    <?php }?>
    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH'])) {?>
        <tr>
            <td align="right">Demurrage Charge</td>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value,2);?>
</td>       	
        </tr>  
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'FRT' && $_smarty_tpl->tpl_vars['summary']->value->serviceTax > 0) {?>
        <tr>
            <td align="right">GST Amount</td>
            <td align="right"><?php echo $_smarty_tpl->tpl_vars['summary']->value->serviceTax;?>
</td>
        </tr>
    <?php }?>
    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR'])) {?>
    <tr>
        <td align="right">Insurance Charge</td>
        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value,2);?>
</td>       	
    </tr>  
    <?php }?>
    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']) || in_array('MC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?>
    <tr>
        <td align="right">Machine Handling Charges</td>
        <td align="right">
            <?php if (in_array('MC',$_smarty_tpl->tpl_vars['addons_mapped']->value['FRECR']->valueList)) {?><span class="pull-left small">&nbsp;<span class="label label-default" title="Free Service">FS</span></span><?php }?>
            <?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value,2);?>

        </td>
    </tr>  
    <?php }?>
    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH'])) {?>
        <tr>
            <td align="right">Freight On Value Charges</td>
            <td align="right">
                <?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value,2);?>

            </td>
        </tr>  
    <?php }?>
    <?php if (isset($_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF'])) {?>
    <tr>
        <td align="right">Round off</td>
        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value,2);?>
</td>
    </tr>
    <?php }?>
    
    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET') {?>
        <tr>
            <td align="right" class="bold">Sub Total</td>
            <td align="right" class="bold">
                <?php echo number_format(($_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value),2);?>

            </td>
        </tr>
    <?php }?>

    <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->lrGstTaxComputeType == 'NET' && $_smarty_tpl->tpl_vars['summary']->value->serviceTax > 0) {?>
        <tr>
            <td align="right">GST Amount</td>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->serviceTax,2);?>
</td>
        </tr>
    <?php }?>

    <tr class="active">
        <td align="right" class="bold">Net Amount</td>
        <td align="right" class="bold"><?php echo number_format(($_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value),2);?>
</td>
    </tr>

    <?php if ($_smarty_tpl->tpl_vars['customerTdsTaxAmount']->value > 0) {?>
        <tr>
            <td align="right">TDS Tax</td>
            <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['customerTdsTaxAmount']->value,2);?>
</td>
        </tr>
    <?php }?>

    <tr>
        <td align="right">Amount Paid</td>
        <td align="right"><?php echo number_format($_smarty_tpl->tpl_vars['summary']->value->paymentAmount,2);?>
</td>
    </tr>
    <tr>
        <td align="right">Amount Balance</td>
        <?php if ($_smarty_tpl->tpl_vars['cargo_setting']->value->gstTaxComputeModel == "INGST") {?>
                        <?php $_smarty_tpl->_assignInScope('balance_to_pay', ($_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value-$_smarty_tpl->tpl_vars['customerTdsTaxAmount']->value)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount);?>
        <?php } else { ?>
            <?php $_smarty_tpl->_assignInScope('balance_to_pay', ($_smarty_tpl->tpl_vars['subtotal']->value+$_smarty_tpl->tpl_vars['summary']->value->totalHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->totalUnloadHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->pickupHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->deliveryHandlingAmount+$_smarty_tpl->tpl_vars['summary']->value->serviceCharge+$_smarty_tpl->tpl_vars['summary']->value->serviceTax+$_smarty_tpl->tpl_vars['summary']->value->hamaliCharge+$_smarty_tpl->tpl_vars['summary']->value->passCharge+$_smarty_tpl->tpl_vars['summary']->value->docketCharge+$_smarty_tpl->tpl_vars['addons_mapped']->value['PODCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['DMRCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['RNDF']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['INSUR']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['ADJSMT']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['MCNHCH']->value+$_smarty_tpl->tpl_vars['addons_mapped']->value['FOVCH']->value-$_smarty_tpl->tpl_vars['customerTdsTaxAmount']->value)-$_smarty_tpl->tpl_vars['summary']->value->paymentAmount);?>
        <?php }?>
       
        <td align="right" <?php if ($_smarty_tpl->tpl_vars['balance_to_pay']->value > 0) {?> class="danger" <?php }?>>

            <?php echo number_format($_smarty_tpl->tpl_vars['balance_to_pay']->value,2);?>

        </td>
    </tr>
</table>

<b>Remarks :</b> 
<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value->remarks, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
    <?php echo $_smarty_tpl->tpl_vars['row']->value->name;?>

<?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
<br/><br/>

<div class="row">
    <div class="col-md-12 text-right">
        <button class="btn btn-primary" type="button" id="confirm-modify-btn" onclick="closeCargoPreviewDialog()">Modify</button>&nbsp;
        <button class="btn btn-success" type="button" id="confirm-booking-btn" onclick="closeCargoPreviewDialog();saveBooking()">Confirm</button>&nbsp;
    </div>
</div>

<?php echo '<script'; ?>
>
    $('[data-toggle="tooltip"]').tooltip();
<?php echo '</script'; ?>
>
<?php }
}
