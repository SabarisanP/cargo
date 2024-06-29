<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 15:26:47
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-report-print-seenutransports-v2.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6655aa5f0641d8_60599764',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'c4711503e214f3348a669eda0bf89d65d68b37c7' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-report-print-seenutransports-v2.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6655aa5f0641d8_60599764 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<html>

<head>
    <title>Transit Chart</title>
    <base href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
">
    <link href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/css/print.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet">
    <style>   
        .lr{  font-size: 12pt;  font-weight: bold;}
        .payment-status{  font-size: 11pt;  font-weight: bold;  letter-spacing: 1.5px; }
        .title { font-weight:bold; text-align: center; }
        .bold { font-weight:bold; }
        .bolder { font-weight: 900; }
        table tr { page-break-inside: avoid; page-break-after: auto; }
    </style>
</head>

<body>
    <h1 class="title" style="font-size: 20px;"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
</h1>
    <h1 class="title" style="font-size: 15px;">Transit Report</h1>
    <table width="100%">
        <tr>
            <td></td>
            <td align="right" width="30%" class="bold">Printed By : <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
</td>
            <td align="right" width="25%" class="bold">Printed At : <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
        </tr>
    </table>
    <div style="border: 1px solid;overflow: hidden;">
        <table style="border-bottom: 1px dashed;" cellpadding="3" width="100%">
            <tr>
                <td width="25%"><b>Transit Number:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->aliasCode;?>
</td>
                <td width="25%"><b>Trip Date:</b> <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogpl']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                <td width="25%"><b>From Branch:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->fromOrganization->name;?>
</td>
                <td width="25%"><b>To Branch:</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->toOrganization->name;?>
</td>
            </tr>
            <tr>
                <td width="25%"><b>Vehicle :</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->busVehicle->registationNumber;?>
</td>
                <td width="25%"><b>Driver1 :</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->mobileNumber;?>
</td>
                <td width="25%"><b>Driver2 :</b> <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->secondaryDriver->name;?>
, <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->secondaryDriver->mobileNumber;?>
</td>
                <td width="25%"><b>Transfer Truck No :</b> </td>
            </tr>
        </table>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogpl']->value->transitCargoDetails, 'transit');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['transit']->value) {
?>
            <table style="border-bottom: 1px dashed;" cellpadding="3" width="100%">
                <tr>
                    <td width="25%"><b>From Branch :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->fromOrganization->name;?>
</td>
                    <td width="25%"><b>To Branch :</b> <?php echo $_smarty_tpl->tpl_vars['transit']->value->toOrganization->name;?>
</td>
                    <td width="25%"><b>Loaded By :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['transit']->value->audit->user->name)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    <td width="25%"><b>Loaded At :</b> <?php if ($_smarty_tpl->tpl_vars['transit']->value->loadedAt != 'NA') {
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['transit']->value->loadedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);
} else { ?>-<?php }?></td>
                </tr>
                <tr>
                    <td width="25%"><b>Unloaded By :</b> <?php echo (($tmp = @$_smarty_tpl->tpl_vars['transit']->value->unloadedBy->name)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    <td width="25%"><b>Unloaded At :</b> <?php if ($_smarty_tpl->tpl_vars['transit']->value->unloadedAt != 'NA') {
echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['transit']->value->unloadedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);
} else { ?>-<?php }?></td>
                    <td width="25%"></td>
                    <td width="25%"></td>
                </tr>
            </table>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <br/>
        <table class="bordered" cellpadding="" width="100%" style="table-layout:auto;">
            <thead style="font-size: 5px;">
                <tr class="bold">
                    <td align="center">S.No</td>
                    <td align="center"><?php echo lang('lr');?>
</td>
                    <td align="center">Booked At</td>
                    <td align="center">Consignor</td>
                    <td align="center">Consignee</td>
                    <td align="center">Article</td>
                    <td align="center">Qty</td>
                    <td align="center">Wt.</td>
                    <td align="center">FF</td>
                    <td align="center">HM</td>
                    <td align="center">DC</td>
                    <td align="center">DD</td>
                    <td align="center">Oth. Ch</td>
                    <td align="center"><?php echo lang('docket_charge');?>
