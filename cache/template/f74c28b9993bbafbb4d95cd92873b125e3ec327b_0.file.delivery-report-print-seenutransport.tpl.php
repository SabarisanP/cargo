<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-03 14:52:08
  from 'E:\xampp\htdocs\cargo\application\views\site\cargo\delivery-report-print-seenutransport.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_665d8b4054d141_49241510',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'f74c28b9993bbafbb4d95cd92873b125e3ec327b' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\cargo\\delivery-report-print-seenutransport.tpl',
      1 => 1716957692,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_665d8b4054d141_49241510 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_checkPlugins(array(0=>array('file'=>'E:\\xampp\\htdocs\\cargo\\application\\third_party\\Smarty\\plugins\\modifier.date_format.php','function'=>'smarty_modifier_date_format',),));
?>
<div class="print-border"></div>
<div class="print-border-left"></div>
<div class="print-border-right"></div>

<div class="print-header">
    <table border="2" cellpadding="2" width="101%">
        <tr>
            <td colspan="12">
                <img align="left" style="margin-left: 20px;margin-top:30px;"
                    src="<?php echo $_smarty_tpl->tpl_vars['base_url']->value;?>
/assets/img/seenutransports-logo.png" alt="logo" width="150px">
                <h1 align="center">Seenu Transports Pvt Ltd</h1>
                <?php if ($_smarty_tpl->tpl_vars['organizationDetails']->value) {?>
                    <p style="margin:0;font-weight:300" align="center"><?php echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->address1;
echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->station->name;?>
-<?php echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->pincode;?>
 Phone: No: <?php echo $_smarty_tpl->tpl_vars['organizationDetails']->value[0]->contact;?>
</p>
                    <?php } else { ?>
                <p align="center">Regd.off : No: 4D8/ 9, 3rd Main Road Industrial Estate, Ambattur, Chennai- 600058.
                    Phone:
                    No:
                    044-26524098 / 26524016, 9380279073</p>
                    <?php }?>
                <h3 align="center">Delivery Ledger Report</h3>
            </td>
        </tr>
    </table>
