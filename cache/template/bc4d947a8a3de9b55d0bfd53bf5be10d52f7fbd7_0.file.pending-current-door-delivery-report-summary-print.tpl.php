<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-15 11:09:54
  from 'E:\xampp\htdocs\cargo\application\views\site\report\pending-current-door-delivery-report-summary-print.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_666d292a332136_21657716',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'bc4d947a8a3de9b55d0bfd53bf5be10d52f7fbd7' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\report\\pending-current-door-delivery-report-summary-print.tpl',
      1 => 1716451517,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_666d292a332136_21657716 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<table style="border: 1px solid #000" cellpadding="0" width="100%">
    <tr>
        <td align="left" width="25%">
        </td>
        <td align="center" width="50%">
            <br>
            <h2><?php if ($_smarty_tpl->tpl_vars['branch_name']->value !== "NA") {
echo $_smarty_tpl->tpl_vars['branch_name']->value;
} else { ?>ALL<?php }?> - DOOR DELIVERY - CHART</h2>
        </td>
        <td width="25%">
        </td>
    </tr>
</table>
<br>
<table width="100%" cellpadding="7">
    <tr>
        <td align="left" style="border: 1px solid #000;" width="30%">
            <b> Branch Name : <?php if ($_smarty_tpl->tpl_vars['branch_name']->value !== "NA") {
echo $_smarty_tpl->tpl_vars['branch_name']->value;
} else { ?>ALL<?php }?></b>
        </td>
        <td align="left" width="5%"></td>
        <td align="center" style="border: 1px solid #000;" width="30%">
            <b> Summary :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
        </td>
        <td align="left" width="5%"></td>
        <td align="left" style="border: 1px solid #000;" width="30%">
            <b> DATE : </b><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['user_date']->value,$_smarty_tpl->tpl_vars['ns_date_format']->value);?>

        </td>
    </tr>
</table>
<br>

<table width="100%" cellpadding="7">
    <tr>
        <td align="left" width="30%" style="vertical-align: text-top;">
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <thead>
                    <tr>
                        <th>DLVD :- Bill Not Received</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    <?php $_smarty_tpl->_assignInScope('pending_lrs', 0);?>
                    <?php $_smarty_tpl->_assignInScope('current_lrs', 0);?>

                    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['summary']->value, 'row', false, 'i');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['i']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                        <?php if ($_smarty_tpl->tpl_vars['row']->value->attribute_type == "PENDING") {?>
                            <tr>
                                <td align="right">LGO DD Pending <?php echo $_smarty_tpl->tpl_vars['row']->value->from_organization_short_code;?>
</td>
                                <td align="right"><?php echo $_smarty_tpl->tpl_vars['row']->value->lr_count;?>
</td>
                            </tr>
                            <?php $_smarty_tpl->_assignInScope('pending_lrs', $_smarty_tpl->tpl_vars['pending_lrs']->value+$_smarty_tpl->tpl_vars['row']->value->lr_count);?>
                        <?php }?>

                        <?php if ($_smarty_tpl->tpl_vars['row']->value->attribute_type == "CURRENT") {?>
                            <?php $_smarty_tpl->_assignInScope('current_lrs', $_smarty_tpl->tpl_vars['current_lrs']->value+$_smarty_tpl->tpl_vars['row']->value->lr_count);?>
                        <?php }?>
                    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                </tbody>
                <tr>
                    <td align="right">Current</td>
                    <td align="right"><?php echo $_smarty_tpl->tpl_vars['current_lrs']->value;?>
</td>
                </tr>
                <tr>
                    <td align="right"><b>Total</b></td>
                    <td align="right"><?php ob_start();
echo $_smarty_tpl->tpl_vars['pending_lrs']->value;
$_prefixVariable1 = ob_get_clean();
echo ($_smarty_tpl->tpl_vars['current_lrs']->value)+$_prefixVariable1;?>
</td>
                </tr>
            </table>
        </td>
        <td align="left" width="5%"></td>
        <td align="left" width="30%">
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <thead>
                    <tr>
                        <th>DLVD :- Bill Not Received</th>
                        <th><?php echo $_smarty_tpl->tpl_vars['delivery_withOut_bill_rec']->value;?>