</td>
                    <td align="center">Total</td>
                    <td align="center">Pay. Type</td>
                    <td align="center">Remarks</td>
                </tr>
            </thead>
            <tbody style="font-size: 5px;">
                <?php $_smarty_tpl->_assignInScope('o_qty', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_article_weight', 0);?>
                <?php $_smarty_tpl->_assignInScope('sno', 1);?>

                <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_tot_hamali_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_tot_dc_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_tot_dd_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_tot_other_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_tot_docket_charge', 0);?>
                <?php $_smarty_tpl->_assignInScope('o_tot_grand_total', 0);?>

                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
                    <tr>
                        <td align="center" colspan="17"><b><?php echo $_smarty_tpl->tpl_vars['routes']->value[$_smarty_tpl->tpl_vars['t1']->value];?>
</b></td>
                    </tr>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <tr>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                            <td align="left" class="lr"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                            <td align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                            <td width="10%"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                            <td width="10%"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                            <td><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>

                            <td align="center">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>

                                <?php $_smarty_tpl->_assignInScope('o_qty', $_smarty_tpl->tpl_vars['o_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                            </td>

                            <td align="center">
                                <?php echo $_smarty_tpl->tpl_vars['row']->value->total_unit_value;?>

                                <?php $_smarty_tpl->_assignInScope('o_article_weight', $_smarty_tpl->tpl_vars['o_article_weight']->value+$_smarty_tpl->tpl_vars['row']->value->total_unit_value);?>
                            </td>
                            
                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_amount));?>

                                <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', $_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['o_freight_tot_amount']->value);?>
                            </td>

                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->hamali_charge));?>

                                <?php $_smarty_tpl->_assignInScope('o_tot_hamali_charge', $_smarty_tpl->tpl_vars['row']->value->hamali_charge+$_smarty_tpl->tpl_vars['o_tot_hamali_charge']->value);?>
                            </td>

                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount));?>

                                <?php $_smarty_tpl->_assignInScope('o_tot_dc_charge', $_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['o_tot_dc_charge']->value);?>
                            </td>

                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount));?>

                                <?php $_smarty_tpl->_assignInScope('o_tot_dd_charge', $_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['o_tot_dd_charge']->value);?>
                            </td>

                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->other_charges_amount-$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount-$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount-$_smarty_tpl->tpl_vars['row']->value->hamali_charge-$_smarty_tpl->tpl_vars['row']->value->docket_charge));?>

                                <?php $_smarty_tpl->_assignInScope('o_tot_other_charge', $_smarty_tpl->tpl_vars['row']->value->other_charges_amount-$_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount-$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount-$_smarty_tpl->tpl_vars['row']->value->hamali_charge-$_smarty_tpl->tpl_vars['row']->value->docket_charge+$_smarty_tpl->tpl_vars['o_tot_other_charge']->value);?>
                            </td>

                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->docket_charge));?>

                                <?php $_smarty_tpl->_assignInScope('o_tot_docket_charge', $_smarty_tpl->tpl_vars['row']->value->docket_charge+$_smarty_tpl->tpl_vars['o_tot_docket_charge']->value);?>
                            </td>

                            <td align="right">
                                <?php echo inr_format(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount));?>

                                <?php $_smarty_tpl->_assignInScope('o_tot_grand_total', $_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount+$_smarty_tpl->tpl_vars['o_tot_grand_total']->value);?>
                            </td>

                            <td align="center"><?php echo strtoupper($_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code]);?>
</td>
                            <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->remarks_count;?>
</td>
                        </tr>
                        <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    <tr class="bold">
                        <td align="right" colspan="6">Total</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['o_qty']->value;?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['o_article_weight']->value;?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_freight_tot_amount']->value);?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_tot_hamali_charge']->value);?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_tot_dc_charge']->value);?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_tot_dd_charge']->value);?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_tot_other_charge']->value);?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_tot_docket_charge']->value);?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['o_tot_grand_total']->value);?>
</td>
                        <td colspan="2"></td>
                    </tr>
                <?php
}
} else {
?>
                    <tr>
                        <td align="center" colspan="17">Sorry! No cargo found</td>
                    </tr>
                <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
        </table>
        <br />
        <table width='100%' cellpadding="">
            <tr>
                <td class="bolder">Payment Summary</td>
                <td class="bolder">Delivery Summary</td>
            </tr>
            <tr>
                <td>
                    <table width='96%' class="bordered" cellpadding="3">
                        <thead>
                            <tr class="bold">
                                <td align="center"><?php echo lang('lr');?>
 Type</td>
                                <td align="center">No.of <?php echo lang('lr');?>
s</td>
                                <td align="center">Total Amount (Rs.)</td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['paymentSummary']->value, 'val', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                <tr>
                                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['key']->value];?>
