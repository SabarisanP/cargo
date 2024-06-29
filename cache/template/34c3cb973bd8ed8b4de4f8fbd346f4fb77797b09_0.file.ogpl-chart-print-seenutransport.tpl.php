<?php
/* Smarty version 3.1.34-dev-7, created on 2024-05-28 15:26:59
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\ogpl-chart-print-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_6655aa6b3e2717_94298234',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '34c3cb973bd8ed8b4de4f8fbd346f4fb77797b09' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\ogpl-chart-print-seenutransport.tpl',
      1 => 1716451514,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_6655aa6b3e2717_94298234 (Smarty_Internal_Template $_smarty_tpl) {
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
        .lr {
            font-size: 9pt;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }

        .bold {
            font-weight: bold;
        }

        .bolder {
            font-weight: 900;
        }

        /* table tr {
            page-break-inside: avoid;
            page-break-after: auto;
        } */

        .center-align {
            padding-left: 0px;
            padding-right: 182px;
        }

        .right-align {
            padding-left: 0px;
            padding-right: 100px;
        }

        footer {
            font-size: 9px;
            color: #f00;
            text-align: center;
        }

        .rounded-rectangle {
            width: 200px;
            height: 30px;
            border: 1px black solid;
        }

        .p-tag {
            margin: 0;
        }

        .page+.page {
            page-break-before: always;
        }

     .div1 {
                border: none;
                border-top: none;
                box-sizing: border-box;
                padding: 10px;
                width: 101.5%;
                display: block;
                position: relative;
                margin: 5px;
                left: -12px;
                top: 13.5rem;
            } 
        
            .header {
                position: fixed;
                width: 100%;
                left: 0;
                background: #fff !important;
                z-index: 1;
                height: 16%;
            }

            .print-header {
                text-align: center;
                font-size: 10px;
                color: #333;
            }


            .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }
            .top-header {
                text-align: center;
                font-size: 9px;
                color: #333;
            }

        .top-header h1 p {
                text-align: center;
                font-size: 9px;
                color: #333;
                margin:0%;
            }

        .innertable {
            position: relative;

        }

        .page-break {
            page-break-before: always;
        }

        .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }


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
            border: .1px solid #000;
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

          .pagebreak-1{
        clear: both;
        page-break-after: always;
    }

 
    .div2 {
            border: 1px solid black;
            box-sizing: border-box;
            padding: 10px;
            height: 0%;
            width: 101%;
            display: block;
            position: relative;
            margin: 5px;
            left: -12px;
            top: 19.5rem;
        }
        div.print-border {
            position: fixed;
            bottom: 30px;
            left: 0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            /* Set the height of the border as needed */
            background-color:black;
            /* Set the border color as needed */
        }

        div.print-border-left {
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:0;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

        div.print-border-right{
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:99.8%;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

    </style>

    <style type="text/css" media="print">
        @media print { 

            @page {
                size: A4 landscape;
                counter-increment: page;
            }

            .pageNumber:after {
                content: counter(page);
            }

            .lr {
            font-size: 9pt;
        }

        .payment-status {
            font-size: 11pt;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }

        .bold {
            font-weight: bold;
        }

        .bolder {
            font-weight: 900;
        }

        /* table tr {
            page-break-inside: avoid;
            page-break-after: auto;
        } */

        .center-align {
            padding-left: 0px;
            padding-right: 182px;
        }

        .right-align {
            padding-left: 0px;
            padding-right: 100px;
        }

        footer {
            font-size: 9px;
            color: #f00;
            text-align: center;
        }

        .rounded-rectangle {
            width: 200px;
            height: 30px;
            border: 1px black solid;
        }

        .p-tag {
            margin: 0;
        }

        .page+.page {
            page-break-before: always;
        }

        div.print-border {
            position: fixed;
            bottom: 30px;
            left: 0px;
            border: 1px solid black;
            border-top:none;
            width: 100%;
            /* Set the height of the border as needed */
            background-color:black;
            /* Set the border color as needed */
        }

        div.print-border-left {
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:0;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }

        div.print-border-right{
            position: fixed;
            top: 90px;
            height: 83%;
            width: 0;
            left:99.8%;
            border: 1px solid black;
            border-right: none;
            background-color: black ;
            z-index: 100;
        }
        
            .header {
                position: fixed;
                width: 100%;
                left: 0;
                background: #fff !important;
                z-index: 1;
                height: 16%;
            }

            .print-header {
                text-align: center;
                font-size: 10px;
                color: #333;
            }


            .title {
            font-weight: bold;
            text-align: center;
            margin:0;
        }
            .top-header {
                text-align: center;
                font-size: 9px;
                color: #333;
            }

        .top-header h1 p {
                text-align: center;
                font-size: 9px;
                color: #333;
                margin:0%;
            }

        .innertable {
            position: relative;

        }

        .page-break {
            page-break-before: always;
        }

        .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }


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
            border: .1px solid #000;
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

          .pagebreak-1{
        clear: both;
        page-break-after: always;
    }

 
   

      
        }
    </style>

</head>

<body>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>
    <div class="container">
        <header class="header">
            <div class="top-header">
            <h1 class="title" style="font-size: 20px;"><?php echo $_smarty_tpl->tpl_vars['namespace_name']->value;?>
 Pvt Ltd</h1>
                                <p><?php echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->address1;
echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->station->name;?>
-<?php echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->pincode;?>
 Phone: No: <?php echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->contact;?>
</p>
                <h1 class="title" style="font-size: 15px;">LUGGAGE LIST REPORT</h1>
            </div>
            <div class="print-header">
                <table style="border: 2px solid;" cellpadding="3" width="100%">
                    <tr>
                        <td width="25%"><b>LUG : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->aliasCode;?>
</b></td>
                        <td class="center-align" width="30%"><b>Lugg List Date :
                                <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogpl']->value->tripDate,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</b></td>
                                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
                                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                        <?php $_smarty_tpl->_assignInScope('from_organization_branch', $_smarty_tpl->tpl_vars['row']->value->transit_from_organization_code);?>
                                    <td class="text-right pr-1" width="15%"><b>From Branch: <?php echo $_smarty_tpl->tpl_vars['row']->value->transit_from_organization_name;?>
</b></td>
                                    <?php break 1;?>
                                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tr>
                    <tr>
                        <td width="25%"><b>Truck No. : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->busVehicle->registationNumber;?>
</td>
                        <td class="center-align" width="30%"><b>Driver Name 1 : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->vehicleDriver->name;?>
</b></td>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['result']->value, 'row1', false, 't1');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t1']->value => $_smarty_tpl->tpl_vars['row1']->value) {
?>
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <?php $_smarty_tpl->_assignInScope('to_organization_branch', $_smarty_tpl->tpl_vars['row']->value->transit_to_organization_code);?>
                            <td class="text-right pr-1" width="15%"><b>To Branch: <?php echo $_smarty_tpl->tpl_vars['row']->value->transit_to_organization_name;?>
