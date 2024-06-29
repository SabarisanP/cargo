<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-31 10:30:50
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-chart-hire-challan-print-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66595982a9b941_71181867',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '06f7fe16f4210c846e03c862158da7214d44720e' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-chart-hire-challan-print-seenutransport.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66595982a9b941_71181867 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<html>

<head>
    <title></title>
    <base href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
">
    <link href="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
assets/css/print.css?<?php echo $_smarty_tpl->tpl_vars['asset_ver']->value;?>
" rel="stylesheet">
    <style>
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

        .border-bottom {
            border-bottom: 2px solid #000;
        }

        .border-outline {
            border: 1px solid #000;
        }
    </style>
</head>

<?php $_smarty_tpl->_assignInScope('balance', 0);?>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
<body style="overflow: hidden;">
    <table class="border-outline" width="100.7%" cellpadding="5">
        <tr class="bold">
            <td width="25%">
                &nbsp;<img src="assets/img/seenutransports-logo.png" alt="logo" width="150px">
            </td>
            <td align="center" colspan="2" style="font-size: 20px;">
                Seenu Transports Pvt.Ltd.<br>
                <p><?php echo $_smarty_tpl->tpl_vars['Payment_Branch']->value->address1;?>
</p>
                <span style="font-size: 18px;">Hire Challan</span>
            </td>
            <td width="25%"></td>
        </tr>
    </table>
    <table class="border-outline" cellpadding="5" width="100.7%">
        <tr>
            <td class="bold">Date</td>
            <td align="left" width="10%" colspan="2"><b> : </b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogpl']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
            <td align="right" class="bold" width="25%">Vehicle Category</td>
            <td align="left" class="bold"> : <?php echo $_smarty_tpl->tpl_vars['vehicle']->value->ownershipType->name;?>
</td>
            <td align="right" class="bold">HIRE CHALLAN NO</td>
            <td align="left" width="20%" class="bold" colspan="2">: <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->aliasCode;?>
</td>
        </tr>
    </table>
    <table class="border-outline" style="border-bottom: 0;line-height: 25px;" cellpadding="5" width="100%"  height = "70%">
        <tr>
            <td class="bold" width="15%" nowrap>FROM BRANCH</td>
            <td align="left" width="15%" nowrap><b> : </b><?php echo $_smarty_tpl->tpl_vars['ogpl']->value->fromOrganization->name;?>
</td>
            <td align="right" class="bold" width="15%" nowrap>TO BRANCH</td>
            <td width="15%" nowrap><b> : </b><?php echo $_smarty_tpl->tpl_vars['ogpl']->value->toOrganization->name;?>
