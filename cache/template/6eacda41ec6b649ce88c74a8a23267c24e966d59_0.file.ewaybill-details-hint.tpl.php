<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-29 11:33:46
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ewaybill-details-hint.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6656c542859599_84049620',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '6eacda41ec6b649ce88c74a8a23267c24e966d59' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ewaybill-details-hint.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6656c542859599_84049620 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
if ($_smarty_tpl->tpl_vars['data']->value->status != 1) {?>
    <div class="text-danger small"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['data']->value->errorDesc)===null||$tmp==='' ? 'Unknown Exception' : $tmp);?>
</div>
<?php } elseif (!isNotNull($_smarty_tpl->tpl_vars['data']->value->data->ewayBillNo)) {?>
    <div class="text-danger small"><?php echo 'Unable to get E-Way Bill details';?>
</div>
<?php } else { ?>
    <?php $_smarty_tpl->_assignInScope('details', $_smarty_tpl->tpl_vars['data']->value->data);?>

    <details>
        <summary class="point_cur" style="display: list-item;"><b>E-Way Bill Details</b></summary>
        <div class="well">

            <table width="100%" cellpadding="5">
                <tbody>
                    <tr>
                        <td width="20%"><b>E-Way Bill No:</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->ewayBillNo;?>
</td>
                        <td width="20%"><b>E-Way Bill Date:</b></td>
                        <td width="30%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['details']->value->createdAt,'%d/%m/%Y %l:%M %p');?>
</td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Valid From:</b></td>
                        <td width="30%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['details']->value->createdAt,'%d/%m/%Y %l:%M %p');?>
 [<?php echo $_smarty_tpl->tpl_vars['details']->value->distance;?>
Kms]</td>
                        <td width="20%"><b>Valid Until:</b></td>
                        <td width="30%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['details']->value->expiryDate,'%d/%m/%Y');?>
</td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Generated By:</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->transportDetails->gstin;?>
 - <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['namespace_name']->value, 'UTF-8');?>
</td>
                    </tr>
                </tbody>
            </table>

            <hr>

            <h6><b>Part - A</b></h6>
            <table width="100%" cellpadding="5">
                <tbody>
                    <tr>
                        <td width="20%"><b>GSTIN of Supplier</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->fromTaxPayerDetails->gstin;?>
, <?php echo $_smarty_tpl->tpl_vars['details']->value->fromTaxPayerDetails->tradeName;?>
</td>
                        <td width="20%"><b>GSTIN of Recipient</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->toTaxPayerDetails->gstin;?>
,<?php echo $_smarty_tpl->tpl_vars['details']->value->toTaxPayerDetails->tradeName;?>
</td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Place of Dispatch</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->fromTaxPayerDetails->place;?>
-<?php echo $_smarty_tpl->tpl_vars['details']->value->fromTaxPayerDetails->pincode;?>
</td>
                        <td width="20%"><b>Place of Delivery</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->toTaxPayerDetails->place;?>
-<?php echo $_smarty_tpl->tpl_vars['details']->value->toTaxPayerDetails->pincode;?>
</td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Document No.</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->documentNo;?>
</td>
                        <td width="20%"><b>Transaction Type:</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['ewaybill_transaction_type']->value[$_smarty_tpl->tpl_vars['details']->value->transactionType];?>
 </td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Document Date</b></td>
                        <td width="30%"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['details']->value->documentDate,'%d/%m/%Y');?>
</td>
                        <td width="20%"><b>HSN Code</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->items[0]->hsnCode;?>
</td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Value of Goods</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->totalInvoiceValue;?>
</td>
                        <td width="20%"><b>Reason for Transportation</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['ewaybill_supply_type']->value[$_smarty_tpl->tpl_vars['details']->value->supplyType];?>
 - <?php echo $_smarty_tpl->tpl_vars['ewaybill_sub_supply_type']->value[$_smarty_tpl->tpl_vars['details']->value->supplySubType];?>
</td>
                    </tr>
                    <tr>
                        <td width="20%"><b>Transporter</b></td>
                        <td width="30%"><?php echo $_smarty_tpl->tpl_vars['details']->value->transportDetails->gstin;?>
 & <?php echo mb_strtoupper($_smarty_tpl->tpl_vars['namespace_name']->value, 'UTF-8');?>
</td>
                    </tr>
                </tbody>
            </table>

            <hr>

            <h6><b>Part - B</b></h6>
            <table class="table table-bordered" width="100%" cellpadding="5">
                <thead>
                    <tr class="active">
                        <th width="10%" class="bold fs-7 border-x border-l">Mode</th>
                        <th class="bold fs-7 border-x">Vehicle / Trans<br /> Doc No & DI.</th>
                        <th class="bold fs-7 border-x">From</th>
                        <th width="20%" class="bold fs-7 border-x">Entered Date</th>
                        <th width="20%" class="bold fs-7 border-x">Entered By</th>
                        <th class="bold fs-7 border-x">CEWB No. <br /> (If any)</th>
                        <th class="bold fs-7 border-x border-r">Multi Veh.Info <br /> (If any)</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['details']->value->vehicleDetails, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <tr>
                            <td width="10%" class="fs-7 border-x border-l"><?php echo $_smarty_tpl->tpl_vars['ewaybill_transportation_mode']->value[$_smarty_tpl->tpl_vars['row']->value->transportDetails->transportMode];?>
</td>
                            <td class="fs-7 border-x"><?php echo $_smarty_tpl->tpl_vars['row']->value->vehicle->registationNumber;?>
</td>
                            <td class="fs-7 border-x"><?php echo $_smarty_tpl->tpl_vars['row']->value->fromStation->name;?>
</td>
                            <td width="20%" class="fs-7 border-x"><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->updatedAt,'%d/%m/%Y %l:%M %p');?>
</td>
                            <td width="20%" class="fs-7 border-x"><?php echo $_smarty_tpl->tpl_vars['row']->value->transportDetails->gstin;?>
</td>
                            <td class="fs-7 border-x"><?php echo $_smarty_tpl->tpl_vars['row']->value->tripSheetNo;?>
</td>
                            <td class="fs-7 border-x border-r">-</td>
                        </tr>
                    <?php
}
} else {
?>
                        <tr>
                            <td colspan="100%" align="center">No Data found</td>
                        </tr>
                    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </tbody>
            </table>
        </div>
    </details>
<?php }?>

<?php echo '<script'; ?>
>
    var ewayBillDetails = <?php echo json_encode($_smarty_tpl->tpl_vars['data']->value->data);?>
;
<?php echo '</script'; ?>
>
<?php }
}