</b></td>
                            <?php break 1;?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tr>
                    <tr>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transitcargoDetails']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->toOrganization->code == $_smarty_tpl->tpl_vars['to_organization_branch']->value && $_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['from_organization_branch']->value) {?>
                        <td  width="15%"><b>Loading Person : <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->fromOrganizationContact->name)===null||$tmp==='' ? '-' : $tmp);?>
</b></td>
                        <?php break 1;?>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                        <td class="center-align" width="30%"><b>Driver Name 2 : <?php echo $_smarty_tpl->tpl_vars['ogpl']->value->secondaryDriver->name;?>
</b></td>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transitcargoDetails']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->toOrganization->code == $_smarty_tpl->tpl_vars['to_organization_branch']->value && $_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['from_organization_branch']->value) {?>
                        <td class="text-right pr-1" width="15%"><b>Unloading Person : <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->toOrganizationContact->name)===null||$tmp==='' ? '-' : $tmp);?>
</b></td>
                        <?php break 1;?>
                            <?php }?>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

                    </tr>
                    <tr>
                        <td width="25%"><b>Transfer Truck No: </b></td>
                        <td class="center-align" width="25%"></td>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transitcargoDetails']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <?php if ($_smarty_tpl->tpl_vars['row']->value->toOrganization->code == $_smarty_tpl->tpl_vars['to_organization_branch']->value && $_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['from_organization_branch']->value) {?>
                        <td class="text-right pr-1" width="20%"><b>Unloading Time :
                                <?php if ($_smarty_tpl->tpl_vars['row']->value->unloadedAt != 'NA') {
echo substr((smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloadedAt,"%d-%m-%y")),0,10);
echo substr((smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->unloadedAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value)),10,9);
} else { ?>-<?php }?></b>
                        </td>
                        <?php break 1;?>
                    <?php }?>
                <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tr>
                </table>
                <br />
                <br />
                <br />
            </div>
        </header>
    </div>

    <div class="page newpage">
        <div class="container">
            <div class="div1">
                <table class="bordered innertable" cellpadding="" width="100%" style="table-layout:auto;">
                    <thead style="font-size: 5px;">
                        <tr class="bold">
                            <td align="center">S.No</td>
                            <td align="center">LR Date</td>
                            <td align="center"><?php echo lang('lr');?>
 No</td>
                            <td align="center">Consignor</td>
                            <td align="center">Consignee</td>
                            <td align="center">Article</td>
                            <td align="center">Article <br>Weight</td>
                            <td align="center">FF</td>
                            <td align="center">HM</td>
                            <td align="center">DC</td>
                            <td align="center">DD</td>
                            <td align="center">Other<br>Charge</td>
                            <td align="center"><?php echo lang('docket_charge');?>