</div>
<table width="100%" style="line-height: 20px;" class="first_page">
    <tr style="border: none;">
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['ogplcargo']->value, 'row');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['row']->value) {
?>
        <?php if ($_smarty_tpl->tpl_vars['row']->value->toOrganization->code == $_smarty_tpl->tpl_vars['ogplDetails']->value->to_organization_code && $_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['ogplDetails']->value->from_organization_code) {?>
    <td colspan="3" border="0">Unloading Person: <?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->toOrganizationContact->name)===null||$tmp==='' ? '-' : $tmp);?>

        </td>
    <?php break 1;?>
        <?php }?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        <td colspan="3" border="0">Vehicle No :<?php echo $_smarty_tpl->tpl_vars['ogplDetails']->value->registration_number;?>

        </td>
        <td colspan="3" border="0">From Branch :<?php echo $_smarty_tpl->tpl_vars['ogplDetails']->value->transit_from_organization_name;?>

        </td>

        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['odometer']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php if ($_smarty_tpl->tpl_vars['row']->value->fromOrganization->code == $_smarty_tpl->tpl_vars['ogplDetails']->value->from_organization_code) {?>
                <?php if (isset($_smarty_tpl->tpl_vars['row']->value->departureAt)) {?>
                    <td colspan="4" border="0">Booking Date :<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->departureAt,"%d-%m-%Y");?>

                    </td>
                    <?php break 1;?>
                <?php }?>
            <?php }?>
    <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>



       
    </tr>
    <tr style="border: none;">
        <td colspan="3" border="0">Prepared Person :<?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>

        </td>
        <td colspan="3" border="0">Arrival Time :<?php echo substr((smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogplDetails']->value->arrival_at,$_smarty_tpl->tpl_vars['ns_datetime_format']->value)),10,9);?>

        </td>
        <td colspan="3" border="0">To Branch :<?php echo $_smarty_tpl->tpl_vars['ogplDetails']->value->transit_to_organization_name;?>

        </td>
        <td colspan="3" border="0">Arrival Date :<?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['ogplDetails']->value->arrival_at,"%d-%m-%Y");?>

    </tr>
</table>
<table class="each-table" border="2" cellpadding="10" width="101%">
    <thead>
        <tr>
            <td  align="center" width="5%"><b>S.No</b></td>
            <td  align="center" width="6%"><b>From Party</b> </td>
            <td  align="center" width="6%"><b>To Party </b></td>
            <td  align="left" width="3%"><b>No of Articles</b></td>
            <td  align="left" width="8%"><b>Payment Type</b> </td>
            <td  align="left" width="2%"><b>Amount</b> </td>
            <td  align="left" width="8%"><b>OD/DD</b></td>
            <td  align="center" width="9%"><b>LR No.</b></td>
            <td  align="center" width="8%"><b>CR.NO</b></td>
            <td  align="center" width="10%"><b> Date </b></td>
            <td  align="center" width="10%"><b>C.C & Sign</b></td>
            <td  align="center" width="10%"><b>Party Seal & Sign</b></td>
        </tr>
    </thead>
    <tbody>
        <?php $_smarty_tpl->_assignInScope('tot_lr_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_item_count', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_fare', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_handling', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_payable', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_paid', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_topay', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_items', 0);?>
        <?php $_smarty_tpl->_assignInScope('tot_commission', 0);?>
        <?php $_smarty_tpl->_assignInScope('s_no', 1);?>
        <?php $_smarty_tpl->_assignInScope('index', 0);?>
        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['singleOgpl']->value, 'row', false, 't');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['t']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
            <?php if ($_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CA' && $_smarty_tpl->tpl_vars['row']->value->cargo_status_code != 'CR') {?>
                <?php if ($_smarty_tpl->tpl_vars['index']->value%5 == 0) {?>
                    <tr class="page-break"></tr>
                <?php }?>

                <tr>
                    <td style ="font-size: 13px;" align="center"><?php echo $_smarty_tpl->tpl_vars['s_no']->value;?>
</td>
                    <td style ="font-size: 13px;" align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->from_customer_name;?>
</td>
                    <td  style ="font-size: 13px;"  align="center"><?php echo $_smarty_tpl->tpl_vars['row']->value->to_customer_name;?>
</td>
                                        <td style ="font-size: 13px;" align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_item_count;?>
 - <?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_item_name;?>
</td>
                                        <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "PAD") {?>
                        <td style ="font-size: 13px;"  align="left">Paid</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "TPPAD") {?>
                        <td style ="font-size: 13px;"  align="left">To Pay Paid</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "INP") {?>
                        <td style ="font-size: 13px;" align="left">On Account</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "FS") {?>
                        <td style ="font-size: 13px;"  align="left">Free Service</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "WTOP") {?>
                        <td style ="font-size: 13px;"  align="left">Way To Pay</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "OATP") {?>
                        <td style ="font-size: 13px;" align="left">On Account To Pay</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->payment_type_code == "TOP") {?>
                        <td style ="font-size: 13px;" align="left">To Pay</td>
                    <?php }?>
                    <td style ="font-size: 13px;"  align="left"><?php echo $_smarty_tpl->tpl_vars['row']->value->total_transaction_amount;?>
</td>
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->delivery_type_code == "DYSE") {?>
                        <td style ="font-size: 13px;" align="left">Self Pickup</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->delivery_type_code == "DYDO") {?>
                        <td style ="font-size: 13px;"  align="left">Door Delivery</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->delivery_type_code == "PUSE") {?>
                        <td style ="font-size: 13px;" align="left">Self Pickup</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->delivery_type_code == "PUDO") {?>
                        <td  style ="font-size: 13px;" align="left">Door Pickup</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->delivery_type_code == "PDDO") {?>
                        <td align="left">Door Pickup and Delivery</td>
                    <?php } elseif ($_smarty_tpl->tpl_vars['row']->value->delivery_type_code == "WAYDY") {?>
                        <td style ="font-size: 13px;" align="left">On the Way Delivery</td>
                    <?php }?>
                    <td style ="font-size: 13px;" align="center" ><?php echo $_smarty_tpl->tpl_vars['row']->value->cargo_code;?>
</td>
                    <?php if ($_smarty_tpl->tpl_vars['row']->value->payment_status_code == "INP" || $_smarty_tpl->tpl_vars['row']->value->payment_status_code == "OATP") {?>

                    <td style ="font-size: 13px;"  align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->invoice_number)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    <?php } else { ?>
                        <td style ="font-size: 13px;"  align="center"><?php echo (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code)===null||$tmp==='' ? '-' : $tmp);?>