</b></td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value['lr'];?>
</td>
                                    <td align="center"><?php echo inr_format($_smarty_tpl->tpl_vars['val']->value['amount']);?>
</td>
                                </tr>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tbody>
                    </table>
                </td>
                <td>
                    <table width='100%' class="bordered" cellpadding="3">
                        <thead>
                            <tr class="bold">
                                <td align="center">Delivery Type</td>
                                <td align="center">No.of <?php echo lang('lr');?>
s</td>
                                <td align="center">Total Amount (Rs.)</td>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['deliverySummary']->value, 'val', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                                <tr>
                                    <td align="center"><b><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['key']->value];?>
</b></td>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value['lr'];?>
</td>
                                    <td align="center"><?php echo inr_format($_smarty_tpl->tpl_vars['val']->value['amount']);?>
</td>
                                </tr>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        </tbody>
                    </table>
                </td>
            </tr>
        </table>

        <h1 class="bolder">Branch Summary</h1>
        <table class="bordered" cellpadding="3" width="100%">
            <thead>
                <tr class="bold">
                    <td align="center">S.No</td>
                    <td align="center">From Branch</td>
                    <td align="center">To Branch</td>
                    <td align="center">No.of <?php echo lang('lr');?>
</td>
                    <td align="center">No.of Article</td>
                    <td align="center">Article Weight</td>
                    <td align="center">Amount</td>
                </tr>
            </thead>
            <tbody>
                <?php $_smarty_tpl->_assignInScope('branch_sno', 1);?>
                <?php $_smarty_tpl->_assignInScope('total_lr', 0);?>
                <?php $_smarty_tpl->_assignInScope('total_amount', 0);?>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['branchSummary']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <tr>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['branch_sno']->value;?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value['from'];?>
</td>
                        <td align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value['to'];?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['lr'];?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['article'];?>
</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value['articleWeight'];?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['row']->value['amount']);?>
</td>
                    </tr>
                    <?php $_smarty_tpl->_assignInScope('branch_sno', $_smarty_tpl->tpl_vars['branch_sno']->value+1);?>
                    <?php $_smarty_tpl->_assignInScope('total_lr', $_smarty_tpl->tpl_vars['total_lr']->value+$_smarty_tpl->tpl_vars['row']->value['lr']);?>
                    <?php $_smarty_tpl->_assignInScope('total_article', $_smarty_tpl->tpl_vars['total_article']->value+$_smarty_tpl->tpl_vars['row']->value['article']);?>
                    <?php $_smarty_tpl->_assignInScope('total_article_weight', $_smarty_tpl->tpl_vars['total_article_weight']->value+$_smarty_tpl->tpl_vars['row']->value['articleWeight']);?>
                    <?php $_smarty_tpl->_assignInScope('total_amount', $_smarty_tpl->tpl_vars['total_amount']->value+$_smarty_tpl->tpl_vars['row']->value['amount']);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tbody>
            <tfoot>
                <tr class="bold">
                    <td align="right" colspan="3">Grand Total</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['total_lr']->value;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['total_article']->value;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['total_article_weight']->value;?>
</td>
                    <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['total_amount']->value);?>
</td>
                </tr>
            </tfoot>
        </table>
    </div>
    </body>
<style>
    body {
        width: unset;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table thead td {
        font-weight: bold;
    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
    }

    <?php if ($_smarty_tpl->tpl_vars['bgimg']->value) {?>
        .background-image {
            position: absolute;
            background-image: url(<?php echo $_smarty_tpl->tpl_vars['bgimg']->value;?>
) !important;
            background-repeat: repeat-y !important;
            background-position: center !important;
            height: 950px;
            width: 100%;
            top: 0;
            left: 0;
            z-index: -1;
        }
    <?php }?>
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            /* Chrome, Safari */
            color-adjust: exact !important;
            /*Firefox*/
        }
    }

    @page {
        size: A4 landscape;
    }
</style>


</html>
<?php }
}