</td>
                            <td align="center"> Grand Total</td>
                            <td align="center">Mode Of Payment</td>
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
                            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['row1']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                                <?php $_smarty_tpl->_assignInScope('addonDetails', explode(",",$_smarty_tpl->tpl_vars['row']->value->fs_addon_value));?>
                                <?php if (($_smarty_tpl->tpl_vars['t']->value+1)%9 == 0 && ($_smarty_tpl->tpl_vars['t']->value+1) != 1) {?>
                                    <tr class="page-break"></tr>
                                <?php }?>
                                <tr>
                                    <td align="center"><?php echo $_smarty_tpl->tpl_vars['sno']->value;?>
</td>
                                    <td align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->booked_at,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>
</td>
                                    <td align="left" class="lr"><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                                    <td width="10%"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                                    <td width="10%"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                                    <td><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
/<?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>

                                        <?php $_smarty_tpl->_assignInScope('o_qty', $_smarty_tpl->tpl_vars['o_qty']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?></td>

                                    
                                    <td align="center">
                                        <?php echo round($_smarty_tpl->tpl_vars['row']->value->total_unit_value,2);?>

                                        <?php $_smarty_tpl->_assignInScope('o_article_weight', $_smarty_tpl->tpl_vars['o_article_weight']->value+(round($_smarty_tpl->tpl_vars['row']->value->total_unit_value,2)));?>
                                    </td>

                                    <td align="right">
                                    <?php if (in_array("FR",$_smarty_tpl->tpl_vars['addonDetails']->value)) {?>
                                    FS
                                    <?php } else { ?>
                                        <?php echo round($_smarty_tpl->tpl_vars['row']->value->total_amount,2);?>

                                        <?php $_smarty_tpl->_assignInScope('o_freight_tot_amount', $_smarty_tpl->tpl_vars['o_freight_tot_amount']->value+(round($_smarty_tpl->tpl_vars['row']->value->total_amount,2)));?>
                                    <?php }?>
                                    </td>
                                    <td align="right">
                                        <?php if (in_array("LC",$_smarty_tpl->tpl_vars['addonDetails']->value)) {?>
                                         FS
                                        <?php } else { ?>
                                            <?php echo round(($_smarty_tpl->tpl_vars['row']->value->total_handling_amount),2);?>

                                         <?php $_smarty_tpl->_assignInScope('o_tot_hamali_charge', $_smarty_tpl->tpl_vars['o_tot_hamali_charge']->value+(round($_smarty_tpl->tpl_vars['row']->value->total_handling_amount,2)));?>
                                        <?php }?>
                                    </td>

                                    <td align="right">
                                       <?php if (in_array("DP",$_smarty_tpl->tpl_vars['addonDetails']->value)) {?>
                                        FS
                                       <?php } else { ?>
                                        <?php echo round(($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount),2);?>

                                        <?php $_smarty_tpl->_assignInScope('o_tot_dc_charge', $_smarty_tpl->tpl_vars['o_tot_dc_charge']->value+(round($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount,2)));?>
                                       <?php }?>
                                    </td>

                                    <td align="right">
                                    <?php if (in_array("DD",$_smarty_tpl->tpl_vars['addonDetails']->value)) {?>
                                        FS
                                       <?php } else { ?>
                                        <?php echo round(($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount),2);?>

                                        <?php $_smarty_tpl->_assignInScope('o_tot_dd_charge', $_smarty_tpl->tpl_vars['o_tot_dd_charge']->value+(round($_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount,2)));?>
                                       <?php }?>
                                      
                                    </td>

                                    <td align="right">
                                    <?php echo round((($_smarty_tpl->tpl_vars['row']->value->other_charges_amount)-($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->hamali_charge+$_smarty_tpl->tpl_vars['row']->value->docket_charge+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount)),2);?>

                                    <?php $_smarty_tpl->_assignInScope('o_tot_other_charge', $_smarty_tpl->tpl_vars['o_tot_other_charge']->value+(round((($_smarty_tpl->tpl_vars['row']->value->other_charges_amount)-($_smarty_tpl->tpl_vars['row']->value->pickup_handling_amount+$_smarty_tpl->tpl_vars['row']->value->delivery_handling_amount+$_smarty_tpl->tpl_vars['row']->value->hamali_charge+$_smarty_tpl->tpl_vars['row']->value->docket_charge+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount)),2)));?>
                                    </td>

                                    <td align="right">
                                    <?php if (in_array("DC",$_smarty_tpl->tpl_vars['addonDetails']->value)) {?>
                                        FS
                                       <?php } else { ?>
                                        <?php echo round(($_smarty_tpl->tpl_vars['row']->value->docket_charge),2);?>

                                        <?php $_smarty_tpl->_assignInScope('o_tot_docket_charge', $_smarty_tpl->tpl_vars['o_tot_docket_charge']->value+(round($_smarty_tpl->tpl_vars['row']->value->docket_charge,2)));?>
                                       <?php }?>
                                    </td>

                                    <td align="right">
                                        <?php echo round(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount),2);?>

                                        <?php $_smarty_tpl->_assignInScope('o_tot_grand_total', $_smarty_tpl->tpl_vars['o_tot_grand_total']->value+(round(($_smarty_tpl->tpl_vars['row']->value->total_amount+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount),2)));?>
                                    </td>

                                    <td align="center"><?php echo strtoupper($_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['row']->value->payment_status_code]);?>
