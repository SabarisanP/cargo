<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-05 10:16:01
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\out-for-delivery-hire-challan-print-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665fed89bfa7e0_66760670',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'fb875ff83ebadf0037dbaf3ed4f14a758129dc6f' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\out-for-delivery-hire-challan-print-seenutransport.tpl',
      1 => 1717509027,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665fed89bfa7e0_66760670 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<html>

<head>
    <title>Out For Delivery Chart</title>
    <base href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
">
    <link href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/css/print.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet">
    <style>
        .title { font-weight:bold; text-align: center; }
        .bold { font-weight:bold; }
        .bolder { font-weight: 900; }
        .border-bottom { border-bottom: 2px solid #000;}
        .border-outline { border: 1px solid #000;}
    </style>
</head>

<body style="overflow: hidden;" class="border-outline">
    <table class="border-outline" width="100%" cellpadding="5" style="border-bottom: none;">
        <tr class="bold">
            <td width="25%">
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="2" style="font-size: 20px;">
                Seenu Transports Pvt.Ltd.<br>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['organizationDetails']->value, 'detail');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['detail']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['ogpl']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['detail']->value->code) {?>
                      <p style = "margin-top:3px; margin-bottom:3px; font-size:16px; font-weight: normal;"><?php echo $_smarty_tpl->tpl_vars['detail']->value->address1;
echo $_smarty_tpl->tpl_vars['detail']->value->address2;
echo $_smarty_tpl->tpl_vars['detail']->value->station->name;?>
&nbsp;<?php echo $_smarty_tpl->tpl_vars['detail']->value->pincode;?>
&nbsp;Phone: No:<?php echo $_smarty_tpl->tpl_vars['detail']->value->contact;?>
</p>
                        <?php break 1;?>
                    <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
            <td width="25%"></td>
        </tr>
    </table>
    <table class="border-outline" cellpadding="5" width="100%" style="border-top: none;">
        <tr>
            <td colspan="3" align="center" class="bold" style="font-size: 18px;">Local Lorry Hire Slip Report</td>
        </tr>
        <tr>
            <td><b>Date : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogpl']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</b></td>
            <td><b>Vechile No : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->busVehicle->registationNumber;?>
 / <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->busVehicle->ownershipType->name;?>
</b></td>
        </tr>
        <tr>
            <td><b>HIRE CHALLAN NO : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->aliasCode;?>
 </b></td>
            <td><b>Location Area : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->fromOrganization->name;?>
 </b></td>
        </tr>
        <tr>
            <td><b>Driver Name : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->name;?>
</b></td>
            <td><b>Driver Mobile :<?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->mobileNumber;?>
</b></td>
        </tr>
    </table>
    <br>
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['odoDetails']->value['OTFD'], 'val', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
        <table class="bordered" cellpadding="3" width="100%">
            <thead>
                <tr>
                    <td align="left" class="title" colspan="6"><?php echo $_smarty_tpl->tpl_vars['key']->value;?>
</td>
                </tr>
                <tr>
                    <td align="center" class="bold" nowrap>Departure & Arrival</td>
                    <td align="center" class="bold" width="20%">Location</td>
                    <td align="center" class="bold" width="15%">Km</td>
                    <td align="center" class="bold" width="20%">Date & Time</td>
                    <td align="center" class="bold" width="15%">Remark</td>
                    <td align="center" class="bold" nowrap>C.C.Sign with Date</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td align="center">DEP:STARTING.Km</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['val']->value->fromOrganization->name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->startOdometer;?>
</td>
                    <td align="center" nowrap>
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['val']->value->departureAt)) {?>
                            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['val']->value->departureAt,'d-m-Y H:i A');?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td></td>
                    <td rowspan="3"></td>
                </tr>
                <tr>
                    <td align="center">ARRI:CLOSING.Km</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['val']->value->toOrganization->name;?>
</td>
                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['val']->value->endOdometer;?>
