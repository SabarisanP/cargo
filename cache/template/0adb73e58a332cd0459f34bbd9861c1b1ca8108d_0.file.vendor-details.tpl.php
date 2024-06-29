<?php
/* Smarty version 3.1.34-dev-7, created on 2024-06-19 13:09:19
  from 'E:\xampp\htdocs\cargo\application\views\site\widgets\vendor-details.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.34-dev-7',
  'unifunc' => 'content_66728b274d2ce0_37052477',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '0adb73e58a332cd0459f34bbd9861c1b1ca8108d' => 
    array (
      0 => 'E:\\xampp\\htdocs\\cargo\\application\\views\\site\\widgets\\vendor-details.tpl',
      1 => 1716451522,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_66728b274d2ce0_37052477 (Smarty_Internal_Template $_smarty_tpl) {
?><div>
    <div><b>Company Name : </b> <?php echo $_smarty_tpl->tpl_vars['vendor']->value->companyName;?>
</div>
    <div><b>Contact Person : </b> <?php echo $_smarty_tpl->tpl_vars['vendor']->value->name;?>
</div>
    <div class="no-wrap"><b>Mobile Number : </b> <?php echo $_smarty_tpl->tpl_vars['vendor']->value->mobileNumber;?>
</div>
    <div class="no-wrap"><b>Email : </b> <?php echo $_smarty_tpl->tpl_vars['vendor']->value->email;?>
</div>
    <div class="no-wrap"><b>Vendor Branch : </b> <?php echo $_smarty_tpl->tpl_vars['vendor']->value->responsibleOrganization->name;?>
</div>
    <div><b>Address : </b> <?php echo $_smarty_tpl->tpl_vars['vendor']->value->vendorAddress->address1;?>
, <?php echo $_smarty_tpl->tpl_vars['vendor']->value->vendorAddress->address2;?>
, <?php echo $_smarty_tpl->tpl_vars['vendor']->value->vendorAddress->landmark;?>
, <?php echo $_smarty_tpl->tpl_vars['vendor']->value->vendorAddress->station->name;?>
 - <?php echo $_smarty_tpl->tpl_vars['vendor']->value->vendorAddress->pincode;?>
</div>

    <hr>

    <div><b>Advance Balance</b> <i class="fa fa-inr"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['vendor_balance']->value->advanceAmountBalance);?>
</div>
    <div><b>Balance</b> <i class="fa fa-inr"></i> <?php echo inr_format($_smarty_tpl->tpl_vars['vendor_balance']->value->currentBalance);?>
</div>
</div>
<?php }
}