</td>
                                  
                                        <td align="center"></td>
                                   
                                </tr>
                                <?php $_smarty_tpl->_assignInScope('sno', $_smarty_tpl->tpl_vars['sno']->value+1);?>
                            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                            <tr class="bold">
                                <td align="right" colspan="5">Total</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['o_qty']->value;?>
</td>
                                <td align="center"><?php echo $_smarty_tpl->tpl_vars['o_article_weight']->value;?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_freight_tot_amount']->value,2);?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_tot_hamali_charge']->value,2);?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_tot_dc_charge']->value,2);?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_tot_dd_charge']->value,2);?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_tot_other_charge']->value,2);?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_tot_docket_charge']->value,2);?>
</td>
                                <td align="right"><?php echo round($_smarty_tpl->tpl_vars['o_tot_grand_total']->value,2);?>
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
                <br/>

                <table width="100%" class="innerTable">
                    <tr>
                        <td align="right">
                            <div class="center-align">
                                <p class="p-tag">Total Article Weight :</p>
                            </div>
                            <br>
                            <div class="right-align">
                                <div class="rounded-rectangle">
                                    <p align="center"><b><?php echo $_smarty_tpl->tpl_vars['o_article_weight']->value;?>
</b></p>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="page-break"></div>
    <div class="page newpage">
        <div class="container">
            <div class="div1">
                <br />
                <br />
                <table width='100%' cellpadding="" class="innerTable">
                    <tr>
                        <td class="bolder">Payment Details :</td>
                        <td class="bolder">Delivery Details :</td>
                    </tr>
                    <tr>
                        <td>
                            <table width='96%' class="bordered" cellpadding="3">
                                <thead>
                                    <tr class="bold">
                                        <td align="center">Mode Of Payment</td>
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
                                            <td align="center"><?php echo sprintf("%d",$_smarty_tpl->tpl_vars['val']->value['amount']);?>
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
                                            <td align="center"><?php echo sprintf("%d",$_smarty_tpl->tpl_vars['val']->value['amount']);?>
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

                <br />
                <br />
                <div id="innertable"></div>
            </div>
        </div>
    </div>

    <div class="print-footer" id="print-footer">
        <table>
            <tr>
                <td width="35%">Printed On : <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['transitcargoDetails']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->toOrganization->code == $_smarty_tpl->tpl_vars['to_organization_branch']->value && $_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['from_organization_branch']->value) {?>
                        <?php if (isset($_smarty_tpl->tpl_vars['row']->value->audit->user->name)) {?>
                        <td width="25%">Booked By: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->audit->user->name)===null||$tmp==='' ? '-' : $tmp);?>
 </td>
                        <?php }?>
                <?php break 1;?>
            <?php }?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['odometer']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <?php if ($_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['from_organization_branch']->value) {?>
                    <?php if (isset($_smarty_tpl->tpl_vars['row']->value->departureAt)) {?>
                        <td width="25%">Booked Date & Time : <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->departureAt,$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                        <?php break 1;?>
                    <?php }?>
                <?php }?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
            </tr>
        </table>
    </div>