</td>
                    <td align="center">
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['val']->value->arrivalAt)) {?>
                            <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['val']->value->arrivalAt,'d-m-Y H:i A');?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td align="right" class="bold" colspan="2">Total Km</td>
                    <td align="center">
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['val']->value->endOdometer) && isNotNull($_smarty_tpl->tpl_vars['val']->value->startOdometer)) {?>
                            <?php echo $_smarty_tpl->tpl_vars['val']->value->endOdometer-$_smarty_tpl->tpl_vars['val']->value->startOdometer;?>

                        <?php } else { ?>
                            0
                        <?php }?>
                    </td>
                    <td align="center">
                        <?php if (isNotNull($_smarty_tpl->tpl_vars['val']->value->departureAt) && isNotNull($_smarty_tpl->tpl_vars['val']->value->arrivalAt)) {?>
                            <?php echo (hoursBetween(smarty_modifier_date_format($_smarty_tpl->tpl_vars['val']->value->arrivalAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value),(smarty_modifier_date_format($_smarty_tpl->tpl_vars['val']->value->departureAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value))));?>

                        <?php } else { ?>
                            -
                        <?php }?>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>
        <br />
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

    <h1 style="text-align: center;">Local DC and DD</h1>
    <table width="100%">
        <tr>
            <td width="45%">
                <table class="bordered" cellpadding="3" width="100%">
                    <thead>
                        <tr>
                            <td align="center" width="5%">S.No</td>
                            <td align="center">Door Delivery</td>
                            <td align="center">Amount</td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $_smarty_tpl->_assignInScope('dd_sno', 0);?>
                        <?php $_smarty_tpl->_assignInScope('dd_t_pickamount', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value->data, 'item', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['item']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['item']->value->door_delivery_flag == 1) {?>
                                <?php $_smarty_tpl->_assignInScope('dd_t_pickamount', $_smarty_tpl->tpl_vars['dd_t_pickamount']->value+$_smarty_tpl->tpl_vars['item']->value->delivery_handling_amount);?>
                                <?php $_smarty_tpl->_assignInScope('dd_sno', $_smarty_tpl->tpl_vars['dd_sno']->value+1);?>
                                <tr>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['dd_sno']->value;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['item']->value->to_customer_name;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['item']->value->delivery_handling_amount;?>
</td>
                                </tr>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td align="center"></td>
                            <td align="left">Total - DD - <?php echo $_smarty_tpl->tpl_vars['dd_sno']->value;?>
 </td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['dd_t_pickamount']->value;?>
</td>
                        </tr>
                    </tfoot>
                </table>
            </td>
            <td></td>
            <td align="right" width="45%">
                <table class="bordered" cellpadding="3" width="100%">
                    <thead>
                        <tr>
                            <td align="center" width="5%">S.No</th>
                            <td align="center">Door Collection</td>
                            <td align="center">Amount</td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $_smarty_tpl->_assignInScope('dp_sno', 0);?>
                        <?php $_smarty_tpl->_assignInScope('dp_t_pickamount', 0);?>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'item', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['item']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['item']->value->door_collection_flag == 1) {?>
                                <?php $_smarty_tpl->_assignInScope('dp_t_pickamount', $_smarty_tpl->tpl_vars['dp_t_pickamount']->value+$_smarty_tpl->tpl_vars['item']->value->pickup_handling_amount);?>
                                <?php $_smarty_tpl->_assignInScope('dp_sno', $_smarty_tpl->tpl_vars['dp_sno']->value+1);?>
                                <tr>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['dp_sno']->value;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['item']->value->to_customer_name;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['item']->value->pickup_handling_amount;?>
</td>
                                </tr>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td align="center"></td>
                            <td align="left">Total - DC - <?php echo $_smarty_tpl->tpl_vars['dp_sno']->value;?>
 </td>
                            <td align="left"><?php echo $_smarty_tpl->tpl_vars['dp_t_pickamount']->value;?>
</td>
                        </tr>
                    </tfoot>
                </table>
            </td>
        </tr>
    </table>
    <br>

    <table width="100%" cellpadding="2">
        <tr>
            <td width="50%">
                <table cellpadding="2">
                    <tr class="bold">
                        <td colspan="2">TOTAL:</td>
                    </tr>
                    <tr>
                        <td class="bold" width="70%">Total-DD</td>
                        <td class="bold">: <?php echo $_smarty_tpl->tpl_vars['dd_sno']->value;?>
</td>
                    </tr>
                    <tr>
                        <td class="bold" width="70%">Total-DC</td>
                        <td class="bold">: <?php echo $_smarty_tpl->tpl_vars['dp_sno']->value;?>
</td>
                    </tr>
                    <tr>
                        <td class="bold" width="70%">Total-DD and DC</td>
                        <td class="bold">: <?php echo $_smarty_tpl->tpl_vars['dd_sno']->value+$_smarty_tpl->tpl_vars['dp_sno']->value;?>
</td>
                    </tr>
                </table>
            </td>
            <td width="50%">
                <table cellpadding="2" width="100%">
                    <tr class="bold">
                        <td>Total Lorry Hire</td>
                        <td class="bold">: <?php echo inr_format($_smarty_tpl->tpl_vars['incomeexpense']->value['HiringAmount']['amount']);?>
</td>
                    </tr>
                    <tr>
                        <td class="bold">Advance</td>
                        <td class="bold">: <?php echo inr_format($_smarty_tpl->tpl_vars['incomeexpense']->value['AdvanceAmount']['amount']);?>
</td>
                    </tr>
                    <tr>
                        <td class="bold">Balance</td>
                        <td class="bold">: <?php echo inr_format(abs($_smarty_tpl->tpl_vars['incomeexpense']->value['HiringAmount']['amount']-$_smarty_tpl->tpl_vars['incomeexpense']->value['AdvanceAmount']['amount']));?>
</td>
                    </tr>
                    <tr>
                        <td class="bold">Driver Beta</td>
                        <td class="bold">: </td>
                    </tr>
                    <tr>
                        <td class="bold">Others</td>
                        <td class="bold">: 
                            <?php $_smarty_tpl->_assignInScope('othercharges', 0);?>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['incomeexpense']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <?php if (!in_array($_smarty_tpl->tpl_vars['k']->value,array('HiringAmount','AdvanceAmount'))) {?>
                                    <?php $_smarty_tpl->_assignInScope('othercharges', $_smarty_tpl->tpl_vars['othercharges']->value+$_smarty_tpl->tpl_vars['row']->value['amount']);?>
                                <?php }?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <?php echo inr_format($_smarty_tpl->tpl_vars['othercharges']->value);?>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <div class="print-footer">
        <table class="border-outline" cellpadding="3" width="100%">
            <tr>
                <td align="" width="33%" class="bold">Printed On : <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                <td align=" " width="35%" class="bold">Booked by : <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
</td>
                <td align="" width="32%" class="bold">Booked Date & Time: <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogpl']->value->tripDate,"%d-%b-%Y");?>
</td>
            </tr>
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

        @page {
            @bottom-center {
                content: element(footer);
            }
        }

        .print-footer {
            position: fixed;
            bottom: 10px;
            width: 97.5%;
            text-align: center;
            font-size: 10px;
            color: #333;
        }
    }

    @page {
        size: A4 portrait;
    }
</style>

</html>
<?php }
}