</td>
                    <?php }?>
                    <?php if (($_smarty_tpl->tpl_vars['row']->value->invoice_number !== '' && (($tmp = @$_smarty_tpl->tpl_vars['row']->value->invoice_number)===null||$tmp==='' ? '-' : $tmp) !== '-')) {?>
                        <td style="font-size: 13px;" align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->invoice_date,"%d-%m-%Y");?>
</td>
                    <?php } elseif (($_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code !== '' && (($tmp = @$_smarty_tpl->tpl_vars['row']->value->transaction_receipt_code)===null||$tmp==='' ? '-' : $tmp) !== '-')) {?>
                        <td style="font-size: 13px;" align="center" nowrap><?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->receipt_transaction_date,"%d-%m-%Y");?>
</td>
                    <?php } else { ?>
                        <td style="font-size: 13px;" align="center" nowrap></td>
                    <?php }?>
                    <td style ="font-size: 13px;" align="center"></td>
                    <td style ="font-size: 13px;" align="left" nowrap>
                    <?php if (($_smarty_tpl->tpl_vars['row']->value->local_alias_code || $_smarty_tpl->tpl_vars['row']->value->created_at || $_smarty_tpl->tpl_vars['row']->value->local_driver_name || $_smarty_tpl->tpl_vars['row']->value->local_driver_mobile_number)) {?>
                       <?php if ($_smarty_tpl->tpl_vars['row']->value->local_alias_code) {?>
                        <span>ogpl No: <?php echo $_smarty_tpl->tpl_vars['row']->value->local_alias_code;?>
</span><br>
                       <?php }?>
                       <?php if ($_smarty_tpl->tpl_vars['row']->value->created_at) {?>
                        <span>Date: <?php echo smarty_modifier_date_format($_smarty_tpl->tpl_vars['row']->value->created_at,"%d-%m-%Y");?>
</span><br>
                       <?php }?>
                       <?php if ($_smarty_tpl->tpl_vars['row']->value->local_driver_name) {?>
                        <span>Driver Name: <?php echo $_smarty_tpl->tpl_vars['row']->value->local_driver_name;?>
</span><br>
                       <?php }?>
                       <?php if ($_smarty_tpl->tpl_vars['row']->value->local_driver_mobile_number) {?>
                        <span> Driver Mobile No: <?php echo $_smarty_tpl->tpl_vars['row']->value->local_driver_mobile_number;?>
</span><br>
                       <?php }?>
                    <?php }?>
                        </td>
                </tr>

                <?php $_smarty_tpl->_assignInScope('s_no', $_smarty_tpl->tpl_vars['s_no']->value+1);?>
                <?php $_smarty_tpl->_assignInScope('index', $_smarty_tpl->tpl_vars['index']->value+1);?>
                <?php $_smarty_tpl->_assignInScope('tot_lr_count', $_smarty_tpl->tpl_vars['tot_lr_count']->value+1);?>
                <?php $_smarty_tpl->_assignInScope('tot_item_count', $_smarty_tpl->tpl_vars['tot_item_count']->value+$_smarty_tpl->tpl_vars['row']->value->item_count);?>
                <?php $_smarty_tpl->_assignInScope('tot_fare', $_smarty_tpl->tpl_vars['tot_fare']->value+$_smarty_tpl->tpl_vars['row']->value->total_transaction_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_handling', $_smarty_tpl->tpl_vars['tot_handling']->value+$_smarty_tpl->tpl_vars['row']->value->total_handling_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_payable', $_smarty_tpl->tpl_vars['tot_payable']->value+$_smarty_tpl->tpl_vars['row']->value->total_transaction_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_paid', $_smarty_tpl->tpl_vars['tot_paid']->value+$_smarty_tpl->tpl_vars['row']->value->transaction_amount);?>
                <?php $_smarty_tpl->_assignInScope('tot_items', $_smarty_tpl->tpl_vars['tot_items']->value+$_smarty_tpl->tpl_vars['row']->value->total_item_count);?>
                <?php $_smarty_tpl->_assignInScope('t_other_tot_amount', $_smarty_tpl->tpl_vars['t_other_tot_amount']->value+$_smarty_tpl->tpl_vars['row']->value->service_charge+$_smarty_tpl->tpl_vars['row']->value->other_charges_amount);?>

                <?php $_smarty_tpl->_assignInScope('tot_commission', $_smarty_tpl->tpl_vars['tot_commission']->value+$_smarty_tpl->tpl_vars['row']->value->commission_amount);?>
            <?php }?>
        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

        <?php if ($_smarty_tpl->tpl_vars['tot_lr_count']->value) {?>
            <tr>
                <td align="right" colspan="3" class="bold">Total</td>
                <td align="center" class="bold"><?php echo $_smarty_tpl->tpl_vars['tot_items']->value;?>
</td>
                <td align="center" class="bold"></td>
                <td align="right" class="bold"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_payable']->value);?>
</td>
                <td colspan="6"></td>
            </tr>
        <?php } else { ?>
            <tr>
                <td colspan="100%" align="center">No Records Found!</td>
            </tr>
        <?php }?>
    </tbody>