</td>
            <td width="20%"></td>
            <td width="15%"></td>
            <td width="5%"></td>
        </tr>
        <tr>
            <td class="bold" width="15%" align="left" nowrap>VIA FROM LOCATION</td>
            <td align="left" width="15%" nowrap><b> : </b>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogpl']->value->fromViaOrganization, 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                    <?php echo $_smarty_tpl->tpl_vars['val']->value->shortCode;?>
 <?php if ($_smarty_tpl->tpl_vars['k']->value < (count($_smarty_tpl->tpl_vars['ogpl']->value->fromViaOrganization))-1) {?>, <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
            <td class="bold" align="right" width="15%" nowrap>VIA TO LOCATION</td>
            <td align="left" width="15%" nowrap><b> : </b>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogpl']->value->toViaOrganization, 'val', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['val']->value) {
?>
                    <?php echo $_smarty_tpl->tpl_vars['val']->value->shortCode;?>
 <?php if ($_smarty_tpl->tpl_vars['k']->value < (count($_smarty_tpl->tpl_vars['ogpl']->value->toViaOrganization))-1) {?>, <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
            <td width="20%"></td>
            <td width="15%"></td>
            <td width="5%"></td>
        </tr>
        <tr>
            <td class="bold">TRUCK NO.</td>
            <td align="left"><b> : </b><?php echo $_smarty_tpl->tpl_vars['vehicle']->value->registationNumber;?>
</td>
            <td align="right" class="bold">TON</td>
            <td align="left"><b> : </b><?php echo $_smarty_tpl->tpl_vars['vehicle']->value->loadCapacity;?>
</td>
            <td align="right" class="bold">TOTAL HIRE</td>
            <td align="left" nowrap><b> : </b><?php echo inr_format($_smarty_tpl->tpl_vars['incomeexpense']->value['HiringAmount']['amount']);?>
</td>
            <td></td>
        </tr>
        <tr>
            <td class="bold" nowrap>DRIVER NAME 1</td>
            <td align="left" nowrap><b> : </b><?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->name;?>
 -
                <b><?php echo (($tmp = @$_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->mobileNumber)===null||$tmp==='' ? 'NIL' : $tmp);?>
</b>
            </td>
            <td></td>
            <td align="right" class="bold" nowrap colspan="2">1. OFFICE ADVANCE BY CASH</td>
            <td align="left" class="border-bottom" nowrap><b> :
                </b><?php echo inr_format($_smarty_tpl->tpl_vars['incomeexpense']->value['AdvanceAmount']['amount']);?>
</td>
            <td></td>
        </tr>
        <tr>
            <td class="bold" nowrap>DRIVER NAME 2</td>
            <td align="left" colspan="2"><b> : </b><?php echo (($tmp = @$_smarty_tpl->tpl_vars['ogpl']->value->secondaryDriver->name)===null||$tmp==='' ? 'NIL' : $tmp);?>
 -
                <b><?php echo (($tmp = @$_smarty_tpl->tpl_vars['ogpl']->value->secondaryDriver->mobileNumber)===null||$tmp==='' ? 'NIL' : $tmp);?>
</b>
            </td>
            <td></td>
            <td align="right" class="bold">BALANCE</td>
            <?php $_smarty_tpl->_assignInScope('balance', $_smarty_tpl->tpl_vars['balance']->value+($_smarty_tpl->tpl_vars['incomeexpense']->value['HiringAmount']['amount']-$_smarty_tpl->tpl_vars['incomeexpense']->value['AdvanceAmount']['amount']));?>
            <td align="left" class="bold"> :
                <?php if (($_smarty_tpl->tpl_vars['incomeexpense']->value['HiringAmount']['amount']-$_smarty_tpl->tpl_vars['incomeexpense']->value['AdvanceAmount']['amount']) > 0) {
echo inr_format(($_smarty_tpl->tpl_vars['incomeexpense']->value['HiringAmount']['amount']-$_smarty_tpl->tpl_vars['incomeexpense']->value['AdvanceAmount']['amount']));
} else {
}?>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td align="right" colspan="2" class="bold" nowrap>2. OFFICE ADVANCE BY DIESEL</td>
            <td align="left" colspan="2"><b> : </b></td>
        </tr>
        <tr>
            <td class="bold" nowrap>D.L No.</td>
            <td align="left" nowrap><b> : </b><?php echo (($tmp = @$_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->licenseNumber)===null||$tmp==='' ? 'NIL' : $tmp);?>
</td>
            <td colspan="2"></td>
            <td align="right">
                <table class="bordered" cellpadding="3" width="<?php if (count($_smarty_tpl->tpl_vars['fuelexpense']->value) == 1) {?>95%<?php } else { ?>65%<?php }?>">
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['fuelexpense']->value, 'fuelData');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['fuelData']->value) {
?>
                    <tr class="bold">
                        <td noerap>LTR</td>
                        <td align="right" nowrap><?php echo inr_format($_smarty_tpl->tpl_vars['fuelData']->value['litres']);?>
</td>
                        <td nowrap>Rate Per LTR</td>
                        <td align="right" nowrap><?php echo inr_format($_smarty_tpl->tpl_vars['fuelData']->value['pricePerLitre']);?>
</td>
                    </tr>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </table>
            </td>
            <td colspan="1" class="bold border-bottom" nowrap>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['fuelexpense']->value, 'fuelData');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['fuelData']->value) {
?>
                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['fuelData']->value['totalAmount'], 'amount');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['amount']->value) {
?>
                        <?php echo inr_format($_smarty_tpl->tpl_vars['amount']->value);?>
<br>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
        </tr>
        <tr>
            <td class="bold" nowrap>OWNER NAME</td>
            <td align="left" nowrap><b> : </b><?php echo (($tmp = @$_smarty_tpl->tpl_vars['vehicle']->value->transporterContact->name)===null||$tmp==='' ? 'NIL' : $tmp);?>
</td>
            <td colspan="2"></td>
            <td align="right" class="bold" nowrap>TOTAL BALANCE</td>
            <td align="left" class="bold border-top" nowrap>

            <?php if (!empty($_smarty_tpl->tpl_vars['fuelexpense']->value)) {?>
                    <?php if (count($_smarty_tpl->tpl_vars['fuelexpense']->value) > 1) {?>
                        <?php echo inr_format(abs($_smarty_tpl->tpl_vars['balance']->value-($_smarty_tpl->tpl_vars['fuelexpense']->value[0]['totalAmount']+$_smarty_tpl->tpl_vars['fuelexpense']->value[1]['totalAmount'])));?>

                    <?php } else { ?>
                        <?php echo inr_format(abs($_smarty_tpl->tpl_vars['balance']->value-$_smarty_tpl->tpl_vars['fuelexpense']->value[0]['totalAmount']));?>

                    <?php }?>
                <?php } else { ?>
                    N/A
                <?php }?>
            </td>
        </tr>
        <tr>
            <td class="bold" nowrap>DELIVERY DETAILS</td>
            <td align="left" class="bold border-bottom"> :</td>
            <td colspan="2"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr style = "line-height: 10px;">
            <td class="bold" nowrap>DEPARTURE DATE & TIME</td>
            <td align="left" nowrap><b> : </b>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['odometer']->value, 'singleOdometer');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['singleOdometer']->value) {
?>
                  <?php if ($_smarty_tpl->tpl_vars['singleOdometer']->value->departureAt) {?>
                    <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['singleOdometer']->value->departureAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>

                    <?php break 1;?>
                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
            <td colspan="1"></td>
            <td align="left" class="bold" nowrap>Petrol Pump Vendor Name</td>
            <td align="left" nowrap><b> : </b>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['fuelexpense']->value, 'fuelData', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['fuelData']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['key']->value != 0) {?>, <?php }
echo $_smarty_tpl->tpl_vars['fuelData']->value['vendor'];?>

                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
            <td></td>
        </tr>
        <tr style = "line-height: 10px;">
            <td colspan="3"></td>
            <td align="left" class="bold" nowrap>Petrol Pump Coupon No.</td>
            <td align="left" nowrap><b> : </b>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['fuelexpense']->value, 'fuelData', false, 'key');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['key']->value => $_smarty_tpl->tpl_vars['fuelData']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['key']->value != 0) {?>, <?php }