</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td align="center">LR Received</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['delivery_bill_rec']->value;?>
</td>
                    </tr>
                </tbody>

                <tr>
                    <td align="center">Balance</td>
                    <td align="right"></td>
                </tr>
            </table>
            <br>
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <tbody>
                    <tr>
                        <td align="center">Pending DD</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['pending_lrs']->value;?>
</td>
                    </tr>
                    <tr>
                        <td align="center">Current DD</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['current_lrs']->value;?>
</td>
                    </tr>
                    <tr>
                        <td align="center"><b>Total</b></td>
                        <td align="right"><?php echo ($_smarty_tpl->tpl_vars['current_lrs']->value)+($_smarty_tpl->tpl_vars['pending_lrs']->value);?>
</td>
                    </tr>
                </tbody>
            </table>
            <br> <br>
            <table border="1" class="bordered" cellpadding="7" width='100%'>
                <tbody>
                    <tr>
                        <td align="center"><b>Delivered</b></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="center">Pending DD</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['delivery_pending_lr']->value;?>
</td>
                    </tr>
                    <tr>
                        <td align="center">Current DD</td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['delivery_current_lr']->value;?>
</td>
                    </tr>
                    <tr>
                        <td align="center"></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="center"><b>Total </b></td>
                        <td align="right"><?php echo $_smarty_tpl->tpl_vars['delivery_current_lr']->value+$_smarty_tpl->tpl_vars['delivery_pending_lr']->value;?>
</td>
                    </tr>
                    <tr>
                        <td align="center"></td>
                        <td align="right"></td>
                    </tr>
                    <tr>
                        <td align="center"><b>Total Pending</b></td>
                        <td align="right"><?php echo ($_smarty_tpl->tpl_vars['current_lrs']->value)+($_smarty_tpl->tpl_vars['pending_lrs']->value)-($_smarty_tpl->tpl_vars['delivery_current_lr']->value+$_smarty_tpl->tpl_vars['delivery_pending_lr']->value);?>
</td>
                    </tr>
                </tbody>
            </table>
        </td>
        <td align="left" width="5%"></td>
        <td align="left" width="30%">
            <table border="1" class="bordered" cellpadding="7" width='100%' style="border: 1px solid #000;">
                <tr>
                    <th colspan="3">DOOR DELIVERY LR'S SUMMARY</th>
                </tr>
                <tr>
                    <td colspan="2">DLVD - Total LR'S</td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_current_lr']->value+$_smarty_tpl->tpl_vars['delivery_pending_lr']->value;?>
</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>DLVD :- Bill Not Rec</b></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Paid</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_paid_lr']->value;?>
</td>
                </tr>
                <tr>
                    <td><b>To-Pay</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_topay_lr']->value;?>
</td>
                </tr>
                <tr>
                    <td><b>TBB</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_onaccount_lr']->value;?>
</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>GRAND TOTAL</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_paid_lr']->value+$_smarty_tpl->tpl_vars['delivery_topay_lr']->value+$_smarty_tpl->tpl_vars['delivery_onaccount_lr']->value;?>
</td>
                </tr>
            </table>
            <br>
            <table border="1" class="bordered" cellpadding="7" width='100%' style="border: 1px solid #000;">
                <tr>
                    <td colspan="2"><b>Total - To-Pay LR'S</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_topay_lr']->value;?>
</td>
                </tr>
                <tr>
                    <td><b>Payment Received</b></td>
                    <td><?php echo $_smarty_tpl->tpl_vars['delivery_payment_rec']->value;?>
</td>
                </tr>
                <tr>
                    <td><b>Account Party</b></td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Single Party</b></td>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<?php echo '<script'; ?>
>
    window.print();
<?php echo '</script'; ?>
>

<style>
    .bold {
        /* font-weight: bold; */
        font-family: Arial, Helvetica, sans-serif;
        font-weight: normal;
        font-size: 0.9em;
        margin: 1px;
        padding: 0;
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
</style><?php }
}