</table>
<div class="page-break-after"></div>
<div class="table-top">
    <table cellpadding="2" width="70%">
        <tr>
            <td width="45%">
                <table cellpadding="2" width="100%">
                    <tr>
                        <td class="bold" colspan="3">Payment Details</td>
                    </tr>
                </table>
                <table border="1" cellpadding="2" width="101%">
                    <thead>
                        <tr>
                            <td align="center">Mode of Payment</td>
                            <td align="center">No. of GCN</td>
                            <td align="center">Amount (Rs.)</td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['payment_details']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <tr>
                                <td align="center" nowrap><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['k']->value];?>
</td>
                                <td align="center"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['count'],$_smarty_tpl->tpl_vars['tot_pay_cnt']->value);?>
</td>
                                <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['amount'],$_smarty_tpl->tpl_vars['tot_pay_amt']->value));?>
</td>
                            </tr>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <tr class="bold">
                        <td align="right">Total</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_pay_cnt']->value;?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_pay_amt']->value);?>
</td>
                    </tr>
                </table>
            </td>
            <td width="10%"></td>
            <td width="45%">
                <table cellpadding="2" width="100%">
                    <tr>
                        <td class="bold" colspan="3">Delivery Details</td>
                    </tr>
                </table>
                <table border="1" cellpadding="2" width="100%">
                    <thead>
                        <tr>
                            <td align="center">Delivery Details</td>
                            <td align="center">No. of GCN</td>
                            <td align="center">Amount (Rs.)</td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['delivery_details']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                            <tr>
                                <td align="center" nowrap><?php echo $_smarty_tpl->tpl_vars['delivery_type_codes']->value[$_smarty_tpl->tpl_vars['k']->value];?>
</td>
                                <td align="center"><?php echo sigma($_smarty_tpl->tpl_vars['row']->value['count'],$_smarty_tpl->tpl_vars['tot_del_cnt']->value);?>
</td>
                                <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['amount'],$_smarty_tpl->tpl_vars['tot_del_amt']->value));?>
</td>
                            </tr>
                        <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
                    </tbody>
                    <tr class="bold">
                        <td align="right">Total</td>
                        <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_del_cnt']->value;?>
</td>
                        <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_del_amt']->value);?>
</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <br>
    <table cellpadding="2" width="70%">
        <tr>
            <td class="bold">Collection Details</td>
        </tr>
    </table>
    <table border="1" width="70%">
        <thead>
            <tr>
                <td align="center">Mode of Payment</td>
                <td align="center">Total LR</td>
                <td align="center">Total LR Amount (Rs.)</td>
                <td align="center">Payment Received LR</td>
                <td align="center">Payment Received LR Amount (Rs.)</td>
                <td align="center">Pending LR</td>
                <td align="center">Pending LR Amount (Rs.)</td>
            </tr>
        </thead>
        <tbody>
            <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['payment_details']->value, 'row', false, 'k');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['row']->value) {
?>
                <tr>
                    <td align="center" nowrap><?php echo $_smarty_tpl->tpl_vars['cargo_payment_status']->value[$_smarty_tpl->tpl_vars['k']->value];?>
</td>
                    <td align="center"><?php echo sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['count'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['tot_coll_cnt']->value);?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['amount'],$_smarty_tpl->tpl_vars['tot_coll_amt']->value));?>
</td>
                    <td align="center"><?php echo sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['paid_count'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['tot_coll_paid_cnt']->value);?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['paid_amt'],$_smarty_tpl->tpl_vars['tot_coll_paid_amt']->value));?>