echo $_smarty_tpl->tpl_vars['fuelData']->value['coupon'];?>

                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </td>
            <td></td>
        </tr>
    </table>
    <table class="border-outline print-footer-top" cellpadding="3" width="100.7%">
<tr >
<td class="bold"  width = "40%" align = "left">C.C SIGN WITH SEAL  :</td>
<td class="bold"  width = "55%" align = "left">DRIVER SIGN   :</td>
</tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr><td width = "40%"></td><td width = "55%"></td></tr>
<tr>
<td class="bold" colspan="4" nowrap>Note:No Halting Charges on Sunday and other Festival Holidays</td>
<td colspan="3"></td>
</tr>
</table>
<table class="print-Footer border-outline" cellpadding="3" width="100.7%">
<tr>
   <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogpl']->value->transitRoutes, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
       <?php if (isset($_smarty_tpl->tpl_vars['row']->value->createdAt)) {?>
           <td align="left" width="25%" class="bold">Booked Date & Time : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->createdAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
           <?php break 1;?>
       <?php }?>
   <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
   <td align="center" width="20%" class="bold">Booked By: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['ogpl']->value->audit->user->name)===null||$tmp==='' ? '-' : $tmp);?>
 </td>
   <td align="right" width="15%" class="bold">Printed By : <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
</td>
   <td align="right" width="25%" class="bold">Printed At : <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
</tr>
</table>
</body>




     
<style>
    body {
        width: unset;
    }
    div{
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

        .title {
            display: none;
        }

        /* .print-Footer{
            position:fixed;
            bottom: 0px;
        } */

        .print-footer-top {
            border-top: none !important;
        }

        /* .print-footer-top{
            position:fixed;
            bottom: 20px;
        } */

        /* .print-border-left,
        .print-border-right {
            position: fixed;
            top: 6px;
            height: 96%;
            width: 1px;
            background-color: #000;
            z-index: 1;
        }

        .print-border-left {
            left: 7px;

        }

        .print-border-right {
            right: 0px;

        }
         */
    }

    @page {
        size: A4 landscape;
    }
</style>

</html><?php }
}