</body>

<?php echo '<script'; ?>
>
var filter = <?php echo json_encode($_smarty_tpl->tpl_vars['filter']->value);?>
;
    var addBranches = <?php echo json_encode($_smarty_tpl->tpl_vars['newBranchSummary']->value);?>
;
    var m = 0;
    var total_amount = 0;
    var total_article = 0;
    var total_lr = 0;
    var total_weight = 0;
    var total_ff = 0;
    var total_hm = 0;
    var total_dc = 0;
    var total_dd = 0;
    var total_other = 0;
    var total_stc = 0;

    var tablesContainer = document.getElementById('innertable');
    var h1 = document.createElement('h1');
    h1.textContent = "Add Branches:-";
    tablesContainer.appendChild(h1);
    var table = document.createElement('table');
    table.setAttribute('cellpadding', '3');
    table.setAttribute('border', '2px')
    table.setAttribute('width', '100%');

    var thead = document.createElement('thead');
    var tr = document.createElement('tr');
    var entries = Object.entries(addBranches);
    var lastValue = entries.length;
    var th = document.createElement('th');
    th.textContent = "SI NO";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "FROM";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "TO";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "No.of.LR";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "NO OF ARTICLES";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "ARTICLES WEIGHT";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "FF";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "HM";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "DC";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "DD";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "OtherCharge";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "STC";
    tr.appendChild(th);
    var th = document.createElement('th');
    th.textContent = "Total Amount";
    tr.appendChild(th);

    thead.appendChild(tr);
    table.appendChild(thead);

    var tbody1 = document.createElement('tbody');
    table.appendChild(tbody1);
    var rowIndex = 0;
    var j = 1;
    for (var [key, value] of entries) {
  
        var row = document.createElement('tr');
        var keys = Object.keys(value);
        var td1 = document.createElement('td');
        td1.setAttribute('align', 'center');
        td1.textContent = j++;
        row.appendChild(td1);

        for (var k = 0; k < keys.length-1; k++) {
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            var presentAddonDetails = [].concat(...value[keys[keys.length - 1]]);
            console.log(keys[k],value[keys[k]]);
            td.textContent = (keys[k] == 'ff' && value[keys[k]] <= 0 && presentAddonDetails.includes("FR")) ? "FS" :
                   (keys[k] == 'hm' && value[keys[k]] <= 0 && presentAddonDetails.includes("LC")) ? "FS" :
                   (keys[k] == 'stc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DC")) ? "FS" :
                   (keys[k] == 'dc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DP")) ? "FS" :
                   (keys[k] == 'dd' && value[keys[k]] <= 0 && presentAddonDetails.includes("DD")) ? "FS" :
                   value[keys[k]];
            if (keys[k] == 'lr') {
                total_lr += value[keys[k]];
            } else if (keys[k] == 'article') {
                total_article += value[keys[k]];
            } else if (keys[k] == 'articleWeight') {
                total_weight += value[keys[k]];
            } else if (keys[k] == 'ff') {
                total_ff += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'dc') {
                total_dc += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'hm') {
                total_hm += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'dd') {
                total_dd += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'otherCharges') {
                total_other += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'amount') {
                total_amount += parseFloat(value[keys[k]].toFixed(2));
            } else if (keys[k] == 'stc') {
                total_stc += parseFloat(value[keys[k]].toFixed(2));
            }

            row.appendChild(td);
            tbody1.appendChild(row);
        }

        if (j > lastValue) {
            var row = document.createElement('tr');
            var td = document.createElement('td');
            var b = document.createElement("B");
            td.setAttribute("colspan", "3")
            td.setAttribute('align', 'right');
            td.classList.add("bold");
            td.textContent = "Total";
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = total_lr;
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = total_article;
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = total_weight;
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_ff.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent =  parseFloat(total_hm.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_dc.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_dd.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_other.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_stc.toFixed(2));
            row.appendChild(td);
            var td = document.createElement('td');
            td.setAttribute('align', 'center');
            td.classList.add("bold");
            td.textContent = parseFloat(total_amount.toFixed(2));
            row.appendChild(td);
            tbody1.appendChild(row);
            table.appendChild(tbody1);
            tablesContainer.appendChild(table);
            br = document.createElement('br');
            tablesContainer.appendChild(br);

            var table3 = document.createElement('table');
            table3.setAttribute("width", "100%");
            table3.classList.add("DriverSign");
            br2 = document.createElement('br');
            table3.appendChild(br2);
            br3 = document.createElement('br');
            table3.appendChild(br3);
            br4 = document.createElement('br');
            table3.appendChild(br4);
            tr3 = document.createElement('tr');
            td3 = document.createElement('td');
            td3.setAttribute("align", "right");
            innerDiv = document.createElement('div');
            innerDiv.classList.add("center-align");
            p = document.createElement('p');
            p.classList.add('p-tag');
            p.textContent = "Driver-Sign";
            innerDiv.appendChild(p);
            td3.appendChild(innerDiv);
            tr3.appendChild(td3);
            table3.appendChild(tr3);
            tablesContainer.appendChild(table3);
            break;
        }

        if (j % 5 == 0) {
            tablesContainer.appendChild(table);
            entries_new = entries.slice(j - 1);
            if (entries_new.length > 0) {
                j = createtable(j, entries, entries_new);
                if (j > lastValue) {
                    break;
                }
            } else {
                break;
            }
        }
    }

    function createtable(j, entries, entries_new) {
        var page = document.createElement('div');
        page.classList.add("page");
        page.classList.add("newpage");
        var container = document.createElement('div');
        container.classList.add("container");
        var div1 = document.createElement('div');
        div1.classList.add("div1");
        var tablecontainer2 = document.createElement('div');
        var table2 = document.createElement('table');
        table2.setAttribute('cellpadding', '3');
        table2.setAttribute('border', '2px')
        table2.setAttribute('width', '100%');
        var thead = document.createElement('thead');
        var tr = document.createElement('tr');
        var th = document.createElement('th');
        th.textContent = "SI NO";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "FROM";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "TO";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "No.of.LR";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "NO OF ARTICLES";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "ARTICLES WEIGHT";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "FF";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "HM";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "DC";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "DD";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "OtherCharge";
        tr.appendChild(th);
        var th = document.createElement('th');
        th.textContent = "STC";
        tr.appendChild(th)
        var th = document.createElement('th');
        th.textContent = "Total Amount";
        tr.appendChild(th);
        thead.appendChild(tr);
        table2.appendChild(thead);
        var tbody = document.createElement('tbody');
        table.appendChild(tbody);
        console.log(entries_new);
        for (var [key, value] of entries_new) {
            var row = document.createElement('tr');
            var keys = Object.keys(value);
            var td1 = document.createElement('td');
            td1.setAttribute('align', 'center');
            td1.textContent = j++;
            row.appendChild(td1);
            for (var k = 0; k < keys.length-1; k++) {
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                if (keys[k] == 'lr') {
                    total_lr += value[keys[k]];
                } else if (keys[k] == 'article') {
                    total_article += value[keys[k]];
                } else if (keys[k] == 'articleWeight') {
                    total_weight += value[keys[k]];
                } else if (keys[k] == 'ff') {
                    total_ff += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'dc') {
                    total_dc += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'hm') {
                    total_hm += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'dd') {
                    total_dd += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'otherCharges') {
                    total_other += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'amount') {
                    total_amount += parseFloat(value[keys[k]].toFixed(2));
                } else if (keys[k] == 'stc') {
                    total_stc += parseFloat(value[keys[k]].toFixed(2));
                }
                var presentAddonDetails = [].concat(...value[keys[keys.length - 1]]);
                td.textContent = (keys[k] == 'ff' && value[keys[k]] <= 0 && presentAddonDetails.includes("FR")) ? "FS" :
                   (keys[k] == 'hm' && value[keys[k]] <= 0 && presentAddonDetails.includes("LC")) ? "FS" :
                   (keys[k] == 'stc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DC")) ? "FS" :
                   (keys[k] == 'dc' && value[keys[k]] <= 0 && presentAddonDetails.includes("DP")) ? "FS" :
                   (keys[k] == 'dd' && value[keys[k]] <= 0 && presentAddonDetails.includes("DD")) ? "FS" :
                   value[keys[k]];
                row.appendChild(td);
            }

            tbody.appendChild(row);

            if (j > lastValue) {
                var row = document.createElement('tr');
                var td = document.createElement('td');
                td.setAttribute("colspan", "3")
                td.setAttribute('align', 'right');
                td.classList.add("bold");
                td.textContent = "Total";
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = total_lr;
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = total_article;
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = total_weight;
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_ff.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_hm.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_dc.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_dd.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_other.toFixed(2));
                row.appendChild(td);
                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_stc.toFixed(2));
                row.appendChild(td);

                var td = document.createElement('td');
                td.setAttribute('align', 'center');
                td.classList.add("bold");
                td.textContent = parseFloat(total_amount.toFixed(2));
                row.appendChild(td);
                tbody.appendChild(row);
                table2.appendChild(tbody);
                tablecontainer2.appendChild(table2);
                div1.appendChild(tablecontainer2);
                container.appendChild(div1);
                br = document.createElement('br');
                container.appendChild(br);
                var table3 = document.createElement('table');
                table3.setAttribute("width", "100%");
                table3.classList.add("DriverSign");
                br2 = document.createElement('br');
                table3.appendChild(br2);
                br3 = document.createElement('br');
                table3.appendChild(br3);
                br4 = document.createElement('br');
                table3.appendChild(br4);
                tr3 = document.createElement('tr');
                td3 = document.createElement('td');
                td3.setAttribute("align", "right");
                innerDiv = document.createElement('div');
                innerDiv.classList.add("center-align");
                p = document.createElement('p');
                p.classList.add('p-tag');
                p.textContent = "Driver-Sign";
                innerDiv.appendChild(p);
                td3.appendChild(innerDiv);
                tr3.appendChild(td3);
                table3.appendChild(tr3);
                div1.appendChild(table3);
                container.appendChild(div1);
                page.appendChild(container);
                var referenceNode = document.getElementById("print-footer");
                referenceNode.parentNode.insertBefore(page, referenceNode);
                return j;
            }

            if (j % 5 == 0) {
                table2.appendChild(tbody);
                tablecontainer2.appendChild(table2);
                div1.appendChild(tablecontainer2);
                container.appendChild(div1);
                page.appendChild(container);
                // page.appendChild( br());
                // page.appendChild( br());
                // page.appendChild(table());
                var referenceNode = document.getElementById("print-footer");
                referenceNode.parentNode.insertBefore(page, referenceNode);
                entries_new = entries.slice(j - 1)
                if (entries_new.length > 0) {
                    j = createtable(j, entries, entries_new);
                    if (j > lastValue) {
                        return j;
                    }
                }
            }
        }
        return j;
    }

    function table() {
        br = document.createElement('br')
        br = document.createElement('br')
        var table3 = document.createElement('table');
        table3.setAttribute("width", "100%");
        table3.classList.add("DriverSign");
        tr3 = document.createElement('tr');
        td3 = document.createElement('td');
        td3.setAttribute("align", "right");
        innerDiv = document.createElement('div');
        innerDiv.classList.add("center-align");
        p = document.createElement('p');
        p.classList.add('p-tag');
        p.textContent = "Driver-Sign";
        innerDiv.appendChild(p);
        td3.appendChild(innerDiv);
        tr3.appendChild(td3);
        table3.appendChild(tr3);
        return table3
    }
<?php echo '</script'; ?>
>

</html><?php }
}