</td>
                    <td align="center"><?php echo sigma((($tmp = @$_smarty_tpl->tpl_vars['row']->value['pend_count'])===null||$tmp==='' ? 0 : $tmp),$_smarty_tpl->tpl_vars['tot_coll_pend_cnt']->value);?>
</td>
                    <td align="right"><?php echo inr_format(sigma($_smarty_tpl->tpl_vars['row']->value['pending_amt'],$_smarty_tpl->tpl_vars['tot_coll_pend_amt']->value));?>
</td>
                </tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
        </tbody>
        <tr class="bold">
            <td align="right">Total</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_coll_cnt']->value;?>
</td>
            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_coll_amt']->value);?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_coll_paid_cnt']->value;?>
</td>
            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_coll_paid_amt']->value);?>
</td>
            <td align="center"><?php echo $_smarty_tpl->tpl_vars['tot_coll_pend_cnt']->value;?>
</td>
            <td align="right"><?php echo inr_format($_smarty_tpl->tpl_vars['tot_coll_pend_amt']->value);?>
</td>
        </tr>
    </table>
</div>

<div class="print-footer" id="print-footer">
        <table>
            <tr>
                <td width="35%">Printed On : <?php echo smarty_modifier_date_format(time(),$_smarty_tpl->tpl_vars['ns_datetime_format']->value);?>
</td>
                <td width="25%">Generated  By: <?php echo $_smarty_tpl->tpl_vars['usr_login_name']->value;?>
 </td>
            </tr>
        </table>
    </div>
<style>
    .bold {
        font-weight: bold;
    }

    table {
        border-collapse: collapse;
    }

    table thead th,
    table tbody td {
        font-weight: 100;
        padding: 4px;

    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
        padding: 4px;
    }

    div.print-border {
        position: fixed;
        bottom: 100px;
        left: 0;
        width: 100%;
        height: 1px;
        /* Set the height of the border as needed */
        background-color: #000;
        /* Set the border color as needed */
    }

    div.print-border-left,
    div.print-border-right {
        position: fixed;
        top: 30px;
        height: 100%;
        width: 1px;
        /* Set the width of the borders as needed */
        background-color: #000;
        /* Set the border color as needed */
        z-index: 1;
        /* Move the borders behind the content */
    }

    div.print-border-left {
        left: 6px;
    }

    div.print-border-right {
        right: 100px;
    }


    .print-header {
        position: fixed;
        top: 0;
    }
</style>

<style type="text/css" media="print">
    @media print {
        body {
            -webkit-print-color-adjust: exact !important;
            color-adjust: exact !important;
        }

        @page {
            size: A4 landscape;
        }


        table thead th,
    table tbody td {
        font-weight: 100;
        padding: 4px;

    }

    table.bordered th,
    table.bordered td {
        border: 1px solid #000;
        padding: 4px;
    }
        div.print-border {
            position: fixed;
            bottom: 20px;
            left: 6px;
            width: 100%;
            height: 1px;
            /* Set the height of the border as needed */
            background-color: #000000;
            /* Set the border color as needed */
        }

        div.print-border-left,
        div.print-border-right {
            position: fixed;
            top: 0px;
            height: 97.5%;
            width: 1px;
            /* Set the width of the borders as needed */
            background-color: #000;
            /* Set the border color as needed */
            z-index: -1;
            /* Move the borders behind the content */
        }

        div.print-border-left {
            left: 7px;
        }

        div.print-border-right {
            right: 0;
        }

        .page-break {
            page-break-before: always;
        }

        .print-table {
            width: 100.5%;
        }

        .print-header {
            position: fixed;
            top: 0;
            width: 100%;
        }

        .each-table {
            position: relative;
            top: 160px;
        }

        .first_page {
            position: relative;
            top: 152px;

        }

        .page-break {
            page-break-before: always;
        }

        .page-break-after {
            page-break-after: always;
        }

        .table-top {
            position: relative;
            top: 200px;
        }

    .print-footer {
                position: fixed;
                bottom: 0;
                width: 100%;
                text-align: center;
                font-size: 10px;
                color: #333;
            }

    }
</style>

<?php echo '<script'; ?>
>
    window.print();
<?php echo '</script'; ?>
><?php }
}
